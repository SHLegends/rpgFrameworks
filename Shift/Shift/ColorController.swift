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







var currentScheme: colorScheme {get{return colorHandler.themeInUse}}


var themeColor: UIColor {get{return currentScheme.background}}

var Colors: [UIColor] {get{return currentScheme.bin}}

var colorIndices = randomizeColors(masterColors: Colors)

var foreground: UIColor {get{return currentScheme.foreground}}

func randColor(_ colors: [UIColor])-> UIColor? {
    if colors.isEmpty {
        //print("colors.isEmpty")
        return nil
    } else {
        //print(colors)
        //print("\(colors.count)")
        let foo = Int(arc4random_uniform(UInt32(colors.count)))
        //print(foo)
        return colors[foo]
    }
}

func getRandColorOther(than: Int, of: [Int])-> Int {
    return returnRandomItem(of.filter({$0 != than}))
}

