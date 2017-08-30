//
//  ItemGen_Functions.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

func returnRandomItem<T>( _ list: [T])-> T {
    return list[Int(arc4random_uniform(UInt32(list.count)))]
}

func returnRandomBool(_ chance: Int, _ inNum: Int)-> Bool {
    return (Int(arc4random_uniform(UInt32(inNum))) + 1 <= chance ? true : false)
}

func returnLength(_ inchs: Int) -> String {
    if inchs < 12 { return "\(inchs)\"" } else { let numOfFeet = Int(inchs / 12); return "\(numOfFeet)\'\(inchs != numOfFeet * 12 ? " \(inchs - numOfFeet * 12)\"" : "")" }
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

func returnRandNumInRange(_ start: Int, _ end: Int)-> Int {
    return Int(arc4random_uniform(UInt32(end + 1 - start))) + start
}

func returnListToString(_ strings: [String])-> String {
    return strings.dropLast().joined(separator: ", ") + (strings.count == 1 ? "\(strings.last!)" : ", and \(strings.last!)")
}

func combineTwoStrings(_ strings: [String])-> String {
    if strings[0] != "" && strings[1] != "" { return "\(strings[0]) and \(strings[1])" } else if strings[0] != "" && strings[1] == "" { return strings[0] } else if strings[0] == "" && strings[1] != "" { return strings[1] } else { return "" }
}
