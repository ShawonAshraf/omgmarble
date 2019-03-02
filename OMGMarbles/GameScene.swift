//
//  GameScene.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let balls = ["ballBlue", "ballGreen", "ballPurple", "ballRed", "ballYellow"]
    let rippleScoreThreshold = 20000
    var motionManager: CMMotionManager?
    
    // score label
    let scoreLabel = SKLabelNode(fontNamed: "Avenir Next")
    
    // state
    var score = 0 {
        didSet {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            let formattedScore = formatter.string(from: score as NSNumber) ?? "0"
            scoreLabel.text = "SCORE: \(formattedScore)"
        }
    }
    var matchedBalls = Set<Ball>()
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "checkerboard")
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
        
        // show ripple when score goes past threshold
        
        if score >= rippleScoreThreshold {
            
        }
        
        // fragment shader
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_speed", float: 1),
            SKUniform(name: "u_strength", float: 3),
            SKUniform(name: "u_frequency", float: 20)
        ]
        
        // show ripple effect
        showRippleEffect(on: background, with: uniforms)
        
        // balls will fall but can't escape an area
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)))
        
        // set up motion manager
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        updatePhysicsBody()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let position = touches.first?.location(in: self) else { return }
        guard let tappedBall = nodes(at: position).first(where: { $0 is Ball }) as? Ball else {
            return
        }
        
        // if matched, let scoreSet do the work
        matchedBalls.removeAll(keepingCapacity: true)
        getMatchesBasedOnDistance(from: tappedBall)
        
        if matchedBalls.count >= 3 {
            score += Int(pow(2, Double(min(matchedBalls.count, 16))))
            
            for ball in matchedBalls {
                // explsion and pop!
                popExplosion(ball: ball)
                ball.removeFromParent()
            }
            
            // show a pop up
            if matchedBalls.count >= 5 {
                showOmgPopUp()
            }
        }
    }
}
