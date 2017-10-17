//
//  ColorController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit



let colorSets: [(name: String, list: [UIColor])] = [("Grayscale", [UIColor.init(red: 1, green: 1, blue: 1, alpha: 1), UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1), UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1), UIColor.init(red: 0.7, green: 0.7, blue: 0.7, alpha: 1), UIColor.init(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1), UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)]), ("Classic", [UIColor.blue, UIColor.black, UIColor.white, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange, UIColor.purple]), ("Reds", [UIColor(red: 0.5098, green: 0, blue: 0.0588, alpha: 1.0), UIColor(red: 0.698, green: 0.0392, blue: 0.2588, alpha: 1.0), UIColor(red: 0.5294, green: 0.0314, blue: 0.2549, alpha: 1.0), UIColor(red: 0.8471, green: 0.051, blue: 0.1412, alpha: 1.0)])]

let Colors = colorSets[0].list

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

