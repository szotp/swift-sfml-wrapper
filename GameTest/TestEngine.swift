//
//  TestEngine.swift
//  ClangTool
//
//  Created by krzat on 10.03.2016.
//

import Foundation

class Content {
    static let blank : Texture = {
        let texture = Texture(width: 1, height: 1)
        texture.updateFromPixels([255,255,255,255], width: 1, height: 1, x: 0, y: 0)
        return texture
    }()
    
    static func texture(name : String) -> Texture {
        if name == "blank" {
            return blank
        }
        
        abort()
    }
    
    static let font = Font(filename: "/System/Library/Fonts/Monaco.dfont")
    
    static func font(name : String) -> Font {
        return font
    }
}

protocol Scene {
    func isRunning() -> Bool
    func draw(window : RenderWindow)
    func update(dT : Float)
    func handleEvent(event : Event)
}

struct GameSettings {
    var videoMode = VideoMode(width: 800, height: 600, bitsPerPixel: 32)
    var title = "SFML Game"
    var frameRateLimit = 0
    var verticalSyncEnabled = true
    var contextSettings : ContextSettings? = nil
    var style = [WindowStyle.Resize]
}

extension RenderWindow {
    convenience init(settings : GameSettings = GameSettings()) {
        var style = UInt32()
        for obj in settings.style {
            style |= obj.rawValue
        }
        
        self.init(mode: settings.videoMode, title: settings.title, style: style, settings: settings.contextSettings)
        self.setFramerateLimit(UInt32(settings.frameRateLimit))
        self.setVerticalSyncEnabled(settings.verticalSyncEnabled)
    }
    
    func run(scene : Scene) {
        let window = self
        var timing = [Float]()
        
        let label = Text()
        label.font = Content.font
        label.characterSize = 12
        
        let clock = Clock.init()
        let drawClock = Clock()
        
        var event = Event()
        while window.isOpen && scene.isRunning() {
            let dT = clock.elapsedTime.asSeconds()
            clock.restart()
            
            
            scene.update(dT)
            window.clear(Color.black)
            
            drawClock.restart()
            scene.draw(window)
            timing.append(drawClock.elapsedTime.asSeconds())
            if timing.count >= 10 {
                var acc = Float()
                for obj in timing {
                    acc += obj
                }
                let avg = acc/10*1000
                label.string = "avg frame: \(avg)ms"
                //print("avg frame: \(avg)ms")
                timing.removeAll()
            }
            window.drawText(label, states: nil)
            window.display()
            sleep(milliseconds(1))
            
            while window.pollEvent(&event) {
                if event.type == .Closed {
                    window.close()
                    break
                } else {
                    scene.handleEvent(event)
                }
                
            }
        }
    }
}

class SpriteBatch {
    private var vertices : [Vertex]
    var states = RenderStates()
    
    private var memory : UnsafeMutablePointer<Vertex>! = nil
    private var count = 0
    private var capacity = 400
    
    private func setMemory( ptr : UnsafeMutablePointer<Vertex>) {
        memory = ptr
    }
    
    init() {
        vertices = [Vertex]()
        vertices.reserveCapacity(capacity)
        setMemory(&vertices)
    }
    
    func reserveQuad() -> UnsafeMutablePointer<Vertex> {
        if count + 4 > capacity {
            capacity *= 2
            vertices.reserveCapacity(capacity)
            setMemory(&vertices)
        }
        let ptr = memory.advancedBy(count)
        count += 4
        return ptr
    }
    
    func draw(position : Vector2f, rec : IntRect, color : Color, scale : Vector2f, origin : Vector2f, rotation : Float = 0) {
        var _sin = Float(0), _cos = Float(1);
        if rotation != 0 {
            let rotation = rotation / 180 * Float(M_PI)
            _sin = sin(rotation)
            _cos = cos(rotation)
        }

        var scale = scale
        
        var pX = -origin.x * scale.y;
        var pY = -origin.y * scale.y;
        
        scale.x *= Float(rec.width);
        scale.y *= Float(rec.height);
        
        var ptr = reserveQuad()
        ptr.memory.position.x = pX * _cos - pY * _sin + position.x;
        ptr.memory.position.y = pX * _sin + pY * _cos + position.y;
        ptr.memory.texCoords.x = Float(rec.left);
        ptr.memory.texCoords.y = Float(rec.top);
        ptr.memory.color = color;
        //test
        ptr = ptr.advancedBy(1)
        pX += scale.x;
        ptr.memory.position.x = pX * _cos - pY * _sin + position.x;
        ptr.memory.position.y = pX * _sin + pY * _cos + position.y;
        ptr.memory.texCoords.x = Float(rec.left + rec.width)
        ptr.memory.texCoords.y = Float(rec.top);
        ptr.memory.color = color;
        
        ptr = ptr.advancedBy(1)
        pY += scale.y;
        ptr.memory.position.x = pX * _cos - pY * _sin + position.x;
        ptr.memory.position.y = pX * _sin + pY * _cos + position.y;
        ptr.memory.texCoords.x = Float(rec.left + rec.width);
        ptr.memory.texCoords.y = Float(rec.top + rec.height);
        ptr.memory.color = color;
        
        ptr = ptr.advancedBy(1)
        pX -= scale.x;
        ptr.memory.position.x = pX * _cos - pY * _sin + position.x;
        ptr.memory.position.y = pX * _sin + pY * _cos + position.y;
        ptr.memory.texCoords.x = Float(rec.left);
        ptr.memory.texCoords.y = Float(rec.top + rec.height);
        ptr.memory.color = color;
    }
    
    func draw(rec : FloatRect, src : IntRect, color : Color) {
        var ptr = reserveQuad()
        ptr.memory.position.x = rec.left;
        ptr.memory.position.y = rec.top;
        ptr.memory.texCoords.x = Float(src.left);
        ptr.memory.texCoords.y = Float(src.top);
        ptr.memory.color = color;
        
        ptr = ptr.advancedBy(1)
        ptr.memory.position.x = rec.left + rec.width;
        ptr.memory.position.y = rec.top;
        ptr.memory.texCoords.x = Float(src.left + src.width)
        ptr.memory.texCoords.y = Float(src.top);
        ptr.memory.color = color;
        
        ptr = ptr.advancedBy(1)
        ptr.memory.position.x = rec.left + rec.width;
        ptr.memory.position.y = rec.top + rec.height;
        ptr.memory.texCoords.x = Float(src.left + src.width);
        ptr.memory.texCoords.y = Float(src.top + src.height);
        ptr.memory.color = color;
        
        ptr = ptr.advancedBy(1)
        ptr.memory.position.x = rec.left;
        ptr.memory.position.y = rec.top + rec.height;
        ptr.memory.texCoords.x = Float(src.left);
        ptr.memory.texCoords.y = Float(src.top + src.height);
        ptr.memory.color = color;
    }
    
    func drawOn(window : RenderWindow) {
        window.drawPrimitives(memory, vertexCount: count, type: PrimitiveType.Quads, states: self.states)
    }
    
    func flush() {
        count = 0
    }
}
