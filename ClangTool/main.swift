//
//  main.swift
//  ClangTool
//

import Foundation

class Config {
    private init() {}
    
    let prefix = "sf"
    let name = "SFML"
    let bindingImportName = "CSFML"
    let header = "sfml.h" //brew install csfml
    let includePath = "/usr/local/include/"
    let replaced = ["RenderStates"]//, "Thread"]
    let owned = ["copy", "capture"]
    let ignoredFunctions = ["sfTcpListener_accept"]
}
let config = Config()

func run() {
    let	index = Index(excludeDeclarationsFromPCH: false, displayDiagnostics: false)
    
    let path = config.header
    
    let	args	=	[
        "-x", "c++",
        "-I\(config.includePath)",
    ]
    let	unit = index.parseTranslationUnit(path, commandLineArguments: args)
    
    let node = AstModule(cursor: unit.cursor)
    //TODO: remove construction from ast initializers
    
    removeIgnoredFunctions(node)
    groupMethods(node)
    translateWrappable(node)
    translateInstanceMethods(node)
    createProperties(node)
    createEnums(node)
    addConstants(node)
    applyReplaced(node)
    
    
    try! node.emit().writeToFile("Generated.swift", atomically: true, encoding: NSUTF8StringEncoding)
}


extension AstModule {
    func enumerateFunctions(block : (obj : AstFunctionDeclaration, owner : AstTypeDeclaration?)->()) {
        for obj in self.functions {
            block(obj: obj, owner: nil)
        }
        
        for type in self.types {
            for member in type.members {
                if let obj = member as? AstFunctionDeclaration {
                    block(obj: obj, owner: type)
                }
            }
        }
        
    }
    
    func visitFunctionCalls(visitor : (body : AstFunctionBody)-> ()) {
        for obj in self.types {
            for member in obj.members {
                if let function = member as? AstFunctionDeclaration {
                    visitor(body: function.body)
                }
                
                if let property = member as? AstPropertyDeclaration {
                    if let getter = property.getter {
                        visitor(body: getter)
                    }
                    
                    if let setter = property.setter {
                        visitor(body: setter)
                    }
                }
            }
        }
    }
    
    func findTypeDeclaration(type : Type) -> AstTypeDeclaration? {
        let type = type.declaration.type
        for obj in types {
            if obj.cursor.type.spelling == type.spelling {
                return obj
            }
        }
        
        return nil
    }
}

extension String {
    func stringByRemovingPrefix(prefix : String) -> String {
        if self.hasPrefix(prefix) {
            if let range = self.rangeOfString(prefix)  {
                return self.substringFromIndex(range.last!.advancedBy(1))
            }
        }
        
        return self
    }
    
    func stringByConvertingToCamelCase() -> String {
        let name = self
        let letter = name.substringToIndex(name.startIndex.advancedBy(1)).lowercaseString
        return letter + name.substringFromIndex(name.startIndex.advancedBy(1))
    }
}

func removeIgnoredFunctions(node : AstModule) {
    for (idx, obj) in node.functions.enumerate() {
        if config.ignoredFunctions.contains(obj.name) {
            node.functions.removeAtIndex(idx)
            break
        }
    }
}

func wrappedTypes(root : AstModule) -> [String : Cursor] {
    var result = [String:Cursor]()
    
    for child in root.cursor.children {
        var obj = child
        if obj.kind == .TypedefDecl {
            obj = obj.typedefDeclarationUnderlyingType.declaration
        }
        
        
        if obj.kind == .EnumDecl || obj.kind == .StructDecl || obj.kind == .UnionDecl {
            if obj.type.spelling.containsString("anonymous") {
                continue
            }
            
            let info = obj.type.info()
            if info.isWrappable {
                result[info.wrappedSpelling] = obj
            }
        }
    }
    
    return result
}

func groupMethods(root : AstModule) {
    let methods = root.functions
    root.functions = []
    
    var dict = [String :[AstFunctionDeclaration]]()
    
    for obj in methods {
        let split = obj.name.componentsSeparatedByString("_")
        if split.count == 2 {
            let key = split.first!
            var arr = dict[key] ?? []
            obj.name = split.last!
            obj.modifier = "static"
            arr .append(obj)
            dict[key] = arr
            
        } else {
            obj.name = obj.name.stringByRemovingPrefix(config.prefix).stringByConvertingToCamelCase()
            root.functions.append(obj)
        }
    }
    
    for (key,decl) in wrappedTypes(root) {
        let value = decl.type.info()
        let type = AstTypeDeclaration(name: key, methods: [], cursor: decl)
        
        switch(value.kind) {
        case .Opaque:
            type.base = "OpaqueWrapper"
            type.kind = "class"
            
            type.members.append(AstSourceCode(src: "internal override init?(unowned : COpaquePointer) {super.init(unowned:unowned)}"))
            type.members.append(AstSourceCode(src: "internal override init(owned : COpaquePointer) {super.init(owned:owned)}"))
            
        case .Enum:
            fallthrough
        case .Struct:
            type.kind = "extension"
            type.alias = "typealias \(key) = \(config.prefix + key)"
        default:
            abort()
        }
        
        let methods = dict[config.prefix + key] ?? []
        
        for obj in methods {
            type.members.append(obj)
        }
        root.types.append(type)
    }
}

func translateWrappable(root : AstModule) {
    root.enumerateFunctions { (obj, owner) -> () in
        let info = obj.cursor.resultType.info()
        if info.isWrappable {
            obj.returnType = info.wrappedSpelling
            if info.kind == .Opaque {
                let unowned = config.owned.filter({obj.name.containsString($0)}).isEmpty
                if !unowned {
                    obj.body.returnWrapper = { "\(info.wrappedSpelling)(owned:\($0))" }
                } else {
                    obj.body.returnWrapper = { "\(info.wrappedSpelling)(unowned:\($0))!" }
                }
            }
        }
        
        if info.type.spelling == "sfBool" {
            obj.returnType = "Bool"
            obj.body.returnWrapper = {"Bool(\($0))"}
        }
        
        if info.type.spelling == "const char *" {
            obj.returnType = "String"
            obj.body.returnWrapper = {"String(\($0))"}
        }
        
        let params = obj.body.params
        let count = obj.arguments.count
        for i in 0..<count {
            let arg = obj.arguments[i]
            let exp = params[i]
            
            let info = arg.cursor.type.info()
            if info.isWrappable {
                arg.type = info.wrappedSpelling
                if info.kind == .Opaque {
                    assert(!exp.src.containsString(".ptr"))
                    exp.src += ".ptr"
                }
            }
            
            if info.type.spelling == "sfBool" {
                exp.src = "Int32(\(exp.src))"
                arg.type = "Bool"
            }
            
            if info.type.spelling == "const char *" {
                arg.type = "String"
            }
            
            if arg.type.containsString("Pointer") {
                let pointee = info.type.canonicalType.pointeeType
                if pointee.info().kind == .Struct {
                    if pointee.isConstQualifiedType {
                        
                        if arg.left.hasSuffix("s") && !pointee.info().wrappedSpelling.hasSuffix("s") {
                            
                        } else {
                            arg.type = pointee.info().wrappedSpelling + "?"
                            exp.src = "pointer(&\(exp.src))"
                            obj.body.toMutate.append(arg.left)
                        }
                    } else {
                        arg.left = "inout " + arg.left
                        arg.type = pointee.info().wrappedSpelling
                        exp.src = "&"+exp.src                    }
                }
            }
        }
    }
}

func translateInstanceMethods(root : AstModule) {
    root.enumerateFunctions { (obj, owner) -> () in
        if obj.name.containsString("create") && !obj.name.containsString("createMask")  {
            obj.emitter = AstFunctionDeclaration.emitInit
            obj.modifier = ""
            obj.body.returnWrapper = {"super.init(owned:\($0))"}
        }
        
        else if obj.name.containsString("destroy") {
            obj.emitter = AstFunctionDeclaration.emitDeinit
            obj.modifier = ""
            obj.body.params.first?.src = "self.ptr"
            obj.body.returnWrapper = {"if owned {\($0)}"}
        } else {
            if let arg = obj.cursor.argumentCursors.first {
                let info = arg.type.info()
                let spelling = info.wrappedSpelling
                if !spelling.isEmpty && obj.cursor.spelling.containsString(spelling) {
                    obj.modifier = ""
                    obj.arguments.removeFirst()
                    obj.body.params.first?.src = info.kind == .Opaque ? "self.ptr" : "self"
                }
            }
        }
    }
}


extension AstTypeDeclaration {
    func removeMethod(object: AstFunctionDeclaration) -> Bool {
        for (idx, other) in self.members.enumerate() {  //in old swift use enumerate(self)
            if let other = other as? AstFunctionDeclaration {
                if other === object {
                    self.members.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
}


func createProperties(root : AstModule) {
    class CreatePropertiesInfo {
        var getter : AstFunctionDeclaration?
        var setter : AstFunctionDeclaration?
    }
    
    for type in root.types {
        var dict = [String : CreatePropertiesInfo]()
        func get(key : String) -> CreatePropertiesInfo {
            if let obj = dict[key] {
                return obj
            }
            let obj = CreatePropertiesInfo()
            dict[key] = obj
            return obj
        }
        
        for member in type.members {
            if let method = member as? AstFunctionDeclaration {
                var name = method.name
                
                if name.hasPrefix("is") && method.arguments.isEmpty {
                    get(name).getter = method
                }
                
                if name.hasPrefix("get") && method.arguments.isEmpty {
                    name = name.stringByRemovingPrefix("get")
                    get(name).getter = method
                }
                
                if name.hasPrefix("set") && method.arguments.count == 1 && method.returnType == "()" {
                    name = name.stringByRemovingPrefix("set")
                    get(name).setter = method
                }
                
            }
        }
        
        for (key, value) in dict {
            guard let getter = value.getter else {
                continue
            }
            
            if let setter = value.setter {
                type.removeMethod(setter)
            }
            type.removeMethod(getter)
            
            let prop = AstPropertyDeclaration()
            prop.name = key.stringByConvertingToCamelCase()
            prop.type = getter.returnType
            prop.getter = getter.body
            prop.setter = value.setter?.body
            
            if let setterBody = value.setter?.body {
                prop.setterName = setterBody.cursor.argumentCursors[1].spelling
            }
            
            type.members.append(prop)
        }
    }
}

func createEnums(root : AstModule) {
    func commonPrefix(array : [String]) -> String {
        var result = array.first!
        
        for obj in array {
            result = result.commonPrefixWithString(obj, options: NSStringCompareOptions())
        }
        
        return result
    }
    
    
    for obj in root.types {
        if obj.cursor.type.info().kind == .Enum {
            obj.kind = "enum"
            obj.alias = ""
            
            let decl = obj.cursor.type.declaration
            obj.base = decl.enumDeclarationIntegerType.info().rawSpelling
            
            let common = commonPrefix(decl.children.map({$0.spelling}))
            
            for child in decl.children {
                assert(child.kind == .EnumConstantDecl)
                let name = child.spelling.stringByRemovingPrefix(common)
                obj.members.append(AstSourceCode(src: "case \(name) = \(child.enumConstantDeclarationValue)"))
            }
        }
    }

    root.visitFunctionCalls { (body) -> () in
        let retInfo = body.cursor.resultType.info()
        if retInfo.kind == .Enum {
            body.returnWrapper = {"\(retInfo.wrappedSpelling)(rawValue:\($0).rawValue)!"}
            //body.returnWrapper = {"unsafeBitCast(\($0), \(retInfo.wrappedSpelling).self)"}
        }
        
        for obj in body.params {
            let paramInfo = obj.cursor.type.info()
            if paramInfo.kind == .Enum {
                obj.src = "\(config.prefix)\(paramInfo.wrappedSpelling)(rawValue:\(obj.src).rawValue)"
                //obj.src = "unsafeBitCast(\(obj.src), \(config.prefix)\(paramInfo.wrappedSpelling).self)"
            }
        }
    }
}

func addConstants(root : AstModule) {
    for obj in root.cursor.children {
        let obj = obj.kind == .UnexposedDecl ? obj.children.first! : obj
        if obj.kind == .VarDecl {
            let ownerType = root.findTypeDeclaration(obj.type)!
            let mappedName = obj.spelling
                .componentsSeparatedByString("_")
                .last!.stringByRemovingPrefix(config.prefix)
                .stringByConvertingToCamelCase()
            
            let src = "static let \(mappedName) = \(obj.spelling)"
            ownerType.members.append(AstSourceCode(src: src))
            print("VarDecl " + obj.type.info().wrappedSpelling)
        }
    }
}

func applyReplaced(root : AstModule) {
    for obj in root.types {
        if config.replaced.contains(obj.name) {
            obj.alias = ""
            obj.name = config.prefix + obj.name
            obj.kind = "extension"
        }
    }
}

run()