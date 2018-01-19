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
    var PlayAgainDelegate: GameOverDelegate?
    
    var gameDelegate: GameViewController?
    
    
//    let transitionManager = TransitionManager()
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
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        
//        self.gameDelegate!.restartGame()
        
        //self.dismiss(animated: false, completion: nil)
        
//        self.presentingViewController!.dismiss(animated: true, completion: nil)
            //self.performSegue(withIdentifier: "unwindToGame", sender: self)

    }
    
    @IBAction func mainMenuPressed(_ sender: Any) {
        //self.performSegue(withIdentifier: "unwindToMenu", sender: self)

    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
//        let toViewController = segue.destination as UIViewController
//        self.transitionManager.direction = self.transitionType
//        toViewController.transitioningDelegate = self.transitionManager
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
