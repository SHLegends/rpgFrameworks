//
//  Classes.swift
//  Duel
//
//  Created by Joel Huggett on 2017-11-14.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

typealias coor = (x: Int, y: Int)

enum damageState {
    case undamaged
    case scratched
    case slashed
    case chopped
    case stabbed
}

typealias DamagablePoints = (head: damageState, chest: damageState)

func returnRandomItem<T>( _ list: [T])-> T {
    return list[Int(arc4random_uniform(UInt32(list.count)))]
}

func returnRandomBool(_ chance: Int, _ inNum: Int)-> Bool {
    return (Int(arc4random_uniform(UInt32(inNum))) + 1 <= chance ? true : false)
}

func returnRandNumInRange(_ start: Int, _ end: Int)-> Int {
    return Int(arc4random_uniform(UInt32(end + 1 - start))) + start
}
enum directions {
    case north
    case south
    case east
    case west
}

enum actions {
    case moved
    case failedMove
    
}

protocol entity: class {
    var name: String {get set}
    var hp: Int {get set}
    var weapEquiped: weapon {get set}
    var isAlive: Bool {get set}
    var location: coor {get set}
    
    var health: DamagablePoints {get set}
    
}

extension entity {
     func isDamaged(by: Int) {
        self.hp -= by
    }
    
    @discardableResult
    func moveSelf(direction: directions, entities: [entity], currentArena: arena)-> actions {
        switch direction {
        case .north:
            let newCoor = (self.location.x, self.location.y - 1)
            if self.location.y - 1 >= 0 && (entities.filter({$0.location == newCoor}).count == 0 ? true : false) {
                self.location = newCoor
                return actions.moved
            } else {
                return actions.failedMove
            }
        case .south:
            let newCoor = (self.location.x, self.location.y + 1)
            if self.location.y + 1 < currentArena.height && (entities.filter({$0.location == newCoor}).count == 0 ? true : false) {
                self.location = newCoor
                return actions.moved
            } else {
                return actions.failedMove
            }
        case .east:
            let newCoor = (self.location.x + 1, self.location.y)
            if self.location.x + 1 < currentArena.width && (entities.filter({$0.location == newCoor}).count == 0 ? true : false) {
                self.location = newCoor
                return actions.moved
            } else {
                return actions.failedMove
            }
        case .west:
            let newCoor = (self.location.x - 1, self.location.y)
            if self.location.x - 1 >= 0 && (entities.filter({$0.location == newCoor}).count == 0 ? true : false) {
                self.location = newCoor
                return actions.moved
            } else {
                return actions.failedMove
            }
        }
        
        
    }
    
    
    
    func attack()-> Int {
        
        
        
        
        return 0
    }
}

protocol weapon {
    var name: String {get set}
    var weight: Double {get set}
    var length: Double {get set}
    
    
}

struct sword: weapon {
    var name = "Sword"
    var weight = 4.0
    var length = 36.0
    
    init() {
        
    }
}

class playerEntity: entity {
    var health: DamagablePoints = (.undamaged, .undamaged)
    var location: coor
    var isAlive: Bool = true
    var name = "genaric"
    var hp = 20
    var weapEquiped: weapon = sword()
    
    
    
    init(location: coor) {
        self.location = location
    }
    
    
}


class enemyEntity: entity {
    var health: DamagablePoints = (.undamaged, .undamaged)
    var isAlive: Bool = true
    var location: coor
    var energy = 1000
    var name = "genaric"
    var hp = 20
    var weapEquiped: weapon = sword()
    
    init(location: coor) {
        self.location = location
        
    }
    
    func flee(_ thingToFollow: entity, currentArena: arena, entities: [entity]) {
        let locationDifference: coor = (self.location.x - thingToFollow.location.x, self.location.y - thingToFollow.location.y)
        print(locationDifference)
        let directionType = returnRandomBool(1, 2)
        if directionType {
            if locationDifference.y < 0 {
                self.moveSelf(direction: .north, entities: entities, currentArena: currentArena)
            } else if locationDifference.y > 0 {
                self.moveSelf(direction: .south, entities: entities, currentArena: currentArena)
            } else if locationDifference.y == 0 {
                if locationDifference.x < 0 {
                    self.moveSelf(direction: .west, entities: entities, currentArena: currentArena)
                } else if locationDifference.x > 0 {
                    self.moveSelf(direction: .east, entities: entities, currentArena: currentArena)
                } else {
                    return
                }
            } else {
                return
            }
        } else {
            if locationDifference.x < 0 {
                self.moveSelf(direction: .west, entities: entities, currentArena: currentArena)
            } else if locationDifference.x > 0 {
                self.moveSelf(direction: .east, entities: entities, currentArena: currentArena)
            } else if locationDifference.x == 0 {
                if locationDifference.y < 0 {
                    self.moveSelf(direction: .north, entities: entities, currentArena: currentArena)
                } else if locationDifference.y > 0 {
                    self.moveSelf(direction: .south, entities: entities, currentArena: currentArena)
                } else {
                    return
                }
            } else {
                return
            }
        }
        
    }
    
    func follow(_ thingToFollow: entity, currentArena: arena, entities: [entity]) {
        let locationDifference: coor = (self.location.x - thingToFollow.location.x, self.location.y - thingToFollow.location.y)
        print(locationDifference)
        let directionType = returnRandomBool(1, 2)
        if directionType {
            if locationDifference.y < 0 {
                self.moveSelf(direction: .south, entities: entities, currentArena: currentArena)
            } else if locationDifference.y > 0 {
                self.moveSelf(direction: .north, entities: entities, currentArena: currentArena)
            } else if locationDifference.y == 0 {
                if locationDifference.x < 0 {
                    self.moveSelf(direction: .east, entities: entities, currentArena: currentArena)
                } else if locationDifference.x > 0 {
                    self.moveSelf(direction: .west, entities: entities, currentArena: currentArena)
                } else {
                    return
                }
            } else {
                return
            }
        } else {
            if locationDifference.x < 0 {
                self.moveSelf(direction: .east, entities: entities, currentArena: currentArena)
            } else if locationDifference.x > 0 {
                self.moveSelf(direction: .west, entities: entities, currentArena: currentArena)
            } else if locationDifference.x == 0 {
                if locationDifference.y < 0 {
                    self.moveSelf(direction: .south, entities: entities, currentArena: currentArena)
                } else if locationDifference.y > 0 {
                    self.moveSelf(direction: .north, entities: entities, currentArena: currentArena)
                } else {
                    return
                }
            } else {
                return
            }
        }
        
    }
    
    func reaction(actionType: actions, player: playerEntity, currentArena: arena, direction: directions?) {
        switch actionType {
        case .moved, .failedMove:
            // follow player
            if true {
                follow(player, currentArena: currentArena, entities: [player])
                
            }
            
        }
    }
    
    
    
}

class arena {
    var area = [Int: [Int: String]]()
    
    var width: Int
    var height: Int
    
    var baseSymbol = "O "
    
    init(_ width: Int, by height: Int) {
        self.width = width
        self.height = height
        
        for i in 0..<height {
            self.area[i] = [Int: String]()
            for t in 0..<width {
                self.area[i]![t] = self.baseSymbol
            }
        }
    }
    
    var readable: String {get{var readable = ""; for i in 0..<self.height {for t in 0..<self.width {readable += self.area[i]![t]!}; readable += "\n"}; return readable}}
    
    func moveItem(from: coor, to: coor, with: String) {
        self.area[from.y]![from.x] = self.baseSymbol
        self.area[to.y]![to.x] = with
        
    }
    
    func addItem(at: coor, with: String) {
        self.area[at.y]![at.x] = with
    }
    
    func cleanArena() {
        for i in 0..<height {
            self.area[i] = [Int: String]()
            for t in 0..<width {
                self.area[i]![t] = self.baseSymbol
            }
        }
    }
    
}
