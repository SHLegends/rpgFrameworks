//
//  ColorController.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit

let Colors = [UIColor.blue, UIColor.black, UIColor.white, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange, UIColor.purple]

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

