//
//  MenuViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

protocol GameOverDelegate {
    func gameOver(score: Int, delVC: GameViewController)
    func playAgain()
    
}

protocol MenuSetupDelegate {
    func loadViewColors()
}


var customNavigationAnimator = CustomNavigationAnimationController()

class MenuViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate, GameOverDelegate, MenuSetupDelegate {
    
    

    @IBAction func unwindToMenu(segue: UIStoryboardSegue) { }
    
    
    func gameOver(score: Int, delVC: GameViewController) {
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
    
    
    func loadViewColors() {
        navigationController?.view.backgroundColor = themeColor
        self.view.backgroundColor = themeColor
        
        self.swipeMessage.textColor = foreground
        self.tapLabel.textColor = foreground
        self.highscoreLabel.textColor = foreground
        self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
    }
    
    var colorShiftNum = 0
    
    var colorShiftCurrent = colorHandler.Colors.first!
    var colorShiftTo = colorHandler.Colors[1]
    
    @objc func attributedColorShift() {
        var attributedString = NSMutableAttributedString(string: "CELOX")
        
        if colorShiftNum < attributedString.length {
            var increment = 0
            while increment <= colorShiftNum {
                attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: colorShiftTo, range: NSRange(location: increment, length: 1))
                
                increment += 1
            }
            if increment < attributedString.length {
                for i in increment..<attributedString.length {
                    attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: colorShiftCurrent, range: NSRange(location: i, length: 1))
                }
            }
            
            colorShiftNum += 1
            
            
            
        } else {
            colorShiftCurrent = colorShiftTo
            colorShiftTo = randColor(Colors.filter({$0 != colorShiftCurrent}))!
            
            colorShiftNum = 0
        }
        
        for i in 0..<attributedString.length {
            attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: colorHandler.Colors[i], range: NSRange(location: i, length: 1))
        }
        
        //attributedString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: attributedString.length - 2))
        
        //        TitleLabel.text = nil
        //        TitleLabel.attributedText = attributedString
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attributedColorShift()
        
        //self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: (#selector(self.handlePanGesture(gestureRecognizer:)))))
        
//        self.transitionManager.sourceViewController = self
        
        
        loadViewColors()
        let newColor = self.masterColors[colorIndices[0]]
        
        let basicFont = UIFont.monospacedDigitSystemFont(ofSize: 100, weight: UIFont.Weight(rawValue: 10))
        
        let fontFeatures = [
            [UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
             UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedTextSelector]
        ]
        
//        self.S.font = basicFont
//        self.H.font = basicFont
//        self.I.font = basicFont
//        self.F.font = basicFont
//        self.T.font = basicFont
        
        
        self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
        
        let kernValue: CGFloat = 20.0
        
        self.S.textColor = colorHandler.background
        
//        let cString = NSMutableAttributedString(string: "C")
//        cString.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSRange(location: 0, length: 1))
//        self.S.text = nil
//        self.S.attributedText = cString
        
        self.H.textColor = colorHandler.background
        
//        let hString = NSMutableAttributedString(string: "E")
//        hString.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSRange(location: 0, length: 1))
//        self.H.text = nil
//        self.H.attributedText = hString
        
        self.I.textColor = colorHandler.background
        
//        let iString = NSMutableAttributedString(string: "L")
//        iString.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSRange(location: 0, length: 1))
//        self.I.text = nil
//        self.I.attributedText = iString
        
        self.F.textColor = colorHandler.background
        
//        let fString = NSMutableAttributedString(string: "O")
//        fString.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSRange(location: 0, length: 1))
//        self.F.text = nil
//        self.F.attributedText = fString
        
        self.T.textColor = colorHandler.background
        
//        let tString = NSMutableAttributedString(string: "X")
//        tString.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSRange(location: 0, length: 1))
//        self.T.text = nil
//        self.T.attributedText = tString
        
        self.animateTitle()
        self.colorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.animateTitle)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
        
        customInteractionController.shouldPop = false
        customInteractionController.forPush = ("ColorPicking", "ColorPickerView")
        
        
        navigationController?.delegate = self as UINavigationControllerDelegate
        
        customInteractionController.shouldPop = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.S.font = self.T.font
//            self.H.font = self.T.font
//            self.I.font = self.T.font
//            self.F.font = self.T.font
            
        }
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("Menu did appear")
        customInteractionController.attachToViewController(viewController: self)
        customInteractionController.shouldPop = false
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
//            if let vc: MenuViewController = toVC as? MenuViewController {
//                //customInteractionController.attachToViewController(viewController: vc)
//            }
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
//        customNavigationAnimationController.reverse = operation == .pop
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
    

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("preparing for segue")
        if segue.identifier == "toSettings" {
            let toViewController = segue.destination as UIViewController
            toViewController.transitioningDelegate = self
        }
        
        if let toVC: ColorPickerViewController = segue.destination as? ColorPickerViewController {
            toVC.menuDelegate = self
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
        
        //navigationController!.present(vc, animated: true, completion: nil)
        
        navigationController?.pushViewController(vc, animated: true)
        
        
        //self.present(vc, animated: true, completion: nil)
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

