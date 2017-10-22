//
//  GameViewViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {return true}
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
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
    
    
    
    var isFirstTap = true
    
    var numOfSameColorTaps = 0
    
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
    var timer = Timer()
    var timeLeft = 60000
    
    func randomizeColors()-> [Int] {
        var colors = [Int]()
        for i in 0..<masterColors.count {
            colors.append(i)
        }
        var rColors = [Int]()
        for _ in colors {
            let newColor: Int = returnRandomItem(colors)
            rColors.append(newColor)
            colors = colors.filter({$0 != newColor})
        }
        return rColors
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.buttons = [NW!, N!, NE!, W!, C!, E!, SW!, S!, SE!]
        self.buttons2D = [0: [0: NW!, 1: N!, 2: NE!], 1: [0: W!, 1: C!, 2: E!], 2: [0: SW!, 1: S!, 2: SE!]]
        for i in 0..<self.buttons2D.count {
            for t in 0..<self.buttons2D[i]!.count {
                self.buttons2D[i]![t]!.selfCoor = (t, i)
            }
        }
        
        warningLabel.presentTextToStay(newText: "Tap a circle", duration: 1)
        
        print("View Loaded")
//        colorIndices = randomizeColors()
        print("Created self.colorIndices: \(colorIndices)")
        
        print("Setup timer")
        
        
        print("MASTER_COLORS: \(self.masterColors)\n")
        colourBin = [colorIndices[0], colorIndices[1]]
        print("COLOR_BIN: \(self.colourBin)\n")

        
        for i in buttons {i.changeColor(self.masterColors[self.colourBin[0]]); i.colorIndex = self.colourBin[0]; i.changeBorderColor(to: self.masterColors[self.colourBin[1]])}
        warningLabel.changeColor(self.masterColors[self.colourBin[0]], 0.2)
        ScoreLabel.changeColor(self.masterColors[self.colourBin[0]], 0.2)
        TimeLabel.changeColor(self.masterColors[self.colourBin[0]], 0.2)
        self.colorIndex = self.colourBin[1]
//        UIView.animate(withDuration: 1.0, animations: {self.view.backgroundColor = self.masterColors[self.colourBin[1]]})
        self.view.backgroundColor = themeColor
        print("Basic Game Setup DONE")
 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "GameOver", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameOverView") as! GameOverViewController
//        present(newViewController, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: {})
        gameScore = self.score
        performSegue(withIdentifier: "gameOverSegue", sender: nil)
        
        
    }
    
    func calcPoints(numOfButtons: Int, timeBetweenTaps: Double)-> Int {
        
        if timeBetweenTaps < 1.0 {
            switch Double(Int(timeBetweenTaps * 10))/10 {
            case 0.0:
                return numOfButtons * 100
            case 0.1:
                return numOfButtons * 75
            case 0.2:
                return numOfButtons * 50
            case 0.3:
                return numOfButtons * 25
            case 0.4:
                return numOfButtons * 10
            case 0.5:
                return numOfButtons * 9
            case 0.6:
                return numOfButtons * 8
            case 0.7:
                return numOfButtons * 7
            case 0.8:
                return numOfButtons * 6
            case 0.9:
                return numOfButtons * 5
            default:
                return 0
            }
            
        } else if timeBetweenTaps < 2.0 {
            return numOfButtons * 4
        } else if timeBetweenTaps < 3.0 {
            return numOfButtons * 3
        } else if timeBetweenTaps < 4.0 {
            return numOfButtons * 2
        } else {
            return numOfButtons * 1
        }
        
    }
    
    func nextRound() {
        print("\n\nSetting up next round\n\n")
        
        
        
        self.round += 1
        
        
        if self.round == 1 {
            warningLabel.presentTextToStay(newText: "Match the colors to the rings", duration: 0.5)
        } else if self.round == 2 {
            warningLabel.presentTextToStay(newText: "Get higher scores by playing faster", duration: 0.5)
        } else {
            warningLabel.dismissText(duration: 0.5)
        }
        
        
        
        self.numOfSameColorTaps = 0
        if self.round % self.round == 0 {
            if self.colourBin.count < colorIndices.count {
                self.colourBin.append(colorIndices[self.colourBin.count])
                print("\(self.colourBin)\n")
                print("SUCCESS GRAB NEW COLOR")
            } else {
                print("FAILED GRAB NEW COLOR")}
        }
        
        self.TimeLabel.text = String(self.round)
        let newColor = returnRandomItem(self.colourBin.filter({$0 != self.colorIndex}))
        self.colorIndex = newColor
        self.warningLabel.changeColor(self.masterColors[self.colorIndex], 0.5)
        self.TimeLabel.changeColor(self.masterColors[self.colorIndex], 0.5)
        self.ScoreLabel.changeColor(self.masterColors[self.colorIndex], 0.5)
        for i in self.buttons {
            i.pulsate(duration: 0.2)
            i.changeBorderColor(to: self.masterColors[self.colorIndex], duration: 0.5)
        }
//        UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: {
//
//            self.view.backgroundColor = self.masterColors[newColor]
//        })
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
    
    func checkAllSame(_ but: ColorCircle, _ point: coor) {
        
        if self.isFirstTap {
            warningLabel.dismissText(duration: 1)
        }
        self.isFirstTap = false
        
        let elapsedTime = Date().timeIntervalSince(self.timeSinceLastTap)
        self.timeSinceLastTap = Date()
        
        
        print("\(but) PRESSED POINT: ", point)
        if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 1 && but.colorIndex != self.colorIndex {
            print("1 button left of diff color")
            but.colorIndex = self.colorIndex
            but.changeColor(self.masterColors[self.colorIndex])
            but.pulsate(duration: 0.2)
            self.score += calcPoints(numOfButtons: 1, timeBetweenTaps: elapsedTime)
            checkAfter()
        } else {
            let oldColor = but.colorIndex + 0
            var butNums = 0
            
            
            
            
            for i in self.buttons {
                if i.colorIndex == oldColor {
                    print("----------------\nfound but of index \(i.colorIndex)")
                    let newColor = returnRandomItem(self.colourBin.filter({$0 != i.colorIndex}))
                    print("\nchanged to \(newColor) | self.colorIndex = \(self.colorIndex)")
                    i.colorIndex = newColor
//                    if but.selfCoor.x - i.selfCoor.x != 0 {
//                        if but.selfCoor.x - i.selfCoor.x < 0 {
//                            i.pulsate(duration: Double((but.selfCoor.x - i.selfCoor.x) * -1))
//                            i.changeColor(self.masterColors[newColor], duration: Double((but.selfCoor.x - i.selfCoor.x)) * -1)
//                        } else {
//                            i.pulsate(duration: Double((but.selfCoor.x - i.selfCoor.x)))
//                            i.changeColor(self.masterColors[newColor], duration: Double((but.selfCoor.x - i.selfCoor.x)))
//                        }
//                    } else if but.selfCoor.y - i.selfCoor.y != 0 {
//                        if but.selfCoor.y - i.selfCoor.y < 0 {
//                            i.pulsate(duration: Double((but.selfCoor.y - i.selfCoor.y) * -1))
//                            i.changeColor(self.masterColors[newColor], duration: Double((but.selfCoor.y - i.selfCoor.y) * -1))
//                        } else {
//                            i.pulsate(duration: Double((but.selfCoor.y - i.selfCoor.y)))
//                            i.changeColor(self.masterColors[newColor], duration: Double((but.selfCoor.y - i.selfCoor.y)))
//                        }
//                    } else {
//
//                    }
//                    i.pulsate(duration: 0.2)
                    i.changeColor(self.masterColors[newColor], duration: 0.5)
                    
                    butNums += 1
                }
            }
            
            
            if oldColor == self.colorIndex {
                self.numOfSameColorTaps += 1
                if self.numOfSameColorTaps >= 3 {
                    endGame()
                } else {
                    self.view.bringSubview(toFront: but)
                    but.pulsate(duration: 0.2, from: 1.0, to: 4.0)
                    if numOfSameColorTaps == 1 {
                        warningLabel.presentText(newText: "Warning: Don't tap single colored buttons", duration: 1, stayFor: 2)
                    } else if numOfSameColorTaps == 2 {
                        warningLabel.presentText(newText: "Warning: Last Chance", duration: 1, stayFor: 2)
                    }
                    
                    ScoreLabel.shake()
                    print("was different color")
                
                    self.score = Int(Double(self.score) * 0.75)
                    if self.score < 0 {
                        self.score = 0
                        
                    }
                }
            } else {
                but.pulsate(duration: 0.2)
//                print("\nbutNums: \(butNums)\nelapsedTime: \(elapsedTime)\nelapsedTime + 1: \(Double(Int(elapsedTime) + 1))\ntime - wholeNum: \(elapsedTime - Double(Int(elapsedTime)))\nfinal: \(Int(Double(butNums) / (elapsedTime - Double(Int(elapsedTime))) / Double(Int(elapsedTime) + 1)))\n")
//                self.score += Int(Double(butNums) / (elapsedTime - Double(Int(elapsedTime))) / Double(Int(elapsedTime) + 1))
                self.score += calcPoints(numOfButtons: butNums, timeBetweenTaps: elapsedTime)
            }
            
            ScoreLabel.text = String(self.score)
            checkForComplete()
        }
        
        
        
    }
    
    @IBAction func pressedNW(_ sender: Any) {
        checkAllSame(NW, (0, 0))
    }
    @IBAction func pressedN(_ sender: Any) {
        checkAllSame(N, (1, 0))
    }
    @IBAction func pressedNE(_ sender: Any) {
        checkAllSame(NE, (2, 0))
    }
    @IBAction func pressedW(_ sender: Any) {
        checkAllSame(W, (0, 1))
    }
    @IBAction func pressedC(_ sender: Any) {
        checkAllSame(C, (1, 1))
    }
    @IBAction func pressedE(_ sender: Any) {
        checkAllSame(E, (2, 1))
    }
    @IBAction func pressedSW(_ sender: Any) {
        checkAllSame(SW, (0, 2))
    }
    @IBAction func pressedS(_ sender: Any) {
        checkAllSame(S, (1, 2))
    }
    @IBAction func pressedSE(_ sender: Any) {
        checkAllSame(SE, (2, 2))
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

extension UILabel {
    func changeColor(_ to: UIColor?, _ time: Double, delay: Double = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {UIView.transition(with: self, duration: time, options: .transitionCrossDissolve, animations: {self.textColor = to})})
        
    }
    
    func shake() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        shake.fromValue = fromValue
        shake.toValue = toValue
        layer.add(shake, forKey: "position")
    }
    
    func presentText(newText: String, duration: Double, stayFor: Double) {
//        var oldText = ""
//        if self.text != nil && self.text! != "" {
//            oldText = self.text!
//        }
        self.text = newText
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 1.0
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + stayFor, execute: {
            UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
                self.alpha = 0.0
            })
//            if oldText != "" {
//                self.text = oldText
//                UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
//                    self.alpha = 1.0
//                })
//            }
            
        })
        
    }
    
    func presentTextToStay(newText: String, duration: Double) {
        self.text = newText
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 1.0
        })
    }
    
    func dismissText(duration: Double) {
        UIView.animate(withDuration: duration, delay: 0, options: .allowUserInteraction, animations: {
            self.alpha = 0.0
        })
    }
}
