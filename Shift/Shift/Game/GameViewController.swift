//
//  GameViewViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit
import AVFoundation

protocol GamePusher {
    func pushGame()
}

class GameViewController: UIViewController, GameDelgate {
    
    override var prefersStatusBarHidden: Bool {return true}
    
    @IBAction func unwindToGame(segue: UIStoryboardSegue) { }
    
    @IBOutlet weak var GameOver: UILabel!
    @IBOutlet weak var NW: ColorCircle!
    @IBOutlet weak var N: ColorCircle!
    @IBOutlet weak var NE: ColorCircle!
    @IBOutlet weak var W: ColorCircle!
    @IBOutlet weak var C: ColorCircle!
    @IBOutlet weak var E: ColorCircle!
    @IBOutlet weak var SW: ColorCircle!
    @IBOutlet weak var S: ColorCircle!
    @IBOutlet weak var SE: ColorCircle!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var liveslabel: UILabel!
    @IBOutlet weak var scorelabell: UILabel!
    @IBOutlet weak var multiplierLabel: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    
    var substractAmount = 2
    
    var roundMultiplier = 1.0
    
    let indexToSound: [Int: String] = [0: "breakingGlass", 1: "breakingGlass", 2: "breakingGlass", 3: "breakingGlass", 4: "breakingGlass"]
    
    var highScoreUpdateDelegate: UpdateHighScoreDelegate? = nil
    
    var isFirstTap = true
    var numOfSameColorTaps = 3
    var round = 0
    var score = 0
    let grid = (xMin: 0, xMax: 8, yMin: 0, yMax: 8)
    var timeSinceLastTap = Date()
    let masterColors = Colors
    var colourBin = [Int]()
    var colorIndex = 1
    var buttons = [ColorCircle]()
    var buttons2D = [Int: [Int: ColorCircle]]()
    var nextRoundUUID = String()
    var tapTimer = Timer()
    var hintTimer = Timer()
    var tapTimerValue = 0.0
    var mutiplierUUID = ""
    var gameOver = false
    
    @objc func hint() {
        if (tapTimerValue > 1 || tapTimerValue == 0) && !gameOver && !DataManager.hintsOff {
            let hintButs = buttons.filter({$0.backgroundColor != $0.borderColor})
            if !hintButs.isEmpty {
                let but = returnRandomItem(hintButs)
                but.scaling([(0.2, 1.2, 1.2), (0.1, 1, 1)])
            }
        }
    }
    
    @objc func addMilisecond() {
        
        self.tapTimerValue += 0.1
        if self.score - 1 >= 0 {
            if self.round >= 3 {
                self.score -= Int(Double(self.substractAmount) * roundMultiplier)
                if self.score < 0 { self.score = 0 }
                self.ScoreLabel.text = String(self.score)
            }
        } else if self.isFirstTap == false {
            endGame()
        }
        
        
    }
    
    func restartGame() {
        resetGame()
        screenLoad()
        gameStartAnimation()
        
    }
    
    func resetGame() {
        tapTimerValue = 0.0
        score = 0
        numOfSameColorTaps = 3
        round = 0
        timeSinceLastTap = Date()
        substractAmount = 2
        colourBin = [Int]()
        colorIndex = 1
        buttons = [ColorCircle]()
        buttons2D = [Int: [Int: ColorCircle]]()
        nextRoundUUID = String()
        isFirstTap = true
    }
    
    func screenLoad() {
        colorIndices = randomizeColors(masterColors: Colors)
        self.multiplierLabel.text = ""
        self.gameOver = false
        self.buttons = [NW!, N!, NE!, W!, C!, E!, SW!, S!, SE!]
        self.buttons2D = [0: [0: NW!, 1: N!, 2: NE!], 1: [0: W!, 1: C!, 2: E!], 2: [0: SW!, 1: S!, 2: SE!]]
        for i in 0..<self.buttons2D.count {
            for t in 0..<self.buttons2D[i]!.count {
                self.buttons2D[i]![t]!.selfCoor = (t, i)
            }
        }
        warningLabel.presentTextToStay(newText: "Tap a circle", duration: 1)
        colourBin = [colorIndices[0], colorIndices[1]]
        for i in buttons {i.changeColor(self.masterColors[self.colourBin[0]]); i.colorIndex = self.colourBin[0]; i.changeBorderColor(to: self.masterColors[self.colourBin[1]])}
        warningLabel.textColor = foreground
        ScoreLabel.textColor = foreground
        
        
        self.multiplierLabel.textColor = foreground
        GameOver.textColor = foreground
        GameOver.alpha = 0
        self.colorIndex = self.colourBin[1]
        self.view.backgroundColor = themeColor
        for i in self.buttons {
            i.alpha = 0
            i.isEnabled = true
        }
        self.ScoreLabel.alpha = 0
        self.ScoreLabel.text = "\(self.score)"
        self.warningLabel.alpha = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            for i in self.buttons {
                i.bounds.size.height = i.bounds.size.width
                i.layer.cornerRadius = i.bounds.size.width / 2
            }
        })
        
    }
    
    override func viewWillLayoutSubviews() {
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            for i in self.buttons {
                i.layer.borderWidth = 14
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        restartGame()
        self.tapTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.addMilisecond)), userInfo: nil, repeats: true)
        self.hintTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: (#selector(self.hint)), userInfo: nil, repeats: true)
    }
    
    
    func endGame() {
        hintTimer.invalidate()
        tapTimer.invalidate()
        self.gameOver = true
        AudioHandler.playSound("Sad_Trombone", ".mp3")
        if self.score < 0 {
            self.score = 0
        }
        gameScore = self.score
        gameEndAnimation()
        
    }
    
    
    func gameEndAnimation() {
        var delay = 0.0
        let by = 0.05
        let duration = 1.0
        
        for i in buttons {
            i.isEnabled = false
        }
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.multiplierLabel.alpha = 0
            self.ScoreLabel.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.SE.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.S.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.SW.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.W.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [], animations: {
            self.C.alpha = 0
            self.GameOver.alpha = 1
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.E.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.NE.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.N.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.NW.alpha = 0
        }, completion: nil)
        delay += by
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            self.warningLabel.alpha = 0
        }, completion: nil)
        
        delay += by
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay+duration + 1, execute: {
            self.tapTimer.invalidate()
            let storyBoard: UIStoryboard = UIStoryboard(name: "GameOver", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "GameOverView") as! GameOverViewController
            vc.score = self.score
            vc.gameDelegate = self
            vc.highScoreUpdateDelegate = self.highScoreUpdateDelegate!
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        })
    }
    
    func gameStartAnimation() {
        var delay = 0.1
        let by = 0.2

        UIView.animate(withDuration: 1, delay: delay, options: [.allowUserInteraction], animations: {
            self.warningLabel.alpha = 1
        }, completion: nil)
        
        delay += by
        
        UIView.animate(withDuration: 1, delay: delay, options: [.allowUserInteraction], animations: {
            self.N.alpha = 1
            self.NE.alpha = 1
            self.NW.alpha = 1
            
        }, completion: nil)
        
        delay += by
        
        UIView.animate(withDuration: 1, delay: delay, options: [.allowUserInteraction], animations: {
            self.C.alpha = 1
            
            self.E.alpha = 1
            self.W.alpha = 1
            
        }, completion: nil)
        
        delay += by
        
        UIView.animate(withDuration: 1, delay: delay, options: [.allowUserInteraction], animations: {
            
            self.S.alpha = 1
            self.SE.alpha = 1
            self.SW.alpha = 1
            
        }, completion: nil)
        
        delay += by
        
        UIView.animate(withDuration: 1, delay: delay, options: [.allowUserInteraction], animations: {
            self.ScoreLabel.alpha = 1
            
        }, completion: nil)
        

    }
    
    func calcPoints(numOfButtons: Int, timeBetweenTaps: Double)-> Int {
        let duration = 1.0
        
        if timeBetweenTaps < 1.0 {
            switch Double(Int(timeBetweenTaps * 10))/10 {
            case 0.0:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 2.0)
                self.multiplierLabel.presentText(newText: "x20", duration: 0.2, stayFor: duration)
                return numOfButtons * 20
            case 0.1:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.9)
                self.multiplierLabel.presentText(newText: "x17", duration: 0.2, stayFor: duration)
                return numOfButtons * 17
            case 0.2:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.8)
                self.multiplierLabel.presentText(newText: "x15", duration: 0.2, stayFor: duration)
                return numOfButtons * 15
            case 0.3:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.7)
                self.multiplierLabel.presentText(newText: "x12", duration: 0.2, stayFor: duration)
                return numOfButtons * 12
            case 0.4:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.6)
                self.multiplierLabel.presentText(newText: "x10", duration: 0.2, stayFor: duration)
                return numOfButtons * 10
            case 0.5:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.5)
                self.multiplierLabel.presentText(newText: "x9", duration: 0.2, stayFor: duration)
                return numOfButtons * 9
            case 0.6:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.4)
                self.multiplierLabel.presentText(newText: "x8", duration: 0.2, stayFor: duration)
                return numOfButtons * 8
            case 0.7:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.3)
                self.multiplierLabel.presentText(newText: "x7", duration: 0.2, stayFor: duration)
                return numOfButtons * 7
            case 0.8:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.2)
                self.multiplierLabel.presentText(newText: "x6", duration: 0.2, stayFor: duration)
                return numOfButtons * 6
            case 0.9:
                self.multiplierLabel.pulsate(duration: 0.2, from: 1.0, to: 1.1)
                self.multiplierLabel.presentText(newText: "x5", duration: 0.2, stayFor: duration)
                return numOfButtons * 5
            default:
                return 0
            }
            
        } else if timeBetweenTaps < 2.0 {
            self.multiplierLabel.presentText(newText: "x4", duration: 0.2, stayFor: duration)
            return numOfButtons * 4
        } else if timeBetweenTaps < 3.0 {
            self.multiplierLabel.presentText(newText: "x3", duration: 0.2, stayFor: duration)
            return numOfButtons * 3
        } else if timeBetweenTaps < 4.0 {
            self.multiplierLabel.presentText(newText: "x2", duration: 0.2, stayFor: duration)
            return numOfButtons * 2
        } else {
            return numOfButtons * 1
        }
        
    }
    
    func nextRound() {
        self.round += 1
        self.roundMultiplier += 0.25
        
        if self.round == 1 {
            warningLabel.presentTextToStay(newText: "Only tap circles with two colors", duration: 0.5)
        } else if self.round == 2 {
            warningLabel.presentTextToStay(newText: "Play faster for more points", duration: 0.5)
        } else {
            warningLabel.dismissText(duration: 0.5)
        }
        
        if true {
            if self.colourBin.count < colorIndices.count {
                self.colourBin.append(colorIndices[self.colourBin.count])
            }
        }
        
        
        let newColor = returnRandomItem(self.colourBin.filter({$0 != self.colorIndex}))
        self.colorIndex = newColor
        
        AudioHandler.playSound("glass_ping", "mp3")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            AudioHandler.playSound("glass_ping", "mp3")
        })
        
        if !DataManager.tapticMute {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
        for i in self.buttons {
            i.scaling([(0.2, 1.05, 1.1), (0.2, 1, 1)])
            i.changeBorderColor(to: self.masterColors[self.colorIndex], duration: 0.5)
        }
    }
    
    
    func checkAfter() {
        let currentUUID = UUID().uuidString
        self.nextRoundUUID = currentUUID
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 0 {
                if self.nextRoundUUID == currentUUID {
                    self.nextRound()
                }
            }
        })
    }
    
    
    func checkForComplete() {
        if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 0 {
            checkAfter()
        }
    }
    
    
    func checkAllSame(_ but: ColorCircle) {
        
        but.scale(time: 0.1, x: 1.0, y: 1.0)
        self.tapTimerValue = 0.0
        if self.isFirstTap {
            warningLabel.dismissText(duration: 1)
            
            self.timeSinceLastTap = Date()
        }
        self.isFirstTap = false
        let elapsedTime = Date().timeIntervalSince(self.timeSinceLastTap)
        self.timeSinceLastTap = Date()
        if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 1 && but.colorIndex != self.colorIndex {
            AudioHandler.playSound("breakingGlass", "mp3")
            but.colorIndex = self.colorIndex
            but.changeColor(self.masterColors[self.colorIndex])
            self.score += Int(Double(calcPoints(numOfButtons: 1, timeBetweenTaps: elapsedTime)) * roundMultiplier)
            checkAfter()
        } else {
            let oldColor = but.colorIndex + 0
            var butNums = 0
            var timeBetween = 0.0
            for i in self.buttons {
                if i.colorIndex == oldColor {
                    timeBetween += 0.1
                    let newColor = returnRandomItem(self.colourBin.filter({$0 != i.colorIndex}))
                    i.colorIndex = newColor
                    i.changeColor(self.masterColors[newColor], duration: 0.5)
                    butNums += 1
                }
            }
            
            
            if oldColor == self.colorIndex {
                
                if !DataManager.tapticMute {
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                }
                
                self.numOfSameColorTaps -= 1
                self.view.bringSubview(toFront: but)
                but.scaling([(0.2, 1, 0.1), (0.1, 1, 1)])
                
                if self.numOfSameColorTaps == 0 {
                    endGame()
                } else {
                    AudioHandler.playSound("wrong", "mp3")
                    if numOfSameColorTaps > 1 {
                        warningLabel.presentText(newText: "Warning: Don't tap single colored circles", duration: 1, stayFor: 2)
                    } else if numOfSameColorTaps == 1 {
                        warningLabel.presentText(newText: "Warning: Last Chance", duration: 1, stayFor: 2)
                    }
                    
                    ScoreLabel.shake()
                    if self.score < 0 {
                        self.score = 0
                        
                    }
                }
            } else {
                AudioHandler.playSound("breakingGlass", "mp3")
                self.score += Int(Double(calcPoints(numOfButtons: butNums, timeBetweenTaps: elapsedTime)) * roundMultiplier)
            }
            
            ScoreLabel.text = String(self.score)
            checkForComplete()
        }
        
        
        
    }
    
  
    
    
    @IBAction func circleOut(_ sender: ColorCircle) {
        checkAllSame(sender)
    }
    

    @IBAction func circleTouchDown(_ sender: ColorCircle) {
        if traitCollection.forceTouchCapability == .available {
            sender.scale(time: 0.2, x: 0.95, y: 0.95)
        } else {
            sender.scale(time: 0.2, x: 0.4, y: 0.4)
        }
        
        self.view.bringSubview(toFront: sender)
        if !DataManager.tapticMute {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        }
        sender.dateSinceTouchDown = Date()
    }
    
    
    @IBAction func circlePressed(_ sender: ColorCircle) {
        if Date().timeIntervalSince(sender.dateSinceTouchDown) > 0.2 {
            if !DataManager.tapticMute {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }
        checkAllSame(sender)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tapTimer.invalidate()
        self.hintTimer.invalidate()
    }

}

