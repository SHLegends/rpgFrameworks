//
//  MapView.swift
//  MapViewer
//
//  Created by Joel Huggett on 2017-09-27.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Cocoa

class MapView: NSView {

    override func draw(_ Rect: NSRect) {
        var x = 0
        var y = 0
        for _ in 0...100 {
            
            //// Color Declarations
            let color = NSColor.red
            
            //// Rectangle Drawing
            let rectanglePath = NSBezierPath(rect: NSRect(x: x, y: 0, width: 1, height: 1))
            color.setFill()
            rectanglePath.fill()
            x += 1
            y += 1
            
            
        }
        

    }
    
}
