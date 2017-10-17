//
//  MenuViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-15.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var MainLabel: UIButton!
    @IBOutlet weak var PlayLabel: UIButton!
    @IBOutlet weak var ColorsLabel: UIButton!
    @IBOutlet weak var ScoresLabel: UIButton!
    @IBOutlet weak var OptionsLabel: UIButton!
    
    
    var masterColors = Colors
    var colorIndices = [Int]()
    
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
    
    func randomColorDifferent(than: [Int])-> [Int] {
        // returns list of numbers different than passed set
        var colors = [Int]()
        for i in 0..<masterColors.count {
            colors.append(i)
        }
        var rColors = [Int]()
        rColors.append(returnRandomItem(colors.filter({$0 != than[0]})))
        colors = colors.filter({$0 != rColors[0]})
        rColors.append(returnRandomItem(colors.filter({$0 != than[1]})))
        colors = colors.filter({$0 != rColors[1]})
        for _ in colors {
            let newColor: Int = returnRandomItem(colors)
            rColors.append(newColor)
            colors = colors.filter({$0 != newColor})
        }
        return rColors
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorIndices = randomizeColors()
        
        self.view.backgroundColor = self.masterColors[self.colorIndices[1]]
        let newColor = self.masterColors[self.colorIndices[0]]
        self.MainLabel.setTitleColor(newColor, for: .normal)
        self.PlayLabel.setTitleColor(newColor, for: .normal)
        self.ColorsLabel.setTitleColor(newColor, for: .normal)
        self.ScoresLabel.setTitleColor(newColor, for: .normal)
        self.OptionsLabel.setTitleColor(newColor, for: .normal)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func shiftAction(_ sender: Any) {
        self.colorIndices = randomColorDifferent(than: [self.colorIndices[0], self.colorIndices[1]])
        UIView.animate(withDuration: 1, delay: 0.0, options: .allowUserInteraction, animations: {
            self.view.backgroundColor = self.masterColors[self.colorIndices[1]]
            let newColor = self.masterColors[self.colorIndices[0]]
            self.MainLabel.setTitleColor(newColor, for: .normal)
            self.PlayLabel.setTitleColor(newColor, for: .normal)
            self.ColorsLabel.setTitleColor(newColor, for: .normal)
            self.ScoresLabel.setTitleColor(newColor, for: .normal)
            self.OptionsLabel.setTitleColor(newColor, for: .normal)
        })
        
        
        
    }
    @IBAction func startGame(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameView") as! GameViewController
        newViewController.colorIndices = self.colorIndices
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
