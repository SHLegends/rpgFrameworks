// VALUE needs to be based off of WEIGHT ie. $ per lb
// 100 cp -> 1 sp | 100 sp -> 1 gp
// 10000 cp -> 1 gp

import Cocoa

let startTime = NSDate().timeIntervalSince1970


// DATA ------------------------------------ DATA ------------------------------------ DATA ------------------------------------ DATA ------------------------------------ DATA ------------------------------------ DATA

let fabrics: [(name: String, value: Int, gripPercent: Int)]
fabrics = [("Silk", 1000000, 65), ("Wool", 20, 60), ("Hemp", 10, 60), ("Linen", 20, 60), ("Cotton", 15, 60)]

let fabricQualities: [(name: String, modifier: Double)]
fabricQualities = [("Frayed", 0.8), ("Strong", 1.2), ("Worn", 0.8), ("Damaged", 0.7), ("Smooth", 1.0), ("Thick", 1.2), ("Thin", 1.0)]

let woods: [(name: String, value: Int, gripPercent: Int)]
woods = [("White Ash", 50, 70), ("Oak", 30, 70), ("White Oak", 40, 70), ("Elm", 25, 70), ("Maple", 25, 70), ("Walnut", 50, 70), ("Cherry", 75, 70), ("Rosewood", 80, 70), ("Ash", 40, 70), ("Hickory", 30, 70), ("Birch", 30, 70), ("Hemlock", 30, 70), ("Cedar", 30, 70), ("Pine", 15, 70)]

let woodQualities: [(name: String, modifier: Double)]
woodQualities = [("Burnt", 0.5), ("Ruff", 0.8), ("Smooth", 1.0), ("Lacquered", 1.5)]

let leathers: [(name: String, value: Int, gripPercent: Int)]
leathers = [("Leather", 100, 85), ("Buckskin", 110, 85), ("Sharkskin", 50000, 90), ("Goat Skin", 50, 85), ("Deerskin", 90, 85), ("Elk Skin", 120, 85), ("Rayskin", 60000, 90), ("Snakeskin", 10000, 85)]

let leatherQualities: [(name: String, modifier: Double)]
leatherQualities = [("Ruff", 0.9), ("Worn", 0.8), ("Thick", 1.2), ("Thin", 1.0), ("Strong", 1.2), ("Weak", 0.8), ("Damaged", 0.7), ("Smooth", 1.0), ("Hard", 0.9)]

let gripQualities: [(name: String, multiplier: Double, gripPercent: Int)]
gripQualities = [("Simple", 1.0, 25), ("Interwoven", 1.1, 30), ("Ornate", 1.5, 30), ("Elegant", 1.8, 20), ("Braided", 1.6, 30)]

let gems: [(name: String, value: Int)]
gems = [("Quartz", 50000), ("Agate", 60000), ("Bloodstone", 200000), ("Emerald", 10000000), ("Ruby", 10000000), ("Garnet", 400000), ("Amethyst", 100000), ("Aquamarine", 200000), ("Topaz", 100000), ("Opal", 5000000), ("Carnelian", 200000), ("Tourmaline", 800000), ("Diamond", 100000000), ("Jasper", 10000), ("Onyx", 500000), ("Peridot", 2500000), ("Malichite", 300000), ("Beryl", 1000000), ("Citrine", 100000), ("Spinel", 1000000)]

let gemShapes: [(name: String, valueModifier: Double)]
gemShapes = [("Circular", 1.1), ("Oval", 1.15), ("Square", 1.175), ("Pentagonal", 1.2), ("Hexagonal", 1.3), ("Octagonal", 1.4), ("Pear", 1.25), ("Marquise", 1.41), ("Triangle", 1.19)]

let gemSizes: [(name: String, modifier: Double)]
gemSizes = [("Tiny", 0.25), ("Small", 0.5), ("Medium", 0.75), ("Large", 1.0), ("Massive", 1.5), ("Giant", 2.0)]


let pommelTypes: [(name: String, labourMultiplier: Double, weight: Double)]
pommelTypes = [("Sphere", 1.2, 0.5), ("Cube", 1.0, 0.5), ("Fish-Tail", 1.4, 0.3), ("Disk", 1.01, 0.4), ("Shield-Shaped", 1.3, 0.4), ("Trefoil", 1.4, 0.6), ("Cresent", 1.1, 0.4), ("Pear-Shape", 1.1, 0.5), ("Misshapen Wheel", 1.0, 0.5), ("Boat-Shape", 1.2, 0.4), ("Cocked Hat", 1.25, 0.5), ("Lobed", 1.3, 0.5), ("Scent Stopper", 1.3, 0.5), ("Key-Shapped", 1.4, 1.0)]

let carvedAnimals = ["Eagle", "Dog", "Crow", "Horse", "Dragon", "Wolf", "Snake", "Boar", "Deer", "Moose", "Lion", "Panther", "Tiger"]


let metalBaseValue = 2 //per "
let metalBaseWeight = 0.02 //per "

let metals: [String: [(name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int)]]
metals = ["reg": [("Bronze", 1.6, 1.3, 1.0, 1.0, 150), ("Brass", 1.7, 1.2, 1.0, 1.0, 110), ("Copper", 1.8, 1.0, 0.9, 1.0, 100), ("Iron", 1.6, 1.3, 1.8, 1.6, 200), ("Steel", 1.5, 1.4, 2.0, 1.7, 300), ("Damascus Steel", 1.4, 2.0, 2.0, 1.7, 500)], "rare": [("Silver", 1.8, 3.0, 0.3, 1.0, 10000), ("Gold", 3.0, 5.0, 0.1, 1.0, 400000), ("Electrum", 2.5, 7.0, 0.2, 1.0, 500000)]]

let metalQualities: [(name: String, modifier: Double)]
metalQualities = [("Tarnished", 0.5), ("Scratched", 0.6), ("Poilished", 1.5)]


let crossguardSizes: [(name: String, weightModifier: Double)]
crossguardSizes = [("Narrow", 0.5), ("Broad", 1.5), ("Thin", 0.5), ("Slender", 0.5)]

let crossguardShapes: [(name: String, value: Int)]
crossguardShapes = [("Straight", 1), ("Up-Curved", 1), ("Serpentine", 2), ("Crescentic", 1), ("Arched", 1), ("Elliptical", 1), ("Bowed", 1), ("Angled", 1), ("Tilted", 1), ("Beveled", 1), ("Bowtie", 1)]



let crossguardEtchingsOfThing = ["a Wolf", "a Tree", "a Bear", "the Moon", "the Sun", "a Battle", "a Harvest", "a Sunset", "a Sunrise", "a Lion", "a Fish", "a Dragon", "a Crow", "a Boar"]
let crossguardEtchingStyles = ["Floral", "Swirling", "Interweaving", "Costal", "Fiery", "Hieroglyphic", "Tidal", "Serpentine", "Fish-Scale", "Feather-like"]

let etchings = ["style": ["Floral", "Swirling", "Interweaving", "Costal", "Fiery", "Hieroglyphic", "Tidal", "Serpentine", "Fish-Scale", "Feather-like"], "of thing": ["a Wolf", "a Tree", "a Bear", "the Moon", "the Sun", "a Battle", "a Harvest", "a Sunset", "a Sunrise", "a Lion", "a Fish", "a Dragon", "a Crow", "a Boar"]]


let axeSizes: [(name: String, value: Int, weightModifier: Double)]
axeSizes = [("Broad", 1, 1.5), ("Narrow", 1, 0.5), ("Slender", 1, 0.5), ("Rounded", 1, 1.0)]

let wrapAmounts: [(name: String, gripModifier: Double)]
wrapAmounts = [("Half Length", 1.2), ("Quarter Length", 1.1)]


// edit to change chances of better equipement

let randomChance = 4

let salvageMaterialLoss = 0.999

// FUNCTIONS ------------------------------------ FUNCTIONS ------------------------------------ FUNCTIONS ------------------------------------ FUNCTIONS ------------------------------------ FUNCTIONS

func returnRandomItem<T>( _ list: [T])-> T {
    return list[Int(arc4random_uniform(UInt32(list.count)))]
}

func returnRandomBool(_ chance: Int, _ inNum: Int)-> Bool {
    return (Int(arc4random_uniform(UInt32(inNum))) + 1 <= chance ? true : false)
}

func returnLength(_ inchs: Int) -> String {
    if inchs < 12 {
        return "\(inchs)\""
    } else {
        let numOfFeet = Int(inchs / 12)
        return "\(numOfFeet)\'\(inchs != numOfFeet * 12 ? " \(inchs - numOfFeet * 12)\"" : "")"
        
    }
}

func returnValueInPieces(_ getCP: Int)-> String {
    var pieces = ""
    var cp = getCP
    if cp >= 10000 {
        pieces += "\(cp / 10000) gp "
        cp = cp % 10000
    }
    if cp >= 100 {
        pieces += "\(cp / 100) sp "
        cp = cp % 100
    }
    if cp > 0 {
        pieces += "\(cp) cp"
    }
    return pieces
}




// STRUCTURES ------------------------------------ STRUCTURES ------------------------------------ STRUCTURES ------------------------------------ STRUCTURES ------------------------------------ STRUCTURES

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
    var etchingMetal: (name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int)?
    var withMetal: Bool
    init(withMetal: Bool = false, giveEtchingType: (name: String, value: Int)? = nil, giveEtchingMetal: (name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int) = returnRandomItem(metals["rare"]!)) {
        self.withMetal = withMetal
        if giveEtchingType != nil { self.etchingType = giveEtchingType! } else if returnRandomBool(3, 4) {
            self.etchingType = ("\(returnRandomItem(etchings["style"]!)) Etchings", 1000)
        } else {
            self.etchingType = ("Etching of \(returnRandomItem(etchings["of thing"]!))", 2500)
        }
        if withMetal { self.etchingMetal = giveEtchingMetal } else { self.etchingMetal = nil }
    }
    var name: String {return "\((self.withMetal ? "\(self.etchingMetal!.name) " : ""))\(etchingType.name)"}
    var value: Int {return self.etchingType.value + (self.withMetal ? Int(Double(self.etchingMetal!.value) * 0.001) : 0)}
    func description() {
        print("\nEtching\n-------------------------------------------------------------")
        print("Description: \(self.name)")
        print("Value: \(self.value) cp")
    }
}

// COMPONENTS ---------------------------------  COMPONENTS ---------------------------------  COMPONENTS ---------------------------------  COMPONENTS ---------------------------------  COMPONENTS ---------------------------------


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
    init(hasEtching: Bool = returnRandomBool(1, 5), hasGem: Bool = returnRandomBool(1, 5), isHead: Bool = returnRandomBool(1, 6), isRare: Bool = returnRandomBool(1, 5), giveMetal: metal? = nil, giveType: (name: String, labourMultiplier: Double, weight: Double)? = nil, giveGem: gemstone = gemstone(isPolished: true, hasShape: true), giveEtching: etching = etching(withMetal: returnRandomBool(1, 6)), baseWeight: Double = 0.3) {
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
        print("\nPommel\n-------------------------------------------------------------")
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
}


struct handle: weaponComponent {
    typealias handleMaterial = baseMaterial & materialWithGrip
    var baseWeight: Double = 0.1
    var labourValue = 15
    var hasWrap: Bool
    var componentWood: wood
    var wrap: handleMaterial?
    var wrapType: (name: String, multiplier: Double, gripPercent: Int)?
    var hasEtching: Bool
    var componentEtching: etching?
    
    
    var length: Int = 6
        init(giveWood: wood? = nil, hasWrap: Bool = returnRandomBool(1, 5), giveWrap: handleMaterial? = nil, giveWrapType: (name: String, multiplier: Double, gripPercent: Int)? = nil, hasEtching: Bool = returnRandomBool(1, 5), giveEtching: etching? = nil) {
            self.componentWood = (giveWood != nil ? giveWood! : wood(baseWeight: self.baseWeight))
            if hasWrap { if giveWrap != nil { self.wrap = giveWrap! } else { if returnRandomBool(1, 1) { self.wrap = leather(baseWeight: self.baseWeight) } else { self.wrap = fabric(baseWeight: self.baseWeight) } }
                self.wrapType = (giveWrapType != nil ? giveWrapType! : returnRandomItem(gripQualities)) } else { self.wrap = nil; self.wrapType = nil }
        self.hasEtching = hasEtching
        if hasEtching { self.componentEtching = giveEtching ?? etching(withMetal: returnRandomBool(1, 4)) } else { self.componentEtching = nil }
        self.hasWrap = hasWrap
    }
    var grip: Int {get {return (self.hasWrap ? self.wrap!.grip : self.componentWood.grip)}}
    var name: String {return "\(self.hasWrap ? "\(self.wrapType!.name) \(self.wrap!.name)\(self.wrap! as? fabric != nil ? " Cord" : "") Handle (\(self.componentWood.name) underneath\(self.hasEtching ? " with \(self.componentEtching!.name)" : ""))" : "\(self.componentWood.name) Handle\(self.hasEtching ? " (with \(self.componentEtching!.name))" : "")")"}
    var weight: Double {return self.componentWood.weight + (self.hasWrap ? self.wrap!.weight : 0.0)}
    var value: Int {return self.componentWood.value + (self.hasEtching ? self.componentEtching!.value : 0) + Int((self.hasWrap ? Double(self.wrap!.value) : 0.0) * (self.hasWrap ? self.wrapType!.multiplier : 0.0)) + self.labourValue}
    var abilities: [String] = [""]
    var components: [(name: String, amount: Double)] {return self.componentWood.components + (self.hasWrap ? self.wrap!.components : [])}
    func description() {
        print("\nHandle\n-------------------------------------------------------------")
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
}

//struct crossguard: weaponComponent {
//
//}









//
//
//
//
//struct shaft {
//    var name: String
//    var value = 0
//    var weight: Double
//    var length: Int
//    var grip: Int
//    var isMetal = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? true : false)
//    init(metal: (name: String, durability: Int, sharpness: Int, weight: Double, value: Double), length: (start: Int, stop: Int)) {
//        self.length = Int(arc4random_uniform(UInt32(length.stop - length.start + 1))) + length.start
//        let wrap = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(handleGrips) : nil)
//        let wrapQuality = (wrap != nil ? returnRandomItem(gripQualities) : nil)
//        let wrapAmount = (wrap != nil ? returnRandomItem(wrapAmounts) : nil)
//        let wrapText = (wrap != nil ? "with a \(wrapAmount!.name) \(wrapQuality!.name) \(wrap!.name) Wrap" : nil)
//        self.grip = 50
//        switch self.isMetal {
//            case true:
//                //metal rod
//                self.name = "\(self.length)\" \(metal.name) Rod\((wrap != nil ? " \(wrapText!)" : ""))"
//                self.weight = Double(self.length) * 0.07 * metal.weight
//                self.value = Int(Double(self.length) * 0.07 * metal.value)
//            default:
//                //wood shaft
//                self.name = "\(self.length)\" TODO Shaft\((wrap != nil ? " \(wrapText!)" : ""))"
//                self.weight = 1.5
//                self.value = 1 + (wrap != nil ? wrap!.value : 0)
//        }
//        if wrap != nil {
//            self.grip = Int(Double(self.grip + wrap!.gripPercent + wrapQuality!.gripPercent))
//        } else if self.isMetal {
//            self.grip -= 10
//        }
//    }
//
//    func description() {
//        print("\nShaft\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Length \(self.length)\"")
//        print("Weight: \(self.weight) lb")
//        print("Grip: \(self.grip) %")
//        print("Value: \(self.value) gp")
//    }
//}
//
//
//struct axeHead {
//    var name: String
//    var value = 0
//    var weight: Double
//
//    init(metal: (name: String, durability: Int, sharpness: Int, weight: Double, value: Double)) {
//        let withEtching = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? true : false)
//        let withGem = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? true : false)
//        let gem = (withGem ? returnRandomItem(gems) : nil)
//        let isDouble = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? true : false)
//        let etchingMetal = (withEtching && Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(rareMetals) : nil)
//        let axeSize = returnRandomItem(axeSizes)
//        self.weight = 2
//        self.name = "\(axeSize.name) \(metal.name)\(isDouble ? " Double": "") Axe Head"
//        switch (withEtching, withGem) {
//            case (true, true):
//                self.name += " (with inlaid \(gem!.name) and \((etchingMetal != nil ? "\(etchingMetal!.name) " : ""))\((Int(arc4random_uniform(UInt32(2))) == 0 ? "Etchings of a \(returnRandomItem(crossguardEtchingsOfThing))" : "\(returnRandomItem(crossguardEtchingStyles)) Etchings")))"
//                self.weight = self.weight * axeSize.weightModifier * (isDouble ? 2.0 : 1.0)
//                self.value = 0 + gem!.value + (etchingMetal != nil ? 1 : 0) + 1 + axeSize.value
//            case (true, false):
//                self.name += " (with \((etchingMetal != nil ? "\(etchingMetal!.name) " : ""))\((Int(arc4random_uniform(UInt32(2))) == 0 ? "Etchings of a \(returnRandomItem(crossguardEtchingsOfThing))" : "\(returnRandomItem(crossguardEtchingStyles)) Etchings")))"
//                self.weight = self.weight * axeSize.weightModifier * (isDouble ? 2.0 : 1.0)
//                self.value = 0 + (etchingMetal != nil ? 1 : 0) + 1 + axeSize.value
//            case (false, true):
//                self.name += " (with inlaid \(gem!.name))"
//                self.weight = self.weight * axeSize.weightModifier * (isDouble ? 2.0 : 1.0)
//                self.value = 0 + gem!.value + axeSize.value
//            case (false, false):
//                self.weight = self.weight * axeSize.weightModifier * (isDouble ? 2.0 : 1.0)
//                self.value = axeSize.value
//        self.weight *= metal.weight
//        }
//    }
//    func description() {
//        print("\nAxe Head\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//    }
//
//}
//
//
//struct blade {
//    // | blade lenght 12" - 40" | blade weight 0.5 - 4.0
//    var name: String
//    var value = 0
//    var weight: Double
//    var length: Int
//    var abilities = [String]()
//    let withEtching = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? true : false)
//    init(bladeLength: (start: Int, stop: Int), metalType: (name: String, durability: Int, sharpness: Int, weight: Double, value: Double)) {
//        self.length = Int(arc4random_uniform(UInt32(bladeLength.stop - bladeLength.start + 1))) + bladeLength.start
//        let withFuller = (self.length > 12 ? returnRandomItem([true, false, false]) : false)
//        let fullerDepth: (name: String, modifier: Double)? = (withFuller ? returnRandomItem([("Deep", 0.7), ("Shallow", 0.95)]) : nil)
//        let metalType = metalType
//        var blade: (name: String, modifer: Double)
//        let etchingMetal = (self.withEtching && Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(rareMetals) : nil)
//        let etchingText: String
//        if self.withEtching {
//            if Int(arc4random_uniform(UInt32(2))) == 0 {
//                etchingText = "(with \(etchingMetal != nil ? "\(etchingMetal!.name) " : "")\(returnRandomItem(crossguardEtchingStyles)) Etchings)"
//            } else {
//                etchingText = "(with \(etchingMetal != nil ? "\(etchingMetal!.name) " : "")Etchings of \(returnRandomItem(crossguardEtchingsOfThing)))"
//            }
//            self.value += 2
//        } else {
//            etchingText = ""
//        }
//        let checkLength = self.length
//        if Int(arc4random_uniform(UInt32(randomChance))) == 1 && checkLength > 20 {
//            // unique blade
//            blade = (checkLength < 40 ? returnRandomItem([("Curved", 1.0), ("Serpentine", 1.0), ("Leaf-Shaped", 1.0)]) : ("Serpentine", 1.0))
//        } else {
//
//            blade = ("Straight", 1.0)
//        }
//        self.name = "\(self.length)\" \(blade.name) \(metalType.name) Blade\((withFuller ? " with a \(fullerDepth!.name) Fuller" : "")) \(etchingText)"
//        self.weight = Double(Int((Double(length) * 0.085 * (withFuller ? fullerDepth!.modifier : 1.0)) * 100)) / 100.0
//        self.value += Int(Double(length) * 0.1 / (withFuller ? fullerDepth!.modifier : 1.0)) + 1
//    }
//    func description() {
//        print("\nBlade\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Length: \(self.length)\"")
//    }
//}
//
//
//struct crossguard {
//    var name: String
//    var value: Int
//    var weight: Double
//    let gemType = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(gems): nil)
//    let withEtching = (Int(arc4random_uniform(UInt32(4))) == 0 ? true : false)
//    let size = returnRandomItem(crossguardSizes)
//    let shape = returnRandomItem(crossguardShapes)
//    init(metal: (name: String, durability: Int, sharpness: Int, weight: Double, value: Double)) {
//        let metalType = metal
//        self.value = Int(Double(self.shape.value) * metalType.value) + (self.gemType != nil ? self.gemType!.value : 0) + (self.withEtching ? 1 : 0)
//        self.weight = size.weightModifier * metalType.weight
//        let etchingMetal = (self.withEtching && Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(rareMetals) : nil)
//        self.name = "\(self.size.name) \(self.shape.name) \(metalType.name) Guard "
//        if self.gemType != nil {
//            let gem = "with inlaid \(self.gemType!.name)"
//            if self.withEtching {
//                var etching = ""
//                if Int(arc4random_uniform(UInt32(2))) == 0 {
//                    etching = "and \(etchingMetal != nil ? "\(etchingMetal!.name) " : "")\(returnRandomItem(crossguardEtchingStyles)) Etchings"
//                } else {
//                    etching = "and \(etchingMetal != nil ? "\(etchingMetal!.name) " : "")Etchings of \(returnRandomItem(crossguardEtchingsOfThing))"
//                }
//                self.name += "(\(gem) \(etching))"
//            } else {
//                self.name += "(\(gem))"
//            }
//        } else {
//            if self.withEtching {
//                var etching = ""
//                if Int(arc4random_uniform(UInt32(2))) == 0 {
//                    etching = "with \(etchingMetal != nil ? "\(etchingMetal!.name) " : "")\(returnRandomItem(crossguardEtchingStyles)) Etchings"
//                } else {
//                    etching = "with \(etchingMetal != nil ? "\(etchingMetal!.name) " : "")Etchings of \(returnRandomItem(crossguardEtchingsOfThing))"
//                }
//                self.name += "(\(etching))"
//            }
//            self.weight /= 2.0
//        }
//    }
//    func description() {
//        print("\nCross-Guard\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//    }
//}
//
//
//struct handle {
//    var name: String
//    var value, grip: Int
//    var weight: Double
//    var withGrip: Bool
//    init(withGrip: Bool) {
//        self.grip = 50
//        self.weight = 0.25
//        self.withGrip = withGrip
//        let handleNameWithWood = "TODO Handle"
//        if self.withGrip {
//            let gripQuality = returnRandomItem(gripQualities)
//            let gripType = returnRandomItem(handleGrips)
//            let randGrip = "\(gripQuality.name) \(gripType.name) Grip"
//            self.name = "\(randGrip) (\(handleNameWithWood))"
//            self.grip += gripQuality.gripPercent + gripType.gripPercent
//            self.value = 1 + gripQuality.value + gripType.value
//            self.weight += 0.1
//        } else {
//            self.name = handleNameWithWood
//            self.value = 1
//        }
//    }
//
//    func description() {
//        print("\nHandle\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Grip: \(self.grip) %")
//        print("Value: \(self.value) gp")
//    }
//}
//
//
//struct longHandle {
//    var name: String
//    var weight: Double
//    var value, grip: Int
//    var withGrip: Bool
//    init(metal: (name: String, durability: Int, sharpness: Int, weight: Double, value: Double), withGrip: Bool) {
//        self.grip = 50
//        self.weight = 0.50
//        self.withGrip = withGrip
//        let wood = "TODO"
//        let numberOfHandHolds: (name: String, value: Int, weightMultiplier: Double) = returnRandomItem([("Two", 1, 1.0), ("Three", 2, 1.5)])
//        if self.withGrip {
//            let gripQuality = returnRandomItem(gripQualities)
//            let gripType = returnRandomItem(handleGrips)
//            let randGrip = "\(numberOfHandHolds.name) Hold \(gripQuality.name) \(gripType.name) Grip with \(metal.name) Collars"
//            self.name = "\(randGrip) (\(wood) underneath)"
//            self.grip += gripQuality.gripPercent + gripType.gripPercent
//            self.value = 1 + gripQuality.value + gripType.value + numberOfHandHolds.value
//            self.weight += 0.1
//        } else {
//            self.name = "\(numberOfHandHolds.name) Hold \(wood) Handle with \(metal.name) Collars"
//            self.value = numberOfHandHolds.value
//        }
//        self.weight *= numberOfHandHolds.weightMultiplier
//    }
//    func description() {
//        print("\nLong Handle\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Grip: \(self.grip) %")
//        print("Value: \(self.value) gp")
//    }
//}
//
//
//struct pommel {
//    var name: String
//    var weight: Double
//    var value: Int
//    var pommelType = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? (name: "\(returnRandomItem(carvedAnimals)) Head", value: 2, weight: 0.5) : returnRandomItem(pommelTypes))
//    var gemType = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(gems): nil)
//    init(originalMetalName: String) {
//        let metalType = (Int(arc4random_uniform(UInt32(randomChance))) == 0 ? returnRandomItem(rareMetals) : (name: originalMetalName, value: 1, weightMultiplier: 1.0))
//        self.weight = self.pommelType.weight * metalType.weightMultiplier
//        self.value = self.pommelType.value * metalType.value + (gemType != nil ? gemType!.value : 0)
//        self.name = "\(metalType.name) \(self.pommelType.name) Pommel \((gemType != nil ? "(with inlaid \(gemType!.name))" : ""))"
//        self.weight /= 2.0
//    }
//    func description() {
//        print("\nPommel\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp\((self.gemType != nil ? "\nWith Gem: \(self.gemType!.name)" : ""))")
//    }
//
//}
//
//
//struct swordSrap {
//    var name: String
//    var weight: Double
//    var value: Int
//    init(metal: (name: String, durability: Int, sharpness: Int, weight: Double, value: Double)) {
//        switch Int(arc4random_uniform(UInt32(5))) {
//            case 1  :
//                let material = metal
//                self.name = "\(material.name) Chain"
//                self.value = 1
//                self.weight = 0.4 * material.weight
//            case 2  :
//                let material: (name: String, weightModifier: Double, value: Int) = returnRandomItem([("Cotton", 0.3, 0), ("Silk", 0.6, 1)])
//                let knotType: (name: String, weightModifier: Double, value: Int) = returnRandomItem([("Single", 1.0, 0), ("Double", 2.0, 0), ("Triple", 3.0, 1), ("Flat", 0.8, 1), ("Diamond", 1.0, 1)])
//                let withWire = (Int(arc4random_uniform(UInt32(randomChance))) == 1 ? returnRandomItem(rareMetals) : nil)
//                self.name = "\(material.name)\((withWire != nil ? " and \(withWire!.name) Wire" : "")) \(knotType.name) Knot"
//                self.value = material.value + knotType.value + (withWire != nil ? withWire!.value : 0)
//                self.weight = 0.2 * material.weightModifier * knotType.weightModifier * (withWire != nil ? withWire!.weightMultiplier : 1)
//            default  :
//                let leatherType = returnRandomItem(handleGrips)
//                self.name = "\(leatherType.name) Strap"
//                self.value = leatherType.value
//                self.weight = 0.3
//        }
//    }
//
//    func description() {
//        print("\nSword Strap\n-------------------------------------------------------------")
//        print("Description: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//    }
//
//}
//
//
//
//class weaponGeneralItem {
//    var name: String
//    var weight: Double
//    var value: Int
//    var abilities: [String]
//    init(name: String, weight: Double, value: Int, abilities: [String]) {
//        self.name = name
//        self.weight = weight
//        self.value = value
//        self.abilities = abilities
//    }
//    func printAbilities() {
//        if self.abilities.count > 0 {
//            print("\n><><><><><>< Abilities ><><><><><><")
//            for item in self.abilities {print("Can \(item)")}
//        } else {
//            print("\nFOUND NO ABILITIES")
//        }
//    }
//}
//
//
//class weaponKnifeItem: weaponGeneralItem {
//    let itemBlade: blade
//    let itemHandle: handle
//    let metalType = returnRandomItem(metalTypes)
//    var length = 5
//    init() {
//        self.itemBlade = blade(bladeLength: (3, 11), metalType: self.metalType)
//        self.itemHandle = handle(withGrip: returnRandomItem([true, false]))
//        self.length += self.itemBlade.length
//        let weight = self.itemBlade.weight + self.itemHandle.weight
//        let value = self.itemBlade.value + self.itemHandle.value
//        super.init(name: "\(returnLength(self.itemBlade.length)) \(metalType.name) Knife" , weight: weight / 2.0, value: value, abilities: ["stab", "scratch"])
//    }
//    func description() {
//        print("===============================================")
//        print("Name: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Full Length: \(returnLength(self.length)) or \(self.length)\"")
//        print("\n\nComponents:\n")
//        self.itemBlade.description()
//        self.itemHandle.description()
//        print("===============================================")
//    }
//}
//
//
//class weaponDaggerItem: weaponGeneralItem {
//    let itemBlade: blade
//    let itemGuard: crossguard
//    let itemHandle: handle
//    let itemPommel: pommel
//    let metalType = returnRandomItem(metalTypes)
//    var length = 6
//    init() {
//        self.itemBlade = blade(bladeLength: (12, 20), metalType: self.metalType)
//        self.itemGuard = crossguard(metal: self.metalType)
//        self.itemHandle = handle(withGrip: returnRandomItem([true, false]))
//        self.itemPommel = pommel(originalMetalName: self.metalType.name)
//        self.length += self.itemBlade.length
//        let weight = self.itemBlade.weight + self.itemGuard.weight + self.itemHandle.weight + self.itemPommel.weight
//        let value = self.itemBlade.value + self.itemGuard.value + self.itemHandle.value + self.itemPommel.value
//        super.init(name: "\(returnLength(self.itemBlade.length)) \(metalType.name) Dagger" , weight: weight, value: value, abilities: ["stab", "slice", "parry", "scratch"])
//    }
//    func description() {
//        print("===============================================")
//        print("Name: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Full Length: \(returnLength(self.length)) or \(self.length)\"")
//        print("\n\nComponents:\n")
//        self.itemBlade.description()
//        self.itemGuard.description()
//        self.itemHandle.description()
//        self.itemPommel.description()
//        print("===============================================")
//    }
//}
//
//class weaponSwordItem: weaponGeneralItem {
//    let itemBlade: blade
//    let itemGuard: crossguard
//    let itemHandle: handle
//    let itemPommel: pommel
//    let itemKnot: swordSrap?
//    let metalType = returnRandomItem(metalTypes)
//    var length = 6
//    init() {
//        self.itemBlade = blade(bladeLength: (20, 40), metalType: self.metalType)
//        self.itemGuard = crossguard(metal: self.metalType)
//        self.itemHandle = handle(withGrip: returnRandomItem([true, false]))
//        self.itemPommel = pommel(originalMetalName: self.metalType.name)
//        self.length += self.itemBlade.length
//        self.itemKnot = (Int(arc4random_uniform(UInt32(2))) == 1 ? swordSrap(metal: self.metalType) : nil)
//        let weight = self.itemBlade.weight + self.itemGuard.weight + self.itemHandle.weight + self.itemPommel.weight + (self.itemKnot != nil ? self.itemKnot!.weight : 0.0)
//        let value = self.itemBlade.value + self.itemGuard.value + self.itemHandle.value + self.itemPommel.value + (self.itemKnot != nil ? self.itemKnot!.value : 0)
//        var abilities = ["stab", "slice", "parry", "chop", "disarm", "scratch"]
//        if itemKnot != nil {abilities.append("strap catch")}
//        super.init(name: "\(returnLength(self.itemBlade.length)) \(metalType.name) Sword" , weight: weight, value: value, abilities: abilities)
//    }
//    func description() {
//        print("===============================================")
//        print("Name: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Full Length: \(returnLength(self.length)) or \(self.length)\"")
//        print("\n\nComponents:\n")
//        self.itemBlade.description()
//        self.itemGuard.description()
//        self.itemHandle.description()
//        self.itemPommel.description()
//        if self.itemKnot != nil {self.itemKnot?.description()}
//        print("===============================================")
//    }
//}
//
//
//class weaponLongSwordItem: weaponGeneralItem {
//    let itemBlade: blade
//    let itemGuard: crossguard
//    let itemHandle: longHandle
//    let itemPommel: pommel
//    let metalType = returnRandomItem(metalTypes)
//    var length = 8
//    init() {
//        self.itemBlade = blade(bladeLength: (41, 70), metalType: self.metalType)
//        self.itemGuard = crossguard(metal: self.metalType)
//        self.itemHandle = longHandle(metal: metalType, withGrip: returnRandomItem([true, false]))
//        self.itemPommel = pommel(originalMetalName: self.metalType.name)
//        self.length += self.itemBlade.length
//        let weight = self.itemBlade.weight + self.itemGuard.weight + self.itemHandle.weight + self.itemPommel.weight
//        let value = self.itemBlade.value + self.itemGuard.value + self.itemHandle.value + self.itemPommel.value
//        let abilities = ["stab", "slice", "parry", "chop", "disarm", "scratch", "reach"]
//        super.init(name: "\(returnLength(self.itemBlade.length)) \(metalType.name) Long Sword" , weight: weight, value: value, abilities: abilities)
//    }
//    func description() {
//        print("===============================================")
//        print("Name: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Full Length: \(returnLength(self.length)) or \(self.length)\"")
//        print("\n\nComponents:\n")
//        self.itemBlade.description()
//        self.itemGuard.description()
//        self.itemHandle.description()
//        self.itemPommel.description()
//        print("===============================================")
//    }
//}
//
//
//class weaponAxeItem: weaponGeneralItem {
//    let itemAxeHead: axeHead
//    let itemShaft: shaft
//    var length = 0
//    let metalType = returnRandomItem(metalTypes)
//    init() {
//        self.itemAxeHead = axeHead(metal: self.metalType)
//        self.itemShaft = shaft(metal: self.metalType, length: (18, 34))
//        let name = "\(returnLength(self.itemShaft.length)) \(self.metalType.name) Axe"
//        let weight = self.itemAxeHead.weight + self.itemShaft.weight
//        let value = self.itemAxeHead.value + self.itemShaft.value
//        self.length += self.itemShaft.length
//        super.init(name: name, weight: weight, value: value, abilities: ["block", "chop", "cleave"])
//    }
//    func description() {
//        print("===============================================")
//        print("Name: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Full Length: \(returnLength(self.length)) or \(self.length)\"")
//        print("\n\nComponents:\n")
//        self.itemAxeHead.description()
//        self.itemShaft.description()
//        print("===============================================")
//    }
//}
//
//
//class weaponSwordStaffItem: weaponGeneralItem {
//    let itemBlade: blade
//    let itemShaft: shaft
//    var length = 0
//    let metalType = returnRandomItem(metalTypes)
//
//
//
//    init() {
//        self.itemBlade = blade(bladeLength: (18, 30), metalType: self.metalType)
//        self.itemShaft = shaft(metal: self.metalType, length: (24, 60))
//        let name = "\(returnLength(self.itemShaft.length + self.itemBlade.length)) \(self.metalType.name) Sword Staff"
//        let weight = self.itemBlade.weight + self.itemShaft.weight
//        let value = self.itemBlade.value + self.itemShaft.value
//        self.length += self.itemShaft.length + itemBlade.length
//        super.init(name: name, weight: weight, value: value, abilities: ["block", "stab", "slice", "parry", "chop", "disarm", "scratch", "reach"])
//    }
//    func description() {
//        print("===============================================")
//        print("Name: \(self.name)")
//        print("Weight: \(self.weight) lb")
//        print("Value: \(self.value) gp")
//        print("Full Length: \(returnLength(self.length)) or \(self.length)\"")
//        print("\n\nComponents:\n")
//        self.itemBlade.description()
//        self.itemShaft.description()
//        print("===============================================")
//    }
//}


//let foo = "\n\n\n\n\n\n\n\n\nNEXT ITEM\n\n\n\n\n\n\n\n\n"
//let axe = weaponAxeItem()
//let sword = weaponSwordItem()
//let lsword = weaponLongSwordItem()
//let dagger = weaponDaggerItem()
//let knife = weaponKnifeItem()
//let swordS = weaponSwordStaffItem()
//
//swordS.description()
//swordS.printAbilities()
//print(foo)
//axe.description()
//axe.printAbilities()
//print(foo)
//lsword.description()
//lsword.printAbilities()
//print(foo)
//sword.description()
//sword.printAbilities()
//print(foo)
//dagger.description()
//dagger.printAbilities()
//print(foo)
//knife.description()
//knife.printAbilities()

//for _ in 1...10 {
//    var foo = gemstone(isPolished: returnRandomBool(3, 4), hasShape: returnRandomBool(3, 4))
//    foo.description()
//}
//
//for _ in 1...10 {
//    var foo = leather()
//    foo.description()
//}
//
//for _ in 1...10 {
//    var foo = fabric()
//    foo.description()
//}
//
//for _ in 1...10 {
//    var foo = wood()
//    foo.description()
//}
//
//for _ in 1...10 {
//    var foo = metal()
//    foo.description()
//}
//
//for _ in 1...10 {
//    var foo = etching(withMetal: returnRandomBool(1, 4))
//    foo.description()
//}

var foo = handle()
foo.description()

var bar = pommel()
bar.description()



print("\n\nRUNTIME: \(Double(Int((NSDate().timeIntervalSince1970 - startTime) * 100))/100-0.05) +0.05s")



