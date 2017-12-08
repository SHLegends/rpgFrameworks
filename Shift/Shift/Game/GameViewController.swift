//
//  GameViewViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {return true}
    @IBOutlet weak var ScoreLabel: UILabel!
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
    
    var substractAmount = 1
    
    
    
    
    
    let indexToSound: [Int: String] = [0: "breakingGlass", 1: "breakingGlass", 2: "breakingGlass", 3: "breakingGlass", 4: "breakingGlass"]
    
    
    
//    let transitionManager = TransitionManager()
    
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
    var tapTimerValue = 0.0
    
    var mutiplierUUID = ""
    
    @objc func addMilisecond() {
        self.tapTimerValue += 0.1
        if self.score - 1 >= 0 {
            self.score -= self.substractAmount
            self.ScoreLabel.text = String(self.score)
        } else if self.isFirstTap == false {
            endGame()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorIndices = randomizeColors(masterColors: Colors)
       
        self.multiplierLabel.text = ""
        
        self.scorelabell.text = ""
        self.liveslabel.text = ""
        
        
        self.buttons = [NW!, N!, NE!, W!, C!, E!, SW!, S!, SE!]
        self.buttons2D = [0: [0: NW!, 1: N!, 2: NE!], 1: [0: W!, 1: C!, 2: E!], 2: [0: SW!, 1: S!, 2: SE!]]
        for i in 0..<self.buttons2D.count {
            for t in 0..<self.buttons2D[i]!.count {
                self.buttons2D[i]![t]!.selfCoor = (t, i)
            }
        }
        
        self.tapTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(self.addMilisecond)), userInfo: nil, repeats: true)
        
        
        warningLabel.presentTextToStay(newText: "Tap a circle", duration: 1)
        
        
        colourBin = [colorIndices[0], colorIndices[1]]

        
        for i in buttons {i.changeColor(self.masterColors[self.colourBin[0]]); i.colorIndex = self.colourBin[0]; i.changeBorderColor(to: self.masterColors[self.colourBin[1]])}

        warningLabel.textColor = foreground
        ScoreLabel.textColor = foreground
        liveslabel.textColor = foreground
        scorelabell.textColor = foreground
        self.multiplierLabel.textColor = foreground
        
        
        self.colorIndex = self.colourBin[1]
        
        
        self.view.backgroundColor = themeColor
        print("Basic Game Setup DONE")
        
        DataManager.mute = false
        
        
    }

    
    func endGame() {
        
        AudioHandler.playSound("Sad_Trombone", ".mp3")
        if self.score < 0 {
            self.score = 0
        }
        gameScore = self.score
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {self.performSegue(withIdentifier: "gameOverSegue", sender: nil)})
        
        
        
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
            self.multiplierLabel.presentText(newText: "x1", duration: 0.2, stayFor: duration)
            return numOfButtons * 1
        }
        
    }
    
    func nextRound() {
        
        self.round += 1
        if self.round % 5 == 0 {
            self.substractAmount += 1
        }
        
        if self.round == 1 {
            warningLabel.presentTextToStay(newText: "Match the colors to the rings", duration: 0.5)
        } else if self.round == 2 {
            warningLabel.presentTextToStay(newText: "Get more points by playing faster", duration: 0.5)
        } else {
            warningLabel.dismissText(duration: 0.5)
        }
        
        if true {
            if self.colourBin.count < colorIndices.count {
                self.colourBin.append(colorIndices[self.colourBin.count])
                print("\(self.colourBin)\n")
                print("SUCCESS GRAB NEW COLOR")
            } else {
                print("FAILED GRAB NEW COLOR")}
        }
        
        
        let newColor = returnRandomItem(self.colourBin.filter({$0 != self.colorIndex}))
        self.colorIndex = newColor
        
        AudioHandler.playSound("glass_ping", "mp3")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            AudioHandler.playSound("glass_ping", "mp3")
        })
        
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        for i in self.buttons {
            i.scaling([(0.2, 1.05, 1.1), (0.2, 1, 1)])
            i.changeBorderColor(to: self.masterColors[self.colorIndex], duration: 0.5)
        }
    }
    
    
    func checkAfter() {
        
        
        
        let currentUUID = UUID().uuidString
        self.nextRoundUUID = currentUUID
        print("\nsending DISPATCHQUEUE: \(currentUUID)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 0 {
                if self.nextRoundUUID == currentUUID {
                    print("\nSUCCESS - DISPATCHQUEUE: \(currentUUID)")
                    self.nextRound()
                } else {
                    print("\nQueue FAILED ... DISPATCHQUEUE: \(currentUUID)")
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
            scorelabell.changeColor(themeColor, 0.5)
            liveslabel.changeColor(themeColor, 0.5)
            self.timeSinceLastTap = Date()
        }
        self.isFirstTap = false
        let elapsedTime = Date().timeIntervalSince(self.timeSinceLastTap)
        self.timeSinceLastTap = Date()
        if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 1 && but.colorIndex != self.colorIndex {
            print("1 button left of diff color")
            but.colorIndex = self.colorIndex
            but.changeColor(self.masterColors[self.colorIndex])
            self.score += calcPoints(numOfButtons: 1, timeBetweenTaps: elapsedTime)
            checkAfter()
        } else {
            let oldColor = but.colorIndex + 0
            var butNums = 0
            var timeBetween = 0.0
            for i in self.buttons {
                if i.colorIndex == oldColor {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + timeBetween, execute: {AudioHandler.playSound("breakingGlass", "mp3")})
                    timeBetween += 0.1
                    print("----------------\nfound but of index \(i.colorIndex)")
                    let newColor = returnRandomItem(self.colourBin.filter({$0 != i.colorIndex}))
                    print("\nchanged to \(newColor) | self.colorIndex = \(self.colorIndex)")
                    i.colorIndex = newColor

                    i.changeColor(self.masterColors[newColor], duration: 0.5)
                    
                    
                    
                    butNums += 1
                }
            }
            
            
            if oldColor == self.colorIndex {
                AudioHandler.playSound("alarmSound", "mp3")
                UINotificationFeedbackGenerator().notificationOccurred(.error)
                
                self.numOfSameColorTaps -= 1
                if self.numOfSameColorTaps == 0 {
                    self.view.bringSubview(toFront: but)
                    
                    but.scale(time: 0.2, x: 3, y: 3)
                    //but.pulsate(duration: 0.6, from: 0.1, to: 10.0)
                    endGame()
                } else {
                    self.view.bringSubview(toFront: but)
                    but.scaling([(0.2, 2, 2), (0.1, 1, 1)])
                    //but.pulsate(duration: 0.2, from: 1.0, to: 4.0)
                    if numOfSameColorTaps > 1 {
                        warningLabel.presentText(newText: "Warning: Don't tap single colored buttons", duration: 1, stayFor: 2)
                    } else if numOfSameColorTaps == 1 {
                        warningLabel.presentText(newText: "Warning: Last Chance", duration: 1, stayFor: 2)
                    }
                    
                    ScoreLabel.shake()
                    print("was different color")
                    if self.score < 0 {
                        self.score = 0
                        
                    }
                }
            } else {
                AudioHandler.playSound("breakingGlass", "mp3")
                self.score += calcPoints(numOfButtons: butNums, timeBetweenTaps: elapsedTime)
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
        
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        sender.dateSinceTouchDown = Date()
    }
    
    
    @IBAction func circlePressed(_ sender: ColorCircle) {
        
        print(Date().timeIntervalSince(sender.dateSinceTouchDown))
        if Date().timeIntervalSince(sender.dateSinceTouchDown) > 0.2 {
//            AudioHandler.playSound(self.indexToSound[sender.colorIndex]!, "mp3")
            //UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        checkAllSame(sender)
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.tapTimer.invalidate()
        self.ScoreLabel.textColor = themeColor
        
//        let toViewController = segue.destination as UIViewController
//        self.transitionManager.direction = "normal"
//        toViewController.transitioningDelegate = self.transitionManager
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

