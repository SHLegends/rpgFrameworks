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
    @IBOutlet weak var TimerLabel: UILabel!
    
    var round = 0
    var score = 0
    
    let masterColors = Colors
    var colorIndices = [Int]()
    var colourBin = [Int]()
    var colorIndex = 1
    
    var buttons = [ColorCircle]()
    
    
    
    
    
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
        
        
        
        
        print("View Loaded")
        colorIndices = randomizeColors()
        print("Created self.colorIndices: \(self.colorIndices)")
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            if self.timeLeft - 1 <= 0 {
                self.endGame()
            } else {
                self.timeLeft -= 1
                self.TimerLabel.text = String(self.timeLeft)
            }
        })
        print("Setup timer")
        
        
        print("MASTER_COLORS: \(self.masterColors)\n")
        colourBin = [colorIndices[0], colorIndices[1]]
        print("COLOR_BIN: \(self.colourBin)\n")

        
        for i in buttons {i.changeColor(self.masterColors[self.colourBin[0]]); i.colorIndex = self.colourBin[0]}
        ScoreLabel.changeColor(self.masterColors[self.colourBin[0]], 0.2)
        TimeLabel.changeColor(self.masterColors[self.colourBin[0]], 0.2)
        self.colorIndex = self.colourBin[1]
        UIView.animate(withDuration: 1.0, animations: {self.view.backgroundColor = self.masterColors[self.colourBin[1]]})
        print("Basic Game Setup DONE")
        
//        let b4resizing: [[ColorCircle]] = [[NW, N, NE], [W, C, E], [SW, S, SE]]
//        let screenHeight = Double(UIScreen.main.bounds.height)
//        var row = 0
//        var column = 0
//        for i in b4resizing {
//            row += 1
//            for t in i {
//                column += 1
//
//                t.bounds.size.height = CGFloat(screenHeight / 7)
//                t.bounds.size.width = t.bounds.size.height
//                t.layer.cornerRadius = t.bounds.width / 2
//                //screenWidth*0.1+ screenHeight*0.3+
//                //t.center = CGPoint(x: screenWidth*0.4*Double(column), y: screenHeight*0.4*Double(row))
//
//            }
//        }
//
//
//        C.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
//        N.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2*0.65)
//        S.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2*1.35)
//        NW.center = CGPoint(x: self.view.bounds.width/2*0.4, y: self.view.bounds.height/2*0.65)
//
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func endGame() {
        fatalError()
    }
    
    func nextRound() {
        print("\n\nSetting up next round\n\n")
        self.timeLeft += 20
        self.TimerLabel.text = String(self.timeLeft)
        self.round += 1
        self.TimerLabel.changeColor(self.masterColors[self.colorIndex], 0.5)
        self.TimeLabel.changeColor(self.masterColors[self.colorIndex], 0.5)
        self.ScoreLabel.changeColor(self.masterColors[self.colorIndex], 0.5)
        if self.round % self.round == 0 {
            if self.colourBin.count < self.colorIndices.count {
                self.colourBin.append(self.colorIndices[self.colourBin.count])
                print("\(self.colourBin)\n")
                print("SUCCESS GRAB NEW COLOR")
            } else {
                print("FAILED GRAB NEW COLOR")}
        }
        
        let newColor = returnRandomItem(self.colourBin.filter({$0 != self.colorIndex}))
        self.colorIndex = newColor
        UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: {
            self.TimeLabel.text = String(self.round)
            self.view.backgroundColor = self.masterColors[newColor]
        })
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
        print("\(but) PRESSED")
        
        
        
//        but.pulsate(duration: 0.2)
//        self.score += 1
//        ScoreLabel.text = String(self.score)
        
        if self.buttons.filter({$0.colorIndex != self.colorIndex}).count == 1 && but.colorIndex != self.colorIndex {
            print("1 button left of diff color")
            but.colorIndex = self.colorIndex
            but.changeColor(self.masterColors[self.colorIndex])
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
                    i.pulsate(duration: 0.2)
                    i.changeColor(self.masterColors[newColor])
                    butNums += 1
                }
            }
            
//            let newColor = returnRandomItem(self.colourBin.filter({$0 != but.colorIndex}))
//            print("\n\nchanged to \(newColor)")
//            but.pulsate(duration: 0.2)
//            but.changeColor(self.masterColors[newColor])
//            butNums += 1
//            print("butNums = \(butNums)")

            
            if oldColor == self.colorIndex {
                print("was different color")
                self.timeLeft -= 5
                if self.timeLeft <= 0 {
                    endGame()
                } else {
                    self.TimerLabel.text = String(self.timeLeft)
                }
                self.score -= butNums * 4
                if self.score < 0 {self.score = 0}
            } else {
                self.score += butNums
            }
            ScoreLabel.text = String(self.score)
            checkForComplete()
        }
        
        
        
        /*
         
        
        
        if checks.count == 1 {
            if self.masterColourBin.count >= 2 {
                for i in buttons {
                    if i.backgroundColor != self.view.backgroundColor {
                        self.colourBin = [self.view.backgroundColor!]
                    }
                    
                }
            }
            
            
        }
        
        score += 1
        ScoreLabel.text = String(score)
        but.pulsate(duration: 0.2)
        but.changeColor(colorDifferent(than: but.backgroundColor, from: self.colourBin))
        
        checks = buttons.filter({$0.backgroundColor != self.view.backgroundColor})
        
        if checks.count == 0 {
                    if buttons.filter({$0.backgroundColor != self.view.backgroundColor}).count == 0 {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.colourBin = self.masterColourBin
                        self.round += 1
                        self.TimeLabel.text = String(self.round)
                        self.TimeLabel.changeColor(self.view.backgroundColor, 0.5)
                        self.ScoreLabel.changeColor(self.view.backgroundColor, 0.5)
                        self.view.backgroundColor = self.colorDifferent(than: self.view.backgroundColor, from: self.colourBin)
                        if self.round % 3 == 0 {
                            if let newColor = self.grabNewColor(self.colourBin) {
                                self.colourBin.append(newColor)
                                self.masterColourBin = self.colourBin
                                print("\(self.colourBin)\n\(newColor)")
                                print("SUCCESS GRAB NEW COLOR")
                            } else {print("FAILED GRAB NEW COLOR")}
                            
                        }
                    })
                    
                }
                
            
        }
        
        */
    }
    
    @IBAction func pressedNW(_ sender: Any) {
        checkAllSame(NW)
    }
    @IBAction func pressedN(_ sender: Any) {
        checkAllSame(N)
    }
    @IBAction func pressedNE(_ sender: Any) {
        checkAllSame(NE)
    }
    @IBAction func pressedW(_ sender: Any) {
        checkAllSame(W)
    }
    @IBAction func pressedC(_ sender: Any) {
        checkAllSame(C)
    }
    @IBAction func pressedE(_ sender: Any) {
        checkAllSame(E)
    }
    @IBAction func pressedSW(_ sender: Any) {
        checkAllSame(SW)
    }
    @IBAction func pressedS(_ sender: Any) {
        checkAllSame(S)
    }
    @IBAction func pressedSE(_ sender: Any) {
        checkAllSame(SE)
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
    func changeColor(_ to: UIColor?, _ time: Double) {
        UIView.animate(withDuration: time, animations: {self.textColor = to})
    }
}
