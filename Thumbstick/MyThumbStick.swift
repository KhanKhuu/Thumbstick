//
//  MyThumbStick.swift
//
//  Created by Matthew Larkins on 01/02/2020
//  Open-source. Use it however you want, just credit me and
//  keep it libre. I got a great start on creating a draggable
//  UIView thanks to Arthur Knopper's tutorial called
//  IOS10DraggingViewsTutorial. I accessed Arthur's tutorial at:
//  https://www.ioscreator.com/tutorials/drag-views-gestures-ios-tutorial
//  on 01/02/2020.//

import UIKit

protocol ThumbStickDelegate {
    func panEnded(_ sender: MyThumbStick)
}

class MyThumbStick: UIView {

    var delegate: ThumbStickDelegate?
    var lastLocation = CGPoint(x: 0, y: 0)
    var originalPosition = CGPoint()
    private let knobMaxDistanceFromOriginalPosition = CGFloat(75)
//    private var totalTranslationX = CGFloat(0.0)
//    private var totalTranslationY = CGFloat(0.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initialization code
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(MyThumbStick.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        
        let imageView = UIImageView(image: UIImage(named: "knob"))
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.addSubview(imageView)
        self.bringSubviewToFront(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func detectPan(_ recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.superview)

        if (hypot(translation.x, translation.y) < knobMaxDistanceFromOriginalPosition) {
            self.center = CGPoint(x: lastLocation.x + translation.x, y: lastLocation.y + translation.y)
        } else {
            self.center = getNewCoords(translation)
        }
        
        if (recognizer.state == .ended) {
            delegate?.panEnded(self)
            
        }
    }
    
    func getNewCoords(_ translation: CGPoint) -> CGPoint {
        let a2 = translation.x
        let b2 = translation.y
        let d1 = knobMaxDistanceFromOriginalPosition
        var a1 = d1 * sin(atan(a2 / b2))
        var b1 = d1 * cos(atan(a2 / b2))
        
        // the following statement deals the sign uncertainty after the trig functions
        if translation.x > 0 {
            if translation.y < 0 {
                a1 *= -1
                b1 *= -1
            }
        } else {
            if (translation.y < 0) {
                a1 *= -1
                b1 *= -1
            }
        }
        
        let x = originalPosition.x + a1
        let y = originalPosition.y + b1

        return CGPoint(x: x, y: y)
    }
    
    override func touchesBegan(_ touches: (Set<UITouch>?), with event: UIEvent!) {
        // Promote the touched view
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
        originalPosition = self.center
    }
    
    func moveTo(_ point: CGPoint) {
        self.frame.origin = point
    }
}
