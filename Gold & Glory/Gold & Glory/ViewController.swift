//
//  ViewController.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

protocol EventDelegate {
    func finished()
}

import UIKit

class CombatViewController: UIViewController, EventDelegate {
    @IBOutlet weak var textView: UITextView!
    
    var contestants: [contestent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            let event = fightEvent(textView: self.textView, combatants: self.contestants)
            event.start()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func finished() {
        print("Done")
    }
    
    
    
}

