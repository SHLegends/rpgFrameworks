//
//  GameOverViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-21.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

protocol GameDelgate {
    func restartGame()
}

class GameOverViewController: UIViewController {
	override var prefersStatusBarHidden: Bool {return true}
    
    @IBOutlet weak var scoreNum: UILabel!
    @IBOutlet weak var scoreWord: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var mainMenu: UIButton!
    
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var creditsNum: UILabel!
    @IBOutlet weak var highscoreNum: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var score: Int?
    
    var gameDelegate: GameViewController?
    
    var transitionType = "normal"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = themeColor
        scoreNum.textColor = foreground
        scoreWord.textColor = foreground
        playAgain.setTitleColor(foreground, for: .normal)
        mainMenu.setTitleColor(foreground, for: .normal)
        creditsLabel.textColor = foreground
        creditsNum.textColor = foreground
        highscoreNum.textColor = foreground
        highScoreLabel.textColor = foreground
        
        
        scoreNum.text = String(score!)
        
        if gameScore > DataManager.highScore {
           DataManager.highScore = gameScore
            highScoreLabel.text = "New Highscore!"
        }
        
        highscoreNum.text = String(DataManager.highScore)
        
        DataManager.totalCredits = DataManager.totalCredits + gameScore
        
        creditsNum.text = String(DataManager.totalCredits)
        
        self.modalTransitionStyle = .crossDissolve
        
    }

}
