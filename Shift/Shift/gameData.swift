//
//  gameData.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-22.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

var gameScore = 0




struct GameDataManager {
    let defaults = UserDefaults.standard
    
    var highScore: Int {
        get {
            return defaults.integer(forKey: "highScore")
        }
        set {
            defaults.set(newValue, forKey: "highScore")
        }
    }
    
    var totalCredits: Int {
        get {
            return defaults.integer(forKey: "totalCredits")
        }
        set {
            defaults.set(newValue, forKey: "totalCredits")
        }
    }
    
    var themeInUse: Int {
        get {
            return defaults.integer(forKey: "themeInUse")
        }
        set {
            defaults.set(newValue, forKey: "themeInUse")
        }
    }
}

var DataManager =  GameDataManager()
