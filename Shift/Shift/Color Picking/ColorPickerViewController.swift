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
    
    /*
     set up color interactor
 */
    
    @IBOutlet weak var colorInteractor: UIButton!
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
    
    var rowSelected: IndexPath? = nil
    
    var scrollToPath: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! colorTableViewCell
        let size = 50
        row.firstColor.layer.masksToBounds = true
        row.secondColor.layer.masksToBounds = true
        row.thirdColor.layer.masksToBounds = true
        row.fourthColor.layer.masksToBounds = true
        row.fifthColor.layer.masksToBounds = true
        row.firstColor.layer.cornerRadius = CGFloat(size / 2)
        row.secondColor.layer.cornerRadius = CGFloat(size / 2)
        row.thirdColor.layer.cornerRadius = CGFloat(size / 2)
        row.fourthColor.layer.cornerRadius = CGFloat(size / 2)
        row.fifthColor.layer.cornerRadius = CGFloat(size / 2)
        row.cColorScheme = colorSets[indexPath.row]
        row.layer.borderColor = UIColor.gray.cgColor
        
        if let path = self.rowSelected {
            if path == indexPath {
                _ = 0
                
            } else {
                row.layer.borderWidth = 0
            }
        }
        
        if row.cColorScheme.name == colorSets[DataManager.themeInUse].name {
            self.scrollToPath = indexPath
            row.layer.borderColor = UIColor.brown.cgColor
            row.layer.borderWidth = 5
        }
        
        row.backgroundColor = row.cColorScheme.background
        UIView.transition(with: row, duration: 0.75, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            if DataManager.themeInUse == indexPath.row {
                row.nameLabel?.text = "\(row.cColorScheme.name) (current theme)"
            } else if colorSets[indexPath.row].name == self.localScheme.name {
                row.nameLabel?.text = "\(row.cColorScheme.name)"
            } else {
                row.nameLabel?.text = "\(row.cColorScheme.name)"
            }
            
            row.nameLabel?.textColor = row.cColorScheme.foreground
            row.priceLabel.text = "Price: \(row.cColorScheme.price) pts"
            row.priceLabel?.textColor = row.cColorScheme.foreground
            row.firstColor.backgroundColor = row.cColorScheme.bin[0]
            row.secondColor.backgroundColor = row.cColorScheme.bin[1]
            row.thirdColor.backgroundColor = row.cColorScheme.bin[2]
            row.fourthColor.backgroundColor = row.cColorScheme.bin[3]
            row.fifthColor.backgroundColor = row.cColorScheme.bin[4]
        }, completion: nil)
        return row
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        localScheme = colorSets[indexPath.row]
        self.colorIndex = 0
        if let path = self.rowSelected {
            if let row: colorTableViewCell = self.colorTableView.cellForRow(at: path) as? colorTableViewCell {
                
                if row.cColorScheme.name == colorSets[DataManager.themeInUse].name {
                    _ = 0
                } else {
                    row.layer.borderWidth = 0
                }
            }
        }
        if let row: colorTableViewCell = self.colorTableView.cellForRow(at: indexPath) as? colorTableViewCell {
            if row.cColorScheme.name == colorSets[DataManager.themeInUse].name {
                _ = 0
            } else {
                row.layer.borderWidth = 5
            }
        }
        self.rowSelected = indexPath
        UIView.transition(with: self.colorTableView, duration: 0.1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            self.setName.text = self.localScheme.name
            
        }, completion: nil)
    
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    func updateBackgroundTheme() {
        UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            self.view.backgroundColor = self.localScheme.background
            
        }, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataManager.themeInUse = 4
        

        
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        
        
        
        
        self.view.backgroundColor = localScheme.background
        
        
        
        self.colorInteractor.setTitleColor(localScheme.foreground, for: .normal)
        self.colorInteractor.setTitle("", for: .normal)
        
        creditsLabel.textColor = localScheme.foreground
        creditsLabel.text = "Points: \(DataManager.totalCredits)"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.colorTableView.scrollToRow(at: self.scrollToPath!, at: .bottom, animated: false)
        })
        
        
        
        
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
//        self.colorTime.invalidate()
        let toViewController = segue.destination as UIViewController
        self.transitionManager.direction = "E"
        toViewController.transitioningDelegate = self.transitionManager
    }
}


