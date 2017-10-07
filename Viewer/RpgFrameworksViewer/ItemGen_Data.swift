//
//  ItemGen_Data.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let gemRarityModifier = 5

let rarityModifier = 10

//let metalBaseValue = 2 //per "
//let metalBaseWeight = 0.02 //per "

let axeTypes: [(name: String, value: Int, weightModifier: Double)] = [("Broad", 1, 1.5), ("Narrow", 1, 0.8), ("Slender", 1, 0.8), ("Rounded", 1, 1.0), ("Heavy", 1, 1.6), ("Light", 1, 0.6), ("Curved", 1, 1.0), ("Recurved", 1, 1.0)]

let randomChance = 4

let salvageMaterialLoss = 0.999

let gems: [(name: String, value: Int)] = [("Quartz", 500), ("Agate", 600), ("Bloodstone", 20000), ("Emerald", 20000), ("Ruby", 30000), ("Garnet", 4000), ("Amethyst", 1000), ("Aquamarine", 20000), ("Topaz", 10000), ("Opal", 10000), ("Carnelian", 20000), ("Tourmaline", 80000), ("Diamond", 100000), ("Jasper", 1000), ("Onyx", 50000), ("Peridot", 25000), ("Malichite", 30000), ("Beryl", 10000), ("Citrine", 10000), ("Spinel", 10000), ("Saphire", 30000)]

let gemShapes: [(name: String, valueModifier: Double)] = [("Circular", 1.1), ("Oval", 1.15), ("Square", 1.175), ("Pentagonal", 1.2), ("Hexagonal", 1.3), ("Octagonal", 1.4), ("Pear", 1.25), ("Marquise", 1.41), ("Triangle", 1.19)]

let gemSizes: [(name: String, modifier: Double)] = [("Tiny", 0.25), ("Small", 0.5), ("Medium", 0.75), ("Large", 1.0), ("Massive", 1.5), ("Giant", 2.0)]


let leathers: [(name: String, value: Int, gripPercent: Int)] = [("Leather", 100, 85), ("Buckskin", 110, 85), ("Sharkskin", 50000, 90), ("Goat Skin", 50, 85), ("Deerskin", 90, 85), ("Elk Skin", 120, 85), ("Rayskin", 60000, 90), ("Snakeskin", 10000, 85)]

let leatherQualities: [(name: String, modifier: Double)] = [("Rough", 0.9), ("Worn", 0.8), ("Thick", 1.2), ("Thin", 1.0), ("Strong", 1.2), ("Weak", 0.8), ("Damaged", 0.7), ("Smooth", 1.0), ("Hard", 0.9), ("Charred", 0.8), ("Soft", 1.1), ("Marred", 0.9)]

let fabrics: [(name: String, value: Int, gripPercent: Int)] = [("Silk", 1000000, 65), ("Wool", 20, 60), ("Hemp", 10, 60), ("Linen", 20, 60), ("Cotton", 15, 60)]

let fabricQualities: [(name: String, modifier: Double)] = [("Frayed", 0.8), ("Strong", 1.2), ("Worn", 0.8), ("Damaged", 0.7), ("Smooth", 1.0), ("Thick", 1.2), ("Thin", 1.0), ("Soft", 1.1)]

let woods: [(name: String, value: Int, gripPercent: Int)] = [("White Ash", 50, 70), ("Oak", 30, 70), ("White Oak", 40, 70), ("Elm", 25, 70), ("Maple", 25, 70), ("Walnut", 50, 70), ("Cherry", 75, 70), ("Rosewood", 80, 70), ("Ash(AoD)", 40, 70), ("Hickory", 30, 70), ("Birch", 30, 70), ("Hemlock", 30, 70), ("Cedar", 30, 70), ("Pine", 15, 70), ("Linden", 30, 70)]

let woodQualities: [(name: String, modifier: Double)] = [("Burnt", 0.5), ("Rough", 0.8), ("Smooth", 1.0), ("Lacquered", 1.5), ("Coarse", 0.8), ("Marred", 0.9), ("Gnarled", 0.9)]

let metals: [String: [(name: String, weightModifier: Double, valueModifier: Double, durabilityModifier: Double, sharpnessModifier: Double, value: Int)]] = ["reg": [("Bronze", 1.6, 1.3, 1.0, 1.0, 150), ("Brass", 1.7, 1.2, 1.0, 1.0, 110), ("Copper", 1.8, 1.0, 0.9, 1.0, 100), ("Iron", 1.6, 1.3, 1.8, 1.6, 200), ("Steel", 1.5, 1.4, 2.0, 1.7, 300), ("Damascus Steel", 1.4, 2.0, 2.0, 1.7, 500)], "rare": [("Silver", 1.8, 3.0, 0.3, 1.0, 10000), ("Gold", 3.0, 5.0, 0.1, 1.0, 400000), ("Electrum", 2.5, 7.0, 0.2, 1.0, 500000)]]

let metalQualities: [(name: String, modifier: Double)] = [("Tarnished", 0.5), ("Scratched", 0.6), ("Polished", 1.5), ("Shiny", 1.5), ("Coarse", 0.9), ("Smooth", 1.2), ("Rough", 0.9)]

let etchings = ["style": ["Floral", "Swirling", "Interweaving", "Costal", "Fiery", "Hieroglyphic", "Tidal", "Serpentine", "Fish-Scale", "Feather-like"], "of thing": ["a Wolf", "a Tree", "a Bear", "the Moon", "the Sun", "a Battle", "a Harvest", "a Sunset", "a Sunrise", "a Lion", "a Fish", "a Dragon", "a Crow", "a Boar", "a Lion", "a Panther", "a Tiger", "a Lynx", "a Goat", "an Owl", "a Fox", "a Puma", "a Cougar", "a Viper", "a Cobra", "a Lizard", "a Weasel", "a Rabbit", "a Hare", "a Bison", "a Newt"]]

let etchingQualities: [(name: String, modifier: Double)] = [("Simplistic", 0.8), ("Detailed", 1.2), ("Intricate", 0.8), ("Deep", 0.7), ("Shallow", 1.0), ("Ornate", 1.2), ("Narrow", 0.9), ("Slender", 0.9)]

let pommelTypes: [(name: String, labourMultiplier: Double, weight: Double)] = [("Sphere", 1.2, 0.5), ("Cube", 1.0, 0.5), ("Fish-Tail", 1.4, 0.3), ("Disk", 1.01, 0.4), ("Shield-Shaped", 1.3, 0.4), ("Trefoil", 1.4, 0.6), ("Cresent", 1.1, 0.4), ("Pear-Shape", 1.1, 0.5), ("Misshapen Wheel", 1.0, 0.5), ("Boat-Shape", 1.2, 0.4), ("Cocked Hat", 1.25, 0.5), ("Lobed", 1.3, 0.5), ("Scent Stopper", 1.3, 0.5), ("Key-Shapped", 1.4, 1.0)]

let carvedAnimals = ["Eagle", "Dog", "Crow", "Horse", "Dragon", "Wolf", "Snake", "Boar", "Deer", "Moose", "Lion", "Panther", "Tiger", "Lynx", "Goat", "Owl", "Fox", "Puma", "Cougar", "Viper", "Cobra", "Lizard", "Weasel", "Rabbit", "Hare", "Bison", "Newt"]

let gripQualities: [(name: String, multiplier: Double, gripPercent: Int)] = [("Simple", 1.0, 25), ("Interwoven", 1.1, 30), ("Ornate", 1.5, 30), ("Elegant", 1.8, 20), ("Braided", 1.6, 30), ("Spiraled", 1.6, 30)]

let crossguardSizes: [(name: String, weightModifier: Double)] = [("Narrow", 0.9), ("Broad", 1.2), ("Thin", 0.9), ("Slender", 0.9), ("Wide", 1.1), ("Thick", 1.2)]

let crossguardShapes: [(name: String, labourMultiplier: Double)] = [("Straight", 1.0), ("Up-Curved", 1.1), ("Serpentine", 1.5), ("Crescentic", 1.2), ("Arched", 1.2), ("Elliptical", 1.3), ("Bowed", 1.2), ("Angled", 1.1), ("Tilted", 1.1), ("Beveled", 1.1), ("Bowtie", 1.3), ("Wavy", 1.4), ("Corkscrew", 1.3), ("Spiral", 1.3), ("Hooked", 1.2), ("Falcate", 1.2)]

let doubleEdgeBladeShapes: [(name: String, labourMultiplier: Double)] = [("Straight", 1.0), ("Straight", 1.0), ("Straight", 1.0), ("Straight", 1.0), ("Straight", 1.0), ("Curved", 1.1), ("Hooked", 1.2), ("Serpintine", 1.3), ("Leaf-Shape", 1.2), ("Recurved", 1.1)]

let doubleEdgeBladeSizes: [(name: String, labourMultiplier: Double, weightModifier: Double)] = [("Wide", 1.05, 1.4), ("Slender", 1.0, 0.9), ("Broad", 1.05, 1.4), ("Narrow", 1.0, 0.9), ("Typical", 1.0, 1.0)]

let fullerTypes: [(name: String, weightModifier: Double, valueMultiplier: Double)] = [("Deep", 0.8, 1.1), ("Double", 0.8, 1.2), ("Shallow", 0.9, 1.1), ("Half-length", 0.9, 1.1)]

let IntToString: [Int: String] = [0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine", 10: "Ten", 11: "Eleven", 12: "Twelve"]

let haftTypes: [(name: String, weightModifier: Double)] = [("Thin", 0.9), ("Slender", 0.9), ("Thick", 1.1), ("Light", 0.9), ("Heavy", 1.1)]

let maceTypes: [(name: String, value: Int, weightModifier: Double)] = [("Heavy", 1, 1.5), ("Light", 1, 0.8), ("Spiked", 1, 1.0), ("Oval", 1, 1.0), ("Round", 1, 1.0), ("Bladed", 1, 1.0)]

let bones: [(name: String, value: Int, gripPercent: Int)] = [("Whale Bone", 300, 70), ("Whale Ivory", 10000, 70), ("Walrus Ivory", 10000, 70), ("Elephant Ivory", 10000, 70), ("Mammoth Ivory", 100000, 70)]

let boneQualities: [(name: String, modifier: Double)] = [("Rough", 0.8), ("Smooth", 1.0), ("Lacquered", 1.5), ("Coarse", 0.8), ("Marred", 0.9), ("Gnarled", 0.9), ("Discolored", 0.9)]

let spearHeadSizes: [(name: String, labourMultiplier: Double, weightMultiplier: Double)] = [("Wide", 1.1, 1.2), ("Narrow", 1.0, 0.8), ("Slender", 1.0, 0.8), ("Broad", 1.1, 1.2), ("Heavy", 1.1, 1.3), ("Light", 1.0, 0.8)]

let wingTypes: [(name: String, labourMultiplier: Double)] = [("Curved", 1.1), ("Spiraled", 1.2), ("Curled", 1.2), ("Rounded", 1.1), ("Straight", 1.0)]

let wingSizes: [(name: String, labourMultiplier: Double, weightMultiplier: Double)] = [("Wide", 1.1, 1.2), ("Narrow", 1.0, 0.8), ("Slender", 1.0, 0.8), ("Broad", 1.1, 1.2), ("Long", 1.2, 1.1)]

