//
//  ColorCircle.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//


import UIKit

public class ColorCircle: UIButton {
    @IBInspectable var color: UIColor? = nil

    var foo = 0
    
    func getColor()-> UIColor? {
        return self.backgroundColor
    }
    
    var colorIndex = 0
    var selfCoor: coor = (0, 0)
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.bounds.size.height = self.bounds.size.width
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
        self.backgroundColor = self.color
        self.layer.borderWidth = 8
       
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension UIButton {
    func pulsate(duration: Double, from: Double = 1, to: Double = 0.8) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration 
        pulse.fromValue = from
        pulse.toValue = to
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 4
        pulse.damping = 1.0
        layer.add(pulse, forKey: "pulse")
    }
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.1
        flash.fromValue = 1
        flash.toValue = 0.0
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.2
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 10, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 10, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    func changeColor(_ toColor: UIColor?, duration: Double = 0.2) {
        UIView.animate(withDuration: duration , delay: 0, options: .allowUserInteraction, animations: {self.backgroundColor = toColor})
    }
    func changeBorderColor(to: UIColor, duration: Double = 0.2, delay: Double = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: .allowUserInteraction, animations: {
            self.layer.borderColor = to.cgColor
            })
    }
}

