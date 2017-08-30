//
//  amour_components.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-30.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation




struct symbol {
    var cType: (name: String, effect: (type: String, amount: Int))
    var cColour: colour
    init(cType: (name: String, effect: (type: String, amount: Int)) = returnRandomItem(symbols), cColour: colour = returnRandomItem(colours)) {
        self.cType = cType
        self.cColour = cColour
    }
    var name: String {get{return "\(self.cColour.name) Symbol of \(self.cType.name)"}}
    var value: Int {get{return self.cColour.value + 50}}
}

struct pelt {
    var cPelt: (name: String, value: Int, gripPercent: Int, effect: (type: String, amount: Int))
    var cMaterial: leather
    var cEffect: (type: String, amount: Int)
    init(cPelt: (name: String, value: Int, gripPercent: Int, effect: (type: String, amount: Int)) = returnRandomItem(pelts)) {
        self.cPelt = cPelt
        self.cMaterial = leather(giveRawMaterial: (self.cPelt.name, self.cPelt.value, self.cPelt.gripPercent))
        self.cEffect = cPelt.effect
    }
}
