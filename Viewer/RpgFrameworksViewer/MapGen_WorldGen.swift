//
//  MapGen_WorldGen.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-09-04.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

typealias dimensions = (height: Int, width: Int)
typealias coor = (x: Int, y: Int)

func scan(_ distance: Int, _ point: coor)-> [coor] {
    var coors = [coor]()
    for i in point.x-distance...point.x+distance {
        for t in point.y-distance...point.y+distance {
            coors += [(i, t)]
        }
    }
    return coors
}

func ring(_ distance: Int, _ point: coor)-> [coor] {
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

var cIDs = [randName]()


func getNewID()-> randName {
    while true {
        let cName = randName(syllNum: 3)
        if cIDs.filter({$0.readable == cName.readable}).count > 0 {
            continue
        } else {
            cIDs.append(cName)
            return cName
        }
    }
}

func getDirection(point: inout coor, _ distance: Int)-> coor {
    switch returnRandNumInRange(1, 4) {
    case 1:
        return coor((point.x+distance, point.y))
    case 2:
        return coor((point.x-distance, point.y))
    case 3:
        return coor((point.x, point.y+distance))
    case 4:
        return coor((point.x, point.y-distance))
    default:
        return point
        
    }
}


struct location {
    var continentID: randName?
    var landClass: (name: String, symbol: String) = ("water", ". ")
    var symbol: String {get{return self.landClass.symbol}}
    var lType: String {get{return self.landClass.name}}
}

struct sector {
    var gridSize: dimensions
    var locations = [Int: [Int: location]]()
    var owner: String? = nil
    var numOfCon: Int = 0
    var numOfIsl: Int = 0
    
    init(gridSize: dimensions) {
    
        self.gridSize = gridSize
        for i in 0...self.gridSize.height {self.locations[i] = [:]; for t in 0...self.gridSize.width {self.locations[i]![t] = location()}}
    }
    var readable: String {get{var readable = ""; for i in 0...self.gridSize.height {readable += "\n"; for t in 0...self.gridSize.width {readable += self.locations[i]![t]!.symbol}}; return readable}}
    
    mutating func genContinent(_ cSize: Int, _ size: Int) {
        for p in 1...25 {
            let randPoint: coor = (returnRandNumInRange(0, self.gridSize.width)-10, returnRandNumInRange(0, self.gridSize.height)-10)
            if scan(size, randPoint).filter({self.locations[$0.y] == nil || self.locations[$0.y]![$0.x] == nil || self.locations[$0.y]![$0.x]!.lType != "water"}).count > 0 {
                print("Scan Attempt #\(p)/25")
                continue
            } else {
                let cID = getNewID()
                print("<NEW CONTINENT> <\(cID.readable)> START POINT: \(randPoint)")
                let startPoint = randPoint
                var point = startPoint
                self.locations[point.y]![point.x]!.landClass = ("land", "\(cID.readable.first!) ")
                self.locations[point.y]![point.x]!.continentID = cID

                for p in 1...cSize {
                    let sScan = scan(5, point).filter({$0.x < 0 || $0.x > self.gridSize.width || $0.y < 0 || $0.y > self.gridSize.height || self.locations[$0.y]![$0.x]!.continentID != nil && self.locations[$0.y]![$0.x]!.continentID!.readable != cID.readable})
                    if sScan.count > 0 {
                        print("\(cID.readable)-DRAW SCAN-OUT OF BOUNDS-LOG: last point: \(point) {MOVE #\(p)/\(cSize)};\nfailing points: \(sScan)")
                        point = startPoint
                    } else {
                        point = getDirection(point: &point, 2)
                        let scanedPoint = scan(1, point)
                        print("\(cID.readable)-DRAW SUCCESS-POINTS: \(scanedPoint) {MOVE #\(p)/\(cSize)}")
                        scanedPoint.map({self.locations[$0.y]![$0.x]!.landClass = ("land", "\(cID.readable.first!) "); self.locations[$0.y]![$0.x]!.continentID = cID})
                        ring(2, point).map({if returnRandomBool(1, 2) { self.locations[$0.y]![$0.x]!.landClass = ("land", "\(cID.readable.first!) "); self.locations[$0.y]![$0.x]!.continentID = cID}})
                        
                    }
                }
                print("|\(cID.readable) - Complete|")
                break
            }
        }
    }
}


struct worldMap {
    var gridSize: dimensions
    var sectors: [Int: [Int: sector]]
    
    
}


