//
//  amour_classes.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-28.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

protocol wearable {
    var slot: String {get}
    var name: String {get}
    var value: Int {get}
    var cEffects: [String: Int] {get}
    func description()
}


protocol headWearable: wearable {
    //for future use
}


struct headdress: headWearable {
    var slot: String = "head"
    var cType: String
    var cKind: (name: String, effect: Int)
    init(cType: String = (returnRandomBool(1, 3) ? "Head" : "Skull"), cKind: (name: String, effect: Int)? = nil) {
        self.cType = cType
        if cKind != nil { self.cKind = cKind! } else if self.cType == "Head" {self.cKind = returnRandomItem(wHeads)} else { self.cKind = returnRandomItem(wSkulls) }
    }
    var cEffects: [String: Int] {get{return ["I": self.cKind.effect, "N": 0]}}
    var name: String {get{return "\(self.cKind.name) \(self.cType) Headdress"}}
    var value: Int {get{return 50}}
    func description() {
        print("\nHeaddress\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}


struct crown: headWearable {
    var slot: String = "head"
    var cTypeName: String
    var cMaterial: baseMaterial
    var cGems: [(name: String, value: Int)] = []
    var cType: (name: String, valueModifier: Double, effect: Int)
    
    init(cTypeName: String = "Crown", cMaterial: baseMaterial = metal(giveRawMaterial: returnRandomItem(metals["reg"]! + metals["rare"]!)), cType: (name: String, valueModifier: Double, effect: Int) = returnRandomItem(crownTypes), giveGems: [(name: String, value: Int)]? = nil) {
        self.cTypeName = cTypeName
        self.cMaterial = cMaterial
        self.cType = cType
        self.cMaterial.baseWeight = 1.0 * self.cType.valueModifier
        if giveGems != nil {
            self.cGems = giveGems!
        } else {
            while returnRandomBool(1, 6) {
                let gem = returnRandomItem(gems)
                if self.cGems.filter({$0 == gem}).count == 0 {
                    self.cGems.append(gem)
                }
            }
        }
    }
    var cEffects: [String : Int] {var effects = ["I": 0, "N": 0]; if let mat = self.cMaterial as? metal {if metals["rare"]!.filter({$0 == mat.baseMaterial}).count > 0 { effects["N"]! += 4 } else { effects["I"]! += 3 }} else { effects["I"]! += 3};effects["N"]! += (!self.cGems.isEmpty ? cGems.reduce(0, {$0 + Int(Double($1.value) / 10000)}) : 0);effects["N"]! += self.cType.effect; return effects}
    var name: String {return "\(self.cType.name) \(self.cMaterial.name) \(self.cTypeName)" + (!self.cGems.isEmpty ? " with \(returnListToString(self.cGems.map({$0.name})))" : "")}
    var value: Int {return self.cMaterial.value + (!self.cGems.isEmpty ? cGems.reduce(0, {$0 + Int(Double($1.value) * 0.005) * returnRandNumInRange(1, 4)}) : 0)}
    func description() {
        print("\nCrown\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}


struct hood: headWearable {
    var slot: String = "head"
    var cTypeName: String
    var cColours: [colour]
    var cMaterial: baseMaterial
    var embroidery: colour?
    var cSymbol: symbol?
    var baseValue = 500
    var extras: [String] = []
    init(cTypeName: String = (returnRandomBool(1, 3) ? "Cowl" : "Hood"), cMaterial: baseMaterial = (returnRandomBool(1, rarityModifier) ? leather() : fabric()), cColours: [colour] = [returnRandomItem(colours)], embroidery: colour? = (returnRandomBool(1, rarityModifier) ? returnRandomItem(colours) : nil), cSymbol: symbol? = (returnRandomBool(1, rarityModifier) ? symbol() : nil)) {
        self.cTypeName = cTypeName
        self.cColours = cColours
        self.cMaterial = cMaterial
        self.embroidery = embroidery
        self.cSymbol = cSymbol
        if self.cMaterial as? leather != nil { self.cColours = [("", 0, ("I", 2))] }
        self.cMaterial.baseWeight = 0.05
        self.extras = [(self.embroidery != nil ? "\(self.embroidery!.name) Embroidery" : ""), (self.cSymbol != nil ? "a \(self.cSymbol!.name)" : "")]
        
    }
    var cEffects: [String: Int] {get{var effects = ["N": 0, "I": 0]; effects[(self.cMaterial as? leather != nil ? "I" : "N")]! += 2; for item in self.cColours {effects[item.effect.type]! += item.effect.amount}; if embroidery != nil {effects["N"]! += 2};if self.cSymbol != nil {effects[self.cSymbol!.cType.effect.type]! += self.cSymbol!.cType.effect.amount}; if self.cMaterial as? fabric != nil && self.cMaterial.rawMaterial.name == "Silk" { effects["N"]! += 2}; return effects}}
    var name: String {let second = returnListToString(self.cColours.map({$0.name})); let third = "\(self.cMaterial.name) \(self.cTypeName)"; return (second != "" ? "\(second) " : "") + third + addWith(returnListToString(stripEmptyStrings(self.extras)))}
    var value: Int {var value = cMaterial.value; if embroidery != nil { value += Int(Double(embroidery!.value) * 0.25) + 500 }; for item in self.cColours {value += item.value}; if self.cSymbol != nil {value += self.cSymbol!.value}; return value + self.baseValue}
    func description() {
        print("\nHood\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}


struct helmet: headWearable {
    var slot: String = "head"
    var cMaterial: baseMaterial
    var edging: baseMaterial?
    var cType: (name: String, valueModifier: Double, effect: (I: Int, N: Int))
    
    init(cMaterial: baseMaterial = metal(), cType: (name: String, valueModifier: Double, effect: (I: Int, N: Int)) = returnRandomItem(helmetTypes), edging: baseMaterial? = (returnRandomBool(1, rarityModifier) ? metal(giveRawMaterial: returnRandomItem(metals["reg"]! + metals["rare"]!)) : nil)) {
        self.cMaterial = cMaterial
        self.edging = edging
        self.cType = cType
        self.cMaterial.baseWeight = 1.0 * self.cType.valueModifier
    }
    
    var name: String {return "\(self.cMaterial.name) \(self.cType.name)\((self.edging != nil ? " with \(edging!.name) Edging" : ""))"}
    var value: Int {return self.cMaterial.value + (self.edging != nil ? self.edging!.value : 0)}
    var cEffects: [String : Int] {var effects = ["I": 0, "N": 0];effects["I"]! += self.cType.effect.I;effects["N"]! += self.cType.effect.N;if edging != nil {if let edge = edging! as? metal {if metals["rare"]!.filter({$0 == edge.baseMaterial}).count > 0 { effects["N"]! += 3 } else { effects["I"]! += 1 }} else { effects["I"]! += 1}}; return effects}

    func description() {
        print("\nHelmet\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}


typealias colour = (name: String, value: Int, effect: (type: String, amount: Int))
struct clothing {
    var slot: String = "body"
    var cTypeName: String
    var style: (name: String, valueModifier: Double, effect: (type: String, amount: Int))
    var cColours: [colour]
    var cPelts: [pelt]?
    var cMaterial: baseMaterial
    var embroidery: colour?
    var cSymbol: symbol?
    var baseValue = 500
    var extras: [String]
    init(cTypeName: String = (returnRandomBool(1, 3) ? "Garments" : "Clothing"), cMaterial: baseMaterial = (returnRandomBool(1, rarityModifier) ? leather() : fabric()), style: (name: String, valueModifier: Double, effect: (type: String, amount: Int)) = returnRandomItem(clothingStyles), cColours: [colour] = [returnRandomItem(colours)], cPelts: [pelt]? = (returnRandomBool(1, rarityModifier) ? [pelt()] : nil), embroidery: colour? = (returnRandomBool(1, rarityModifier) ? returnRandomItem(colours) : nil), cSymbol: symbol? = (returnRandomBool(1, rarityModifier) ? symbol() : nil)) {
        self.cTypeName = cTypeName
        self.style = style
        self.cColours = cColours
        self.cPelts = cPelts
        self.cMaterial = cMaterial
        self.embroidery = embroidery
        self.cSymbol = cSymbol
        if self.cMaterial as? leather != nil { self.cColours = [("", 0, ("I", 2))] }
        self.cMaterial.baseWeight = 1.0
        self.extras = [(self.embroidery != nil ? "\(self.embroidery!.name) Embroidery" : ""), (self.cSymbol != nil ? "a \(self.cSymbol!.name)" : ""), (self.cPelts != nil ? "\(returnListToString(self.cPelts!.map({$0.cMaterial.name})))": "")]
    }
    var cEffects: [String: Int] {get{var effects = ["N": 0, "I": 0]; effects[(self.cMaterial as? leather != nil ? "I" : "N")]! += self.style.effect.amount;effects[self.style.effect.type]! += self.style.effect.amount; for item in self.cColours {effects[item.effect.type]! += item.effect.amount}; if embroidery != nil {effects["N"]! += 4};if self.cSymbol != nil {effects[self.cSymbol!.cType.effect.type]! += self.cSymbol!.cType.effect.amount};if self.cPelts != nil {for item in self.cPelts! {effects[item.cPelt.effect.type]! += item.cPelt.effect.amount}};if self.cMaterial as? fabric != nil && self.cMaterial.rawMaterial.name == "Silk" { effects["N"]! += 5 }; return effects}}
    var name: String {let first = self.style.name; let second = returnListToString(self.cColours.map({$0.name})); let third = "\(self.cMaterial.name) \(self.cTypeName)"; return (first != "" ? "\(first) " : "") + (second != "" ? "\(second) " : "") + third + addWith(returnListToString(stripEmptyStrings(self.extras)))}
    var value: Int {var value = cMaterial.value; if cPelts != nil { for item in cPelts! {value += item.cMaterial.value} }; if embroidery != nil { value += Int(Double(embroidery!.value) * 0.25) + 500 }; for item in self.cColours {value += item.value}; if self.cSymbol != nil {value += self.cSymbol!.value}; return value + self.baseValue}
    func description() {
        print("\nClothing\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}


struct cape: wearable {
    var slot: String = "back"
    var cTypeName: String
    var cSize: (name: String, valueModifier: Double, effect: Int)
    var cLength: (name: String, valueModifier: Double, effect: Int)
    var cColours: [colour]
    var cPelts: [pelt]?
    var cMaterial: baseMaterial
    var embroidery: colour?
    var cSymbol: symbol?
    var baseValue = 500
    var extras: [String]
    init(cTypeName: String = (returnRandomBool(1, 3) ? "Cape" : "Cloak"), cMaterial: baseMaterial = (returnRandomBool(1, rarityModifier) ? leather() : fabric()), cSize: (name: String, valueModifier: Double, effect: Int) = returnRandomItem(capeSizes), cLength: (name: String, valueModifier: Double, effect: Int) = returnRandomItem(capeLengths), cColours: [colour] = [returnRandomItem(colours)], cPelts: [pelt]? = (returnRandomBool(1, rarityModifier) ? [pelt()] : nil), embroidery: colour? = (returnRandomBool(1, rarityModifier) ? returnRandomItem(colours) : nil), cSymbol: symbol? = (returnRandomBool(1, rarityModifier) ? symbol() : nil)) {
        self.cTypeName = cTypeName
        self.cSize = cSize
        self.cLength = cLength
        self.cColours = cColours
        self.cPelts = cPelts
        self.cMaterial = cMaterial
        self.embroidery = embroidery
        self.cSymbol = cSymbol
        if self.cMaterial as? leather != nil { self.cColours = [("", 0, ("I", 2))] }
        self.cMaterial.baseWeight = 0.5 * self.cLength.valueModifier * self.cSize.valueModifier
        self.extras = [(self.embroidery != nil ? "\(self.embroidery!.name) Embroidery" : ""), (self.cSymbol != nil ? "a \(self.cSymbol!.name)" : ""), (self.cPelts != nil ? "\(returnListToString(self.cPelts!.map({$0.cMaterial.name})))": "")]
    }
    var cEffects: [String: Int] {get{var effects = ["N": 0, "I": 0]; effects[(self.cMaterial as? leather != nil ? "I" : "N")]! += self.cLength.effect + self.cSize.effect; for item in self.cColours {effects[item.effect.type]! += item.effect.amount}; if embroidery != nil {effects["N"]! += 4};if self.cSymbol != nil {effects[self.cSymbol!.cType.effect.type]! += self.cSymbol!.cType.effect.amount};if self.cPelts != nil {for item in self.cPelts! {effects[item.cPelt.effect.type]! += item.cPelt.effect.amount}};if self.cMaterial as? fabric != nil && self.cMaterial.rawMaterial.name == "Silk" { effects["N"]! += 5 }; return effects}}
    var name: String {let first = combineTwoStrings([self.cSize.name, self.cLength.name]); let second = returnListToString(self.cColours.map({$0.name})); let third = "\(self.cMaterial.name) \(self.cTypeName)"; return (first != "" ? "\(first) " : "") + (second != "" ? "\(second) " : "") + third + addWith(returnListToString(stripEmptyStrings(self.extras)))}
    var value: Int {var value = cMaterial.value; if cPelts != nil { for item in cPelts! {value += item.cMaterial.value} }; if embroidery != nil { value += Int(Double(embroidery!.value) * 0.25) + 500 }; for item in self.cColours {value += item.value}; if self.cSymbol != nil {value += self.cSymbol!.value}; return value + self.baseValue}
    func description() {
        print("\nCape\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}


struct armour {
    var slot: String = "body"
    var cType: (name: String, valueModifier: Double, effect: Int)
    var cMaterial: baseMaterial
    var cSymbol: symbol?
    var edging: baseMaterial?
    var baseValue: Int = 50
    var extras: [String]
    init(cType: (name: String, valueModifier: Double, effect: Int) = returnRandomItem(armourTypes), cMaterial: baseMaterial = metal(), cSymbol: symbol? = (returnRandomBool(1, rarityModifier) ? symbol() : nil), edging: baseMaterial? = (returnRandomBool(1, rarityModifier) ? metal(giveRawMaterial: returnRandomItem(metals["reg"]! + metals["rare"]!)) : nil)) {
        self.cType = cType
        self.cMaterial = cMaterial
        self.cSymbol = cSymbol
        self.edging = edging
        self.cMaterial.baseWeight = 40.0 * cType.valueModifier
        if self.edging != nil {self.edging!.baseWeight = 0.05}
        self.extras = [(self.edging != nil ? "\(self.edging!.name) Edging" : ""), (self.cSymbol != nil ? "a \(self.cSymbol!.name)" : "")]
    }
    var name: String {return "\(cMaterial.name) \(cType.name)" + addWith(returnListToString(stripEmptyStrings(self.extras)))}
    var cEffects: [String: Int] {get{var effects = ["N": 0, "I": 0]; effects["I"]! += self.cType.effect; if self.cSymbol != nil {effects[self.cSymbol!.cType.effect.type]! += self.cSymbol!.cType.effect.amount};if edging != nil {if let edge = edging! as? metal {if metals["rare"]!.filter({$0 == edge.baseMaterial}).count > 0 { effects["N"]! += 4 } else { effects["I"]! += 3 }} else { effects["I"]! += 3}}; return effects}}
    var value: Int {var value = cMaterial.value; if self.cSymbol != nil {value += self.cSymbol!.value}; if edging != nil {value += edging!.value}; return value + self.baseValue}
    
    func description() {
        print("\nArmour\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
    
}


struct shield: wearable {
    var slot: String = "shield"
    var cType: (name: String, valueModifier: Double, effect: Int)
    var cMaterial: baseMaterial
    var painted: [colour]?
    var cSymbol: symbol?
    var edging: baseMaterial?
    var baseValue: Int = 50
    var extras: [String]
    init(cType: (name: String, valueModifier: Double, effect: Int) = returnRandomItem(shieldTypes), cMaterial: baseMaterial = (returnRandomBool(1, Int(rarityModifier/2)) ? metal() : wood()), painted: [colour]? = (returnRandomBool(1, rarityModifier) ? [returnRandomItem(colours)] : nil), cSymbol: symbol? = (returnRandomBool(1, rarityModifier) ? symbol() : nil), edging: baseMaterial? = (returnRandomBool(1, rarityModifier) ? metal(giveRawMaterial: returnRandomItem(metals["reg"]! + metals["rare"]!)) : nil)) {
        self.cType = cType
        self.cMaterial = cMaterial
        self.painted = painted
        self.cSymbol = cSymbol
        self.edging = edging
        self.cMaterial.baseWeight = 10.0 * cType.valueModifier
        if self.edging != nil {self.edging!.baseWeight = 0.05}
        self.extras = [(self.edging != nil ? "\(self.edging!.name) Edging" : ""), (self.cSymbol != nil ? "a \(self.cSymbol!.name)" : "")]
    }
    var name: String {let first: String = (self.painted != nil ? "\(returnListToString(self.painted!.map({$0.name}))) Painted " : ""); let second = "\(cMaterial.name) \(cType.name)"; return first + second + addWith(returnListToString(stripEmptyStrings(self.extras)))}
    var cEffects: [String: Int] {get{var effects = ["N": 0, "I": 0]; effects[(self.cMaterial as? metal != nil ? "N" : "I")]! += self.cType.effect; if self.painted != nil { for item in self.painted! {effects[item.effect.type]! += item.effect.amount} }; if self.cSymbol != nil {effects[self.cSymbol!.cType.effect.type]! += self.cSymbol!.cType.effect.amount};if edging != nil {if let edge = edging! as? metal {if metals["rare"]!.filter({$0 == edge.baseMaterial}).count > 0 { effects["N"]! += 4 } else { effects["I"]! += 3 }} else { effects["I"]! += 3}}; return effects}}
    var value: Int {var value = cMaterial.value; if self.painted != nil {for item in self.painted! {value += item.value}}; if self.cSymbol != nil {value += self.cSymbol!.value}; if edging != nil {value += edging!.value}; return value + self.baseValue}
    func description() {
        print("\nShield\n----------------------------------")
        print(self.name)
        print("\nNobility: \(self.cEffects["N"]!)\tIntimidation: \(self.cEffects["I"]!)")
        print("Value: \(returnValueInPieces(self.value))")
    }
}
