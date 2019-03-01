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
}
