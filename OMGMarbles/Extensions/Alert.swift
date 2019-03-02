//
//  Alert.swift
//  OMGMarbles
//
//  Created by Shawon Ashraf on 3/2/19.
//  Copyright © 2019 Shawon Ashraf. All rights reserved.
//

import UIKit

extension GameScene {
    func showAlert() {
        let gameOverAlert = UIAlertController(title: "Well...You beat the game!", message: "Want to start over again?", preferredStyle: .actionSheet)
        
        let nope = UIAlertAction(title: "Nope", style: .default) {
            (action) in
            // do nothing
        }
        let reset = UIAlertAction(title: "Let's do it again!", style: .default) { (action) in
            if self.rippleEffectOn {
                // reset the game
                self.resetState()
                self.resetScene()
                
                // start a new game
                self.setupScene(for: self.view!)
            }
        }
        
        gameOverAlert.addAction(nope)
        gameOverAlert.addAction(reset)
        
        // popover controller
        // since alertViews fail on iPad
        if let popOverController = gameOverAlert.popoverPresentationController {
            popOverController.sourceView = self.viewController!.view
            let view = self.viewController.view!
            
            // put at the center of the view
            popOverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popOverController.permittedArrowDirections = []
        }
        
        self.viewController!.present(gameOverAlert, animated: true)
    }
}
