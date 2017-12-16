//
//  MenuViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
//    let customPresentAnimationController = CustomPresentAnimationController()
    
    let customNavigationAnimationController = CustomNavigationAnimationController()
    
    let customInteractionController = CustomInteractionController()
    
    
    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return customPresentAnimationController
//    }

    override var prefersStatusBarHidden: Bool {return true}
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var swipeMessage: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var S: UILabel!
    @IBOutlet weak var H: UILabel!
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var F: UILabel!
    @IBOutlet weak var T: UILabel!
    
//    let transitionManager = TransitionManager()
    var colorTimer = Timer()
    var masterColors: [UIColor] {get{return Colors}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.transitionManager.sourceViewController = self
        self.view.backgroundColor = themeColor
        let newColor = self.masterColors[colorIndices[0]]
        self.swipeMessage.textColor = foreground
        self.tapLabel.textColor = foreground
        self.highscoreLabel.textColor = foreground
        self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
        
        self.S.textColor = colorHandler.background
        self.H.textColor = colorHandler.background
        self.I.textColor = colorHandler.background
        self.F.textColor = colorHandler.background
        self.T.textColor = colorHandler.background
        
        self.animateTitle()
        self.colorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.animateTitle)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
        navigationController?.delegate = self as? UINavigationControllerDelegate
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            customInteractionController.attachToViewController(viewController: toVC)
        }
        customNavigationAnimationController.reverse = operation == .pop
        return customNavigationAnimationController
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customInteractionController.transitionInprogress ? customInteractionController : nil
    }
    

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "toSettings" {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
        
        
    }
    
    
    @IBAction func goToPicker(_ sender: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "toColorPicker", sender: nil)
        
        
    }
    
    @IBAction func goToMain(_ sender: Any) {
        self.performSegue(withIdentifier: "toMain", sender: nil)
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        self.performSegue(withIdentifier: "toSettings", sender: nil)
    }
    
    
    
    @objc func animateTitle() {
        let newColor = randColor(Colors)
        self.S.changeColor(newColor, 0.5, delay: 0.0)
        self.H.changeColor(newColor, 0.5, delay: 0.2)
        self.I.changeColor(newColor, 0.5, delay: 0.4)
        self.F.changeColor(newColor, 0.5, delay: 0.6)
        self.T.changeColor(newColor, 0.5, delay: 0.8)
    }
        
    @IBAction func resetData(_ sender: Any) {
        DataManager.highScore = 0
        DataManager.defaults.set(nil, forKey: "setsData")
        DataManager.totalCredits = 0
        DataManager.themeInUse = 0
        DataManager.totalCredits = 0
    }
}



//extension MenuViewController : UIViewControllerTransitioningDelegate {
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return DismissAnimator()
//    }
//}

