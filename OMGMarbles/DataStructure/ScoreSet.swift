//
//  ScoreSet.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import Foundation
import CoreMotion
import SpriteKit

class ScoreSet {
    public var matchedBalls: Set<Ball>
    
    init() {
        matchedBalls = Set<Ball>()
    }
    
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
}
