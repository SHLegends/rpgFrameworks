//
//  ViewController.swift
//  Knighthood
//
//  Created by Joel Huggett on 2018-02-13.
//  Copyright © 2018 Joel Huggett. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var OutputLabel: UILabel!
    
    var actions = 0
    
    var pinchBeganLocation = 0.0
    
    @IBOutlet weak var RightSide: UIView!
    @IBOutlet weak var LeftSide: UIView!
    
    @objc func thrust() {
        actions += 1
        OutputLabel.text = "You thrust (\(actions))"
        
    }
    
    
    
    @objc func handlePinch(pinchGesture: UIPinchGestureRecognizer) {
        switch pinchGesture.state {
        case .ended:
            if pinchGesture.numberOfTouches == 2 {
                if pinchGesture.scale > 1.1 {
                    actions += 1
                    OutputLabel.text = "You step forward (\(actions))"
                } else if pinchGesture.scale < 0.9 {
                    actions += 1
                    OutputLabel.text = "You step back (\(actions))"
                }
            }
            
            
        default:
            _ = 0
        }
    }
    
    @objc func handlePan(panGesture: UIPanGestureRecognizer) {
        
        switch panGesture.state {
        case .changed:
            
            //let numTouches = panGesture.numberOfTouches
            _ = 0
            //print("xVel = \(Int(xVel))  <+>  yVel = \(Int(yVel))  ||  xTrans = \(Int(xTrans))  <+>  yTrans \(Int(yTrans))   ||   #touches = \(numTouches)")
            panGesture.numberOfTouchesForEndState = panGesture.numberOfTouches
            
            
        case .ended:
            print("\(panGesture.numberOfTouchesForEndState)")
            
            let xVel = panGesture.velocity(in: self.view).x
            let yVel = panGesture.velocity(in: self.view).y
            
            let xTrans = panGesture.translation(in: self.view).x
            let yTrans = panGesture.translation(in: self.view).y
            
            let diff: CGFloat = 100
            
//            if panGesture.numberOfTouchesForEndState == 2 {
//                if xVel > 100 {
//                    actions += 1
//                    OutputLabel.text = "You step Right (\(actions))"
//                } else if xVel < -100 {
//                    actions += 1
//                    OutputLabel.text = "You step Left (\(actions))"
//
//                }
//            } else if panGesture.numberOfTouchesForEndState == 1 {
                if xTrans.magnitude < diff && yTrans < -100 {
                    actions += 1
                    OutputLabel.text = "You swing Up (\(actions))"
                    
                } else if xTrans.magnitude < diff && yTrans > 100 {
                    actions += 1
                    OutputLabel.text = "You swing Down (\(actions))"
                } else if xTrans > 100 && yTrans.magnitude < diff {
                    actions += 1
                    OutputLabel.text = "You swing Right (\(actions))"
                } else if xTrans < -100 && yTrans.magnitude < diff {
                    actions += 1
                    OutputLabel.text = "You swing Left (\(actions))"
                } else {
                    if yTrans < -100 && xTrans < -100 {
                        actions += 1
                        OutputLabel.text = "You swing Up Left (\(actions))"
                    } else if yTrans < -100 && xTrans > 100 {
                        actions += 1
                        OutputLabel.text = "You swing Up Right (\(actions))"
                    } else  if yTrans > 100 && xTrans < -100 {
                        actions += 1
                        OutputLabel.text = "You swing Down Left (\(actions))"
                    } else if yTrans > 100 && xTrans > 100 {
                        actions += 1
                        OutputLabel.text = "You swing Down Right (\(actions))"
                    }
                    
                }
            //}
            
            
            
        default:
            _ = 0
        }
    }

    @objc func leftDoubleTap() {
        actions += 1
        OutputLabel.text = "You step Left (\(actions))"
    }
    
    @objc func rightDoubleTap() {
        actions += 1
        OutputLabel.text = "You step Right (\(actions))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        OutputLabel.text = ""
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.thrust)))
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch(pinchGesture:)))
        //self.view.addGestureRecognizer(pinchGesture)
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(panGesture:)))
        //\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\//\\
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        
        self.view.addGestureRecognizer(panGesture)
        
        let leftGesture = UITapGestureRecognizer(target: self, action: #selector(self.leftDoubleTap))
        leftGesture.numberOfTapsRequired = 2
        LeftSide.addGestureRecognizer(leftGesture)
        
        let rightGesture = UITapGestureRecognizer(target: self, action: #selector(self.rightDoubleTap))
        rightGesture.numberOfTapsRequired = 2
        RightSide.addGestureRecognizer(rightGesture)
        
//        let slashPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleSlash(panGesture:)))
//        slashPanGesture.minimumNumberOfTouches = 1
//        slashPanGesture.maximumNumberOfTouches = 1
        
        //self.view.addGestureRecognizer(slashPanGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



extension UIPanGestureRecognizer {
    private struct AssociatedKeys {
        static var numberOfTouchesForEndState: Int = 0
    }
    
    var numberOfTouchesForEndState: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.numberOfTouchesForEndState) as! Int
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.numberOfTouchesForEndState, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

