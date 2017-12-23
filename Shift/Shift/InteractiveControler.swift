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
        navigationController = viewController.navigationController
        setupGestureRecognizer(viewController.view)
    }
    
    private func setupGestureRecognizer(_ view: UIView) {
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: (#selector(self.handlePanGesture(gestureRecognizer:)))))
    }
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        switch gestureRecognizer.state {
        case .began:
            
            transitionInprogress = true
            if self.shouldPop {
                navigationController.popViewController(animated: true)
                print(navigationController.viewControllers)
            } else {
                let storyboard = UIStoryboard.init(name: forPush!.storyboard, bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: forPush!.VC)
                navigationController.pushViewController(vc, animated: true)
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
            transitionInprogress = false
            if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
                cancel()
            } else {
                finish()
            }
        default:
            print("Default")
            
        }
        
    }
}
