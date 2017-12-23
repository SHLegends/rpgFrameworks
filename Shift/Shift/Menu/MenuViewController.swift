//
//  MenuViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

protocol GameOverDelegate {
    func gameOver(score: Int, delVC: GameDelgate)
    func playAgain()
    
}



var customNavigationAnimator = CustomNavigationAnimationController()

class MenuViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, GameOverDelegate {
    
    func gameOver(score: Int, delVC: GameDelgate) {
//        if let vc = navigationController?.viewControllers.filter({$0 as? GameViewController != nil})[0] {
//            vc.dismiss(animated: false, completion: nil)
//        } else {
//            print("ERROR: Unable to find GameViewController")
//        }
        

//        for i in 0..<navigationController!.viewControllers.count {
//            if let VC: GameOverViewController = navigationController!.viewControllers[i] as? GameOverViewController {
//                print(VC)
//                navigationController?.viewControllers.remove(at: i)
//            }
//        }
        
        
        print(navigationController?.viewControllers)
        let storyBoard: UIStoryboard = UIStoryboard(name: "GameOver", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "GameOverView") as! GameOverViewController
        vc.score = score
        vc.gameDelegate = delVC
        navigationController?.pushViewController(vc, animated: true)
        print(navigationController?.viewControllers)
    }
    
    func playAgain() {
//        if let vc = navigationController?.viewControllers.filter({$0 as? GameOverViewController != nil})[0] {
//            vc.dismiss(animated: false, completion: nil)
//        } else {
//            print("ERROR: Unable to find GameOverViewController")
//        }
        
//        for i in 0..<navigationController!.viewControllers.count {
//            if let VC: GameViewController = navigationController!.viewControllers[i] as? GameViewController {
//                print(VC)
//                navigationController?.viewControllers.remove(at: i)
//            }
//        }
        
//        navigationController?.popToRootViewController(animated: false)
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
//        vc.EndGameDelegate = self
//        
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
//    let customPresentAnimationController = CustomPresentAnimationController()
    
    let customNavigationAnimationController = customNavigationAnimator
    
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
        
        //self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: (#selector(self.handlePanGesture(gestureRecognizer:)))))
        
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
        
        customInteractionController.shouldPop = false
        customInteractionController.forPush = ("ColorPicking", "ColorPickerView")
        customInteractionController.attachToViewController(viewController: self)
        
        navigationController?.delegate = self as UINavigationControllerDelegate
        
        
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
            if ((toVC as? ColorPickerViewController) != nil) {
                customInteractionController.pullLeft = false
            } else {
                customInteractionController.pullLeft = true
            }
            customInteractionController.attachToViewController(viewController: toVC)
        }
//        customNavigationAnimationController.reverse = operation == .pop
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
        customNavigationAnimationController.reverse = true
        let storyBoard: UIStoryboard = UIStoryboard(name: "ColorPicking", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ColorPickerView") as! ColorPickerViewController
        navigationController?.pushViewController(vc, animated: true)
        
        
        //self.performSegue(withIdentifier: "toColorPicker", sender: nil)
        
        
    }
    
    @IBAction func goToMain(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
        vc.EndGameDelegate = self
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        customNavigationAnimationController.reverse = false
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

