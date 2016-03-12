//
//  TypeInfo.swift
//  ClangTool
//

import Foundation

let primitives : [TypeKind : String] = {
    var dict = [TypeKind : String]()
    dict[TypeKind.Short] = String(Int16.self)
    dict[TypeKind.UShort] = String(UInt16.self)
    dict[TypeKind.Int] = String(Int32.self)
    dict[TypeKind.Char_S] = String(Int8.self)
    dict[TypeKind.SChar] = String(Int8.self)
    dict[TypeKind.UChar] = String(UInt8.self)
    dict[TypeKind.Float] = String(Float.self)
    dict[TypeKind.Double] = String(Double.self)
    dict[TypeKind.UInt] = String(UInt32.self)
    dict[TypeKind.Void] = String(Void.self)
    dict[TypeKind.Long] = String(Int.self)
    dict[TypeKind.ULong] = String(Int.self)
    dict[TypeKind.LongLong] = String(Int64.self)
    dict[TypeKind.ULongLong] = String(UInt64.self)
    dict[TypeKind.WChar] = String(Int32.self)
    
    return dict
}()


enum TypeInfoKind {
    case Opaque, Pointer, MutablePointer, Basic, Struct, Enum, Function
}

private func analyse(inputType : Type) -> TypeInfo {
    var type = inputType
    type = type.kind == .Typedef ? type.declaration.typedefDeclarationUnderlyingType : type
    type = type.canonicalType
    

    
    if type.kind == .Pointer {
        var basePointee = type
        while basePointee.kind == .Pointer {
            basePointee = basePointee.pointeeType
        }
        
        let pointee = type.pointeeType
        
        if pointee.kind == .FunctionProto {
            let spelling = inputType.spelling
            
            if spelling.containsString("*") {
                let result = pointee.resultType.info().rawSpelling
                let args = pointee.argumentTypes!.map({$0.info().rawSpelling})
                let spelling = "@convention(c) (\(args.joinWithSeparator(", "))) -> (\(result))"
                
                return TypeInfo(type: inputType, kind: .Function, rawSpelling: spelling)
            }
            
            return TypeInfo(type: inputType, kind: .Function, rawSpelling: spelling)
        }
        
        
        let pointeeInfo = type.pointeeType.info()
        
        if pointee.declaration.children.count == 0 && basePointee.kind == .Record {
            return TypeInfo(type: inputType, kind: .Opaque, rawSpelling: "COpaquePointer")
        }
        
        let const = pointee.isConstQualifiedType
        if const {
            return TypeInfo(type: inputType, kind: .Pointer, rawSpelling: "UnsafePointer<\(pointeeInfo.rawSpelling)>", pointee: pointeeInfo)
        } else {
            return TypeInfo(type: inputType, kind: .Pointer, rawSpelling: "UnsafeMutablePointer<\(pointeeInfo.rawSpelling)>", pointee: pointeeInfo)
        }
    }
    
    if type.kind == .Record {
        
        if type.declaration.children.count == 0 {
            return TypeInfo(type: inputType, kind: .Opaque, rawSpelling: "COpaquePointer")
        }
        
        let spelling = type.spelling.stringByReplacingOccurrencesOfString("const ", withString: "")
        return TypeInfo(type: inputType, kind: .Struct, rawSpelling: spelling)
    }
    
    if type.kind == .Enum {
        let spelling = type.spelling.stringByReplacingOccurrencesOfString("const ", withString: "")
        return TypeInfo(type: inputType, kind: .Enum, rawSpelling: spelling)
    }
    
    if type.kind == .FunctionProto {
        return TypeInfo(type: inputType, kind: .Function, rawSpelling: "FunctionProto")
    }
    
    return TypeInfo(type: inputType, kind: .Basic, rawSpelling: primitives[type.kind]!)
}

class TypeInfo : CustomDebugStringConvertible {
    var type : Type
    var kind : TypeInfoKind
    var rawSpelling : String

    var pointee : TypeInfo? = nil
    
    init(type : Type, kind : TypeInfoKind, rawSpelling : String, pointee : TypeInfo? = nil) {
        self.type = type
        self.kind = kind
        self.rawSpelling = rawSpelling
        self.pointee = pointee
        self.wrappedSpelling = ""
        
        if self.isWrappable {
            var spelling = type.spelling
            spelling = spelling.stringByReplacingOccurrencesOfString("const ", withString: "")
            spelling = spelling.stringByReplacingOccurrencesOfString(" *", withString: "")
            assert(isWrappable)
            
            assert(spelling.hasPrefix(config.prefix))
            let range = spelling.rangeOfString(config.prefix)
            wrappedSpelling = spelling.substringFromIndex(range!.last!.advancedBy(1))
        }
    }
    
    var debugDescription: String {
        get {
            return "TypeInfo : \(rawSpelling) : \(type.spelling)"
        }
    }
    
    var isWrappable : Bool {
        get {
            let kind = self.kind
            return kind == .Opaque || kind == .Struct || kind == .Enum
        }
    }
    
    var wrappedSpelling : String
}

var cache =  [String : TypeInfo]()
extension Type {
    func info() -> TypeInfo {
        let key = self.spelling
        var obj = cache[key]
        if obj == nil {
            obj = analyse(self)
            cache[key] = obj
        }
        
        //assert(obj!.type == self)
        
        return obj!
    }
}