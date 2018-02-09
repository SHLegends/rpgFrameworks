//
//  MenuViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit


protocol MenuSetupDelegate {
    func loadViewColors()
}

protocol UpdateHighScoreDelegate {
    func updateHighScore()
}


var customNavigationAnimator = CustomNavigationAnimationController()

class MenuViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, MenuSetupDelegate, UpdateHighScoreDelegate {
    
    func updateHighScore() {
        if DataManager.highScore == 0 {
            self.highscoreLabel.text = ""
        } else {
            self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
        }
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) { }
    
    let customNavigationAnimationController = customNavigationAnimator
    
    let customInteractionController = CustomInteractionController()

    override var prefersStatusBarHidden: Bool {return true}
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var swipeMessage: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var S: UILabel!
    @IBOutlet weak var H: UILabel!
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var F: UILabel!
    @IBOutlet weak var T: UILabel!
    
    var colorTimer = Timer()
    var masterColors: [UIColor] {get{return Colors}}
    var colorShiftNum = 0
    
    var colorShiftCurrent = colorHandler.Colors.first!
    var colorShiftTo = colorHandler.Colors[1]
    
    
    func gameOver(score: Int, delVC: GameViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "GameOver", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "GameOverView") as! GameOverViewController
        vc.score = score
        vc.gameDelegate = delVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadViewColors() {
        navigationController?.view.backgroundColor = themeColor
        self.view.backgroundColor = themeColor
        
        self.swipeMessage.textColor = foreground
        self.tapLabel.textColor = foreground
        self.highscoreLabel.textColor = foreground
        if DataManager.highScore == 0 {
            self.highscoreLabel.text = ""
        } else {
            self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewColors()

        self.S.textColor = colorHandler.background
        self.H.textColor = colorHandler.background
        self.I.textColor = colorHandler.background
        self.F.textColor = colorHandler.background
        self.T.textColor = colorHandler.background
        
        
        self.animateTitle()
        self.colorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.animateTitle)), userInfo: nil, repeats: true)
        
        customInteractionController.shouldPop = false
        customInteractionController.forPush = ("ColorPicking", "ColorPickerView")
        
        
        navigationController?.delegate = self as UINavigationControllerDelegate
        
        customInteractionController.shouldPop = false

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        customInteractionController.attachToViewController(viewController: self)
        customInteractionController.shouldPop = false
        if DataManager.highScore == 0 {
            self.highscoreLabel.text = ""
        } else {
            self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
        }
    }
    
    @objc func animateTitle() {
        let newColor = randColor(Colors)
        self.S.changeColor(newColor, 0.5, delay: 0.0)
        self.H.changeColor(newColor, 0.5, delay: 0.2)
        self.I.changeColor(newColor, 0.5, delay: 0.4)
        self.F.changeColor(newColor, 0.5, delay: 0.6)
        self.T.changeColor(newColor, 0.5, delay: 0.8)
    }
    
    
    @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        print("panned")
        if gestureRecognizer.translation(in: self.view).x > 0 {
            
            print("right")
            print(gestureRecognizer.translation(in: self.view).x)
        } else {
            print("left")
            print(gestureRecognizer.translation(in: self.view).x)
        }
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            if ((toVC as? ColorPickerViewController) != nil) && ((fromVC as? MenuViewController) != nil) {
                customNavigationAnimationController.fade = false
                customInteractionController.attachToViewController(viewController: toVC)
                customInteractionController.pullLeft = false
            
            } else if ((toVC as? SetttingsViewController) != nil) && ((fromVC as? MenuViewController) != nil) {
                customNavigationAnimationController.fade = false
                customInteractionController.attachToViewController(viewController: toVC)
                customInteractionController.pullLeft = true
            } else {
                
                customNavigationAnimationController.fade = true
            }
        } else {
            if ((toVC as? MenuViewController) != nil) && ((fromVC as? ColorPickerViewController) != nil) {
                customInteractionController.pullLeft = true
                customNavigationAnimationController.fade = false
            } else if ((toVC as? MenuViewController) != nil) && ((fromVC as? SetttingsViewController) != nil) {
                customInteractionController.pullLeft = false
                customNavigationAnimationController.fade = false
                
            } else {
                customNavigationAnimationController.fade = true
            }
            
        }
        customNavigationAnimationController.reverse = customInteractionController.pullLeft
        return customNavigationAnimationController
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return customInteractionController.transitionInprogress ? customInteractionController : nil
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if ((viewController as? ColorPickerViewController) != nil) {
            customNavigationAnimationController.reverse = false
        } else {
            customNavigationAnimationController.reverse = true
        }
    }
        
    
    @IBAction func goToMain(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
        
        vc.highScoreUpdateDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
   
}



