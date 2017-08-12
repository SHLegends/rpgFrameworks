//
//  ItemGen_Data.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let gemRarityModifier = 2

let rarityModifier = 10

//let metalBaseValue = 2 //per "
//let metalBaseWeight = 0.02 //per "

let axeSizes: [(name: String, value: Int, weightModifier: Double)] = [("Broad", 1, 1.5), ("Narrow", 1, 0.5), ("Slender", 1, 0.5), ("Rounded", 1, 1.0)]

let wrapAmounts: [(name: String, gripModifier: Double)] = [("Half Length", 1.2), ("Quarter Length", 1.1)]

let randomChance = 4

let salvageMaterialLoss = 0.999

let gems: [(name: String, value: Int)] = [("Quartz", 50000), ("Agate", 60000), ("Bloodstone", 200000), ("Emerald", 10000000), ("Ruby", 10000000), ("Garnet", 400000), ("Amethyst", 100000), ("Aquamarine", 200000), ("Topaz", 100000), ("Opal", 5000000), ("Carnelian", 200000), ("Tourmaline", 800000), ("Diamond", 100000000), ("Jasper", 10000), ("Onyx", 500000), ("Peridot", 2500000), ("Malichite", 300000), ("Beryl", 1000000), ("Citrine", 100000), ("Spinel", 1000000)]

let gemShapes: [(name: String, valueModifier: Double)] = [("Circular", 1.1), ("Oval", 1.15), ("Square", 1.175), ("Pentagonal", 1.2), ("Hexagonal", 1.3), ("Octagonal", 1.4), ("Pear", 1.25), ("Marquise", 1.41), ("Triangle", 1.19)]

let gemSizes: [(name: String, modifier: Double)] = [("Tiny", 0.25), ("Small", 0.5), ("Medium", 0.75), ("Large", 1.0), ("Massive", 1.5), ("Giant", 2.0)]


let leathers: [(name: String, value: Int, gripPercent: Int)] = [("Leather", 100, 85), ("Buckskin", 110, 85), ("Sharkskin", 50000, 90), ("Goat Skin", 50, 85), ("Deerskin", 90, 85), ("Elk Skin", 120, 85), ("Rayskin", 60000, 90), ("Snakeskin", 10000, 85)]

let leatherQualities: [(name: String, modifier: Double)] = [("Ruff", 0.9), ("Worn", 0.8), ("Thick", 1.2), ("Thin", 1.0), ("Strong", 1.2), ("Weak", 0.8), ("Damaged", 0.7), ("Smooth", 1.0), ("Hard", 0.9)]

let fabrics: [(name: String, value: Int, gripPercent: Int)] = [("Silk", 1000000, 65), ("Wool", 20, 60), ("Hemp", 10, 60), ("Linen", 20, 60), ("Cotton", 15, 60)]

let fabricQualities: [(name: String, modifier: Double)] = [("Frayed", 0.8), ("Strong", 1.2), ("Worn", 0.8), ("Damaged", 0.7), ("Smooth", 1.0), ("Thick", 1.2), ("Thin", 1.0)]

let woods: [(name: String, value: Int, gripPercent: Int)] = [("White Ash", 50, 70), ("Oak", 30, 70), ("White Oak", 40, 70), ("Elm", 25, 70), ("Maple", 25, 70), ("Walnut", 50, 70), ("Cherry", 75, 70), ("Rosewood", 80, 70), ("Ash", 40, 70), ("Hickory", 30, 70), ("Birch", 30, 70), ("Hemlock", 30, 70), ("Cedar", 30, 70), ("Pine", 15, 70)]

let woodQualities: [(name: String, modifier: Double)] = [("Burnt", 0.5), ("Ruff", 0.8), ("Smooth", 1.0), ("Lacquered", 1.5)]
let metals: [String: [(name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int)]] = ["reg": [("Bronze", 1.6, 1.3, 1.0, 1.0, 150), ("Brass", 1.7, 1.2, 1.0, 1.0, 110), ("Copper", 1.8, 1.0, 0.9, 1.0, 100), ("Iron", 1.6, 1.3, 1.8, 1.6, 200), ("Steel", 1.5, 1.4, 2.0, 1.7, 300), ("Damascus Steel", 1.4, 2.0, 2.0, 1.7, 500)], "rare": [("Silver", 1.8, 3.0, 0.3, 1.0, 10000), ("Gold", 3.0, 5.0, 0.1, 1.0, 400000), ("Electrum", 2.5, 7.0, 0.2, 1.0, 500000)]]

let metalQualities: [(name: String, modifier: Double)] = [("Tarnished", 0.5), ("Scratched", 0.6), ("Poilished", 1.5)]
let etchings = ["style": ["Floral", "Swirling", "Interweaving", "Costal", "Fiery", "Hieroglyphic", "Tidal", "Serpentine", "Fish-Scale", "Feather-like"], "of thing": ["a Wolf", "a Tree", "a Bear", "the Moon", "the Sun", "a Battle", "a Harvest", "a Sunset", "a Sunrise", "a Lion", "a Fish", "a Dragon", "a Crow", "a Boar"]]

let etchingQualities: [(name: String, modifier: Double)] = [("Simplistic", 0.8), ("Detailed", 1.2), ("Intricate", 0.8), ("Deep", 0.7), ("Shallow", 1.0), ("Ornate", 1.2), ("Narrow", 0.9), ("Slender", 0.9)]

let pommelTypes: [(name: String, labourMultiplier: Double, weight: Double)] = [("Sphere", 1.2, 0.5), ("Cube", 1.0, 0.5), ("Fish-Tail", 1.4, 0.3), ("Disk", 1.01, 0.4), ("Shield-Shaped", 1.3, 0.4), ("Trefoil", 1.4, 0.6), ("Cresent", 1.1, 0.4), ("Pear-Shape", 1.1, 0.5), ("Misshapen Wheel", 1.0, 0.5), ("Boat-Shape", 1.2, 0.4), ("Cocked Hat", 1.25, 0.5), ("Lobed", 1.3, 0.5), ("Scent Stopper", 1.3, 0.5), ("Key-Shapped", 1.4, 1.0)]

let carvedAnimals = ["Eagle", "Dog", "Crow", "Horse", "Dragon", "Wolf", "Snake", "Boar", "Deer", "Moose", "Lion", "Panther", "Tiger"]

let gripQualities: [(name: String, multiplier: Double, gripPercent: Int)] = [("Simple", 1.0, 25), ("Interwoven", 1.1, 30), ("Ornate", 1.5, 30), ("Elegant", 1.8, 20), ("Braided", 1.6, 30)]

let crossguardSizes: [(name: String, weightModifier: Double)] = [("Narrow", 0.9), ("Broad", 1.2), ("Thin", 0.9), ("Slender", 0.9), ("Wide", 1.1), ("Thick", 1.2)]

let crossguardShapes: [(name: String, labourMultiplier: Double)] = [("Straight", 1.0), ("Up-Curved", 1.1), ("Serpentine", 1.5), ("Crescentic", 1.2), ("Arched", 1.2), ("Elliptical", 1.3), ("Bowed", 1.2), ("Angled", 1.1), ("Tilted", 1.1), ("Beveled", 1.1), ("Bowtie", 1.3), ("Wavy", 1.4), ("Corkscrew", 1.3), ("Spiral", 1.3), ("Hooked", 1.2), ("Falcate", 1.2)]

let doubleEdgeBladeShapes: [(name: String, labourMultiplier: Double)] = [("Straight", 1.0), ("Curved", 1.1), ("Hooked", 1.2), ("Serpintine", 1.3)]
let doubleEdgeBladeSizes: [(name: String, labourMultiplier: Double, weightModifier: Double)] = [("Wide", 1.05, 1.4), ("Slender", 1.0, 0.9), ("Broad", 1.05, 1.4), ("Narrow", 1.0, 0.9), ("Typical", 1.0, 1.0)]
