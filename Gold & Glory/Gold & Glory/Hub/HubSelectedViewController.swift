//
//  HubSelectedViewController.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

protocol HubViewDelegate {
    func refreshCellForRow(_ path: IndexPath)
}

class HubSelectedViewController: UIViewController {
    
    @IBOutlet weak var fightButton: UIButton!
    var contestant: contestent?
    var delegate: HubViewDelegate?
    var index: IndexPath?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var weaponLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let hubDelegate = self.delegate {
            if let indexpath = self.index {
                hubDelegate.refreshCellForRow(indexpath)
            } else {
                fatalError("Missing IndexPath for delegate")
            }
            
            
        } else {
            fatalError("HubSelectedViewController has no delegate")
        }
        if let newContestant: contestent = contestant {
            nameLabel.text = newContestant.name
            if newContestant.isDead {
                hpLabel.text = "HP: DEAD"
                fightButton.isHidden = true
                fightButton.isEnabled = false
            } else {
                hpLabel.text = "HP: \(newContestant.hp)"
            }
            
            weaponLabel.text = "DMG: \(newContestant.weapon.damage)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fightPressed(_ sender: Any) {
        performSegue(withIdentifier: "startFight", sender: nil)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let VC: CombatViewController = segue.destination as? CombatViewController {
            VC.contestants = [contestant!, contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: "Enemy")]
        }
    }
 

}
