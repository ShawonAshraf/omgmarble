//
//  GameScene.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var balls = ["ballBlue", "ballGreen", "ballPurple", "ballRed", "ballYellow"]
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "chekerboard")
        
        // puts at the center of the screen
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        // matches the color to the background
        background.alpha = 0.2
        // put this behind everything so that it doesn't take over the balls
        background.zPosition = -1
        addChild(background)
        
        let ball = SKSpriteNode(imageNamed: "ballBlue")
        let ballRadius = ball.frame.width / 2.0
        
        // bounds for ball movement so that it stays inside the scene
        for i in stride(from: ballRadius, to: view.bounds.width - ballRadius, by: ball.frame.width) {
            for j in stride(from: 100, to: view.bounds.height, by: ball.frame.height) {
                // get a random ball
                let ballType = balls.randomElement()!
                let ball = Ball(imageNamed: ballType)
                ball.position = CGPoint(x: i, y: j)
                ball.name = ballType
                addChild(ball)
            }
        }
    }
    
    override func sceneDidLoad() {
    }
}
