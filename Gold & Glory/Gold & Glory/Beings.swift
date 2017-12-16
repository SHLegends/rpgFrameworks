//
//  Beings.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let titles: [String] = ["Knight", "Warrior", "Coward", "Unaware", "Clueless"]

func getNameWithTitle()-> String {
    let name = randName.init(syllNum: returnRandomItem([1, 2, 3])).readable
    return "\(name) the \(returnRandomItem(titles))"
}

func returnRandomBool(_ chance: Int, _ inNum: Int)-> Bool {
    return (Int(arc4random_uniform(UInt32(inNum))) + 1 <= chance ? true : false)
}

protocol Being {
    var name: String {get set}
    var hp: Int {get set}
}

extension Being {
    var isDead: Bool {
        get {
            if self.hp == 0 {
                return true
            } else {
                return false
            }
        }
    }
}

class weaponItem {
    var damage: Int
    
    init(damage: Int) {
        self.damage = damage
    }
}

protocol Combatant: Being {
    
    var weapon: weaponItem {get set}
}

class contestent: Combatant {
    var name: String
    
    var weapon: weaponItem
    
    var hp: Int {
        didSet {
            if hp < 0 {
                hp = 0
            }
        }
    }
    
    
    
    init(hp: Int, weapon: weaponItem, name: String) {
        self.hp = hp
        self.weapon = weapon
        self.name = name
    }
    
}
