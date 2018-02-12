//
//  SetttingsViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-12-08.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class SetttingsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    @IBOutlet weak var soundSwitchOutlet: UISwitch!
    @IBOutlet weak var soundLabel: UILabel!
    @IBOutlet weak var tapticLabel: UILabel!
    @IBOutlet weak var tapticSwitchOutlet: UISwitch!
    @IBOutlet weak var hintsLabel: UILabel!
    @IBOutlet weak var hintsSwitchOutlet: UISwitch!
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var tutorialSwitchOutlet: UISwitch!
    
    
    override var prefersStatusBarHidden: Bool {return true}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorHandler.background
        self.soundLabel.textColor = colorHandler.foreground
        self.soundSwitchOutlet.isOn = !DataManager.mute
        
        self.tapticLabel.textColor = colorHandler.foreground
        self.tapticSwitchOutlet.isOn = !DataManager.tapticMute
        
        self.hintsLabel.textColor = colorHandler.foreground
        self.hintsSwitchOutlet.isOn = !DataManager.hintsOff
        
        self.tutorialLabel.textColor = colorHandler.foreground
        self.tutorialSwitchOutlet.isOn = !DataManager.tutorialOff
        
    }

    
    @IBAction func soundSwitch(_ sender: UISwitch) {
        DataManager.mute = !sender.isOn
    }
    @IBAction func tapticSwitch(_ sender: UISwitch) {
        DataManager.tapticMute = !sender.isOn
    }
    @IBAction func hintsSwitch(_ sender: UISwitch) {
        DataManager.hintsOff = !sender.isOn
    }
    @IBAction func tutorialSwitch(_ sender: UISwitch) {
        DataManager.tutorialOff = !sender.isOn
    }
    
    
}
