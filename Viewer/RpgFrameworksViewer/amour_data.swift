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

let colours: [(name: String, value: Int, effect: (type: String, amount: Int))] = [("Black", 1, ("I", 2)), ("Blue", 20, ("N", 2)), ("Red", 50, ("I", 2)), ("Purple", 10000, ("N", 10)), ("White", 1, ("N", 5)), ("Brown", 1, ("I", 2)), ("Gold", 1000, ("N", 8)), ("Crimson", 250, ("I", 4)), ("Green", 1, ("N", 3))]

let capeSizes: [(name: String, valueModifier: Double, effect: Int)] = [("Short", 0.5, 1), ("Long", 1.5, 3), ("", 1.0, 2), ("", 1.0, 2), ("Rounded", 1.0, 2), ("Forked", 1.0, 3), ("Pointed", 1.0, 2)]

let capeLengths: [(name: String, valueModifier: Double, effect: Int)] = [("Wide", 1.2, 3), ("Slender", 0.8, 1), ("", 1.0, 2), ("Narrow", 0.6, 1)]

