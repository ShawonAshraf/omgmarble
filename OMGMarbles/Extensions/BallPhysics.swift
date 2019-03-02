//
//  ScoreSet.swift
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
    // check if a given ball is in contact with a ball of the matching color
    // if not add it to the set, else pop it
    // rinse, repeat. it'll go on a recurtsion
    func getMatches(from node: Ball) {
        for body in node.physicsBody!.allContactedBodies() {
            guard let ball = body.node as? Ball else { continue }
            guard ball.name == node.name else { continue }
            
            if !matchedBalls.contains(ball) {
                matchedBalls.insert(ball)
                getMatches(from: ball)
            }
        }
    }
    
    // based on distance
    // because physics can get it wrong at times
    func distanceSquared(from: Ball, to: Ball) -> CGFloat {
        let dx = pow(from.position.x - to.position.x, 2)
        let dy = pow(from.position.y - to.position.y, 2)
        
        return dx + dy
    }
    
    func getMatchesBasedOnDistance(from startBall: Ball) {
        let matchWidth = pow(startBall.frame.width, 2) * 1.1
        
        for node in children {
            guard let ball = node as? Ball else { continue }
            guard ball.name == startBall.name else { continue }
            
            let distance = distanceSquared(from: startBall, to: ball)
            
            guard distance < matchWidth else { continue }
            
            if !matchedBalls.contains(ball) {
                matchedBalls.insert(ball)
                getMatchesBasedOnDistance(from: ball)
            }
        }
    }
    
    // display the OMG sprite
    func showOmgPopUp() {
        let omg = SKSpriteNode(imageNamed: "omg")
        omg.position = CGPoint(x: frame.midX, y: frame.midY)
        omg.zPosition = 100
        omg.xScale = 0.001
        omg.yScale = 0.001
        
        addChild(omg)
        
        let appear = SKAction.group([SKAction.scale(to: 1, duration: 0.25), SKAction.fadeIn(withDuration: 0.25)])
        let disappear = SKAction.group([SKAction.scale(to: 2, duration: 0.25), SKAction.fadeOut(withDuration: 0.25)])
        let sequence = SKAction.sequence([appear, SKAction.wait(forDuration: 0.25), disappear])
        omg.run(sequence)
    }
    
    // show pop explosion
    func popExplosion(ball: SKNode) {
        // pop the balls when matched
        if let particles = SKEmitterNode(fileNamed: "Explosion") {
            particles.position = ball.position
            addChild(particles)
            
            // remove from scene
            let removeAfterDead = SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.removeFromParent()])
            particles.run(removeAfterDead)
        }
    }
}
