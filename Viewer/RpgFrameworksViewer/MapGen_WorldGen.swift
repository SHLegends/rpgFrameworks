//
//  MapGen_WorldGen.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-09-04.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

// earth's diameter is ~12000 km
// therefore 12000 / 200 = 60
// thus each location is 60 km by 60 km

import Foundation

typealias dimensions = (height: Int, width: Int)
typealias coor = (x: Int, y: Int)

func scan(_ distance: Int, _ point: coor)-> [coor] {
    // return all coors around point by distance
    var coors = [coor]()
    for i in point.x-distance...point.x+distance {
        for t in point.y-distance...point.y+distance {
            coors += [(i, t)]
        }
    }
    return coors
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

// array of randName for checking if randName is unique
var cIDs = [randName]()


func getNewID()-> randName {
    // get a new randName that is unique
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
    // choose a random direction and return the modified point
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

struct landMass {
    // continents, islands, etc. (contains info pertaining to interacting with the landMass itself)
    var name: randName = getNewID()
    var coors = [coor]()
    
}


struct location {
    // points on worldMap (~60 km by ~60 km)
    // continentID - name of its landmass
    var continentID: randName?
    // landClass - type of land and its representive symbol
    var landClass: (name: String, symbol: String) = ("water", ". ")
    // symbol - pictoral representation of landClass (landClass.symbol)
    var symbol: String {get{return self.landClass.symbol}}
    // lType - type of land (landClass.name)
    var lType: String {get{return self.landClass.name}}
}


struct worldMap {
    // landMasses - array of all landMasses (continents, etc.)
    var landMasses = [landMass]()
    // gridSize - width and height of map
    var gridSize: dimensions
    // locations - reference points for all coordinates (i.e. the map)
    var locations = [Int: [Int: location]]()
    // numOfCon - stat for # of continents
    var numOfCon: Int = 0
    init(gridSize: dimensions) {
        self.gridSize = gridSize
        // Generating blank canvas for the map
        print("Creating Blank Map - \(gridSize)")
        for i in 0...self.gridSize.height {self.locations[i] = [:]; for t in 0...self.gridSize.width {self.locations[i]![t] = location(); print("Blank Map - \(gridSize) {y: \(i), x: \(t)}")}}
        print("Finished Blank Map")
    }
    // readable - pictoral representation of map
    var readable: String {get{var readable = ""; for i in 0...self.gridSize.height {readable += "\n"; for t in 0...self.gridSize.width {readable += self.locations[i]![t]!.symbol}}; return readable}}
    
    mutating func genContinent(_ cSize: Int, _ size: Int) {
        // add a landMass to worldMap
        // looking for point to place landmass
        for p in 1...50 {
            // get random coordinate (height - 10, width - 10)
            let randPoint: coor = (returnRandNumInRange(0, self.gridSize.width)-10, returnRandNumInRange(0, self.gridSize.height)-10)
            // scan around the point by a distance of parameter "size" checking if the scan is all "water"
            if scan(size, randPoint).filter({self.locations[$0.y] == nil || self.locations[$0.y]![$0.x] == nil || self.locations[$0.y]![$0.x]!.lType != "water"}).count > 0 {
                // scan failed ... try again
                print("Scan Attempt #\(p)/50")
                continue
            } else {
                // scan succeded, starting the drawing process
                // newLandMass - generate a new landMass
                var newLandMass = landMass()
                print("<NEW CONTINENT> <\(newLandMass.name.readable)> START POINT: \(randPoint)")
                // startPoint - landMass' starting point
                let startPoint = randPoint
                // point - the pointer for where to draw (being set to startPoint)
                var point = startPoint
                // draw land on point and add coors to newLandMass coors
                if self.locations[point.y]![point.x]!.landClass.name == "water" {newLandMass.coors.append(point)}
                self.locations[point.y]![point.x]!.landClass = ("land", "\(newLandMass.name.readable.first!) ")
                self.locations[point.y]![point.x]!.continentID = newLandMass.name
                // start drawing loop
                for p in 1...cSize {
                    // scan point by a distance of 5 looking for out of bounds or other landMasses
                    let sScan = scan(5, point).filter({$0.x < 0 || $0.x > self.gridSize.width || $0.y < 0 || $0.y > self.gridSize.height || self.locations[$0.y]![$0.x]!.continentID != nil && self.locations[$0.y]![$0.x]!.continentID!.readable != newLandMass.name.readable})
                    if sScan.count > 0 {
                        // scan has picked up an out of bounds or other landMass
                        print("\(newLandMass.name.readable)-DRAW SCAN-OUT OF BOUNDS-LOG: last point: \(point) {MOVE #\(p)/\(cSize)};\nfailing points: \(sScan)")
                        // set point back to startpoint (i.e. a draw location reset)
                        point = startPoint
                        // loop again
                    } else {
                        // scan succeeded
                        // move point in random direction by distance of 2
                        point = getDirection(point: &point, 2)
                        // scanedPoint - scan around new point by distance of 1
                        let scanedPoint = scan(1, point)
                        print("\(newLandMass.name.readable)-DRAW SUCCESS-POINTS: \(scanedPoint) {MOVE #\(p)/\(cSize)}")
                        // set scanned coordinates as land
                        for v in scanedPoint {if self.locations[v.y]![v.x]!.landClass.name == "water" {newLandMass.coors.append(v)}; self.locations[v.y]![v.x]!.landClass = ("land", "L "); self.locations[v.y]![v.x]!.continentID = newLandMass.name}
                        // add random coordinated around the scan by distance of one (it causes the landMass to form in a more natural apperance)
                        for v in ring(2, point) {if self.locations[v.y]![v.x]!.landClass.name == "water" {newLandMass.coors.append(v)};if returnRandomBool(1, 2) { self.locations[v.y]![v.x]!.landClass = ("land", "L "); self.locations[v.y]![v.x]!.continentID = newLandMass.name}}}
                }
                // add newLandMass to landMasses
                self.landMasses.append(newLandMass)
                print("|\(newLandMass.name.readable) - Complete|")
                // DONE
                break
            }
        }
    }
    
    func fullMapScan() {
        // goes through every location in map for various uses
        for i in 0...self.gridSize.height {
            for t in 0...self.gridSize.width {
                // for later use
            }
        }
    }
    
    func landMassDescription() {
        // print out info on all the landMasses
        print("LandMasses")
        for i in self.landMasses {
            print("\(i.name.readable): \(i.coors.count) * 60 kilometers squared = \(i.coors.count * 60) km squared")
        }
    }
}




