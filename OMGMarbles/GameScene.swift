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
    let MIN_REMAINING_BALLS = 80
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
    
    // ripple effect flag
    var rippleEffectOn = false
    
    // set to contain macthed balls
    var matchedBalls = Set<Ball>()
    
    // fragment shader
    let uniforms: [SKUniform] = [
        SKUniform(name: "u_speed", float: 1),
        SKUniform(name: "u_strength", float: 3),
        SKUniform(name: "u_frequency", float: 20)
    ]
    
    // bakground texture
    let background = SKSpriteNode(imageNamed: "checkerboard")
    
    override func didMove(to view: SKView) {
        setupScene(for: view)
    }
    
    override func update(_ currentTime: TimeInterval) {
        updatePhysicsBody()
        // checkFlag
        setRippleFlag()
        
        // don't show ripple effect if flag is set to false
        if rippleEffectOn {
            showRippleEffect(on: background)
        }
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
