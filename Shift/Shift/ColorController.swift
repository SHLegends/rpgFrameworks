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




typealias colorScheme = (name: String, background: UIColor, foreground: UIColor, bin: [UIColor])

let colorSets: [colorScheme] = [("alpha", UIColor.black, UIColor.white, [UIColor.blue, UIColor.white, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange, UIColor.purple]), ("beta white", UIColor.white, UIColor.black, [UIColor.blue, UIColor.red, UIColor.black, UIColor.green, UIColor.purple]), ("beta black", UIColor.black, UIColor.white, [UIColor.blue, UIColor.red, UIColor.white, UIColor.green, UIColor.purple])]



enum colorBins {
    
    
    static let alpha: colorScheme = ("alpha", UIColor.black, UIColor.white, [UIColor.blue, UIColor.white, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange, UIColor.purple])
    
    static let betaWhite: colorScheme = ("beta white", UIColor.white, UIColor.black, [UIColor.blue, UIColor.red, UIColor.black, UIColor.green, UIColor.purple])
    
    static let betaBlack: colorScheme = ("beta black", UIColor.black, UIColor.white, [UIColor.blue, UIColor.red, UIColor.white, UIColor.green, UIColor.purple])
}



var currentScheme: colorScheme = colorBins.betaBlack

var themeColor = currentScheme.background

var Colors = currentScheme.bin

var colorIndices = randomizeColors(masterColors: Colors)

var foreground = currentScheme.foreground

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

