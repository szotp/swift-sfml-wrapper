//
//  Extras.swift
//  ClangTool
//
//  Created by krzat on 27.02.2016.


import Foundation
import CSFML


class OpaqueWrapper {
    let ptr : COpaquePointer
    let owned : Bool
    init(owned : COpaquePointer) {
        assert(owned != nil)
        self.ptr = owned
        self.owned = true
    }
    
    init?(unowned : COpaquePointer) {
        self.ptr = unowned
        self.owned = false
        if unowned == nil {
            return nil
        }

    }
}

func pointer<T,U>(inout value : T?) -> UnsafePointer<U> {
    func inner<T,U>(value : UnsafePointer<T>) -> UnsafePointer<U> {
        return UnsafePointer(value)
    }
    
    if value != nil {
        return inner(&value!)
    } else {
        return nil
    }
}

extension Bool {
    init(_ value : Int32) {
        self = value != 0
    }
}

extension Int32 {
    init(_ value : Bool) {
        self = value ? 1 : 0;
    }
}

extension Event {
    var type : EventType{
        get {
            let result : sfEventType = self.type
            return EventType(rawValue: result.rawValue)!
        }
    }
}

extension TcpListener {
    func accept() -> (SocketStatus, TcpSocket?) {
        var ptr = COpaquePointer()
        let status = sfTcpListener_accept(self.ptr, &ptr)
        return (SocketStatus(rawValue: status.rawValue)!, TcpSocket(unowned:ptr))
    }
}

//typealias ThreadClosure = ()->()
//extension Thread  {
//    private class BlockWrapper {
//        var block : ThreadClosure
//        init(block : ThreadClosure) {
//            self.block = block
//        }
//    }
//
//    convenience init(function : ThreadClosure) {
//        let wrapper = BlockWrapper(block: function)
//        let userData = UnsafeMutablePointer<()>(Unmanaged.passRetained(wrapper).toOpaque())
//        //TODO: leak if closure never executed
//        
//        self.init(owned: sfThread_create({ userData in
//            let obj : BlockWrapper = Unmanaged.fromOpaque(COpaquePointer(userData)).takeRetainedValue()
//            obj.block()
//        }, userData))
//    }
//}

struct RenderStates {
    private var states : sfRenderStates
    
    init(texture : Texture? = nil, shader : Shader? = nil, transform : Transform = Transform.identity, blendMode : BlendMode = BlendMode.blendAlpha) {
        self.texture = texture
        self.shader = shader
        self.states = sfRenderStates(blendMode: blendMode, transform: transform, texture: self.texture?.ptr ?? nil, shader: self.shader?.ptr ?? nil)
    }
    
    var texture : Texture? {
        didSet {
            states.texture = self.texture?.ptr ?? nil
        }
    }
    var shader : Shader? {
        didSet {
            states.shader = self.shader?.ptr ?? nil
        }
    }
    var transform : Transform {
        get {
            return states.transform
        }
        set {
            states.transform = newValue
        }
    }
    var blendMode : BlendMode {
        get {
            return states.blendMode
        }
        set {
            states.blendMode = newValue
        }
    }
}




extension Vector2i {
    var to2f : Vector2f {
        get {
            return Vector2f(x: Float(self.x), y: Float(self.y))
        }
    }
}

extension Vector2u {
    var to2f : Vector2f {
        get {
            return Vector2f(x: Float(self.x), y: Float(self.y))
        }
    }
}

