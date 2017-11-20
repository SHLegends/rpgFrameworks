//
//  ViewController.swift
//  Duel
//
//  Created by Joel Huggett on 2017-11-14.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit


let symbolToColor: [String: UIColor] = ["O ": UIColor.white, "P ": UIColor.green, "E ": UIColor.red]

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func xyFromInt(number: Int, currentArena: arena)-> coor {
        
        let x = number % (currentArena.width)
        print(x)
        
        let y = (number - x) / (currentArena.height)

        return (x, y)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentArena.width * self.currentArena.height
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.arenaCellIdentifier, for: indexPath) as! ArenaCollectionViewCell
        
        
        let path: coor = xyFromInt(number: indexPath.row, currentArena: self.currentArena)
        
        print(indexPath.row)
        print(path)
        
        cell.backgroundColor = symbolToColor[currentArena.area[path.y]![path.x]!]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow = self.currentArena.width
        
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        
        return CGSize(width: size, height: size)
        
        
    }
    
    
    @IBOutlet weak var arenaCollectionView: UICollectionView!
    @IBOutlet weak var mapTextView: UITextView!
    
    @IBOutlet weak var textView: UITextView!
    
    var currentArena = arena(5, by: 5)
    var player = playerEntity(location: (4, 4))
    var enemy = enemyEntity(location: (0, 0))
    
    let arenaCellIdentifier = "arenaCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        arenaCollectionView.delegate = self
        arenaCollectionView.dataSource = self
        
        self.textView.text = ""
        
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
        self.mapTextView.text = ""
        
        self.arenaCollectionView.reloadData()
    }
    
    
    
    
    @IBAction func moveNorth(_ sender: Any) {
        self.player.moveSelf(direction: .north, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .north)
        renderArena()
    }
    @IBAction func moveSouth(_ sender: Any) {
        self.player.moveSelf(direction: .south, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .south)
        renderArena()
    }
    @IBAction func moveEast(_ sender: Any) {
        self.player.moveSelf(direction: .east, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .east)
        renderArena()
    }
    @IBAction func moveWest(_ sender: Any) {
        self.player.moveSelf(direction: .west, entities: [enemy], currentArena: self.currentArena)
        self.enemy.reaction(actionType: .moved, player: self.player, currentArena: self.currentArena, direction: .west)
        renderArena()
    }
    
}

extension UITextView {
    func addText(_ newText: String) {
        self.text = self.text + "\(newText)"
        
        let stringLength:Int = self.text.count
        self.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }
}

