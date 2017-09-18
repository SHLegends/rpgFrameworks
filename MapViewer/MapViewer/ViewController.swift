//
//  ViewController.swift
//  MapViewer
//
//  Created by Joel Huggett on 2017-09-17.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var mapView: NSTextFieldCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var foo = worldMap((100, 100))
        mapView.stringValue = foo.readable
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
   


}

