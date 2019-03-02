//
//  Effects.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

extension GameScene {
    // show the ripple effect
    func showRippleEffect() {
        let shader = SKShader(fileNamed: "Background")
        shader.uniforms = uniforms
        background.shader = shader
        
        // repeat background rotation
        let ripple = SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 10))
        background.run(ripple, withKey: "ripple")
    }
    
    // stopRippleEffect
    func stopRippleEffect() {
        if let ripple = background.action(forKey: "ripple") {
            ripple.speed = 0
        } else {
            print("Error")
        } 
        background.removeAction(forKey: "ripple")
    }
    
    // set flag
    func setRippleFlag() {
        if countRemainingBalls() <= MIN_REMAINING_BALLS {
            rippleEffectOn = true
        }
    }
    
    // remaining balls count
    func countRemainingBalls() -> Int {
        var remaining = 0
        let children = self.children
        
        for child in children {
            guard let _ = child as? Ball else { continue }
            remaining += 1
        }
        
        return remaining
    }
}
