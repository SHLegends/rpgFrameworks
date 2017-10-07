//
//  SecondViewController.swift
//  Duel
//
//  Created by Joel Huggett on 2017-10-03.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var NWButton: UIButton!
    
    @IBOutlet weak var NButton: UIButton!
    @IBOutlet weak var NEButton: UIButton!
    @IBOutlet weak var WButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var EButton: UIButton!
    @IBOutlet weak var SWButton: UIButton!
    @IBOutlet weak var SButton: UIButton!
    @IBOutlet weak var SEButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NWButton.setRound()
        NButton.setRound()
        NEButton.setRound()
        WButton.setRound()
        CButton.setRound()
        EButton.setRound()
        SWButton.setRound()
        SButton.setRound()
        SEButton.setRound()
        
        
        self.view.backgroundColor = Colors.secondBackground
        
//        roundButton.layer.cornerRadius = 50
//        roundButton.layer.borderWidth = 8
//        roundButton.layer.borderColor = UIColor.red.cgColor
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func NWpressed(_ sender: Any) {
        print("Start")
        
        NWButton.pressAnimation()
        print("Done")
    }
    @IBAction func Npressed(_ sender: Any) {
        
        NButton.pressAnimation()
    }
    @IBAction func NEpressed(_ sender: Any) {
        NEButton.pressAnimation()
    }
    @IBAction func Wpressed(_ sender: Any) {
        WButton.pressAnimation()
    }
    @IBAction func Cpressed(_ sender: Any) {
        CButton.pressAnimation()
    }
    @IBAction func Epressed(_ sender: Any) {
        EButton.pressAnimation()
    }
    @IBAction func SWpressed(_ sender: Any) {
        SWButton.pressAnimation()
    }
    @IBAction func Spressed(_ sender: Any) {
        SButton.pressAnimation()
    }
    @IBAction func SEpressed(_ sender: Any) {
        SEButton.pressAnimation()
    }
    

}

extension UIButton {
    func setRound() {
        self.layer.cornerRadius = 50
        self.layer.borderWidth = 4
        self.layer.borderColor = Colors.hitBorder
    }
}

extension UIButton {
    func pressAnimation() {
        self.layer.borderColor = UIColor.red.cgColor
        self.backgroundColor = UIColor.cyan
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.backgroundColor = UIColor.green;
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.backgroundColor = UIColor.cyan;
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.backgroundColor = nil
                    
                })
            })
            
        })
        
    }
}

