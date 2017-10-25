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
    
    @IBOutlet weak var colorTableView: UITableView!
    @IBOutlet weak var b1: ColorCircle!
    @IBOutlet weak var b2: ColorCircle!
    @IBOutlet weak var b3: ColorCircle!
    @IBOutlet weak var b4: ColorCircle!
    @IBOutlet weak var b5: ColorCircle!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = colorTableViewCell()
        
        row.cColorScheme = colorSets[indexPath.row]
        
        row.textLabel?.text = row.cColorScheme.name
        row.textLabel?.textColor = foreground
        row.backgroundColor = themeColor
        
        return row
        
    }
    
    func updateExamples(){
        colorIndices = randomizeColors(masterColors: Colors)
        let buttons = [b1, b2, b3, b4, b5]
        var x = 0
        for i in buttons {
            i?.backgroundColor = Colors[x]
            x += 1
            i?.layer.borderWidth = 4
            i?.layer.borderColor = Colors[colorIndices[0]].cgColor
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentScheme = colorSets[indexPath.row]
        tableView.reloadData()
        self.updateBackgroundTheme()
        DoneButton.setTitleColor(foreground, for: .normal)
        colorTableView.backgroundColor = themeColor
        colorTableView.separatorColor = foreground
        updateExamples()
    }
    
    override var prefersStatusBarHidden: Bool {return true}

    @IBOutlet weak var DoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateExamples()
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        
        colorTableView.backgroundColor = themeColor
        colorTableView.separatorColor = foreground
        
        
        self.view.backgroundColor = themeColor
        DoneButton.setTitleColor(foreground, for: .normal)
        

        // Do any additional setup after loading the view.
    }

    @IBAction func donePressed(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController {
    func updateBackgroundTheme() {
        self.view.backgroundColor = themeColor
    }
}
