//
//  opponentObjec.swift
//  Duel
//
//  Created by Joel Huggett on 2017-10-05.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

/*
 . . .   =   0 1 2   =   ne|n |nw
 . . .   =   3 4 5   =   e |c |w
 . . .   =   6 7 8   =   se|s |sw
 */

import Foundation

class opponent {
    
    
    var health = 1000
    var energy = 1000
    var oppActions = [Int]()
    var plrActions = [Int]()
    
    var fightPatterns = [[Int]]()
    var foundPatterns = [[Int]]()
    
    init() {
        
    }
    
}
