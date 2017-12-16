//
//  contestantList.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

class contestantList {
    var contestants: [contestent]
    
    init(contestants: [contestent]) {
        self.contestants = contestants
    }
}

var contestants = contestantList.init(contestants: [contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle()), contestent.init(hp: 20, weapon: weaponItem.init(damage: 2), name: getNameWithTitle())])
