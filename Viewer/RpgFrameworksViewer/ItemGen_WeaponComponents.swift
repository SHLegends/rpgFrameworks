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
    var cMaterial: baseMaterial {get set}
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
    var cMaterial: baseMaterial
    var componentType: (name: String, labourMultiplier: Double, weight: Double)
    var hasEtching: Bool
    var hasGem: Bool
    var componentEtching: etching?
    var componentGemstone: gemstone?
    var length: Int {return 5}
    var baseWeight: Double
    var labourValue = 50
    init(hasEtching: Bool = returnRandomBool(1, rarityModifier), hasGem: Bool = returnRandomBool(1, rarityModifier), isHead: Bool = returnRandomBool(1, rarityModifier), isRare: Bool = returnRandomBool(1, rarityModifier), cMaterial: baseMaterial? = nil, giveType: (name: String, labourMultiplier: Double, weight: Double)? = nil, giveGem: gemstone = gemstone(isPolished: true, hasShape: true), giveEtching: etching = etching(withMetal: returnRandomBool(1, rarityModifier)), baseWeight: Double = 0.3) {
        if isRare && cMaterial == nil { self.cMaterial =  metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) } else if !isRare && cMaterial == nil { self.cMaterial =  metal(giveRawMaterial: returnRandomItem(metals["reg"]!)) } else { self.cMaterial =  cMaterial! }
        if giveType != nil { self.componentType = giveType! } else if isHead { self.componentType = ("\(returnRandomItem(carvedAnimals)) Head", 2.0, 0.5) } else { self.componentType = returnRandomItem(pommelTypes) }
        self.hasEtching = hasEtching
        self.hasGem = hasGem
        self.componentEtching = (hasEtching ? giveEtching : nil)
        self.componentGemstone = (hasGem ? giveGem : nil)
        self.baseWeight = baseWeight
        self.cMaterial.baseWeight = baseWeight
    }
    var name: String {return "\(self.cMaterial.name) \(self.componentType.name) Pommel\((self.hasGem || self.hasEtching ? " (with ": ""))\(self.hasGem ? "a \(self.componentGemstone!.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? "\(self.componentEtching!.name)" : ""))\(self.hasGem || self.hasEtching ? ")" : "")"}
    var weight: Double {return self.cMaterial.weight + (self.hasGem ? self.componentGemstone!.weight : 0)}
    var value: Int {return self.cMaterial.value + (self.hasEtching ? self.componentEtching!.value : 0) + (self.hasGem ? self.componentGemstone!.value : 0) + Int(Double(self.labourValue) * self.componentType.labourMultiplier)}
    var abilities: [String] {return ["smack, catch"]}
    var components: [(name: String, amount: Double)] {return self.cMaterial.components + (self.hasGem ? self.componentGemstone!.components : [])}
    func description() {
        print("\nPommel\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        if self.hasGem {self.componentGemstone!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Pommel: \(self.cMaterial.rawMaterial.name) \(self.componentType.name) Pommel\((self.hasGem || self.hasEtching ? " with ": ""))\(self.hasGem ? "inlaid \(self.componentGemstone!.rawMaterial.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? self.componentEtching!.etchingType.name : ""))"}
}



struct handle: weaponComponent, handleComponent {
    typealias handleMaterial = baseMaterial & materialWithGrip
    var baseWeight: Double = 0.05
    var labourValue = 15
    var hasWrap: Bool
    var cMaterial: baseMaterial
    var wrap: baseMaterial?
    var wrapType: (name: String, multiplier: Double, gripPercent: Int)?
    var hasEtching: Bool
    var componentEtching: etching?
    var length: Int = 6
    init(cMaterial: wood? = nil, hasWrap: Bool = returnRandomBool(1, rarityModifier), giveWrap: baseMaterial? = nil, giveWrapType: (name: String, multiplier: Double, gripPercent: Int)? = nil, hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching? = nil) {
        self.cMaterial = (cMaterial != nil ? cMaterial! : wood(baseWeight: self.baseWeight))
        if hasWrap { if giveWrap != nil { self.wrap = giveWrap! } else { if returnRandomBool(1, rarityModifier) { self.wrap = leather(baseWeight: self.baseWeight) } else { self.wrap = fabric(baseWeight: self.baseWeight) } }
        self.wrapType = (giveWrapType != nil ? giveWrapType! : returnRandomItem(gripQualities)) } else { self.wrap = nil; self.wrapType = nil }
        self.hasEtching = hasEtching
        if hasEtching { self.componentEtching = giveEtching ?? etching(withMetal: returnRandomBool(1, 4)) } else { self.componentEtching = nil }
        self.hasWrap = hasWrap
        self.cMaterial.baseWeight *= Double(self.length)
    }
    var grip: Int {return (self.hasWrap ? self.wrap!.grip : self.cMaterial.grip)}
    var name: String {return "\(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Grip (\(self.cMaterial.name) Handle\(self.hasEtching ? " with \(self.componentEtching!.name)" : ""))" : "\(self.cMaterial.name) Handle\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")")"}
    var weight: Double {return self.cMaterial.weight + (self.hasWrap ? self.wrap!.weight : 0.0)}
    var value: Int {return self.cMaterial.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int((self.hasWrap ? Double(self.wrap!.value) : 0.0) * (self.hasWrap ? self.wrapType!.multiplier : 0.0)) + self.labourValue}
    var abilities: [String] = [""]
    var components: [(name: String, amount: Double)] {return self.cMaterial.components + (self.hasWrap ? self.wrap!.components : [])}
    func description() {
        print("\nHandle\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Grip Percent: \(self.grip) %")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasWrap { self.wrap!.description() }
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Handle: \(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.rawMaterial.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Handle" : "\(self.cMaterial.rawMaterial.name) Handle\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")")"}
}



struct crossguard: weaponComponent {
    var labourValue = 75
    var cMaterial: baseMaterial
    var length = 2
    var baseWeight: Double
    var guardShape: (name: String, labourMultiplier: Double)
    var guardSize: (name: String, weightModifier: Double)
    var hasEtching: Bool
    var hasGem: Bool
    var componentEtching: etching?
    var componentGemstone: gemstone?
    init(giveGuardShape: (name: String, labourMultiplier: Double) = returnRandomItem(crossguardShapes), giveGuardSize: (name: String, weightModifier: Double) = returnRandomItem(crossguardSizes), hasEtching: Bool = returnRandomBool(1, rarityModifier), hasGem: Bool = returnRandomBool(1, rarityModifier), isRare: Bool = returnRandomBool(1, rarityModifier), cMaterial: baseMaterial? = nil, giveGem: gemstone = gemstone(isPolished: true, hasShape: true), giveEtching: etching = etching(), baseWeight: Double = 0.3) {
        if isRare && cMaterial == nil { self.cMaterial =  metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) } else if !isRare && cMaterial == nil { self.cMaterial =  metal(giveRawMaterial: returnRandomItem(metals["reg"]!)) } else { self.cMaterial =  cMaterial! }
        self.guardShape = giveGuardShape
        self.guardSize = giveGuardSize
        self.hasEtching = hasEtching
        self.hasGem = hasGem
        self.componentEtching = (hasEtching ? giveEtching : nil)
        self.componentGemstone = (hasGem ? giveGem : nil)
        self.baseWeight = baseWeight
        self.cMaterial.baseWeight = baseWeight * self.guardSize.weightModifier
    }
    var name: String {return "\(self.guardSize.name) \(self.cMaterial.name) \(self.guardShape.name) Guard\((self.hasGem || self.hasEtching ? " (with ": ""))\(self.hasGem ? "a \(self.componentGemstone!.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? "\(self.componentEtching!.name)" : ""))\(self.hasGem || self.hasEtching ? ")" : "")"}
    var weight: Double {return self.cMaterial.weight + (self.hasGem ? self.componentGemstone!.weight : 0)}
    var value: Int {return self.cMaterial.value + (self.hasEtching ? self.componentEtching!.value : 0) + (self.hasGem ? self.componentGemstone!.value : 0) + Int(Double(self.labourValue) * self.guardShape.labourMultiplier)}
    var abilities: [String] {return ["block"]}
    var components: [(name: String, amount: Double)] {return self.cMaterial.components + (self.hasGem ? self.componentGemstone!.components : [])}
    func description() {
        print("\nCrossguard\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        if self.hasGem {self.componentGemstone!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Guard: \(self.cMaterial.rawMaterial.name) \(self.guardShape.name) Guard\((self.hasGem || self.hasEtching ? " with ": ""))\(self.hasGem ? "inlaid \(self.componentGemstone!.rawMaterial.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? self.componentEtching!.etchingType.name : ""))"}
    
    
}

struct blade: weaponComponent, bladedComponent {
    var withFuller: Bool
    var fuller: (name: String, weightModifier: Double, valueMultiplier: Double)?
    var isDoubleEdge: Bool
    var labourValue: Int = 150
    var cMaterial: baseMaterial
    var componentType: (name: String, labourMultiplier: Double)
    var componentWidthType: (name: String, labourMultiplier: Double, weightModifier: Double)
    var length: Int
    var sharpness: Double
    var hasEtching: Bool
    var componentEtching: etching?
    var baseWeight: Double = 0.07
    init(length: Int = returnRandNumInRange(6, 60), isDoubleEdge: Bool = returnRandomBool(3, 4), giveSharpness: Double = 1.0, giveType: (name: String, labourMultiplier: Double) = returnRandomItem(doubleEdgeBladeShapes), giveWidthType: (name: String, labourMultiplier: Double, weightModifier: Double) = returnRandomItem(doubleEdgeBladeSizes), hasEtching: Bool = returnRandomBool(1, rarityModifier), cMaterial: baseMaterial = metal(), giveEtching: etching = etching(), withFuller: Bool = returnRandomBool(1, 5), giveFuller: (name: String, weightModifier: Double, valueMultiplier: Double) = returnRandomItem(fullerTypes) ) {
        self.cMaterial = cMaterial
        self.componentType = giveType
        self.componentWidthType = giveWidthType
        self.sharpness = giveSharpness
        self.length = length
        self.hasEtching = hasEtching
        self.componentEtching = (hasEtching ? giveEtching : nil)
        self.cMaterial.baseWeight = self.baseWeight * Double(length)
        self.isDoubleEdge = isDoubleEdge
        self.withFuller = withFuller
        self.fuller = (withFuller ? giveFuller : nil)
    }
    var name: String {return "\(self.length)\" \(self.componentWidthType.name) \(self.componentType.name) \(self.isDoubleEdge ? "Double-Edged" : "Single-Edged") \(self.cMaterial.name) Blade\(self.withFuller ? " with a \(self.fuller!.name) Fuller" : "")\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.cMaterial.weight * self.componentWidthType.weightModifier * (self.withFuller ? self.fuller!.weightModifier : 1.0)}
    var value: Int {return self.cMaterial.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int(Double(self.labourValue) * self.componentType.labourMultiplier * (self.withFuller ? self.fuller!.valueMultiplier : 1.0))}
    var abilities: [String] {return ["slice", "stab", "block"]}
    var components: [(name: String, amount: Double)] {return self.cMaterial.components}
    
    func description() {
        print("\nBlade\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Blade: \(self.length)\" \(self.componentType.name) \(self.isDoubleEdge ? "Double-Edged" : "Single-Edged") \(self.cMaterial.rawMaterial.name) Blade\(self.withFuller ? " with a \(self.fuller!.name) Fuller" : "")\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}
}

struct longHandle: weaponComponent, handleComponent {
    var numOfHolds: Int
    var ringMaterial: baseMaterial
    typealias handleMaterial = baseMaterial & materialWithGrip
    var baseWeight: Double = 0.05
    var labourValue = 15
    var hasWrap: Bool
    var cMaterial: baseMaterial
    var wrap: baseMaterial?
    var wrapType: (name: String, multiplier: Double, gripPercent: Int)?
    var hasEtching: Bool
    var componentEtching: etching?
    
    init(ringMaterial: baseMaterial = metal(), numOfHolds: Int = returnRandNumInRange(2, 4), cMaterial: baseMaterial? = nil, hasWrap: Bool = returnRandomBool(1, rarityModifier), giveWrap: baseMaterial? = nil, giveWrapType: (name: String, multiplier: Double, gripPercent: Int)? = nil, hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching? = nil) {
        self.ringMaterial = ringMaterial
        self.numOfHolds = numOfHolds
        self.cMaterial = (cMaterial != nil ? cMaterial! : wood(baseWeight: self.baseWeight))
        if hasWrap { if giveWrap != nil { self.wrap = giveWrap! } else { if returnRandomBool(1, rarityModifier) { self.wrap = leather(baseWeight: self.baseWeight) } else { self.wrap = fabric(baseWeight: self.baseWeight) } }
            self.wrapType = (giveWrapType != nil ? giveWrapType! : returnRandomItem(gripQualities)) } else { self.wrap = nil; self.wrapType = nil }
        self.hasEtching = hasEtching
        if hasEtching { self.componentEtching = giveEtching ?? etching(withMetal: returnRandomBool(1, 4)) } else { self.componentEtching = nil }
        self.hasWrap = hasWrap
        self.cMaterial.baseWeight *= Double(self.length)
    }
    var length: Int {return self.numOfHolds * 6}
    var grip: Int {return (self.hasWrap ? self.wrap!.grip : self.cMaterial.grip)}
    var name: String {return "\(IntToString[self.numOfHolds]!) Hold \(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Grip with \(self.ringMaterial.name) Rings (\(self.cMaterial.name) Long Handle\(self.hasEtching ? " with \(self.componentEtching!.name)" : ""))" : "\(self.cMaterial.name) Long Handle with \(self.ringMaterial.name) Rings\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")")"}
    var weight: Double {return self.cMaterial.weight + (self.hasWrap ? self.wrap!.weight : 0.0)}
    var value: Int {return self.cMaterial.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int((self.hasWrap ? Double(self.wrap!.value) : 0.0) * (self.hasWrap ? self.wrapType!.multiplier : 0.0)) + self.labourValue}
    var abilities: [String] = [""]
    var components: [(name: String, amount: Double)] {return self.cMaterial.components + (self.hasWrap ? self.wrap!.components : [])}
    func description() {
        print("\nLong Handle\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Grip Percent: \(self.grip) %")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasWrap { self.wrap!.description() }
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Long Handle: \(IntToString[self.numOfHolds]!) Hold \(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.rawMaterial.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Long Handle with \(self.ringMaterial.rawMaterial.name) Rings" : "\(self.cMaterial.rawMaterial.name) Long Handle with \(self.ringMaterial.rawMaterial.name) Rings\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")")"}
}


struct haft: weaponComponent, handleComponent {
    var cMaterial: baseMaterial
    var componentType: (name: String, weightModifier: Double)
    var length: Int
    var baseWeight = 0.025
    var labourValue = 1
    var hasEtching: Bool
    var componentEtching: etching?

    init(cMaterial: baseMaterial = wood(), length: Int = returnRandNumInRange(24, 72), giveType: (name: String, weightModifier: Double) = returnRandomItem(haftTypes), hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching = etching()) {
        self.cMaterial = cMaterial
        self.length = length
        self.componentType = giveType
        self.cMaterial.baseWeight = self.baseWeight * Double(self.length) * self.componentType.weightModifier
        self.labourValue *= self.length
        self.hasEtching = hasEtching
        self.componentEtching = (self.hasEtching ? giveEtching : nil)
        
    }
    
    var grip: Int {return 75}
    var name: String {return "\(self.componentType.name) \(self.length)\" \(self.cMaterial.name) Haft\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.cMaterial.weight}
    var value: Int {return self.cMaterial.value + self.labourValue}
    var abilities: [String] = ["block"]
    var components: [(name: String, amount: Double)] {return self.cMaterial.components}
    func description() {
        print("\nHaft\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Grip Percent: \(self.grip) %")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Haft: \(self.length)\" \(self.cMaterial.rawMaterial.name) Haft\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}

}

struct axeHead: weaponComponent, bladedComponent {
    var cMaterial: baseMaterial
    var hasDoubleHead: Bool
    var componentType: (name: String, value: Int, weightModifier: Double)
    var length = 8
    var baseWeight = 1.0
    var labourValue = 20
    var hasEtching: Bool
    var componentEtching: etching?
    var sharpness: Double
    init(cMaterial: baseMaterial = metal(), isDoubleHead: Bool = returnRandomBool(1, rarityModifier), giveType: (name: String, value: Int, weightModifier: Double) = returnRandomItem(axeTypes), hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching = etching(), giveSharpness: Double = 1.0) {
        self.cMaterial = cMaterial
        self.hasDoubleHead = isDoubleHead
        self.componentType = giveType
        self.hasEtching = hasEtching
        self.componentEtching = giveEtching
        self.sharpness = giveSharpness
        self.cMaterial.baseWeight = self.baseWeight * self.componentType.weightModifier
        self.baseWeight *= (self.hasDoubleHead ? 1.5 : 1.0)
        self.labourValue *= self.componentType.value
        
    }
    var name: String {return "\(self.componentType.name) \(self.cMaterial.name)\(self.hasDoubleHead ? " Double" : "") Axe Head\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.cMaterial.weight}
    var value: Int {return self.cMaterial.value + self.labourValue}
    var abilities: [String] = ["chop"]
    var components: [(name: String, amount: Double)] {return self.cMaterial.components}
    
    func description() {
        print("\nHaft\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Axe Head: \(self.componentType.name) \(self.cMaterial.rawMaterial.name)\(self.hasDoubleHead ? " Double" : "") Axe Head\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}
}

struct maceHead: weaponComponent {
    var cMaterial: baseMaterial
    var componentType: (name: String, value: Int, weightModifier: Double)
    var length = 8
    var baseWeight = 1.5
    var labourValue = 50
    var hasEtching: Bool
    var componentEtching: etching?
    var sharpness: Double
    init(cMaterial: baseMaterial = metal(), giveType: (name: String, value: Int, weightModifier: Double) = returnRandomItem(maceTypes), hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching = etching(), giveSharpness: Double = 1.0) {
        self.cMaterial = cMaterial
        self.componentType = giveType
        self.hasEtching = hasEtching
        self.componentEtching = giveEtching
        self.sharpness = giveSharpness
        self.cMaterial.baseWeight = self.baseWeight * self.componentType.weightModifier
        self.labourValue *= self.componentType.value
    }
    var name: String {return "\(self.componentType.name) \(self.cMaterial.name) Mace Head\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return self.cMaterial.weight}
    var value: Int {return self.cMaterial.value + self.labourValue}
    var abilities: [String] = ["club"]
    var components: [(name: String, amount: Double)] {return self.cMaterial.components}
    func description() {
        print("\nHaft\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return "Mace Head: \(self.componentType.name) \(self.cMaterial.rawMaterial.name) Mace Head\(self.hasEtching ? " with \(self.componentEtching!.etchingType.name)" : "")"}
}

struct spearHead: weaponComponent {
    var cMaterial: baseMaterial
    var cSize: (name: String, labourMultiplier: Double, weightMultiplier: Double)
    var hasWings: Bool
    var wingType: (name: String, labourMultiplier: Double)?
    var wingSize: (name: String, labourMultiplier: Double, weightMultiplier: Double)?
    var length: Int
    var baseWeight = 0.4
    var labourValue = 25
    var hasEtching: Bool
    var componentEtching: etching?
    var sharpness: Double
    
    init(cMaterial: baseMaterial = metal(), length: Int = 8, hasWings: Bool = returnRandomBool(1, rarityModifier), giveSize: (name: String, labourMultiplier: Double, weightMultiplier: Double) = returnRandomItem(spearHeadSizes), giveWingType: (name: String, labourMultiplier: Double) = returnRandomItem(wingTypes), giveWingSize: (name: String, labourMultiplier: Double, weightMultiplier: Double) = returnRandomItem(wingSizes), sharpness: Double = 1.0, hasEtching: Bool = returnRandomBool(1, rarityModifier), giveEtching: etching = etching()) {
        
        self.cMaterial = cMaterial
        self.hasWings = hasWings
        self.length = length
        self.hasEtching = hasEtching
        self.componentEtching = (self.hasEtching ? giveEtching : nil)
        self.cSize = giveSize
        self.wingType = (self.hasWings ? giveWingType : nil)
        self.wingSize = (self.hasWings ? giveWingSize : nil)
        self.sharpness = sharpness
        self.cMaterial.baseWeight = self.baseWeight * self.cSize.weightMultiplier * (self.hasWings ? self.wingSize!.weightMultiplier : 1.0)
        self.labourValue = Int(Double(self.labourValue) * self.cSize.labourMultiplier * (self.hasWings ? self.wingSize!.labourMultiplier : 1.0) * (self.hasWings ? self.wingType!.labourMultiplier : 1.0))
        
    }
    var name: String {return "\(self.length)\" \(self.cSize.name) \(self.cMaterial.name) Spear Head\(self.hasWings ? " with \(self.wingSize!.name) \(self.wingType!.name) Wings" : "")\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")"}
    var weight: Double {return cMaterial.weight}
    var value: Int {return self.cMaterial.value + self.labourValue}
    var abilities: [String] = ["stab"]
    var components: [(name: String, amount: Double)] {return self.cMaterial.components}
    func description() {
        print("\nSpear Head\n-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("\nComponents:")
        self.cMaterial.description()
        if self.hasEtching {self.componentEtching!.description()}
        print("")
        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    var simpleDescription: String {return " \(self.length)\" \(self.cMaterial.rawMaterial.name) Spear Head\(self.hasWings ? " with \(self.wingType!.name) Wings" : "")\(self.hasEtching ? " with \(self.componentEtching!.name)" : "")"}

}

// Long Thick Spear Head with Wide Up-Curved Wings (with etchings of a tree)
