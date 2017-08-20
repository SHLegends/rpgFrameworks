//
//  ItemGen_Weapons.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-12.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

protocol weapon {
    var cMaterial: baseMaterial {get set}
    var name: String {get}
    var weight: Double {get}
    var value: Int {get}
    var components: [(name: String, amount: Double)] {get}
    var grip: Int {get}
    var length: Int {get}
    func description()
    func simpleDescription()
    func basicDescription()
    var cList: [weaponComponent] {get}
    var typeName: String {get}
}
extension weapon {
    func description() {
        print("\n\n\n\(self.typeName)\n=============================================")
        print("Description: \(self.name)")
        print("Weight: \(self.weight) lb")
        print("Value: \(self.value) cp || \(returnValueInPieces(self.value))")
        print("Full Length: \(self.length)\"")
        for item in cList { item.description() }
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
    var weight: Double {var weight = 0.0; for item in self.cList {weight += item.weight}; return weight}
    var value: Int {var value = 0; for item in self.cList {value += item.value}; return value}
    var components: [(name: String, amount: Double)] {var components = [(name: String, amount: Double)](); for item in cList { components += item.components }; return components}
}

protocol bladedWeapon {
    var cBlade: blade {get set}
    var isDoubleEdge: Bool {get}
}
extension bladedWeapon {
    var isDoubleEdge: Bool {return self.cBlade.isDoubleEdge}
}

struct shortAxe: weapon {
    var typeName: String = "One-Handed Axe"
    var cMaterial: baseMaterial
    var cAxeHead: axeHead
    var cHaft: haft
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveAxe: axeHead? = nil,  giveHaft: haft? = nil) {
        self.cMaterial = cMaterial
        if giveAxe != nil { self.cAxeHead = giveAxe! } else { self.cAxeHead = axeHead(cMaterial: self.cMaterial) }
        if giveHaft != nil { self.cHaft = giveHaft! } else { self.cHaft = haft(length: returnRandNumInRange(12, 24))}
        self.cList = [self.cAxeHead, self.cHaft]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.length)\" \(self.typeName)"}
    var grip: Int {return self.cHaft.grip}
}

struct longAxe: weapon {
    var typeName: String = "Two-Handed Axe"
    var cMaterial: baseMaterial
    var cAxeHead: axeHead
    var cHaft: haft
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveAxe: axeHead? = nil,  giveHaft: haft? = nil) {
        self.cMaterial = cMaterial
        if giveAxe != nil { self.cAxeHead = giveAxe! } else { self.cAxeHead = axeHead(cMaterial: self.cMaterial) }
        if giveHaft != nil { self.cHaft = giveHaft! } else { self.cHaft = haft(length: returnRandNumInRange(36, 48))}
        self.cList = [self.cAxeHead, self.cHaft]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.length)\" \(self.typeName)"}
    var grip: Int {return self.cHaft.grip}
}

struct shortMace: weapon {
    var typeName: String = "One-Handed Mace"
    var cMaterial: baseMaterial
    var cMaceHead: maceHead
    var cHaft: haft
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveMace: maceHead? = nil,  giveHaft: haft? = nil) {
        self.cMaterial = cMaterial
        if giveMace != nil { self.cMaceHead = giveMace! } else { self.cMaceHead = maceHead(cMaterial: self.cMaterial) }
        if giveHaft != nil { self.cHaft = giveHaft! } else { self.cHaft = haft(length: returnRandNumInRange(12, 24))}
        self.cList = [self.cMaceHead, self.cHaft]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.length)\" \(self.typeName)"}
    var grip: Int {return self.cHaft.grip}
}

struct longMace: weapon {
    var typeName: String = "Two-Handed Mace"
    var cMaterial: baseMaterial
    var cMaceHead: maceHead
    var cHaft: haft
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveMace: maceHead? = nil,  giveHaft: haft? = nil) {
        self.cMaterial = cMaterial
        if giveMace != nil { self.cMaceHead = giveMace! } else { self.cMaceHead = maceHead(cMaterial: self.cMaterial) }
        if giveHaft != nil { self.cHaft = giveHaft! } else { self.cHaft = haft(length: returnRandNumInRange(36, 48))}
        self.cList = [self.cMaceHead, self.cHaft]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.length)\" \(self.typeName)"}
    var grip: Int {return self.cHaft.grip}
}

struct swordStaff: weapon, bladedWeapon {
    var typeName: String = "Sword Staff"
    var cMaterial: baseMaterial
    var cBlade: blade
    var cHaft: haft
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveBlade: blade? = nil,  giveHaft: haft? = nil) {
        self.cMaterial = cMaterial
        if giveBlade != nil { self.cBlade = giveBlade! } else { self.cBlade = blade(length: returnRandNumInRange(12, 24), cMaterial: self.cMaterial) }
        if giveHaft != nil { self.cHaft = giveHaft! } else { self.cHaft = haft(length: returnRandNumInRange(36, 60))}
        self.cList = [self.cBlade, self.cHaft]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.length)\" \(self.typeName)"}
    var grip: Int {return self.cHaft.grip}
}

struct longSword: weapon, bladedWeapon {
    var typeName: String = "Long Sword"
    var cMaterial: baseMaterial
    var cBlade: blade
    var cGuard: crossguard
    var cHandle: longHandle
    var cPommel: pommel
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveBlade: blade? = nil, giveGuard: crossguard? = nil, giveHandle: longHandle? = nil, givePommel: pommel? = nil) {
        self.cMaterial = cMaterial
        let rareMetal = (isRare ? metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) : nil)
        if giveBlade != nil { self.cBlade = giveBlade! } else { self.cBlade = blade(length: returnRandNumInRange(45, 60), cMaterial: self.cMaterial) }
        if giveGuard != nil { self.cGuard = giveGuard! } else if isRare { self.cGuard = crossguard(cMaterial: rareMetal!) } else { self.cGuard = crossguard(cMaterial: self.cMaterial) }
        if giveHandle != nil { self.cHandle = giveHandle! } else { self.cHandle = longHandle(ringMaterial: self.cMaterial)}
        if givePommel != nil { self.cPommel = givePommel! } else if isRare { self.cPommel = pommel(cMaterial: rareMetal!) } else { self.cPommel = pommel(cMaterial: self.cMaterial) }
        self.cList = [self.cBlade, self.cGuard, self.cHandle, self.cPommel]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.cBlade.length)\" \(self.cMaterial.rawMaterial.name) \(self.typeName)"}
    var grip: Int {return self.cHandle.grip}
}

struct sword: weapon, bladedWeapon {
    var typeName: String = "Sword"
    var cMaterial: baseMaterial
    var cBlade: blade
    var cGuard: crossguard
    var cHandle: handle
    var cPommel: pommel
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveBlade: blade? = nil, giveGuard: crossguard? = nil, giveHandle: handle? = nil, givePommel: pommel? = nil) {
        self.cMaterial = cMaterial
        let rareMetal = (isRare ? metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) : nil)
        if giveBlade != nil { self.cBlade = giveBlade! } else { self.cBlade = blade(length: returnRandNumInRange(26, 40), cMaterial: self.cMaterial) }
        if giveGuard != nil { self.cGuard = giveGuard! } else if isRare { self.cGuard = crossguard(cMaterial: rareMetal!) } else { self.cGuard = crossguard(cMaterial: self.cMaterial) }
        if giveHandle != nil { self.cHandle = giveHandle! } else { self.cHandle = handle()}
        if givePommel != nil { self.cPommel = givePommel! } else if isRare { self.cPommel = pommel(cMaterial: rareMetal!) } else { self.cPommel = pommel(cMaterial: self.cMaterial) }
        self.cList = [self.cBlade, self.cGuard, self.cHandle, self.cPommel]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.cBlade.length)\" \(self.cMaterial.rawMaterial.name) \(self.typeName)"}
    var grip: Int {return self.cHandle.grip}
}

struct dagger: weapon {
    var typeName: String = "Dagger"
    var cMaterial: baseMaterial
    var cBlade: blade
    var cGuard: crossguard
    var cHandle: handle
    var cPommel: pommel
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveBlade: blade? = nil, giveGuard: crossguard? = nil, giveHandle: handle? = nil, givePommel: pommel? = nil) {
        self.cMaterial = cMaterial
        let rareMetal = (isRare ? metal(giveRawMaterial: returnRandomItem(metals["rare"]!)) : nil)
        if giveBlade != nil { self.cBlade = giveBlade! } else { self.cBlade = blade(length: returnRandNumInRange(12, 20), cMaterial: self.cMaterial) }
        if giveGuard != nil { self.cGuard = giveGuard! } else if isRare { self.cGuard = crossguard(cMaterial: rareMetal) } else { self.cGuard = crossguard(cMaterial: self.cMaterial) }
        if giveHandle != nil { self.cHandle = giveHandle! } else { self.cHandle = handle()}
        if givePommel != nil { self.cPommel = givePommel! } else if isRare { self.cPommel = pommel(cMaterial: rareMetal) } else { self.cPommel = pommel(cMaterial: self.cMaterial) }
        self.cList = [self.cBlade, self.cGuard, self.cHandle, self.cPommel]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.cBlade.length)\" \(self.cMaterial.rawMaterial.name) \(self.typeName)"}
    var grip: Int {return self.cHandle.grip}
}

struct knife: weapon {
    var typeName: String = "Knife"
    var cMaterial: baseMaterial
    var cBlade: blade
    var cHandle: handle
    var cList: [weaponComponent]
    init(cMaterial: baseMaterial = metal(), isRare: Bool = returnRandomBool(1, rarityModifier), giveBlade: blade? = nil, giveHandle: handle? = nil) {
        self.cMaterial = cMaterial
        if giveBlade != nil { self.cBlade = giveBlade! } else { self.cBlade = blade(length: returnRandNumInRange(6, 11), cMaterial: self.cMaterial) }
        if giveHandle != nil { self.cHandle = giveHandle! } else { self.cHandle = handle()}
        self.cList = [self.cBlade, self.cHandle]
    }
    var length: Int {var length = 0; for item in self.cList {length += item.length}; return length}
    var name: String {return "\(self.cBlade.length)\" \(self.cMaterial.rawMaterial.name) \(self.typeName)"}
    var grip: Int {return self.cHandle.grip}
}
