//
//  ItemGen_BaseMaterials.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

// 100 cp -> 1 sp | 100 sp -> 1 gp
// 10000 cp -> 1 gp


protocol baseMaterial {
    var name: String {get}
    var weight: Double {get}
    var value: Int {get}
    var components: [(name: String, amount: Double)] {get}
    var baseWeight: Double {get set}
    func description()
}

protocol materialWithGrip {
    var grip: Int {get}
}



struct gemstone: baseMaterial {
    var rawMaterial: (name: String, value: Int)
    var size: (name: String, modifier: Double)
    var polish: Bool
    var shape: (name: String, valueModifier: Double)
    var baseWeight: Double
    init(isPolished: Bool = false, hasShape: Bool = false, giveShape: (name: String, valueModifier: Double) = returnRandomItem(gemShapes), giveRawMaterial: (name: String, value: Int) = returnRandomItem(gems), giveSize: (name: String, modifier: Double) = returnRandomItem(gemSizes), baseWeight: Double = 0.001) {
        self.rawMaterial = giveRawMaterial
        self.size = giveSize
        self.polish = isPolished
        self.shape = (hasShape ? giveShape :  ("Uncut", 0))
        self.baseWeight = baseWeight
    }
    var name: String {return "\(self.size.name) \((self.polish ? "Polished" : "Unpolished")) \(self.shape.name) \(self.rawMaterial.name)"}
    var weight: Double {return self.baseWeight * self.size.modifier}
    var value: Int {return Int(Double(self.rawMaterial.value) * self.weight * self.shape.valueModifier * (polish ? 2.0 : 1.0))}
    var components: [(name: String, amount: Double)]  {return [(self.rawMaterial.name, self.weight * salvageMaterialLoss)]}
    func description() {
        print("\nGemstone\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp")
        //        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        //        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        //        print("~~~~~~~~~~~~~~~~~~~~~")
    }
}

struct leather: baseMaterial, materialWithGrip {
    var rawMaterial: (name: String, value: Int, gripPercent: Int)
    var quality: (name: String, modifier: Double)
    var baseWeight: Double
    init(giveRawMaterial: (name: String, value: Int, gripPercent: Int) = returnRandomItem(leathers), giveQuality: (name: String, modifier: Double) = returnRandomItem(leatherQualities), baseWeight: Double = 0.05) {
        self.rawMaterial = giveRawMaterial
        self.quality = giveQuality
        self.baseWeight = baseWeight
    }
    var grip: Int {return self.rawMaterial.gripPercent}
    var name: String {return "\(self.quality.name) \(self.rawMaterial.name)"}
    
    var weight: Double {return self.baseWeight}
    var value: Int {return Int(Double(self.rawMaterial.value) * weight * self.quality.modifier)}
    var components: [(name: String, amount: Double)] {return [(self.rawMaterial.name, self.weight * salvageMaterialLoss)]}
    func description() {
        print("\nLeather\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp")
        //        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        //        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        //        print("~~~~~~~~~~~~~~~~~~~~~")
    }
}

struct fabric: baseMaterial, materialWithGrip {
    var rawMaterial: (name: String, value: Int, gripPercent: Int)
    var quality: (name: String, modifier: Double)
    var baseWeight: Double
    init(giveRawMaterial: (name: String, value: Int, gripPercent: Int) = returnRandomItem(fabrics), giveQuality: (name: String, modifier: Double) = returnRandomItem(fabricQualities), baseWeight: Double = 0.05) {
        self.rawMaterial = giveRawMaterial
        self.quality = giveQuality
        self.baseWeight = baseWeight
    }
    var grip: Int {return self.rawMaterial.gripPercent}
    var name: String {return "\(self.quality.name) \(self.rawMaterial.name)"}
    var weight: Double {return 0.05}
    var value: Int {return Int(self.weight * Double(self.rawMaterial.value) * self.quality.modifier)}
    var components: [(name: String, amount: Double)] {return [(self.rawMaterial.name, self.weight * salvageMaterialLoss)]}
    func description() {
        print("\nFabric\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp")
        //        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        //        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        //        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    
    
    
}


struct wood: baseMaterial, materialWithGrip {
    var rawMaterial: (name: String, value: Int, gripPercent: Int)
    var quality: (name: String, modifier: Double)
    var baseWeight: Double
    init(giveRawMaterial: (name: String, value: Int, gripPercent: Int) = returnRandomItem(woods), giveQuality: (name: String, modifier: Double) = returnRandomItem(woodQualities), baseWeight: Double = 0.05) {
        self.rawMaterial = giveRawMaterial
        self.quality = giveQuality
        self.baseWeight = baseWeight
    }
    var name: String {return "\(self.quality.name) \(self.rawMaterial.name)"}
    var grip: Int {return self.rawMaterial.gripPercent}
    var weight: Double {return self.baseWeight}
    var value: Int {return Int(self.weight * Double(self.rawMaterial.value) * self.quality.modifier)}
    var components: [(name: String, amount: Double)] {return [(self.rawMaterial.name, self.weight * salvageMaterialLoss)]}
    func description() {
        print("\nWood\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp")
        //        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        //        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        //        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    
}


struct metal: baseMaterial, materialWithGrip {
    var rawMaterial: (name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int)
    var quality: (name: String, modifier: Double)
    var baseWeight: Double
    init(giveRawMaterial: (name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int) = returnRandomItem(metals["reg"]!), giveQuality: (name: String, modifier: Double) = returnRandomItem(metalQualities), baseWeight: Double = 0.08) {
        self.rawMaterial = giveRawMaterial
        self.quality = giveQuality
        self.baseWeight = baseWeight
    }
    var name: String {return "\(self.quality.name) \(self.rawMaterial.name)"}
    var grip: Int {return 50}
    var weight: Double {return self.baseWeight}
    var value: Int {return Int(self.weight * Double(self.rawMaterial.value) * self.quality.modifier)}
    var components: [(name: String, amount: Double)] {return [(self.rawMaterial.name, self.weight * salvageMaterialLoss)]}
    func description() {
        print("\nMetal\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp")
        //        print("~~~~~~~~~~~~~~~~~~~~~\nSalvage:")
        //        for index in self.components { print("\(index.amount) lb of \(index.name)") }
        //        print("~~~~~~~~~~~~~~~~~~~~~")
    }
    
}


struct etching {
    var etchingType: (name: String, value: Int)
    var etchingQuality: (name: String, modifier: Double)
    var etchingMetal: (name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int)?
    var withMetal: Bool
    init(withMetal: Bool = false, giveEtchingType: (name: String, value: Int)? = nil, giveEtchingMetal: (name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int) = returnRandomItem(metals["rare"]!), giveEtchingQuality: (name: String, modifier: Double) = returnRandomItem(etchingQualities)) {
        self.withMetal = withMetal
        if giveEtchingType != nil { self.etchingType = giveEtchingType! } else if returnRandomBool(3, 4) {
            self.etchingType = ("\(returnRandomItem(etchings["style"]!)) Etchings", 1000)
        } else {
            self.etchingType = ("Etchings of \(returnRandomItem(etchings["of thing"]!))", 2500)
        }
        if withMetal { self.etchingMetal = giveEtchingMetal } else { self.etchingMetal = nil }
        self.etchingQuality = giveEtchingQuality
    }
    var name: String {return "\(self.etchingQuality.name) \((self.withMetal ? "\(self.etchingMetal!.name) " : ""))\(etchingType.name)"}
    var value: Int {return Int(Double(self.etchingType.value) * self.etchingQuality.modifier) + (self.withMetal ? Int(Double(self.etchingMetal!.value) * 0.001) : 0)}
    func description() {
        print("\nEtching\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Value: \(self.value) cp")
    }
}











