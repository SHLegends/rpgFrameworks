//
//  SetttingsViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-12-08.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class SetttingsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    let customPresentAnimationController = CustomPresentAnimationController()
    
    @IBOutlet weak var soundSwitchOutlet: UISwitch!
    @IBOutlet weak var soundLabel: UILabel!
    override var prefersStatusBarHidden: Bool {return true}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = colorHandler.background
        self.soundLabel.textColor = colorHandler.foreground
        self.soundSwitchOutlet.isOn = !DataManager.mute
        // Do any additional setup after loading the view.
    }

    
    @IBAction func soundSwitch(_ sender: UISwitch) {
        DataManager.mute = !sender.isOn
    }
    
    @IBAction func close(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
