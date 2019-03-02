//
//  GameLoop.swift
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
    func resetScene() {
        let children = self.children
        for child in children {
            child.removeAllActions()
            child.removeAllChildren()
            child.removeFromParent()
        }
    }
    
    func resetState() {
        // reset state
        score = 0
        rippleEffectOn = false
    }
    
    func setupScene(for view: SKView) {
        // set props
        setBackgroundProps(background: background)
        
        addChild(background)
        
        // set scorelabel props
        setScoreLabelProps(scoreLabel: scoreLabel)
        addChild(scoreLabel)
        
        let ball = SKSpriteNode(imageNamed: "ballBlue")
        let ballRadius = ball.frame.width / 2.0
        
        // bounds for ball movement so that it stays inside the scene
        for i in stride(from: ballRadius, to: view.bounds.width - ballRadius, by: ball.frame.width) {
            for j in stride(from: 100, to: view.bounds.height - ballRadius, by: ball.frame.height) {
                // get a random ball
                let ballType = balls.randomElement()!
                let newBall = Ball(imageNamed: ballType)
                newBall.position = CGPoint(x: i, y: j)
                newBall.name = ballType
                
                // set physics prop
                setPhysicsProps(for: newBall, withRadius: ballRadius)
                
                // add the newly generated ball
                addChild(newBall)
            }
        }
        
        // balls will fall but can't escape an area
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)))
        
        // set up motion manager
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
    }
}
