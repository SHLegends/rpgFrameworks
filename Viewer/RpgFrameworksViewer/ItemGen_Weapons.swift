//
//  ItemGen_Weapons.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-12.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

protocol weapon {
    var name: String {get}
    var weight: Double {get}
    var value: Int {get}
    var components: [(name: String, amount: Double)] {get}
    var grip: Int {get}
    var length: Int {get}
    func description()
    func simpleDescription()
    func basicDescription()
}

struct sword: weapon {
    var cMetal: metal
    var cBlade: doubleEdgeBlade
    var cGuard: crossguard
    var cHandle: handle
    var cPommel: pommel
    var cList: [weaponComponent]
    init(giveMetal: metal = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveBlade: doubleEdgeBlade? = nil, giveGuard: crossguard? = nil, giveHandle: handle? = nil, givePommel: pommel? = nil) {
        self.cMetal = giveMetal
        if giveBlade != nil { self.cBlade = giveBlade! } else { self.cBlade = doubleEdgeBlade(length: returnRandNumInRange(26, 40), giveMetal: self.cMetal) }
        if giveGuard != nil { self.cGuard = giveGuard! } else if isRare { self.cGuard = crossguard(giveMetal: metal(giveRawMaterial: returnRandomItem(metals["rare"]!))) } else { self.cGuard = crossguard(giveMetal: self.cMetal) }
        if giveHandle != nil { self.cHandle = giveHandle! } else { self.cHandle = handle()}
        if givePommel != nil { self.cPommel = givePommel! } else if isRare { self.cPommel = pommel(giveMetal: metal(giveRawMaterial: returnRandomItem(metals["rare"]!))) } else { self.cPommel = pommel(giveMetal: self.cMetal) }
        self.cList = [self.cBlade, self.cGuard, self.cHandle, self.cPommel]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.cBlade.length)\" \(self.cMetal.rawMaterial.name) Sword"}
    var weight: Double {var weight = 0.0; for item in self.cList {weight += item.weight}; return weight}
    var value: Int {var value = 0; for item in self.cList {value += item.value}; return value}
    var grip: Int {return self.cHandle.grip}
    var components: [(name: String, amount: Double)] {return self.cBlade.components + self.cGuard.components + self.cHandle.components + self.cPommel.components}
    func description() {
        print("\n\n\nSword\n=============================================")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        self.cBlade.description()
        self.cGuard.description()
        self.cHandle.description()
        self.cPommel.description()
        print("\n\n~~~~~~~~~~~~~~~~~~~~~\nFULL Salvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
        print("=============================================\n\n\n")
    }
    func simpleDescription() {
        print("\nSimple Description For... \(self.name)\n------------------------")
        for item in self.cList {
            print("-> \(item.simpleDescription) ")
        }
        print("------------------------\n")
    }
    func basicDescription() {
        print("\nDescription For... \(self.name)\n------------------------")
        for item in self.cList {
            print(">>> \(item.name) ")
        }
        print("------------------------\n")
    }
}
