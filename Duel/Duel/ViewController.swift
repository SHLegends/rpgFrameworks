//
//  ViewController.swift
//  Duel
//
//  Created by Joel Huggett on 2017-11-14.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapTextView: UITextView!
    @IBOutlet weak var moveUp: UIButton!
    @IBOutlet weak var moveRight: UIButton!
    @IBOutlet weak var moveDown: UIButton!
    @IBOutlet weak var moveLeft: UIButton!
    @IBOutlet weak var attackBut: UIButton!
    @IBOutlet weak var dodgeBut: UIButton!
    @IBOutlet weak var parryBut: UIButton!
    @IBOutlet weak var blockBut: UIButton!
    @IBOutlet weak var counterBut: UIButton!
    
    @IBOutlet weak var textView: UITextView!
    
    var currentArena = arena(5, by: 5)
    var player = playerEntity(location: (4, 4))
    var enemy = enemyEntity(location: (2, 2))
    
    func moveState() {
        self.attackBut.isEnabled = false
        self.attackBut.isHidden = true
        
        self.parryBut.isEnabled = false
        self.parryBut.isHidden = true
        
        self.blockBut.isEnabled = false
        self.blockBut.isHidden = true
        
        self.dodgeBut.isEnabled = false
        self.dodgeBut.isHidden = true
        
        self.counterBut.isEnabled = false
        self.counterBut.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.textView.text = ""
        moveState()
        self.textView.addText("Welcome to Duel")
        
        self.currentArena.addItem(at: self.player.location, with: "P ")
        self.currentArena.addItem(at: self.enemy.location, with: "E ")
        
        self.mapTextView.text = self.currentArena.readable
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderArena() {
        self.currentArena.cleanArena()
        
        self.currentArena.addItem(at: self.player.location, with: "P ")
        self.currentArena.addItem(at: self.enemy.location, with: "E ")
        self.mapTextView.text = self.currentArena.readable
    }
    
    
        
    
    
    @IBAction func movedUp(_ sender: Any) {
        self.player.moveSelf(direction: .north, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .north)
        renderArena()
    }
    @IBAction func movedRight(_ sender: Any) {
        self.player.moveSelf(direction: .east, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .east)
        renderArena()
    }
    @IBAction func movedDown(_ sender: Any) {
        self.player.moveSelf(direction: .south, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .south)
        renderArena()
    }
    @IBAction func movedLeft(_ sender: Any) {
        self.player.moveSelf(direction: .west, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .west)
        renderArena()
    }
    
    @IBAction func attacked(_ sender: Any) {
    }
    
    @IBAction func dodged(_ sender: Any) {
    }
    @IBAction func parried(_ sender: Any) {
    }
    @IBAction func blocked(_ sender: Any) {
    }
    @IBAction func coutered(_ sender: Any) {
    }
    
}

extension UITextView {
    func addText(_ newText: String) {
        self.text = self.text + "\(newText)"
        
        let stringLength:Int = self.text.characters.count
        self.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }
}

