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
        navigationController = viewController.navigationController
        setupGestureRecognizer(viewController.view)
    }
    
    private func setupGestureRecognizer(_ view: UIView) {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: (#selector(self.handlePanGesture(gestureRecognizer:)))))
    }
   
    private func shouldPresent(gestureRecognizer: UIPanGestureRecognizer) {

        if self.shouldPop {
            self.navigationController.popViewController(animated: true)
            transitionInprogress = true
        } else {
            if gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x > 0 {
                customNavigationAnimator.reverse = true
                let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "Settings")
                self.navigationController.pushViewController(vc, animated: true)
                transitionInprogress = true
            } else if gestureRecognizer.translation(in: gestureRecognizer.view!.superview!).x < 0 {
                customNavigationAnimator.reverse = false
                let storyboard = UIStoryboard.init(name: "ColorPicking", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ColorPickerView") as! ColorPickerViewController
                vc.menuDelegate = (self.navigationController.viewControllers.first! as! MenuSetupDelegate)
                self.navigationController.pushViewController(vc, animated: true)
                transitionInprogress = true
            }
            
        }
    }
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {

        let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        switch gestureRecognizer.state {
        case .began:
            
            transitionInprogress = true
            if self.shouldPop {
                self.navigationController.popViewController(animated: true)
                transitionInprogress = true
            } else {
                if gestureRecognizer.velocity(in: gestureRecognizer.view!.superview).x > 0 {
                    customNavigationAnimator.reverse = true
                    let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "Settings")
                    self.navigationController.pushViewController(vc, animated: true)

                    transitionInprogress = true
                } else if gestureRecognizer.velocity(in: gestureRecognizer.view!.superview).x < 0 {
                    customNavigationAnimator.reverse = false
                    let storyboard = UIStoryboard.init(name: "ColorPicking", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "ColorPickerView") as! ColorPickerViewController
                    vc.menuDelegate = (self.navigationController.viewControllers.first! as! MenuSetupDelegate)
                    self.navigationController.pushViewController(vc, animated: true)
                    transitionInprogress = true
                }
            }
            
        case .changed:
            let viewtranslationX = pullLeft ? viewTranslation.x : -viewTranslation.x
            let const = CGFloat(fminf(fmaxf(Float(viewtranslationX / 400.0), 0.0), 1.0))
            shouldCompleteTransition = const > 0.5
                
            let distance: Int = Int(viewTranslation.x > 0 ? viewTranslation.x : viewTranslation.x * -1)
                
            if distance > highestValue {
                highestValue = distance
            }
                
            update(const)
            
        case .cancelled, .ended:
            
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

            }
        default:
            print("Default")
            
        }
        
    }
}
