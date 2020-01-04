//
//  ViewController.swift
//
//  Created by Matthew Larkins on 01/02/2020
//  Open-source. Use it however you want, just credit me and
//  keep it libre. I got a great start on creating a draggable
//  UIView thanks to Arthur Knopper's tutorial called
//  IOS10DraggingViewsTutorial. I accessed Arthur's tutorial at:
//  https://www.ioscreator.com/tutorials/drag-views-gestures-ios-tutorial
//  on 01/02/2020.
//

import UIKit

class ViewController: UIViewController, ThumbStickDelegate {
    
    let knobWidth: CGFloat = 100
    let knobHeight: CGFloat = 100
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var originalPositionCGPoint = CGPoint()
    var knobView = MyThumbStick()
    @IBOutlet weak var knobOutline: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the knob
        originalPositionCGPoint = CGPoint(x: (screenWidth / 2 - knobWidth / 2), y: (screenHeight - (2 * screenHeight / 3 - knobHeight / 2) / 2))
        
        knobView = MyThumbStick(frame: CGRect(origin: originalPositionCGPoint, size: CGSize(width: knobWidth, height: knobHeight)))
        knobView.delegate = self
        knobView.originalPosition = originalPositionCGPoint
        knobOutline.center = knobView.center
        self.view.addSubview(knobView)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panEnded(_ sender: MyThumbStick) {
        MyThumbStick.animate(withDuration: 0.1, animations: {
            self.knobView.frame.origin = self.originalPositionCGPoint
        })
    }


}

