//
//  Ast.swift
//  ClangTool
//

import Foundation

typealias TranslateClosure = (String) -> (String)

class AstCursorNode : AstNode {
    let cursor : Cursor!
    
    init(cursor : Cursor!) {
        self.cursor = cursor
    }
    
    init(cursor : Cursor) {
        self.cursor = cursor
    }
    
    func emit() -> String {
        abort()
    }
}

protocol AstNode {
    func emit() -> String
}

func emitJoin(nodes : [AstNode], separator : String) -> String{
    let generated = nodes.map({$0.emit()})
    return generated.joinWithSeparator(separator)
}

extension Array where Element : AstNode{
    func emitJoin(separator : String) -> String {
        let generated = self.map({$0.emit()})
        return generated.joinWithSeparator(separator)
    }
}


class AstModule : AstCursorNode {
    var functions : [AstFunctionDeclaration]
    var types : [AstTypeDeclaration] = []
    
    override init(cursor : Cursor) {
        let functions = cursor.children.map({obj in
            return obj.kind == .UnexposedDecl ? obj.children.first! : obj
        }).filter({ $0.kind == .FunctionDecl})
        
        self.functions = functions.map({AstFunctionDeclaration(cursor: $0)})
        super.init(cursor: cursor)
    }
    
    override func emit() -> String {
        return "import CSFML \n\(functions.emitJoin("\n"))\n\(types.emitJoin("\n"))"
    }
}

protocol AstTypeMember : AstNode {
    
}

class AstSourceCode : AstTypeMember {
    var code : String
    init(src : String) {
        code = src
    }
    
    func emit() -> String {
        return code
    }
}
class AstFunctionDeclaration : AstCursorNode, AstTypeMember {
    var arguments : [AstArgument]
    var body : AstFunctionBody
    var name : String
    var returnType : String
    
    var modifier = ""
    var emitter = AstFunctionDeclaration.emitMethod
    
    override init(cursor : Cursor) {
        self.arguments = cursor.argumentCursors.map({AstArgument(cursor: $0)})
        name = cursor.spelling
        returnType = cursor.resultType.info().rawSpelling
        body = AstFunctionBody(cursor: cursor)
        super.init(cursor: cursor)
    }
    
    func emitMethod() -> String {
        let args = arguments.emitJoin(", ")
        let returnWrap = returnType.isEmpty ? "" : " -> " + returnType
        let body = self.body.emit()
        
        var modifier = self.modifier
        if !modifier.isEmpty {
            modifier += " "
        }
        
        return "\(modifier)func \(name)(\(args))\(returnWrap) {\(body)}"
    }
    
    func emitDeinit() -> String {
        let body = self.body.emit(false)
        return "deinit {\(body)}"
    }
    
    func emitInit() -> String {
        let body = self.body.emit(false)
        let args = arguments.emitJoin(", ")
        
        var modifier = self.modifier
        if !modifier.isEmpty {
            modifier += " "
        }
        
        return modifier+"init(\(args)) {\(body)}"
    }
    
    override func emit() -> String {
        return emitter(self)()
    }
}

class AstArgument : AstCursorNode {
    var left : String
    var type : String
    override init(cursor : Cursor) {
        left = cursor.spelling
        if left.isEmpty {
            left = "value"
        }
        type = cursor.type.info().rawSpelling
        super.init(cursor: cursor)
    }
    
    override func emit() -> String {
        return left + " : " + type
    }
}

class AstExpression : AstCursorNode {
    var src : String
    
    init(code : String) {
        src = code
        super.init(cursor: nil)
    }
    
    init(cursor : Cursor, code : String) {
        src = code
        super.init(cursor: cursor)
    }
    
    override func emit() -> String {
        return src
    }
}

class AstTypeDeclaration : AstCursorNode {
    var members = [AstTypeMember]()
    var name = ""
    var base = ""
    var kind = "class"
    var alias = ""
    
    init(name : String, methods : [AstFunctionDeclaration], cursor : Cursor!) {
        for obj in methods {
            self.members.append(obj)
        }
        self.name = name.stringByRemovingPrefix(config.prefix)
        super.init(cursor: cursor)
    }
    
    override func emit() -> String {
        let alias = self.alias.isEmpty ? "" : self.alias + "\n"
        let base = self.base.isEmpty ? "" : " : " + self.base
        
        let converted = members.map({$0 as AstNode})
        
        let inner = emitJoin(converted, separator: "\n")
        return "\(alias)\(kind) \(name)\(base) { \n\(inner)\n }"
    }
}

class AstFunctionBody : AstCursorNode {
    var name : String
    var params : [AstExpression]
    var toMutate : [String] = []
    
    var returnWrapper : ((String)->(String))? = nil
    
    init() {
        self.name = ""
        self.params = []
        super.init(cursor: nil)
    }
    
    override init(cursor : Cursor) {
        name = cursor.spelling
        
        params = cursor.argumentCursors.map({ obj in
            var code = obj.spelling
            
            if code.isEmpty {
                code = "value"
            }
            
            return AstExpression(cursor: obj, code: code)
        })
        super.init(cursor: cursor)
    }
    
    override func emit() -> String {
        return emit(true)
    }
    
    func emit(withReturn : Bool) -> String {
        let inner = params.emitJoin(", ")
        var result = "\(name)(\(inner))"
        if let returnWrapper = returnWrapper {
            result = returnWrapper(result)
        }
        
        if withReturn {
            result = "return " + result
        }
        
        if !toMutate.isEmpty {
            var line = "var "
            let mapped = toMutate.map({"\($0)=\($0)"})
            line += mapped.joinWithSeparator(", ")
            line += ";"
            
            result = line + result
        }
        
        return result
    }
}

class AstPropertyDeclaration : AstNode, AstTypeMember {
    var name = ""
    var type = ""
    var getter : AstFunctionBody?
    var setter : AstFunctionBody?
    var setterName = "value"
    
    func emit() -> String {
        var inner = ""
        
        if let getter = getter {
            inner += "get {\(getter.emit())} "
        }
        
        if let setter = setter {
            inner += "set(\(setterName)) {\(setter.emit())} "
        }
        
        return "var \(name) : \(type) {\(inner)}"
    }
}
