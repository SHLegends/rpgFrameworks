//
//  MiscFunctions.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

typealias coor = (x: Int, y: Int)

func returnRandomBool(_ chance: Int, _ inNum: Int)-> Bool {
    return (Int(arc4random_uniform(UInt32(inNum))) + 1 <= chance ? true : false)
}

func returnRandomItem<T>( _ list: [T])-> T {
    return list[Int(arc4random_uniform(UInt32(list.count)))]
}

func returnRandNumInRange(_ start: Int, _ end: Int)-> Int {
    return Int(arc4random_uniform(UInt32(end + 1 - start))) + start
}

func ring(_ distance: Int, _ point: coor)-> [coor] {
    // return ring of coors from point by distance
    var coors = [coor]()
    for i in point.x-distance+1...point.x+distance-1 {
        coors += [(i, point.y+distance)]
    }
    for i in point.x-distance+1...point.x+distance-1 {
        coors += [(i, point.y-distance)]
    }
    for i in point.y-distance+1...point.y+distance-1 {
        coors += [(point.x-distance, i)]
    }
    for i in point.y-distance+1...point.y+distance-1 {
        coors += [(point.x+distance, i)]
    }
    return coors
}

func filterCoors(grid: (xMin: Int, xMax: Int, yMin: Int, yMax: Int), coors: [coor])-> [coor] {
    return coors.filter({$0.x >= grid.xMin && $0.x <= grid.xMax && $0.y <= grid.yMin && $0.y >= grid.yMax})
}
