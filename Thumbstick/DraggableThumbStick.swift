//
//  DraggableThumbStick.swift
//  Thumbstick
//
//  Created by Matthew Alan Larkins on 1/2/20.
//  Copyright © 2020 Matthew Alan Larkins. All rights reserved.
//

import UIKit

class DraggableThumbStick: UIView {
    var lastLocation = CGPoint(x: 0, y: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan))
        self.gestureRecognizers = [panRecognizer]

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation  = recognizer.translation(in: self.superview)
        self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
    }

}
