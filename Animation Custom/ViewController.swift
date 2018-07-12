//
//  ViewController.swift
//  Animation Custom
//
//  Created by omrobbie on 12/07/18.
//  Copyright © 2018 omrobbie. All rights reserved.
//

import UIKit

extension UIView {
    func circle() {
        self.layer.cornerRadius = self.frame.width / 2
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension Float {
    static var random:Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    
    static func random(min: Float, max: Float) -> Float {
        return Float.random * (max - min) + min
    }
}

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var lblIntro: UILabel!
    
    // MARK: Variables
    var bStart:Bool = false
    var timer:Timer?

    // MARK: Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.bStart { return }
        self.bStart = true
        
        hideIntro()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            self.spawnCircle()
        })
    }

    // MARK: Custom Functions
    func hideIntro() {
        UIView.animate(withDuration: 1) {
            self.lblIntro.alpha = 0
            self.lblIntro.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
    }
    
    func spawnCircle() {
        let circleGapByX = (view.frame.width)/5
        
        for x in 1...5 {
            let size = 70
            let randColor = CGFloat.random()
            let rand = Int(arc4random_uniform(UInt32(size)))
            
            let circleFrame = CGRect(x: (x * Int(circleGapByX) - size),
                                     y: 0 - size,
                                     width: rand,
                                     height: rand)
            let circle = UIView(frame: circleFrame)
            
            circle.circle()
            circle.alpha = CGFloat(Float.random(min: 0, max: 1))
            circle.backgroundColor = UIColor.random()
            circle.transform = CGAffineTransform(translationX: CGFloat(randColor),
                                                 y: view.frame.height + CGFloat(size))
            
            view.addSubview(circle)
            
            UIView.animate(withDuration: TimeInterval(randColor + 5), animations: {
                circle.transform = CGAffineTransform.identity
            }) { (true) in
                circle.removeFromSuperview()
            }
        }
    }
}
