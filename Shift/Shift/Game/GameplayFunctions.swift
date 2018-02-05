//
//  GameplayFunctions.swift
//  Shift
//
//  Created by Joel Huggett on 2017-11-27.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit

struct actionUUIDStorage {
    
    static var actionUUID: String = ""
}

extension UILabel {
    
    var actionUUID: String {
        get {
            guard let selfValue = objc_getAssociatedObject(self, &actionUUIDStorage.actionUUID) as? String else {
                return ""
            }
            return selfValue
        }
        set {
            objc_setAssociatedObject(self, &actionUUIDStorage.actionUUID, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func changeColor(_ to: UIColor?, _ time: Double, delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {UIView.transition(with: self, duration: time, options: .transitionCrossDissolve, animations: {self.textColor = to})})
        
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
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
    func presentText(newText: String, duration: Double, stayFor: Double) {
        let newUUID = UUID().uuidString
        self.actionUUID = newUUID
        self.text = newText
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 1.0
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + stayFor, execute: {
            if self.actionUUID == newUUID {
                UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                    self.alpha = 0.0
                })
            }
            
        })
        
    }
    
    func presentTextToStay(newText: String, duration: Double) {
        self.text = newText
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 1.0
        })
    }
    
    func dismissText(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 0.0
        })
    }
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



