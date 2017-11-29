//
//  MenuViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {return true}
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet weak var swipeMessage: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var S: UILabel!
    @IBOutlet weak var H: UILabel!
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var F: UILabel!
    @IBOutlet weak var T: UILabel!
    let transitionManager = TransitionManager()
    var colorTimer = Timer()
    var masterColors: [UIColor] {get{return Colors}}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitionManager.sourceViewController = self
        self.view.backgroundColor = themeColor
        let newColor = self.masterColors[colorIndices[0]]
        self.swipeMessage.textColor = foreground
        self.tapLabel.textColor = foreground
        self.highscoreLabel.textColor = foreground
        self.highscoreLabel.text = "Highscore: \(DataManager.highScore)"
        
        self.S.textColor = newColor
        self.H.textColor = newColor
        self.I.textColor = newColor
        self.F.textColor = newColor
        self.T.textColor = newColor
        
        self.animateTitle()
        self.colorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.animateTitle)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.colorTimer.invalidate()
        let toViewController = segue.destination as UIViewController
        self.transitionManager.direction = "W"
        toViewController.transitioningDelegate = self.transitionManager
    }
 
    
    @objc func animateTitle() {
        let newColor = randColor(Colors)
        self.S.changeColor(newColor, 0.5, delay: 0.0)
        self.H.changeColor(newColor, 0.5, delay: 0.2)
        self.I.changeColor(newColor, 0.5, delay: 0.4)
        self.F.changeColor(newColor, 0.5, delay: 0.6)
        self.T.changeColor(newColor, 0.5, delay: 0.8)
    }
        
}
