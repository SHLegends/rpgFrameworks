//
//  Fight.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit

func returnRandomItem<T>( _ list: [T])-> T {
    return list[Int(arc4random_uniform(UInt32(list.count)))]
}


class fightEvent {
    
    var delegate: EventDelegate?
    
    var textView: UITextView
    
    var combatants: [Combatant]
    
    var firstCombatant: Combatant
    var secondCobatant: Combatant
    
    var timer = Timer()
    
    var fightIndex = 0
    
    func nextIndex() {
        if fightIndex < combatants.count - 1 {
            fightIndex += 1
        } else if fightIndex == combatants.count - 1 {
            fightIndex = 0
        } else {
            fatalError("Fight Index Problem")
        }
    }
    
    func addLine(line: String) {
        if let text = self.textView.text {
            self.textView.text = "\(line)\n\(text)"
        } else {
            self.textView.text = "\(line)"
        }
        
//        let stringLength:Int = textView.text.count
//        textView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
        
    }
    
    
    init(textView: UITextView, combatants: [Combatant]) {
        self.textView = textView
        self.combatants = combatants
        
        if self.combatants.count == 2 {
            self.firstCombatant = combatants[0]
            self.secondCobatant = combatants[1]
        } else {
            fatalError("THE WORLD IS ABOUT TO END, THERE WASN'T ONLY TWO COMBATANTS")
        }
    }
    
    func start() {
        
        textView.text = ""
        
        fightLoop()
    }
    
    func endFight() {
        self.timer.invalidate()
        if combatants.filter({!$0.isDead}).count == 1 {
            addLine(line: "\(combatants.filter({!$0.isDead}).first!.name) won!")
        } else {
            addLine(line: "No one won...")
        }
        
        if let delegate = self.delegate {
            delegate.finished()
        }
    }
    
    @objc func fightLoop() {
        if combatants.filter({!$0.isDead}).count > 1 {
            let first = combatants[fightIndex]
            var second = findOpponent(oneAttacking: first)
            fightThing(between: first, and: &second)
            addLine(line: "\n")
            nextIndex()
            Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.fightLoop)), userInfo: nil, repeats: false)
        } else {
            endFight()
        }
        
        
    }
        
    func findOpponent(oneAttacking: Combatant)-> Combatant {
        return returnRandomItem(combatants.filter({$0.name != oneAttacking.name}))
        }
    
    func fightThing(between first: Combatant, and second: inout Combatant) {
        interaction(between: first, and: &second)
    }
    
    func interaction(between first: Combatant, and second: inout Combatant) {
        if let damage = tryAttack(guyAttacked: first, guyAttacking: second) {
            if tryDeffend(guyDeffending: second, guyAttacking: first) {
                addLine(line: "\(second.name.prefix(while: {$0 != " "})) BLOCKED a blow")
            } else {
                addLine(line: "\(first.name.prefix(while: {$0 != " "})) swung and HIT")
                second.hp -= damage
            }
        } else {
            addLine(line: "\(first.name.prefix(while: {$0 != " "})) swung and MISSED")
        }
    }
    
    func tryAttack(guyAttacked: Combatant, guyAttacking: Combatant)-> Int? {
        
        if returnRandomBool(1, 2) {
            return guyAttacking.weapon.damage
        } else {
          return nil
        }
        
    }
    
    func tryDeffend(guyDeffending: Combatant, guyAttacking: Combatant)-> Bool {
        if returnRandomBool(1, 4){
            return true
        } else {
            return false
        }
        
    }
    
}
