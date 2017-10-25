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
    
    
    @IBOutlet weak var PlayLabel: UIButton!
    @IBOutlet weak var ColorsLabel: UIButton!
    @IBOutlet weak var S: UILabel!
    @IBOutlet weak var H: UILabel!
    @IBOutlet weak var I: UILabel!
    @IBOutlet weak var F: UILabel!
    @IBOutlet weak var T: UILabel!
    
    var colorTimer = Timer()
    var masterColors = Colors
    
    
    
    
//    func randomColorDifferent(than: [Int])-> [Int] {
//        // returns list of numbers different than passed set
//        var colors = [Int]()
//        for i in 0..<masterColors.count {
//            colors.append(i)
//        }
//        var rColors = [Int]()
//        rColors.append(returnRandomItem(colors.filter({$0 != than[0]})))
//        colors = colors.filter({$0 != rColors[0]})
//        rColors.append(returnRandomItem(colors.filter({$0 != than[1]})))
//        colors = colors.filter({$0 != rColors[1]})
//        for _ in colors {
//            let newColor: Int = returnRandomItem(colors)
//            rColors.append(newColor)
//            colors = colors.filter({$0 != newColor})
//        }
//        return rColors
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        colorIndices = randomizeColors(masterColors: Colors)
        
        self.view.backgroundColor = themeColor
        let newColor = self.masterColors[colorIndices[0]]
        self.PlayLabel.setTitleColor(foreground, for: .normal)
        self.ColorsLabel.setTitleColor(foreground, for: .normal)
        self.S.textColor = newColor
        self.H.textColor = newColor
        self.I.textColor = newColor
        self.F.textColor = newColor
        self.T.textColor = newColor
        
        self.colorTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.animateTitle)), userInfo: nil, repeats: true)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.colorTimer.invalidate()
    }
 
    
    @objc func animateTitle() {
        let newColor = randColor(Colors)
        self.S.changeColor(newColor, 0.5, delay: 0.0)
        self.H.changeColor(newColor, 0.5, delay: 0.2)
        self.I.changeColor(newColor, 0.5, delay: 0.4)
        self.F.changeColor(newColor, 0.5, delay: 0.6)
        self.T.changeColor(newColor, 0.5, delay: 0.8)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
//        UIView.transition(with: self.PlayLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {self.PlayLabel.setTitleColor(newColor, for: .normal)}, completion: nil)
//        UIView.transition(with: self.ColorsLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {self.ColorsLabel.setTitleColor(newColor, for: .normal)}, completion: nil)
//        })
    }
    
//    @IBAction func shiftAction(_ sender: Any) {
//        colorIndices = randomColorDifferent(than: [colorIndices[0], colorIndices[1]])
//        UIView.animate(withDuration: 1, delay: 0.0, options: .allowUserInteraction, animations: {
//
//            let newColor = self.masterColors[colorIndices[0]]
//            self.PlayLabel.setTitleColor(newColor, for: .normal)
//            self.ColorsLabel.setTitleColor(newColor, for: .normal)
//        })
//
//
//
//    }
    @IBAction func startGame(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
//        present(newViewController, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: {
//            
//        })
        

    }
    @IBAction func openColorPicker(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "ColorPicking", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ColorPickerView") as! ColorPickerViewController
//        present(newViewController, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: {})
    }
    
}
