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
    
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }
}


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
