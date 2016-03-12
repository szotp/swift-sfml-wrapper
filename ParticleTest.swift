//
//  SpriteBatch.swift
//  ClangTool
//
//  Created by krzat on 01/03/16.

//

import Foundation

class Particle {
    var position : Vector2f
    var color : Color
    var rotation : Float
    var rotationSpeed : Float
    var scale : Float
    
    var sprite : Sprite
    
    
    
    init() {
        color = Color(r: UInt8(rand()%255), g: 0, b: 0, a: UInt8(rand()%255))
        position = Vector2f(x: Float(rand()%800), y: Float(rand()%600))
        rotation = 0
        
        rotationSpeed = Float(rand() % 500)
        
        let sprite = Sprite()
        
        sprite.setTexture(Content.blank, resetRect: true)
        sprite.position = position
        sprite.color = color
        sprite.rotation = rotation
        sprite.origin = Vector2f(x: 0.5, y: 0.5)
        
        let scale = Float(rand() % 1000 / 50)+5
        sprite.scale = Vector2f(x: scale, y: scale)
        self.scale = scale
        self.sprite = sprite
        
    }
    
    
    func update(dT : Float) {
        rotation += dT * rotationSpeed
    }
    
    func drawOn(window : RenderWindow) {
        sprite.rotation = rotation
        window.drawSprite(sprite, states: nil)
    }
    
    func drawOn(batch : SpriteBatch) {
        let rect = IntRect(left: 0, top: 0, width: 1, height: 1)

        let origin = Vector2f(x: 0.5, y: 0.5)
        let scale = Vector2f(x: self.scale, y: self.scale)
        batch.draw(position, rec: rect, color: color, scale: scale, origin: origin, rotation: rotation)
    }
}

enum ParticleTestState : Int {
    case Sprites, SpriteBatch, SpriteBatchStatic
    
}

class ParticleTest : Scene {
    var state = ParticleTestState(rawValue: 0)! {
        didSet {
            status.string = "\(state)"
        }
    }
    
    var particles = [Particle]()
    var useBatch = true
    let batch = SpriteBatch()
    
    lazy var status : Text = {
        let text = Text()
        text.font = Content.font
        text.string = "SpriteBatch enabled"
        text.characterSize = 12
        
        return text
    }()
    
    func isRunning() -> Bool {
        return true
    }
    
    init() {
        for _ in 0...10000{
            particles.append(Particle())
        }
        batch.states.texture = Content.blank
    }
    
    func handleEvent(event: Event) {
        if event.type == .KeyPressed {
            state = ParticleTestState(rawValue: state.rawValue+1) ?? ParticleTestState.Sprites
        }
    }
    
    func update(dT: Float) {
        for p in particles {
            p.update(dT)
        }
    }
    
    func draw(window : RenderWindow) {
        switch state {
        case .Sprites:
            for p in particles{
                p.drawOn(window)
            }
            break
        case .SpriteBatch:
            batch.flush()
            for p in particles {
                p.drawOn(batch)
            }
            fallthrough
        case .SpriteBatchStatic:
            batch.drawOn(window)
            break
        }
        
        let height = status.localBounds.height + status.localBounds.top
        status.position = Vector2f(x: 0, y:window.size.to2f.y-height)
        
        window.drawText(status, states: nil)
    }
}
