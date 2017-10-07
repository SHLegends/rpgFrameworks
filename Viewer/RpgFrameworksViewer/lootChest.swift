//
//  lootChest.swift
//  Reign||Ruin_Prototype
//
//  Created by Joel Huggett on 2017-09-28.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

func getRandomItem()-> item {
    var item2return: item
    switch returnRandNumInRange(1, 32) {
    case 1:
        item2return = wood()
    case 2:
        item2return = gemstone()
    case 3:
        item2return = leather()
    case 4:
        item2return = metal()
    case 5:
        item2return = bone()
    case 6:
        item2return = fabric()
    case 7:
        item2return = pommel()
    case 8:
        item2return = handle()
    case 9:
        item2return = crossguard()
    case 10:
        item2return = blade()
    case 11:
        item2return = longHandle()
    case 12:
        item2return = haft()
    case 13:
        item2return = axeHead()
    case 14:
        item2return = maceHead()
    case 15:
        item2return = spearHead()
    case 16:
        item2return = dagger()
    case 17:
        item2return = sword()
    case 18:
        item2return = longSword()
    case 19:
        item2return = shortAxe()
    case 20:
        item2return = longAxe()
    case 21:
        item2return = swordStaff()
    case 22:
        item2return = shortMace()
    case 23:
        item2return = longMace()
    case 24:
        item2return = spear()
    case 25:
        item2return = headdress()
    case 26:
        item2return = cape()
    case 27:
        item2return = clothing()
    case 28:
        item2return = crown()
    case 29:
        item2return = hood()
    case 30:
        item2return = shield()
    case 31:
        item2return = helmet()
    case 31:
        item2return = armour()
    case 32:
        item2return = knife()
    default:
        item2return = wood()
    }
    
    
    return item2return
}

struct chest {
    var material = wood()
    var contents = [item]()
    init() {
        for _ in 0...returnRandNumInRange(1, 8) {
            self.contents.append(getRandomItem())
        }
    }
    
    var contentString: String {get{var s2return = ""; for i in self.contents {s2return += "- \(i.name) [\(returnValueInPieces(i.value))]\n"}; return s2return}}
    var totalValue: Int {get{return self.contents.reduce(0, {$0 + $1.value})}}
}
