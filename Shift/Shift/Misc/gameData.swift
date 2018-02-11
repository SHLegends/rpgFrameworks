//
//  gameData.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-22.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

var gameScore = 0

enum setState: Int {
    case unowned
    case owned
    case inUse
}


struct GameDataManager {
    let defaults = UserDefaults.standard
    
    var hintsOff: Bool {
        get {
            return defaults.bool(forKey: "hintsOff")
        }
        set {
            defaults.set(newValue, forKey: "hintsOff")
        }
    }
    
    var mute: Bool {
        get {
            print()
            return defaults.bool(forKey: "mute")
        }
        set {
            defaults.set(newValue, forKey: "mute")
        }
    }
    
    var tapticMute: Bool {
        get {
            return defaults.bool(forKey: "tactileMute")
        }
        set {
            defaults.set(newValue, forKey: "tactileMute")
        }
    }
    
    
    var setsData: [Int] {
        get {
            if defaults.array(forKey: "setsData") == nil {
                var statesOfSets: [Int] = []
                for i in 0..<colorSets.count {
                    if colorSets[i].price == 0 {
                        statesOfSets.append(1)
                    } else {
                        statesOfSets.append(0)
                    }
                }
                statesOfSets[0] = 2
                defaults.set(statesOfSets, forKey: "setsData")
            } else if colorSets.count != (defaults.array(forKey: "setsData") as! [Int]).count {
                var statesOfSets: [Int] = []
                let savedSetInfo = defaults.array(forKey: "setsData") as! [Int]
                for i in 0..<colorSets.count {
                    if i+1 < colorSets.count {
                        statesOfSets.append(savedSetInfo[i])
                    } else if colorSets[i].price == 0 {
                        statesOfSets.append(1)
                    } else {
                        statesOfSets.append(0)
                    }
                }
                defaults.set(statesOfSets, forKey: "setsData")
            }
            return defaults.array(forKey: "setsData") as! [Int]
        }
        set {
            defaults.set(newValue, forKey: "setsData")
        }
    }
    
    var stateOfSets: [setState] {
        get {
            var sets: [setState] = []
            for i in 0..<self.setsData.count {
                sets.append(setState.init(rawValue: self.setsData[i])!)
            }
            return sets
        }
    }
    
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
            for i in 0..<self.setsData.count {
                switch self.stateOfSets[i] {
                case .inUse:
                    return i
                case .owned, .unowned:
                    continue
                }
            }
            return 0
        }
        set {
            var oldArray = self.setsData
            oldArray[self.themeInUse] = 1
            oldArray[newValue] = 2
            defaults.set(oldArray, forKey: "setsData")
        }
    }
    
    mutating func setOwned(of: Int) {
        var oldArray = self.setsData
        let state: Int = oldArray[of]
        if state == 0 {
            oldArray[of] = 1
            self.setsData = oldArray
        }
        
    }
    
    
}

var DataManager =  GameDataManager()

