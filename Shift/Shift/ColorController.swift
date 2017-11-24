//
//  ColorController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit

func randomizeColors(masterColors: [UIColor])-> [Int] {
    var colors = [Int]()
    for i in 0..<masterColors.count {
        colors.append(i)
    }
    var rColors = [Int]()
    for _ in colors {
        let newColor: Int = returnRandomItem(colors)
        rColors.append(newColor)
        colors = colors.filter({$0 != newColor})
    }
    return rColors
}




typealias colorScheme = (name: String, background: UIColor, foreground: UIColor, bin: [UIColor], price: Int)




enum colorBins {
    
    
    static let alpha: colorScheme = ("alpha", UIColor.black, UIColor.white, [UIColor.blue, UIColor.white, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange, UIColor.purple], 5000)
    
    static let betaWhite: colorScheme = ("beta white", UIColor.white, UIColor.black, [UIColor.blue, UIColor.red, UIColor.black, UIColor.green, UIColor.purple], 1000)
    
    static let betaBlack: colorScheme = ("beta black", UIColor.black, UIColor.white, [UIColor.blue, UIColor.red, UIColor.white, UIColor.green, UIColor.purple], 0)
    
    static let greyWhite: colorScheme = ("Grey White", UIColor.white, UIColor.black, [UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1), UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)], 5000)
    
    static let flat: colorScheme = ("Flat", UIColor.black, UIColor.init(red: 253/255, green: 227/255, blue: 167/255, alpha: 1), [UIColor.init(red: 235/255, green: 149/255, blue: 50/255, alpha: 1), UIColor.init(red: 247/255, green: 202/255, blue: 24/255, alpha: 1), UIColor.init(red: 63/255, green: 195/255, blue: 128/255, alpha: 1), UIColor.init(red: 27/255, green: 163/255, blue: 156/255, alpha: 1), UIColor.init(red: 148/255, green: 124/255, blue: 176/255, alpha: 1)], 10000)
    
    static let beta2Black: colorScheme = ("beta2 black", UIColor.black, UIColor.orange, [UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange], 6000)
    
    static let beta2White: colorScheme = ("beta2 white", UIColor.white, UIColor.orange, [UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange], 6000)
}

let colorSets: [colorScheme] = [colorBins.betaBlack, colorBins.betaWhite, colorBins.flat, colorBins.greyWhite, colorBins.beta2Black, colorBins.beta2White]




var currentScheme: colorScheme {get{return colorSets[DataManager.themeInUse]}}


var themeColor: UIColor {get{return currentScheme.background}}

var Colors: [UIColor] {get{return currentScheme.bin}}

var colorIndices = randomizeColors(masterColors: Colors)

var foreground: UIColor {get{return currentScheme.foreground}}

func randColor(_ colors: [UIColor])-> UIColor? {
    if colors.isEmpty {
        print("colors.isEmpty")
        return nil
    } else {
        print(colors)
        print("\(colors.count)")
        let foo = Int(arc4random_uniform(UInt32(colors.count)))
        print(foo)
        return colors[foo]
    }
}

func getRandColorOther(than: Int, of: [Int])-> Int {
    return returnRandomItem(of.filter({$0 != than}))
}

