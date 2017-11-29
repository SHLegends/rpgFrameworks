//
//  ColorPickerViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-21.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit



class ColorPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
     set up color interactor
 */
    
    @IBOutlet weak var colorInteractor: UIButton!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var colorTableView: UITableView!
    
    let transitionManager = TransitionManager()
    
    var localScheme: colorScheme = currentScheme
    
    let localArrayToUse = colorHandler.setWithCurrentFirst
    
    
    var rowSelected: IndexPath? = nil
    
    var scrollToPath: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArrayToUse.count
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
        
        row.cColorScheme = localArrayToUse[indexPath.row]
        row.layer.borderColor = UIColor.gray.cgColor
        row.layer.borderWidth = 0
        if let path = self.rowSelected {
            if path != indexPath {
                row.layer.borderWidth = 0
            }
        }
        if row.cColorScheme.id == colorHandler.themeInUse.id {
            row.layer.borderColor = UIColor.brown.cgColor
            row.layer.borderWidth = 5
        }
        row.backgroundColor = colorHandler.background
        UIView.transition(with: row, duration: 0.75, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            row.backgroundLabel.textColor = colorHandler.foreground
            row.backgroundColorView.backgroundColor = row.cColorScheme.background
            row.backgroundColorView.layer.masksToBounds = true
            row.backgroundColorView.layer.borderWidth = 2
            row.backgroundColorView.layer.borderColor = colorHandler.foreground.cgColor
            row.backgroundColorView.layer.cornerRadius = 8
            row.nameLabel?.text = "\(row.cColorScheme.name)"
            row.nameLabel?.textColor = colorHandler.foreground
            row.priceLabel.text = "Price: \(row.cColorScheme.price) pts"
            row.priceLabel?.textColor = colorHandler.foreground
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
        localScheme = localArrayToUse[indexPath.row]

        if let path = self.rowSelected {
            if let row: colorTableViewCell = self.colorTableView.cellForRow(at: path) as? colorTableViewCell {
                
                if row.cColorScheme.name != colorHandler.themeInUse.name {
                    row.layer.borderWidth = 0
                }
            }
        }
        if let row: colorTableViewCell = self.colorTableView.cellForRow(at: indexPath) as? colorTableViewCell {
            if row.cColorScheme.name != colorHandler.themeInUse.name {
                row.layer.borderWidth = 5
                
                self.colorInteractor.setTitle("Purchase \(row.cColorScheme.name)", for: .normal)
            }
        }
        self.rowSelected = indexPath
        
    
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    func updateBackgroundTheme() {
        UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            self.view.backgroundColor = self.localScheme.background
            
        }, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.themeInUse = 2
        colorTableView.delegate = self
        colorTableView.dataSource = self
        self.view.backgroundColor = localScheme.background
        self.colorInteractor.setTitleColor(localScheme.foreground, for: .normal)
        self.colorInteractor.setTitle("\(colorHandler.name) is in use", for: .normal)
        creditsLabel.textColor = localScheme.foreground
        creditsLabel.text = "Points: \(DataManager.totalCredits)"
        
        colorTableView.separatorColor = colorHandler.foreground
        
    }
    
    

    
    @IBAction func swipedDown(_ sender: Any) {
        
    }
    
    @IBAction func interactorPressed(_ sender: Any) {
        if let path = self.rowSelected {
            colorHandler.changeThemeFromScheme(scheme: self.localArrayToUse[path.row])
            colorTableView.cellForRow(at: path)?.layer.borderColor = UIColor.brown.cgColor
            
        }
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


