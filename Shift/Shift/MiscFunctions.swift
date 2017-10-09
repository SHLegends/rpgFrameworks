//
//  MiscFunctions.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

func chance(of: Int, over: Int)-> Bool {
    return (of >= Int(arc4random_uniform(UInt32(over))) ? true : false)
}



