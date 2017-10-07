//
//  nameGen.swift
//  Duel
//
//  Created by Joel Huggett on 2017-10-05.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let allLetters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

let vowels = ["a", "e", "i", "o", "u"]

let consonants = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]

let letterConditions = ["a": ["a"], "b": ["b"], "c": [""], "d": [""], "e": [""], "f": [""], "g": [""], "h": [""], "i": [""], "j": [""], "k": [""], "l": [""], "m": [""], "n": [""], "o": [""], "p": [""], "q": [""], "r": [""], "s": [""], "t": [""], "u": [""], "v": [""], "w": [""], "x": [""], "y": [""], "z": [""]]


let nVowels = ["a", "e", "i", "o", "u", "y", "ah", "an", "on", "in", "ae", "ar", "or", "ir", "art", "ort", "oo", "ee", "an", "on", "in", "un", "et", "at", "it", "ug", "ack", "oth", "ath", "uth", "ith", "ow", "oe"]

let nConsonants = ["b", "c", "d", "f", "g", "h", "k", "l", "m", "n", "p", "r", "s", "t", "v", "ch", "th", "sh", "thr", "tr", "cr", "kr", "cl"]


var nSyllables: [[String]] {get {var sylls: [[String]] = [[]]; for con in nConsonants {for vowl in nVowels {sylls += [[con, vowl]]}}; return sylls.filter({$0 != ["sh", "it"] || $0 != ["sh", "art"] || $0 != ["f", "ack"]})}}

func uppercaseFirst(_ string: String)-> String {
    if string.count > 0 {return String(string.first!).capitalized + string.dropFirst()} else {return ""}
}

struct randName {
    var raw = [[String]]()
    var syllNum: Int
    init(syllNum: Int = 2) {
        for _ in 1...syllNum {
            self.raw += [returnRandomItem(nSyllables)]
        }
        self.syllNum = syllNum
    }
    var readable: String {get{var readable = ""; for i in self.raw {for t in i {readable += t}}; return uppercaseFirst(readable)}}
    func description() {
        print("\nName\n-------------")
        print("Possible Combinations: \((self.syllNum >= 7 ? "ERROR(exceeds Int.max)" : "\(Int(pow(Double(nSyllables.count), Double(self.syllNum))))"))")
        print(self.readable)
        print("Sylls: \(self.syllNum) | \(self.raw)")
    }
}

