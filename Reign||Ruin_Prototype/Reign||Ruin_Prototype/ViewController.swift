//
//  ViewController.swift
//  Reign||Ruin_Prototype
//
//  Created by Joel Huggett on 2017-09-28.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit
import MetalKit

extension UIButton {
    func makeRounded(_ amount: CGFloat = 7) {
        self.layer.cornerRadius = amount
        self.clipsToBounds = true
    }
}

enum Colors {
    static let wenderlichGreen = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
}

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var genButton: UIButton!
    @IBOutlet weak var genMapButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var mView: MTKView!
    @IBOutlet weak var clearTextButton: UIButton!
    
    var metalView: MTKView {
        return mView 
    }
    var device: MTLDevice!
    var commandQueue: MTLCommandQueue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        metalView.device = MTLCreateSystemDefaultDevice()
        device = metalView.device
        
        metalView.clearColor = Colors.wenderlichGreen
        metalView.delegate = self
        
        commandQueue = device.makeCommandQueue()
        
        
        
        self.view.backgroundColor = UIColor.black
        genMapButton.makeRounded()
        genButton.makeRounded()
        clearButton.makeRounded()
        minusButton.makeRounded()
        plusButton.makeRounded()
        textView.layoutManager.allowsNonContiguousLayout = false
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func testButton() {
        let newChest = chest()
        textView.text = textView.text + "You open a chest...\n\nYou found:\n\n\(newChest.contentString)\nTotal Value:\n\n\(returnValueInPieces(newChest.totalValue))\n\n"
        let stringLength:Int = textView.text.characters.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
        print("done")
        
    }
    
    @IBAction func clearText() {
        textView.text = ""
    }
    @IBAction func genKing() {
        let crownn = crown()
        textView.text = textView.text + "\nGenerating...\n\nCrown:\n\n-> \(crownn.name)\n\nClothing:\n\n"
        let arm = clothing()
        textView.text = textView.text + "-> \(arm.name)\n\nCape:\n\n"
        let cap = cape()
        textView.text = textView.text + "-> \(cap.name)\n"
        
        let stringLength:Int = textView.text.characters.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }
    
    @IBAction func genOutfit() {
        
        textView.text = textView.text + "\nGenerating...\n\nWeapon:\n\n"
        
        let weap: item = returnRandomItem([sword(), shortAxe(), shortMace(), spear()])
        textView.text = textView.text + "-> \(weap.name)\n\nHelmet:\n\n"
        let helm = helmet()
        textView.text = textView.text + "-> \(helm.name)\n\nArmour:\n\n"
        let arm = armour()
        textView.text = textView.text + "-> \(arm.name)\n\nCape:\n\n"
        let capee = cape()
        textView.text = textView.text + "-> \(capee.name)\n\nShield:\n\n"
        let shieldd = shield()
        textView.text = textView.text + "-> \(shieldd.name)\n\n"
        let stringLength:Int = textView.text.characters.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
        
    }
    @IBAction func genAMap() {
        textView.text = textView.text + "\n\nGenerating Map...\nplease wait...\n\n"
        let foo = worldMap()
        foo.canvasSetup()
        foo.genContinent(100, 1)
        foo.genContinent(100, 1)
        foo.genContinent(100, 1)
        foo.fullMapScan()
        textView.text = textView.text + "\n\n\(foo.readable)\n\n"
        
        let stringLength:Int = textView.text.characters.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
    }
    @IBAction func plusFont() {
        textView.font = UIFont.init(name: textView.font!.fontName, size: textView.font!.pointSize + 1)
    }
    
    @IBAction func minusFont() {
        textView.font = UIFont.init(name: textView.font!.fontName, size: textView.font!.pointSize - 1)
    }
    
    @IBAction func genName() {
        textView.text = textView.text + "\n\(randName().readable) \(randName(syllNum: 3).readable)\n"
        let stringLength:Int = textView.text.characters.count
        textView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))
        print("done")
    }
    
}

extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable, let descriptor = view.currentRenderPassDescriptor else {return }
        let commandBuffer = commandQueue.makeCommandBuffer()
        
        let commandEncoder = commandBuffer!.makeRenderCommandEncoder(descriptor: descriptor)
        
        commandEncoder!.endEncoding()
        commandBuffer!.present(drawable)
        commandBuffer!.commit()
    }
}

