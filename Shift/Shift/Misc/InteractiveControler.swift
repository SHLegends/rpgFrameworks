//
//  InteractiveControler.swift
//  Shift
//
//  Created by Joel Huggett on 2017-12-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit
class CustomInteractionController: UIPercentDrivenInteractiveTransition {
    var navigationController: UINavigationController!
    var shouldCompleteTransition = false
    var transitionInprogress = false
    
    var pullLeft: Bool = true
    
    var shouldPop: Bool = false
    
    var forPush: (storyboard: String, VC: String)?
    
    var highestValue = 0
    
    var completionSeed: CGFloat {
        return 1 - percentComplete
    }
    
    func attachToViewController(viewController: UIViewController) {
        print("called: attachToViewController")
        navigationController = viewController.navigationController
        setupGestureRecognizer(viewController.view)
    }
    
    private func setupGestureRecognizer(_ view: UIView) {
        print("called: setupGestureRecognizer")
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: (#selector(self.handlePanGesture(gestureRecognizer:)))))
    }
    
    func useGestureRecognizer(_ pan: UIPanGestureRecognizer) {
        
    }
    
    private func shouldPresent(gestureRecognizer: UIPanGestureRecognizer) {
        print("case: began")
        // this is customized for the left/right interactive transitioning

        if self.shouldPop {
            print("fell in shouldPop")
            self.navigationController.popViewController(animated: true)
            
            print(self.navigationController.viewControllers)
            transitionInprogress = true
        } else {
            if gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x > 0 {
                print(gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x)
                customNavigationAnimator.reverse = true
                let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Settings")
                self.navigationController.pushViewController(vc, animated: true)
                print("right")
                transitionInprogress = true
            } else if gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x < 0 {
                print(gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x)
                customNavigationAnimator.reverse = false
                let storyboard = UIStoryboard.init(name: "ColorPicking", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ColorPickerView") as! ColorPickerViewController
                vc.menuDelegate = (self.navigationController.viewControllers.first! as! MenuSetupDelegate)
                self.navigationController.pushViewController(vc, animated: true)
                print("left")
                transitionInprogress = true
            }
            
            
            print(self.navigationController.viewControllers)
        }
    }
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        
        let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        switch gestureRecognizer.state {
        case .began:
            print("case: began")
            // this is customized for the left/right interactive transitioning
            
            //self.shouldPresent(gestureRecognizer: gestureRecognizer)
                    
            print("case: began")
            // this is customized for the left/right interactive transitioning
            transitionInprogress = true
            if self.shouldPop {
                print("fell in shouldPop")
                self.navigationController.popViewController(animated: true)
                
                print(self.navigationController.viewControllers)
                transitionInprogress = true
            } else {
                if gestureRecognizer.velocity(in: gestureRecognizer.view!.superview).x > 0 {
                    print(gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x)
                    customNavigationAnimator.reverse = true
                    let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Settings")
                    self.navigationController.pushViewController(vc, animated: true)
                    //pullLeft = true
                    print("right")
                    transitionInprogress = true
                } else if gestureRecognizer.velocity(in: gestureRecognizer.view!.superview).x < 0 {
                    print(gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x)
                    customNavigationAnimator.reverse = false
                    let storyboard = UIStoryboard.init(name: "ColorPicking", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ColorPickerView") as! ColorPickerViewController
                    vc.menuDelegate = (self.navigationController.viewControllers.first! as! MenuSetupDelegate)
                    self.navigationController.pushViewController(vc, animated: true)
                    //pullLeft = false
                    print("left")
                    transitionInprogress = true
                }
                
                
                //print(self.navigationController.viewControllers)
            }
            print(self.navigationController.viewControllers)
            
            
            
            
            
        case .changed:
            
            print(gestureRecognizer.velocity(in: gestureRecognizer.view!.superview))
            
//            if !transitionInprogress {
//                //self.shouldPresent(gestureRecognizer: gestureRecognizer)
//
//            } else {
            
                let viewtranslationX = pullLeft ? viewTranslation.x : -viewTranslation.x
                //print(viewtranslationX)
                //print(CGFloat(fminf(fmaxf(Float(viewtranslationX / 400.0), 0.0), 1.0)))
                let const = CGFloat(fminf(fmaxf(Float(viewtranslationX / 400.0), 0.0), 1.0))
                shouldCompleteTransition = const > 0.5
                
                let distance: Int = Int(viewTranslation.x > 0 ? viewTranslation.x : viewTranslation.x * -1)
                
                if distance > highestValue {
                    highestValue = distance
                }
                
                //print(viewTranslation.x)
                update(const)
            //}
            
        case .cancelled, .ended:
            
            print("case: cancelled/ended")
            let distance: Int = Int(viewTranslation.x > 0 ? viewTranslation.x : viewTranslation.x * -1)
            print(distance, highestValue)
            transitionInprogress = false
            
            let VavValue = Int(gestureRecognizer.velocity(in: gestureRecognizer.view!.superview).x)
            
            let VavConst = 300
            
            let tooSlow = pullLeft ? VavValue < VavConst : VavValue > -VavConst
            
            if !shouldCompleteTransition && tooSlow || gestureRecognizer.state == .cancelled  {
                highestValue = 0
                cancel()
            } else {
                highestValue = 0
                finish()

                shouldPop = shouldPop ? shouldPop : true
                //setupGestureRecognizer(vc!.view)
                //shouldPop = false
            }
        default:
            print("Default")
            
        }
        
    }
}
