//
//  themesHandler.swift
//  Shift
//
//  Created by Joel Huggett on 2017-11-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit

class themeHandler {
    
    var themeInUse: colorScheme
    
    var colorSets: [colorScheme] = [colorBins.betaBlack, colorBins.alpha, colorBins.betaWhite, colorBins.greyWhite, colorBins.flat, colorBins.beta2Black, colorBins.beta2White]
    
    var background: UIColor {get{return self.themeInUse.background}}
    var foreground: UIColor {get{return self.themeInUse.foreground}}
    var Colors: [UIColor] {get{return self.themeInUse.bin}}
    var name: String {get{return self.themeInUse.name}}
    
    
    
    init() {
        self.themeInUse = colorSets[DataManager.themeInUse]
        
    }
    
    func changeTheme(index: Int) {
        
    }
    
    
    
}

var colorHandler = themeHandler()
