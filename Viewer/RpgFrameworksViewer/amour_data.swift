//
//  amour_data.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-28.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let symbols: [(name: String, effect: (type: String, amount: Int))] = [("a Wolf", ("I", 2)), ("a Tree", ("N", 1)), ("a Bear", ("I", 2)), ("the Moon", ("N", 1)), ("the Sun", ("N", 2)), ("a Sunrise", ("N", 2)), ("a Lion", ("N", 3)), ("a Dragon", ("N", 5)), ("a Crow", ("I", 2)), ("a Boar", ("I", 2)), ("a Panther", ("I", 2)), ("a Tiger",("I", 2)), ("a Goat", ("I", 1)), ("an Owl", ("N", 1)), ("a Fox", ("I", 1)), ("a Viper", ("I", 2)), ("a Cobra", ("I", 3)), ("a Lizard", ("I", 1)), ("a Weasel", ("I", 1)), ("a Rabbit", ("N", 1)), ("a Hare", ("N", 1)), ("a Bison", ("I", 1)), ("a Newt", ("N", 1))]

let pelts: [(name: String, value: Int, gripPercent: Int, effect: (type: String, amount: Int))] = [("Cow Hides", 50, 75, ("I", 1)), ("Goat Hides", 50, 75, ("I", 1)), ("Pig Skins", 50, 75, ("I", 1)), ("Wolf Pelts", 5000, 75, ("I", 5)), ("Fox Pelts", 10000, 75, ("N", 5)), ("Mink Pelts", 200000, 75, ("N", 9))]

let colours: [(name: String, value: Int, effect: (type: String, amount: Int))] = [("Black", 1, ("I", 2)), ("Blue", 20, ("N", 2)), ("Red", 50, ("I", 2)), ("Purple", 10000, ("N", 10)), ("White", 1, ("N", 5)), ("Brown", 1, ("I", 2)), ("Gold", 1000, ("N", 8)), ("Crimson", 250, ("I", 4)), ("Green", 1, ("N", 3)), ("Yellow", 1, ("N", 3)), ("Orange", 1, ("N", 1))]

let capeSizes: [(name: String, valueModifier: Double, effect: Int)] = [("Short", 0.5, 1), ("Long", 1.5, 3), ("", 1.0, 2), ("", 1.0, 2), ("Rounded", 1.0, 2), ("Forked", 1.0, 3), ("Pointed", 1.0, 2)]

let capeLengths: [(name: String, valueModifier: Double, effect: Int)] = [("Wide", 1.2, 3), ("Slender", 0.8, 1), ("", 1.0, 2), ("Narrow", 0.6, 1)]

let shieldTypes: [(name: String, valueModifier: Double, effect: Int)] = [("Kite Shield", 1.3, 3), ("Buckler", 0.6, 1), ("Heater Shield", 1.1, 2), ("Coffin Shield", 1.3, 4), ("Oval Shield", 1.0, 2)]

let armourTypes: [(name: String, valueModifier: Double, effect: Int)] = [("Splint Armour", 1.0, 3), ("Banded Armour", 1.0, 4), ("Laminar Armour", 1.1, 3), ("Lammelar Armour", 1.1, 3), ("Scale Armour", 1.0, 4), ("Plate Armour", 1.5, 7), ("Brigandine Armour", 1.1, 5), ("Ring Armour", 0.9, 2)]

let clothingStyles: [(name: String, valueModifier: Double, effect: (type: String, amount: Int))] = [("Elegant", 1.0, ("N", 4)), ("Elaborate", 1.0, ("N", 4)), ("Simple", 1.0, ("N", 1)), ("Plain", 1.0, ("N", 0)), ("Torn", 1.0, ("I", 1)), ("Fine", 1.0, ("N", 3)), ("Extravagant", 1.0, ("N", 8))]

let wSkulls: [(name: String, effect: Int)] = [("Human", 10), ("Wolf", 6), ("Lion", 8), ("Bull", 5), ("Ram", 5)]

let wHeads: [(name: String, effect: Int)] = [("Wolf", 6), ("Lion", 8), ("Bull", 5), ("Ram", 5), ("Fox", 4)]

let crownTypes: [(name: String, valueModifier: Double, effect: Int)] = [("Simple", 1.0, 1), ("Extravagant", 1.6, 10), ("Plain", 1.0, 1), ("Smooth", 1.1, 2), ("Broken", 0.8, 0), ("Ridged", 1.1, 2), ("Ornate", 1.3, 4), ("Elegant", 1.4, 5), ("Interwoven", 1.1, 3)]

let helmetTypes: [(name: String, valueModifier: Double, effect: (I: Int, N: Int))] = [("Great Helm", 1.8, (4, 4)), ("Enclosed Helm", 1.4, (4, 4)), ("Closed Helm", 1.2, (3, 3)), ("Horned Helmet", 1.6, (6, 2)), ("Winged Helmet", 1.6, (6, 4)), ("Armet Helmet", 1.2, (3, 3)), ("Barbute Helm", 1.2, (2, 4)), ("Bascinet Helmet", 1.3, (4, 2)), ("Burgonet Helmet", 1.3, (3, 4)), ("Sallet Helm", 1.8, (4, 4)), ("Frog-mouth Helm", 1.8, (4, 5)), ("Hounskull Helm", 1.3, (4, 2))]

