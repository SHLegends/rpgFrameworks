//
//  ViewController.swift
//  MapViewer
//
//  Created by Joel Huggett on 2017-09-17.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Cocoa




class ViewController: NSViewController {

    @IBOutlet weak var stateLabel: NSTextField!
    
    var mapView: MapView = MapView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateLabel.stringValue = "ready"
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
//    override func awakeFromNib() {
//        if self.view.layer != nil {
//            let color : CGColor = CGColor.init(gray: 0.5, alpha: 1)
//            self.view.layer?.backgroundColor = color
//        }
//
//    }
    
    @IBAction func mapToMake(_ sender: Any) {
        
        stateLabel.textColor = NSColor.blue
        stateLabel.stringValue = "working"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stateLabel.textColor = NSColor.green
            self.stateLabel.stringValue = "done"
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.stateLabel.textColor = NSColor.black
            self.stateLabel.stringValue = "ready"
        }
        

        
        
    }
    


}

