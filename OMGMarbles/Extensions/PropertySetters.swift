//
//  PropertySetters.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


extension GameScene {
    // MARK: set background props
    func setBackgroundProps(background: SKSpriteNode) {
        // puts at the center of the screen
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        // matches the color to the background
        background.alpha = 0.2
        // put this behind everything so that it doesn't take over the balls
        background.zPosition = -1
    }
    
    
    // MARK: set physics properties for a randomly generated new ball
    func setPhysicsProps(for ball: Ball, withRadius ballRadius: CGFloat) {
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 0
        ball.physicsBody?.friction = 0
    }
    
    // MARK: update physics body properties based on accelermoter data
    func updatePhysicsBody() {
        // update motion gravity on accelerometer data
        if let accelerometerData = motionManager?.accelerometerData {
            // x and y will swap place since device is set to be in landscape mode
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
    }
    
    // MARK: scorelabel props
    func setScoreLabelProps(scoreLabel: SKLabelNode) {
        scoreLabel.fontSize = 72
        scoreLabel.position = CGPoint(x: 20, y: 20)
        scoreLabel.text = "SCORE: 0"
        scoreLabel.zPosition = 100
        scoreLabel.horizontalAlignmentMode = .left
    }
}
