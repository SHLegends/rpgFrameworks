//
//  ItemGen_WeaponComponents.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

// add: longSwordHandle, shaft, weaponHead(i.e. axe/hammer/pick), maceHead

protocol weaponComponent {
    var name: String {get}
    var weight: Double {get}
    var value: Int {get}
    var length: Int {get}
    var abilities: [String] {get}
    var components: [(name: String, amount: Double)] {get}
    var baseWeight: Double {get set}
    var labourValue: Int {get set}
    func description()
    var simpleDescription: String {get}
}

protocol bladedComponent {
    var sharpness: Double {get set}
}

protocol handleComponent {
    var grip: Int {get}
}


struct pommel: weaponComponent {
    var componentMetal: metal
    var componentType: (name: String, labourMultiplier: Double, weight: Double)
    var hasEtching: Bool
    var hasGem: Bool
    var componentEtching: etching?
    var componentGemstone: gemstone?
    var length: Int {return 5}
    var baseWeight: Double
    var labourValue = 50
    init(hasEtching: Bool = returnRandomBool(1, rarityModifier), hasGem: Bool = returnRandomBool(1, rarityModifier), isHead: Bool = returnRandomBool(1, rarityModifier), isRare: Bool = returnRandomBool(1, rarityModifier), giveMetal: metal? = nil, giveType: (name: String, labourMultiplier: Double, weight: Double)? = nil, giveGem: gemstone = gemstone(isPolished: true, hasShape: true), giveEtching: etching = etching(withMetal: returnRandomBool(1, rarityModifier)), baseWeight: Double = 0.3) {
        if isRare && giveMetal == nil { self.componentMetal =  metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) } else if !isRare && giveMetal == nil { self.componentMetal =  metal(giveRawMaterial: returnRandomItem(metals["reg"]!)) } else { self.componentMetal =  giveMetal! }
        if giveType != nil { self.componentType = giveType! } else if isHead { self.componentType = ("\(returnRandomItem(carvedAnimals)) Head", 2.0, 0.5) } else { self.componentType = returnRandomItem(pommelTypes) }
        self.hasEtching = hasEtching
        self.hasGem = hasGem
        self.componentEtching = (hasEtching ? giveEtching : nil)
        self.componentGemstone = (hasGem ? giveGem : nil)
        self.baseWeight = baseWeight
        self.componentMetal.baseWeight = baseWeight
    }
    var name: String {return "\(self.componentMetal.name) \(self.componentType.name) Pommel\((self.hasGem || self.hasEtching ? " (with ": ""))\(self.hasGem ? "a \(self.componentGemstone!.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? "\(self.componentEtching!.name)" : ""))\(self.hasGem || self.hasEtching ? ")" : "")"}
    var weight: Double {return self.componentMetal.weight + (self.hasGem ? self.componentGemstone!.weight : 0)}
    var value: Int {return self.componentMetal.value + (self.hasEtching ? self.componentEtching!.value : 0) + (self.hasGem ? self.componentGemstone!.value : 0) + Int(Double(self.labourValue) * self.componentType.labourMultiplier)}
    var abilities: [String] {return ["smack, catch"]}
    var components: [(name: String, amount: Double)] {return self.componentMetal.components + (self.hasGem ? self.componentGemstone!.components : [])}
    func description() {
        print("\nPommel\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.componentMetal.description()
        if self.hasEtching {self.componentEtching!.description()}
        if self.hasGem {self.componentGemstone!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Pommel: \(self.componentMetal.rawMaterial.name) \(self.componentType.name) Pommel\((self.hasGem || self.hasEtching ? " with ": ""))\(self.hasGem ? "inlaid \(self.componentGemstone!.rawMaterial.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? self.componentEtching!.etchingType.name : ""))"}
}



struct handle: weaponComponent, handleComponent {
    typealias handleMaterial = baseMaterial & materialWithGrip
    var baseWeight: Double = 0.05
    var labourValue = 15
    var hasWrap: Bool
    var componentWood: wood
    var wrap: handleMaterial?
    var wrapType: (name: String, multiplier: Double, gripPercent: Int)?
    var hasEtching: Bool
    var componentEtching: etching?
    var length: Int = 6
    init(giveWood: wood? = nil, hasWrap: Bool = returnRandomBool(1, rarityModifier), giveWrap: handleMaterial? = nil, giveWrapType: (name: String, multiplier: Double, gripPercent: Int)? = nil, hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching? = nil) {
        self.componentWood = (giveWood != nil ? giveWood! : wood(baseWeight: self.baseWeight))
        if hasWrap { if giveWrap != nil { self.wrap = giveWrap! } else { if returnRandomBool(1, rarityModifier) { self.wrap = leather(baseWeight: self.baseWeight) } else { self.wrap = fabric(baseWeight: self.baseWeight) } }
        self.wrapType = (giveWrapType != nil ? giveWrapType! : returnRandomItem(gripQualities)) } else { self.wrap = nil; self.wrapType = nil }
        self.hasEtching = hasEtching
        if hasEtching { self.componentEtching = giveEtching ?? etching(withMetal: returnRandomBool(1, 4)) } else { self.componentEtching = nil }
        self.hasWrap = hasWrap
        self.componentWood.baseWeight *= Double(self.length)
    }
    var grip: Int {return (self.hasWrap ? self.wrap!.grip : self.componentWood.grip)}
    var name: String {return "\(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Grip (\(self.componentWood.name) Handle\(self.hasEtching ? " with \(self.componentEtching!.name)" : ""))" : "\(self.componentWood.name) Handle\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")")"}
    var weight: Double {return self.componentWood.weight + (self.hasWrap ? self.wrap!.weight : 0.0)}
    var value: Int {return self.componentWood.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int((self.hasWrap ? Double(self.wrap!.value) : 0.0) * (self.hasWrap ? self.wrapType!.multiplier : 0.0)) + self.labourValue}
    var abilities: [String] = [""]
    var components: [(name: String, amount: Double)] {return self.componentWood.components + (self.hasWrap ? self.wrap!.components : [])}
    func description() {
        print("\nHandle\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Grip Percent: \(self.grip) %")
        print("\nComponents:")
        self.componentWood.description()
        if self.hasWrap { self.wrap!.description() }
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Handle: \(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.rawMaterial.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Handle" : "\(self.componentWood.rawMaterial.name) Handle\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")")"}
}



struct crossguard: weaponComponent {
    var labourValue = 75
    var componentMetal: metal
    var length = 2
    var baseWeight: Double
    var guardShape: (name: String, labourMultiplier: Double)
    var guardSize: (name: String, weightModifier: Double)
    var hasEtching: Bool
    var hasGem: Bool
    var componentEtching: etching?
    var componentGemstone: gemstone?
    init(giveGuardShape: (name: String, labourMultiplier: Double) = returnRandomItem(crossguardShapes), giveGuardSize: (name: String, weightModifier: Double) = returnRandomItem(crossguardSizes), hasEtching: Bool = returnRandomBool(1, rarityModifier), hasGem: Bool = returnRandomBool(1, rarityModifier), isRare: Bool = returnRandomBool(1, rarityModifier), giveMetal: metal? = nil, giveGem: gemstone = gemstone(isPolished: true, hasShape: true), giveEtching: etching = etching(), baseWeight: Double = 0.3) {
        if isRare && giveMetal == nil { self.componentMetal =  metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) } else if !isRare && giveMetal == nil { self.componentMetal =  metal(giveRawMaterial: returnRandomItem(metals["reg"]!)) } else { self.componentMetal =  giveMetal! }
        self.guardShape = giveGuardShape
        self.guardSize = giveGuardSize
        self.hasEtching = hasEtching
        self.hasGem = hasGem
        self.componentEtching = (hasEtching ? giveEtching : nil)
        self.componentGemstone = (hasGem ? giveGem : nil)
        self.baseWeight = baseWeight
        self.componentMetal.baseWeight = baseWeight * self.guardSize.weightModifier
    }
    var name: String {return "\(self.guardSize.name) \(self.componentMetal.name) \(self.guardShape.name) Guard\((self.hasGem || self.hasEtching ? " (with ": ""))\(self.hasGem ? "a \(self.componentGemstone!.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? "\(self.componentEtching!.name)" : ""))\(self.hasGem || self.hasEtching ? ")" : "")"}
    var weight: Double {return self.componentMetal.weight + (self.hasGem ? self.componentGemstone!.weight : 0)}
    var value: Int {return self.componentMetal.value + (self.hasEtching ? self.componentEtching!.value : 0) + (self.hasGem ? self.componentGemstone!.value : 0) + Int(Double(self.labourValue) * self.guardShape.labourMultiplier)}
    var abilities: [String] {return ["block"]}
    var components: [(name: String, amount: Double)] {return self.componentMetal.components + (self.hasGem ? self.componentGemstone!.components : [])}
    func description() {
        print("\nCrossguard\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.componentMetal.description()
        if self.hasEtching {self.componentEtching!.description()}
        if self.hasGem {self.componentGemstone!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Guard: \(self.componentMetal.rawMaterial.name) \(self.guardShape.name) Guard\((self.hasGem || self.hasEtching ? " with ": ""))\(self.hasGem ? "inlaid \(self.componentGemstone!.rawMaterial.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? self.componentEtching!.etchingType.name : ""))"}
    
    
}

struct blade: weaponComponent, bladedComponent {
    var withFuller: Bool
    var fuller: (name: String, weightModifier: Double, valueMultiplier: Double)?
    var isDoubleEdge: Bool
    var labourValue: Int = 150
    var componentMetal: metal
    var componentType: (name: String, labourMultiplier: Double)
    var componentWidthType: (name: String, labourMultiplier: Double, weightModifier: Double)
    var length: Int
    var sharpness: Double
    var hasEtching: Bool
    var componentEtching: etching?
    var baseWeight: Double = 0.07
    init(length: Int = returnRandNumInRange(6, 60), isDoubleEdge: Bool = returnRandomBool(3, 4), giveSharpness: Double = 1.0, giveType: (name: String, labourMultiplier: Double) = returnRandomItem(doubleEdgeBladeShapes), giveWidthType: (name: String, labourMultiplier: Double, weightModifier: Double) = returnRandomItem(doubleEdgeBladeSizes), hasEtching: Bool = returnRandomBool(1, rarityModifier), giveMetal: metal = metal(), giveEtching: etching = etching(), withFuller: Bool = returnRandomBool(1, 5), giveFuller: (name: String, weightModifier: Double, valueMultiplier: Double) = returnRandomItem(fullerTypes) ) {
        self.componentMetal = giveMetal
        self.componentType = giveType
        self.componentWidthType = giveWidthType
        self.sharpness = giveSharpness
        self.length = length
        self.hasEtching = hasEtching
        self.componentEtching = (hasEtching ? giveEtching : nil)
        self.componentMetal.baseWeight = self.baseWeight * Double(length)
        self.isDoubleEdge = isDoubleEdge
        self.withFuller = withFuller
        self.fuller = (withFuller ? giveFuller : nil)
    }
    var name: String {return "\(self.length)\" \(self.componentWidthType.name) \(self.componentType.name) \(self.isDoubleEdge ? "Double-Edged" : "Single-Edged") \(self.componentMetal.name) Blade\(self.withFuller ? " with a \(self.fuller!.name) Fuller" : "")\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.componentMetal.weight * self.componentWidthType.weightModifier * (self.withFuller ? self.fuller!.weightModifier : 1.0)}
    var value: Int {return self.componentMetal.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int(Double(self.labourValue) * self.componentType.labourMultiplier * (self.withFuller ? self.fuller!.valueMultiplier : 1.0))}
    var abilities: [String] {return ["slice", "stab", "block"]}
    var components: [(name: String, amount: Double)] {return self.componentMetal.components}
    
    func description() {
        print("\nBlade\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.componentMetal.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Blade: \(self.length)\" \(self.componentType.name) \(self.isDoubleEdge ? "Double-Edged" : "Single-Edged") \(self.componentMetal.rawMaterial.name) Blade\(self.withFuller ? " with a \(self.fuller!.name) Fuller" : "")\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}
}

struct longHandle: weaponComponent, handleComponent {
    var numOfHolds: Int
    var ringMetal: metal
    typealias handleMaterial = baseMaterial & materialWithGrip
    var baseWeight: Double = 0.05
    var labourValue = 15
    var hasWrap: Bool
    var componentWood: wood
    var wrap: handleMaterial?
    var wrapType: (name: String, multiplier: Double, gripPercent: Int)?
    var hasEtching: Bool
    var componentEtching: etching?
    
    init(giveMetal: metal = metal(), numOfHolds: Int = returnRandNumInRange(2, 4), giveWood: wood? = nil, hasWrap: Bool = returnRandomBool(1, rarityModifier), giveWrap: handleMaterial? = nil, giveWrapType: (name: String, multiplier: Double, gripPercent: Int)? = nil, hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching? = nil) {
        self.ringMetal = giveMetal
        self.numOfHolds = numOfHolds
        self.componentWood = (giveWood != nil ? giveWood! : wood(baseWeight: self.baseWeight))
        if hasWrap { if giveWrap != nil { self.wrap = giveWrap! } else { if returnRandomBool(1, rarityModifier) { self.wrap = leather(baseWeight: self.baseWeight) } else { self.wrap = fabric(baseWeight: self.baseWeight) } }
            self.wrapType = (giveWrapType != nil ? giveWrapType! : returnRandomItem(gripQualities)) } else { self.wrap = nil; self.wrapType = nil }
        self.hasEtching = hasEtching
        if hasEtching { self.componentEtching = giveEtching ?? etching(withMetal: returnRandomBool(1, 4)) } else { self.componentEtching = nil }
        self.hasWrap = hasWrap
        self.componentWood.baseWeight *= Double(self.length)
    }
    var length: Int {return self.numOfHolds * 6}
    var grip: Int {return (self.hasWrap ? self.wrap!.grip : self.componentWood.grip)}
    var name: String {return "\(IntToString[self.numOfHolds]!) Hold \(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Grip with \(self.ringMetal.name) Rings (\(self.componentWood.name) Long Handle\(self.hasEtching ? " with \(self.componentEtching!.name)" : ""))" : "\(self.componentWood.name) Long Handle with \(self.ringMetal.name) Rings\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")")"}
    var weight: Double {return self.componentWood.weight + (self.hasWrap ? self.wrap!.weight : 0.0)}
    var value: Int {return self.componentWood.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int((self.hasWrap ? Double(self.wrap!.value) : 0.0) * (self.hasWrap ? self.wrapType!.multiplier : 0.0)) + self.labourValue}
    var abilities: [String] = [""]
    var components: [(name: String, amount: Double)] {return self.componentWood.components + (self.hasWrap ? self.wrap!.components : [])}
    func description() {
        print("\nLong Handle\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Grip Percent: \(self.grip) %")
        print("\nComponents:")
        self.componentWood.description()
        if self.hasWrap { self.wrap!.description() }
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Long Handle: \(IntToString[self.numOfHolds]!) Hold \(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.rawMaterial.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Long Handle with \(self.ringMetal.rawMaterial.name) Rings" : "\(self.componentWood.rawMaterial.name) Long Handle with \(self.ringMetal.rawMaterial.name) Rings\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")")"}
}


struct haft: weaponComponent, handleComponent {
    var componentWood: wood
    var componentType: (name: String, weightModifier: Double)
    var length: Int
    var baseWeight = 0.05
    var labourValue = 1
    var hasEtching: Bool
    var componentEtching: etching?

    init(giveMaterial: wood = wood(), length: Int = returnRandNumInRange(24, 72), giveType: (name: String, weightModifier: Double) = returnRandomItem(haftTypes), hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching = etching()) {
        self.componentWood = giveMaterial
        self.length = length
        self.componentType = giveType
        self.componentWood.baseWeight = self.baseWeight * Double(self.length) * self.componentType.weightModifier
        self.labourValue *= self.length
        self.hasEtching = hasEtching
        self.componentEtching = (self.hasEtching ? giveEtching : nil)
        
    }
    
    var grip: Int {return 75}
    var name: String {return "\(self.componentType.name) \(self.length)\" \(self.componentWood.name) Haft\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.componentWood.weight}
    var value: Int {return self.componentWood.value + self.labourValue}
    var abilities: [String] = ["block"]
    var components: [(name: String, amount: Double)] {return self.componentWood.components}
    func description() {
        print("\nHaft\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Grip Percent: \(self.grip) %")
        print("\nComponents:")
        self.componentWood.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Haft: \(self.length)\" \(self.componentWood.rawMaterial.name) Haft\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}

}

struct axeHead: weaponComponent, bladedComponent {
    var componentMetal: metal
    var hasDoubleHead: Bool
    
    var componentType: (name: String, value: Int, weightModifier: Double)
    var length = 8
    var baseWeight = 1.0
    var labourValue = 20
    var hasEtching: Bool
    var componentEtching: etching?
    var sharpness: Double
    
    init(giveMetal: metal = metal(), isDoubleHead: Bool = returnRandomBool(1, rarityModifier), giveType: (name: String, value: Int, weightModifier: Double) = returnRandomItem(axeTypes), hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching = etching(), giveSharpness: Double = 1.0) {
        self.componentMetal = giveMetal
        self.hasDoubleHead = isDoubleHead
        self.componentType = giveType
        self.hasEtching = hasEtching
        self.componentEtching = giveEtching
        self.sharpness = giveSharpness
        self.componentMetal.baseWeight = self.baseWeight * self.componentType.weightModifier
        self.baseWeight *= (self.hasDoubleHead ? 1.5 : 1.0)
        self.labourValue *= self.componentType.value
        
    }
    
    
    var name: String {return "\(self.componentType.name) \(self.componentMetal.name)\(self.hasDoubleHead ? " Double" : "") Axe Head\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.componentMetal.weight}
    var value: Int {return self.componentMetal.value + self.labourValue}
    var abilities: [String] = ["chop"]
    var components: [(name: String, amount: Double)] {return self.componentMetal.components}
    
    func description() {
        print("\nHaft\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.componentMetal.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    
    var simpleDescription: String {return "Axe Head: \(self.componentType.name) \(self.componentMetal.rawMaterial.name)\(self.hasDoubleHead ? " Double" : "") Axe Head\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}
    
}

