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
    func showRippleEffect(on background: SKSpriteNode, with uniforms: [SKUniform] ) {
        let shader = SKShader(fileNamed: "Background")
        shader.uniforms = uniforms
        background.shader = shader
        
        // repeat background rotation
        background.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 10)))
    }
}
