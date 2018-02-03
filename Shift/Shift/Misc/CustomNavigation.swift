//
//  CustomNavigation.swift
//  Shift
//
//  Created by Joel Huggett on 2017-12-16.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit


class CustomNavigationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse: Bool = false
    var fade: Bool = false
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if fade {
            let containerView = transitionContext.containerView
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toView = toViewController.view!
            let fromView = fromViewController.view!
            
            toView.alpha = 0
            
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext)/2, delay: 0.0, options: [], animations: {
                
                fromView.alpha = 0
                
            }) { finished in
                fromView.removeFromSuperview()
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext)/2, delay: 0.0, options: [], animations: {
                    
                    toView.alpha = 1
                    
                }) { finished in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                }
               
            }
        
            
        } else if !fade {
            let containerView = transitionContext.containerView
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toView = toViewController.view!
            let fromView = fromViewController.view!
            
            containerView.addSubview(toView)
            toView.frame.origin.x = reverse ? UIScreen.main.bounds.minX - UIScreen.main.bounds.maxX : UIScreen.main.bounds.maxX
            var fromViewTo = reverse ? UIScreen.main.bounds.maxX : UIScreen.main.bounds.minX - UIScreen.main.bounds.maxX
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext)/2, delay: 0.0, options: [], animations: {
                
                toView.frame.origin.x = UIScreen.main.bounds.minX
                fromView.frame.origin.x = fromViewTo
                
            }) { finished in
                if (transitionContext.transitionWasCancelled) {
                    toView.removeFromSuperview()
                } else {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
                
            }
            
        } else {
            let containerView = transitionContext.containerView
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
            let toView = toViewController.view!
            let fromView = fromViewController.view!
            let direction: CGFloat = reverse ? -1 : 1
            let const: CGFloat = -0.005
            
            toView.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
            fromView.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)
            
            var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(Double.pi/2), 0.0, 1.0, 0.0)
            var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(Double.pi/2), 0.0, 1.0, 0.0)
            viewFromTransform.m34 = const
            viewToTransform.m34 = const
            
            containerView.transform = CGAffineTransform(translationX: direction * containerView.frame.size.width / 2.0, y: 0)
            toView.layer.transform = viewToTransform
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: [], animations: {
                
                    containerView.transform = CGAffineTransform(translationX: -direction * containerView.frame.size.width / 2.0, y: 0)
                    fromView.layer.transform = viewFromTransform
                    toView.layer.transform = CATransform3DIdentity
                
            }) { finished in
                
                    containerView.transform = CGAffineTransform.identity
                    fromView.layer.transform = CATransform3DIdentity
                    toView.layer.transform = CATransform3DIdentity
                    fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                
                
                if (transitionContext.transitionWasCancelled) {
                    toView.removeFromSuperview()
                } else {
                    fromView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                
            }
        }
    }
    
    
}
