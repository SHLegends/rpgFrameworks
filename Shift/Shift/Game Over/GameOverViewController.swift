//
//  GameOverViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-21.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
	override var prefersStatusBarHidden: Bool {return true}
    
    @IBOutlet weak var gameOver: UILabel!
    @IBOutlet weak var scoreNum: UILabel!
    @IBOutlet weak var scoreWord: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var mainMenu: UIButton!
    
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var creditsNum: UILabel!
    @IBOutlet weak var highscoreNum: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = themeColor
        gameOver.textColor = foreground
        scoreNum.textColor = foreground
        scoreWord.textColor = foreground
        playAgain.setTitleColor(foreground, for: .normal)
        mainMenu.setTitleColor(foreground, for: .normal)
        creditsLabel.textColor = foreground
        creditsNum.textColor = foreground
        highscoreNum.textColor = foreground
        highScoreLabel.textColor = foreground
        
        
        scoreNum.text = String(gameScore)
        
        if gameScore > highscore {
            highscore = gameScore
            highScoreLabel.text = "New Highscore!"
        }
        
        highscoreNum.text = String(highscore)
        
        totalCredits += gameScore
        
        creditsNum.text = String(totalCredits)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
//        present(newViewController, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func mainMenuPressed(_ sender: Any) {
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "MainMenu", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuView") as! MenuViewController
//        present(newViewController, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: {})
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
