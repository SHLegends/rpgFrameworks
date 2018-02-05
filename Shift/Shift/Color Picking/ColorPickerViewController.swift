//
//  ColorPickerViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-21.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit



class ColorPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var themeLabel: UILabel!
    
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var colorTableView: UITableView!
    
    
    var menuDelegate: MenuSetupDelegate?
    
    var localScheme: colorScheme = currentScheme
    
    let localArrayToUse = colorHandler.setWithCurrentFirst
    
    let animationTime = 0.1
    
    var rowSelected: IndexPath? = nil
    
    var scrollToPath: IndexPath? = nil
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localArrayToUse.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! colorTableViewCell

        row.cColorScheme = localArrayToUse[indexPath.row]
        
        row.stateOfAction = .normal
      
        UIView.transition(with: row, duration: animationTime, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            row.backgroundColor = colorHandler.background
            
            row.nameLabel?.text = "\(row.cColorScheme.name)"
            row.nameLabel?.textColor = colorHandler.foreground
            
            row.priceLabel?.textColor = colorHandler.foreground
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
                        menuDelegate!.loadViewColors()
                        UIView.animate(withDuration: animationTime, delay: 0, options: [.allowUserInteraction], animations: {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.themeLabel.changeColor(localScheme.foreground, 0)
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        self.view.backgroundColor = localScheme.background
        creditsLabel.textColor = localScheme.foreground
        creditsLabel.text = "\(DataManager.totalCredits)"
        
        colorTableView.separatorColor = colorHandler.foreground
        
        customNavigationAnimator.reverse = false

    }

}


