//
//  GameScene.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let balls = ["ballBlue", "ballGreen", "ballPurple", "ballRed", "ballYellow"]
    var motionManager: CMMotionManager?
    
    // score label
    let scoreLabel = SKLabelNode(fontNamed: "Avenir Next")
    
    // state
    
    
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
        
        // balls will fall but can't escape an area
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)))
        
        // set up motion manager
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        updatePhysicsBody()
    }
    
    
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
