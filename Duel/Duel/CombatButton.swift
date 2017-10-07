//
//  CombatButton.swift
//  Duel
//
//  Created by Joel Huggett on 2017-10-06.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit


class CombatButton: UIButton {
    
    var foo = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let color: UIColor? = nil
        
        
//
//        let btnFont = "Noteworthy"
//        let bthWidth = 150
//        let btnHeight = 60
//        self.frame.size = CGSize(width: bthWidth, height: btnHeight)
//        self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)
        self.bounds.size.height = self.bounds.size.width
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.clipsToBounds = true
        self.backgroundColor = color
        self.layer.borderWidth = 4.0
        self.layer.borderColor = UIColor.red.cgColor
        self.setTitleColor(color, for: .normal)
//        self.titleLabel?.font = UIFont(name: btnFont, size: 25)
//        self.titleLabel?.adjustsFontSizeToFitWidth = true
//        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
//        let btnGradient = CAGradientLayer()
//        btnGradient.frame = self.bounds
//        btnGradient.colors = [gradientColor1, gradientColor2]
//        self.layer.insertSublayer(btnGradient, at: 0)
        
        self.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        

    }
    
    @objc func onPress() {
        let colours = [UIColor.blue, UIColor.black, UIColor.white, UIColor.red, UIColor.green]
        
        func randColor(_ colors: [UIColor])-> UIColor {
            return colors[Int(arc4random_uniform(UInt32(colors.count)))]
        }
        
        self.changeColor(randColor(colours.filter({$0 != self.backgroundColor})))
        
//        self.backgroundColor = UIColor.green
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {self.backgroundColor = nil})
        
        
        
        
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
    func pulsate(duration: Double) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.fromValue = 1.0
        pulse.toValue = 0.4
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.8
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
        flash.repeatCount = 4
        layer.add(flash, forKey: nil)
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
    func changeColor(_ toColor: UIColor?) {

        UIView.animate(withDuration: 0.2, animations: {self.backgroundColor = toColor})
    }
}
