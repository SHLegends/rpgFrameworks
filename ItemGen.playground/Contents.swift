
// 100 cp -> 1 sp | 100 sp -> 1 gp
// 10000 cp -> 1 gp

// ADD qualities to etchings



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
crossguardSizes = [("Narrow", 0.9), ("Broad", 1.2), ("Thin", 0.9), ("Slender", 0.9), ("Wide", 1.1), ("Thick", 1.2)]

let crossguardShapes: [(name: String, labourMultiplier: Double)]
crossguardShapes = [("Straight", 1.0), ("Up-Curved", 1.1), ("Serpentine", 1.5), ("Crescentic", 1.2), ("Arched", 1.2), ("Elliptical", 1.3), ("Bowed", 1.2), ("Angled", 1.1), ("Tilted", 1.1), ("Beveled", 1.1), ("Bowtie", 1.3), ("Wavy", 1.4), ("Corkscrew", 1.3), ("Spiral", 1.3), ("Hooked", 1.2), ("Falcate", 1.2)]



let etchings = ["style": ["Floral", "Swirling", "Interweaving", "Costal", "Fiery", "Hieroglyphic", "Tidal", "Serpentine", "Fish-Scale", "Feather-like"], "of thing": ["a Wolf", "a Tree", "a Bear", "the Moon", "the Sun", "a Battle", "a Harvest", "a Sunset", "a Sunrise", "a Lion", "a Fish", "a Dragon", "a Crow", "a Boar"]]

let etchingQualities: [(name: String, modifier: Double)]
etchingQualities = [("Simple", 0.8), ("Detailed", 1.2), ("Inticate", 0.8), ("Deep", 0.7), ("Shallow", 1.0), ("Ornate", 1.2), ("Basic", 1.0), ("Narrow", 0.9), ("Slender", 0.9)]

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
    init(giveGuardShape: (name: String, labourMultiplier: Double) = returnRandomItem(crossguardShapes), giveGuardSize: (name: String, weightModifier: Double) = returnRandomItem(crossguardSizes), hasEtching: Bool = returnRandomBool(1, 5), hasGem: Bool = returnRandomBool(1, 5), isRare: Bool = returnRandomBool(1, 5), giveMetal: metal? = nil, giveGem: gemstone = gemstone(isPolished: true, hasShape: true), giveEtching: etching = etching(withMetal: returnRandomBool(1, 6)), baseWeight: Double = 0.3) {
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
    var name: String {return " \(self.guardSize.name) \(self.componentMetal.name) \(self.guardShape.name) Guard\((self.hasGem || self.hasEtching ? " (with ": ""))\(self.hasGem ? "a \(self.componentGemstone!.name)" : "")\((self.hasGem && self.hasEtching ? " and " : ""))\((self.hasEtching ? "\(self.componentEtching!.name)" : ""))\(self.hasGem || self.hasEtching ? ")" : "")"}
    var weight: Double {return self.componentMetal.weight + (self.hasGem ? self.componentGemstone!.weight : 0)}
    var value: Int {return self.componentMetal.value + (self.hasEtching ? self.componentEtching!.value : 0) + (self.hasGem ? self.componentGemstone!.value : 0) + Int(Double(self.labourValue) * self.guardShape.labourMultiplier)}
    var abilities: [String] {return ["block"]}
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
    
    
}

var blah = crossguard(hasEtching: true, hasGem: true)
blah.description()

var foo = handle()
foo.description()

var bar = pommel()
bar.description()


print("\n\nRUNTIME: \(Double(Int((NSDate().timeIntervalSince1970 - startTime) * 100))/100-0.05) +0.05s")



