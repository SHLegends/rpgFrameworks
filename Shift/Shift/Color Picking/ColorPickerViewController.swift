//
//  ColorPickerViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-21.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class colorSetsObject: NSObject {
    let colorSetsArray: [colorScheme]
    
    
    init(sets: [colorScheme]) {
        self.colorSetsArray = sets
    }
}

class ColorPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var setName: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var colorTableView: UITableView!
    @IBOutlet weak var b1: ColorCircle!
    @IBOutlet weak var b2: ColorCircle!
    @IBOutlet weak var b3: ColorCircle!
    @IBOutlet weak var b4: ColorCircle!
    @IBOutlet weak var b5: ColorCircle!
    
    let transitionManager = TransitionManager()
    
    var localScheme: colorScheme = currentScheme
    
    var colorIndex = 0
    
    var colorTime = Timer()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let row = colorTableViewCell()
        let row = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! colorTableViewCell
        
        row.cColorScheme = colorSets[indexPath.row]
        
        
        
//        UIView.animate(withDuration: 1, delay: 0, options: .allowUserInteraction, animations: {
//            row.textLabel?.text = row.cColorScheme.name
//            row.textLabel?.textColor = foreground
//            row.backgroundColor = themeColor
//        })
        
        UIView.transition(with: row, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            if DataManager.themeInUse == indexPath.row {
                row.nameLabel?.text = "\(row.cColorScheme.name) *in use*"
            } else if colorSets[indexPath.row].name == self.localScheme.name {
                row.nameLabel?.text = "\(row.cColorScheme.name) *selected*"
            } else {
                row.nameLabel?.text = "\(row.cColorScheme.name)"
            }
            
            row.nameLabel?.textColor = self.localScheme.foreground
            row.priceLabel.text = "Price: \(row.cColorScheme.price)"
            row.priceLabel?.textColor = self.localScheme.foreground
            //row.backgroundColor = themeColor
        }, completion: nil)
        
        
        return row
        
    }
    
    @objc func animateTitle() {
        if self.colorIndex > localScheme.bin.count-1 {
            self.colorIndex = 0
        }
        let newColor = localScheme.bin[self.colorIndex]
        self.b1.changeColor(newColor, duration: 0.5, delay: 0.0)
        self.b2.changeColor(newColor, duration: 0.5, delay: 0.2)
        self.b3.changeColor(newColor, duration: 0.5, delay: 0.4)
        self.b4.changeColor(newColor, duration: 0.5, delay: 0.6)
        self.b5.changeColor(newColor, duration: 0.5, delay: 0.8)
        
        self.colorIndex += 1
    }
    
    func updateExamples(){
//        colorIndices = randomizeColors(masterColors: Colors)
        let buttons = [b1, b2, b3, b4, b5]
        var x = 0
        for i in buttons {
            i?.layer.borderWidth = 4
            i?.layer.borderColor = self.localScheme.bin[colorIndices[x]].cgColor
            x += 1
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        localScheme = colorSets[indexPath.row]
        self.colorIndex = 0
        tableView.reloadData()
        self.updateBackgroundTheme()
        DoneButton.setTitleColor(self.localScheme.foreground, for: .normal)
        
        UIView.transition(with: self.colorTableView, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            self.setName.textColor = self.localScheme.foreground
            self.setName.text = self.localScheme.name
            
            self.creditsLabel.textColor = self.localScheme.foreground
            //self.colorTableView.backgroundColor = themeColor
            self.colorTableView.separatorColor = self.localScheme.foreground
        }, completion: nil)
    
        
        updateExamples()
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    func updateBackgroundTheme() {
        UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            self.view.backgroundColor = self.localScheme.background
            
        }, completion: nil)
    }
    @IBOutlet weak var DoneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        updateExamples()
        
        let buttons = [b1, b2, b3, b4, b5]
        for i in buttons {
            i?.backgroundColor = Colors[0]
        }
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        
        //colorTableView.backgroundColor = themeColor
        colorTableView.separatorColor = localScheme.foreground
        
        
        self.view.backgroundColor = localScheme.background
        DoneButton.setTitleColor(localScheme.foreground, for: .normal)
        
        setName.textColor = localScheme.foreground
        setName.text = localScheme.name
        
        creditsLabel.textColor = localScheme.foreground
        creditsLabel.text = "Credits: \(DataManager.totalCredits)"
        
        self.colorTime = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(self.animateTitle)), userInfo: nil, repeats: true)
        

        // Do any additional setup after loading the view.
    }

    @IBAction func donePressed(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func swipedDown(_ sender: Any) {
        
    }
    
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        self.colorTime.invalidate()
        let toViewController = segue.destination as UIViewController
        self.transitionManager.direction = "S"
        toViewController.transitioningDelegate = self.transitionManager
    }
}


