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
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var colorTableView: UITableView!
    
//    let transitionManager = TransitionManager()
    
    var localScheme: colorScheme = currentScheme
    
    let localArrayToUse = colorHandler.setWithCurrentFirst
    
    
    var rowSelected: IndexPath? = nil
    
    var scrollToPath: IndexPath? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArrayToUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! colorTableViewCell

        row.cColorScheme = localArrayToUse[indexPath.row]
        

        
        row.stateOfAction = .normal
        
        
        
        
        
        UIView.transition(with: row, duration: 0.75, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            row.backgroundColor = colorHandler.background
            
//            row.backgroundLabel.textColor = colorHandler.foreground
//            row.backgroundColorView.backgroundColor = row.cColorScheme.background
//            row.backgroundColorView.layer.masksToBounds = true
//            row.backgroundColorView.layer.borderWidth = 2
//            row.backgroundColorView.layer.borderColor = colorHandler.foreground.cgColor
//            row.backgroundColorView.layer.cornerRadius = 8
            row.nameLabel?.text = "\(row.cColorScheme.name)"
            row.nameLabel?.textColor = colorHandler.foreground
            
            row.priceLabel?.textColor = colorHandler.foreground
//            row.firstColor.backgroundColor = row.cColorScheme.bin[0]
//            row.secondColor.backgroundColor = row.cColorScheme.bin[1]
//            row.thirdColor.backgroundColor = row.cColorScheme.bin[2]
//            row.fourthColor.backgroundColor = row.cColorScheme.bin[3]
//            row.fifthColor.backgroundColor = row.cColorScheme.bin[4]
        }, completion: nil)
        return row
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let path = self.rowSelected {
            if path.row == indexPath.row {
                if let row: colorTableViewCell = self.colorTableView.cellForRow(at: indexPath) as? colorTableViewCell {
                    if row.stateOfAction == .wasTapped {
                        row.stateOfAction = .wasTappedAgain
                        
                        UIView.animate(withDuration: 0.75, delay: 0, options: [.allowUserInteraction], animations: {
                            self.view.backgroundColor = colorHandler.themeInUse.background
                            
                            self.colorTableView.separatorColor = colorHandler.foreground
                            self.themeLabel.textColor = colorHandler.foreground
                            self.creditsLabel.textColor = colorHandler.foreground
                            
                            
                            for i in self.colorTableView.visibleCells {
                                if let newRow: colorTableViewCell = i as? colorTableViewCell {
                                    newRow.backgroundColor = colorHandler.background
                                    newRow.nameLabel.textColor = colorHandler.foreground
                                    newRow.priceLabel.textColor = colorHandler.foreground
                                    var rowArray: [colorTableViewCell] = self.colorTableView.visibleCells as! [colorTableViewCell]
                                    rowArray = rowArray.filter({$0.cColorScheme.id != row.cColorScheme.id})
                                    for t in rowArray {
                                        t.stateOfAction = .normal
                                    }
                                    
                                }
                            }
                            
                        }, completion: nil)
                        
                        
                    } else if row.stateOfAction == .normal {
                        row.stateOfAction = .wasTapped
                    }
                    
                }
            } else {
                if let oldRow: colorTableViewCell = self.colorTableView.cellForRow(at: path) as? colorTableViewCell {
                    oldRow.stateOfAction = .normal
                }
                if let row: colorTableViewCell = self.colorTableView.cellForRow(at: indexPath) as? colorTableViewCell {
                    row.stateOfAction = .wasTapped
                }
            }
        } else {
            if let row: colorTableViewCell = self.colorTableView.cellForRow(at: indexPath) as? colorTableViewCell {
                if row.stateOfAction == .normal {
                    row.stateOfAction = .wasTapped
                }
            }
        }
        
        if Int(self.creditsLabel.text!) != DataManager.totalCredits {
            
            self.creditsLabel.text = "\(DataManager.totalCredits)"
            
            
        }
        
        
        
        
        
        
        
        
        
        
        self.rowSelected = indexPath
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
//    func updateBackgroundTheme() {
//        UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
//            self.view.backgroundColor = self.localScheme.background
//
//        }, completion: nil)
//    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.themeLabel.changeColor(localScheme.foreground, 0)
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        self.view.backgroundColor = localScheme.background
        creditsLabel.textColor = localScheme.foreground
        creditsLabel.text = "\(DataManager.totalCredits)"
        
        colorTableView.separatorColor = colorHandler.foreground
        
        
        
    }
    
    


    @IBAction func close(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        self.colorTime.invalidate()
//        let toViewController = segue.destination as UIViewController
//        self.transitionManager.direction = "E"
//        toViewController.transitioningDelegate = self.transitionManager
    }
}


