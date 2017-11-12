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
    
    var dateSinceTouchDown = Date()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.bounds.size.height = self.bounds.size.width
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
        self.backgroundColor = self.color
        self.layer.borderWidth = 8
       
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.scale(time: 0.2, x: 1, y: 1)
    }
    
    public func handleTouch(_ touches: Set<UITouch>) {
        let touch = touches.first
        if traitCollection.forceTouchCapability == .available {
            print(touch!.force )
            let time = 0.2
            switch Int(touch!.force) {
            case 1:
                self.scale(time: time, x: 0.8, y: 0.8)
            case 2:
                self.scale(time: time, x: 0.6, y: 0.6)
            case 3:
                self.scale(time: time, x: 0.5, y: 0.5)
            case 4:
                self.scale(time: time, x: 0.4, y: 0.4)
            case 5:
                self.scale(time: time, x: 0.3, y: 0.3)
            case 6:
                self.scale(time: time, x: 0.2, y: 0.2)
                
            default:
                self.scale(time: time, x: 0.9, y: 0.9)
            }
        } else {
            self.scale(time: 0.2, x: 0.8, y: 0.8)
        }
        
    }
    
    
    
//    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        handleTouch(touches)
//    }
//
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }
//
//    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.scale(time: 0.2, x: 1, y: 1)
//
//    }
    

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

extension UIButton {
    
    func scale(time: Double, x: Double, y: Double) {
        UIView.animate(withDuration: time, delay: 0, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform(scaleX: CGFloat(x), y: CGFloat(y))
        })
        
    }
    
    func scaling(_ actions: [(time: Double, x: Double, y: Double)]) {
        var waitTime = 0.0
        for i in actions {
            DispatchQueue.main.asyncAfter(deadline: .now() + waitTime, execute: {self.scale(time: i.time, x: i.x, y: i.y)})
            waitTime += i.time
        }
    }
    
    
    
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
    func changeColor(_ toColor: UIColor?, duration: Double = 0.2, delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            UIView.animate(withDuration: duration , delay: 0, options: .allowUserInteraction,   animations: {self.backgroundColor = toColor})
        })
    }
    func changeBorderColor(to: UIColor, duration: Double = 0.2, delay: Double = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: .allowUserInteraction, animations: {
            self.layer.borderColor = to.cgColor
            })
    }
}

