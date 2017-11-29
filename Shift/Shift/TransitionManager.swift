//
//  TransitionManager.swift
//  Shift
//
//  Created by Joel Huggett on 2017-11-10.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class TransitionManager: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var interactive = false
    
    // private so can only be referenced within this object
    private var enterPanGesture: UIScreenEdgePanGestureRecognizer!
    
    func handleOnstagePan(pan: UIPanGestureRecognizer) {
        
        let translation = pan.translation(in: pan.view!)
        
        let d = translation.x / pan.view!.bounds.width * 0.5
        
//        switch (pan.state) {
//        case .began:
//            self.interactive = true
//            self.sourceViewController.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
//        }
        
    }
    
    // not private, so can also be used from other objects :)
    var sourceViewController: UIViewController! {
        didSet {
//            self.enterPanGesture = UIScreenEdgePanGestureRecognizer()
//            self.enterPanGesture.addTarget(self, action: "handleOnstagePan")
//            self.enterPanGesture.edges = UIRectEdge.left
//            self.sourceViewController.view.addGestureRecognizer(self.enterPanGesture)
        }
    }
    
    
    
    
    
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    var direction = "E"
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        container.backgroundColor = colorHandler.background
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        var offScreenRight = CGAffineTransform(translationX: 0, y: -container.frame.height)
        var offScreenLeft = CGAffineTransform(translationX: 0, y: container.frame.height)
        
        switch self.direction {
        case "S":
             offScreenRight = CGAffineTransform(translationX: 0, y: -container.frame.height)
             offScreenLeft = CGAffineTransform(translationX: 0, y: container.frame.height)
        case "N":
            offScreenRight = CGAffineTransform(translationX: 0, y: container.frame.height)
            offScreenLeft = CGAffineTransform(translationX: 0, y: -container.frame.height)
        case "E":
            offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
            offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        case "W":
            offScreenRight = CGAffineTransform(translationX: -container.frame.width, y: 0)
            offScreenLeft = CGAffineTransform(translationX: container.frame.width, y: 0)
        case "normal":
            let _ = 0
        default:
            offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
            offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        }
        
        toView.transform = offScreenRight
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration , delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.4, options: .allowUserInteraction, animations: {
            fromView.transform = offScreenLeft
            toView.transform = .identity
            
            }) { (finished) in
                transitionContext.completeTransition(true)
        }
        
        
        
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    
}
