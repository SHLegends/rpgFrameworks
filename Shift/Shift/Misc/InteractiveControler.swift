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
    
    var shouldPop: Bool = true
    
    var forPush: (storyboard: String, VC: String)?
    
    
    
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
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        
        
        let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        switch gestureRecognizer.state {
        case .began:
            print("case: began")
            // this is customized for the left/right interactive transitioning
            
            
            transitionInprogress = true
            if self.shouldPop {
                print("fell in shouldPop")
                navigationController.popViewController(animated: true)
                var vc = navigationController.viewControllers.first!
                print(navigationController.viewControllers)
            } else {
                if gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x >= 0 {
                    print(gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x)
                    
                    customNavigationAnimator.reverse = true
                    let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
                    var vc = storyboard.instantiateViewController(withIdentifier: "Settings")
                    
                    
                    
                    navigationController.pushViewController(vc, animated: true)
                    
                    //customNavigationAnimator.reverse = !customNavigationAnimator.reverse
                    //setupGestureRecognizer(vc.view)
                    print("right")
//                    setupGestureRecognizer(vc.view)
//                    customNavigationAnimator.reverse = !customNavigationAnimator.reverse
//                    self.shouldPop = true
                    //setupGestureRecognizer(vc!.view)
                } else if gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x < 0 {
                    print(gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x)
                    
                    customNavigationAnimator.reverse = false
                    let storyboard = UIStoryboard.init(name: "ColorPicking", bundle: nil)
                    var vc = storyboard.instantiateViewController(withIdentifier: "ColorPickerView")
                    
                    navigationController.pushViewController(vc, animated: true)
                    
                    //customNavigationAnimator.reverse = !customNavigationAnimator.reverse
                    //setupGestureRecognizer(vc.view)
                    print("left")
//                    setupGestureRecognizer(vc.view)
//                    customNavigationAnimator.reverse = !customNavigationAnimator.reverse
//                    self.shouldPop = true
                    //setupGestureRecognizer(vc!.view)
                }
                
                
                print(navigationController.viewControllers)
            }
            
        case .changed:
            
            
            
            let viewtranslationX = pullLeft ? viewTranslation.x : -viewTranslation.x
            //print(viewtranslationX)
            //print(CGFloat(fminf(fmaxf(Float(viewtranslationX / 400.0), 0.0), 1.0)))
            var const = CGFloat(fminf(fmaxf(Float(viewtranslationX / 400.0), 0.0), 1.0))
            shouldCompleteTransition = const > 0.5
            update(const)
            
            
        case .cancelled, .ended:
            
            print("case: cancelled/ended")
            
            transitionInprogress = false
            if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                cancel()
            } else {
                
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
