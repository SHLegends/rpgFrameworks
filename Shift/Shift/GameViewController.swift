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
    
    var round = 0
    var score = 0
    
    let masterColors = Colors
    
    func grabNewColor(_ bin: [UIColor])-> UIColor? {
        let newColors = self.masterColors.filter({!bin.contains($0)})
        if newColors.isEmpty {
            return nil
        } else {
            return newColors[Int(arc4random_uniform(UInt32(newColors.count)))]
        }
    }
    
    func colorDifferent(than: UIColor?, from: [UIColor])-> UIColor? {
        if from.isEmpty {
            print("colorDifferent: from is empty")
            return nil
        } else {
            let newList = from.filter({$0 != than})
            if newList.isEmpty {
                print("colorDifferent: newList is empty")
                return nil
            } else {
                print("colorDifferent: successfully returned new item")
                return newList[Int(arc4random_uniform(UInt32(newList.count)))]
            }
        }
    }
    
    var masterColourBin = [UIColor]()
    var colourBin = [UIColor]()
    
    var nextRoundUUID = String()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MASTER_COLORS: \(self.masterColors)\n")
        colourBin.append(grabNewColor(colourBin)!)
        colourBin.append(grabNewColor(colourBin)!)
        print("COLOR_BIN: \(self.colourBin)\n")
        masterColourBin = colourBin
        print("MASTER_COLOR_BIN: \(self.masterColourBin)\n")

        let buttons: [ColorCircle] = [NW, N, NE, W, C, E, SW, S, SE]
        for i in buttons {i.changeColor(self.colourBin[0])}
        ScoreLabel.changeColor(self.colourBin[0], 0.2)
        TimeLabel.changeColor(self.colourBin[0], 0.2)
        UIView.animate(withDuration: 1.0, animations: {self.view.backgroundColor = self.colourBin[1]})
        
        let b4resizing: [[ColorCircle]] = [[NW, N, NE], [W, C, E], [SW, S, SE]]
        let screenHeight = Double(UIScreen.main.bounds.height)
        var row = 0
        var column = 0
        for i in b4resizing {
            row += 1
            for t in i {
                column += 1
                
                t.bounds.size.height = CGFloat(screenHeight / 7)
                t.bounds.size.width = t.bounds.size.height
                t.layer.cornerRadius = t.bounds.width / 2
                //screenWidth*0.1+ screenHeight*0.3+
                //t.center = CGPoint(x: screenWidth*0.4*Double(column), y: screenHeight*0.4*Double(row))
                
            }
        }
        
        
        C.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        N.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2*0.65)
        S.center = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2*1.35)
        NW.center = CGPoint(x: self.view.bounds.width/2*0.4, y: self.view.bounds.height/2*0.65)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextRound() {
        self.round += 1
        self.TimeLabel.changeColor(self.view.backgroundColor, 0.5)
        self.ScoreLabel.changeColor(self.view.backgroundColor, 0.5)
        if self.round % 3 == 0 {
            if let newColor = self.grabNewColor(self.colourBin) {
                self.colourBin.append(newColor)
                self.masterColourBin = self.colourBin
                print("\(self.colourBin)\n\(newColor)")
                print("SUCCESS GRAB NEW COLOR")
            } else {print("FAILED GRAB NEW COLOR")}
            
        }
        
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.TimeLabel.text = String(self.round)
            self.view.backgroundColor = self.colorDifferent(than: self.view.backgroundColor, from: self.colourBin)
        })
    }
    
    func checkAllSame(_ but: ColorCircle) {
        
//        var checks1 = buttons.filter({$0.backgroundColor != self.view.backgroundColor})
//
//        let newColor = colorDifferent(than: but.backgroundColor, from: self.colourBin)
//
//        but.backgroundColor = newColor
//
//        var checks2 = buttons.filter({$0.backgroundColor != self.view.backgroundColor})
//
        
        let buttons: [ColorCircle] = [NW, N, NE, W, C, E, SW, S, SE]
        var butSame = [ColorCircle]()
        var butDiff = [ColorCircle]()
        for i in buttons {
            if i.backgroundColor == self.view.backgroundColor {
                butSame.append(i)
            } else {
                butDiff.append(i)
            }
        }
        
        but.pulsate(duration: 0.2)
        self.score += 1
        ScoreLabel.text = String(self.score)
        
        if butDiff.count == 1 && but.backgroundColor != self.view.backgroundColor {
            but.changeColor(self.view.backgroundColor)
            let currentUUID = UUID().uuidString
            self.nextRoundUUID = currentUUID
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if buttons.filter({$0.backgroundColor != self.view.backgroundColor}).count == 0 {
                    if self.nextRoundUUID == currentUUID {
                        self.nextRound()
                    }
                }
            })
            
        } else {
            but.changeColor(colorDifferent(than: but.backgroundColor, from: self.colourBin))
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
