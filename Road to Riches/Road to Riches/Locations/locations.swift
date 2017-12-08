//
//  locations.swift
//  Road to Riches
//
//  Created by Joel Huggett on 2017-12-05.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

enum placeSize {
    case village
    case town
    case city
    
}


typealias coor = (x: Int, y: Int)
typealias placeType = (name: String, size: placeSize, location: coor)

let places: [placeType] = [

    ("Thrahdathkee", .village, (0, 0)),
    ("Narkrothfin", .village, (20, 20))
    
    
]

func shortestDistanceBetween(_ this: coor, and: coor)-> Int {
    
    var legOne = 0
    
    return 0
}


