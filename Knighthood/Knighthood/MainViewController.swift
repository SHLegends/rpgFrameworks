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
    
    @objc func thrust() {
        actions += 1
        OutputLabel.text = "You thrust (\(actions))"
        
    }
    
    
    
    @objc func handlePinch(pinchGesture: UIPinchGestureRecognizer) {
        switch pinchGesture.state {
        case .ended:
            if pinchGesture.scale > 1.1 {
                actions += 1
                OutputLabel.text = "You step forward (\(actions))"
            } else if pinchGesture.scale < 0.9 {
                actions += 1
                OutputLabel.text = "You step back (\(actions))"
            }
            
        default:
            _ = 0
        }
    }
    
    @objc func handlePan(panGesture: UIPanGestureRecognizer) {
        
        switch panGesture.state {
        case .ended:
            if panGesture.velocity(in: self.view).x > 100 {
                actions += 1
                OutputLabel.text = "You step Right (\(actions))"
            } else if panGesture.velocity(in: self.view).x < -100 {
                actions += 1
                OutputLabel.text = "You step Left (\(actions))"
                
            }
        default:
            _ = 0
        }
    }
    @objc func handleSlash(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .changed:
            let xVel = panGesture.velocity(in: self.view).x
            let yVel = panGesture.velocity(in: self.view).y
            print("xVel = \(xVel)  ||  yVel = \(yVel)")
        case .ended:
            let xVel = panGesture.velocity(in: self.view).x
            let yVel = panGesture.velocity(in: self.view).y
            

            if yVel.magnitude > xVel.magnitude && yVel < -100 {
                actions += 1
                OutputLabel.text = "You swing Up (\(actions))"
                
            } else if yVel.magnitude > xVel.magnitude && yVel > 100 {
                actions += 1
                OutputLabel.text = "You swing Down (\(actions))"
            } else if xVel > 100 && xVel.magnitude > yVel.magnitude {
                actions += 1
                OutputLabel.text = "You swing Right (\(actions))"
            } else if xVel < -100 && xVel.magnitude > yVel.magnitude {
                actions += 1
                OutputLabel.text = "You swing Left (\(actions))"
            }
        default:
            _ = 0
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        OutputLabel.text = ""
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.thrust)))
        
        self.view.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(self.handlePinch(pinchGesture:))))
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(panGesture:)))
        
        panGesture.minimumNumberOfTouches = 2
        panGesture.maximumNumberOfTouches = 2
        
        self.view.addGestureRecognizer(panGesture)
        
        let slashPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handleSlash(panGesture:)))
        slashPanGesture.minimumNumberOfTouches = 1
        slashPanGesture.maximumNumberOfTouches = 1
        
        self.view.addGestureRecognizer(slashPanGesture)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

