//
//  ColorPickerViewController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-21.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var colorTableView: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = colorTableViewCell()
        
        row.textLabel?.text = row.cColorScheme.name
        row.textLabel?.textColor = foreground
        row.backgroundColor = themeColor
        
        return row
        
    }
    
    override var prefersStatusBarHidden: Bool {return true}

    @IBOutlet weak var DoneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
