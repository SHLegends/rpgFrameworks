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
        return coor((point.x+distance, point.y)) // east
    case 2:
        return coor((point.x-distance, point.y)) // west
    case 3:
        return coor((point.x, point.y+distance)) // north
    case 4:
        return coor((point.x, point.y-distance)) // south
    default:
        return point
        
    }
}

func removeOutlyingCoors(coors: [coor], mapSize: dimensions)-> [coor] {
    // strip coors outlying mapSize
    var coorsToReturn = [coor]()
    for i in coors {if 0 <= i.x && i.x <= mapSize.width && 0 <= i.y && i.y <= mapSize.height {coorsToReturn.append(i)}}
    return coorsToReturn
}

struct landMass {
    // continents, islands, etc. (contains info pertaining to interacting with the landMass itself)
    var name: randName = getNewID()
    
    
    
    var coors = [coor]() // all of its coors
    
    var kmSize: Int {get{return self.coors.count}}
    
    var inlandCoors = [coor]() // all inland coors
    
    var shoreCoors = [coor]() // shoreline coors
    
    var coastalCoors = [coor]() // coastal coors
    
    var mountains = [coor]() // mountain coors
    
    
}


struct location {
    // points on worldMap (~60 km by ~60 km)
    
    var continentID: randName? // name of its landmass
    
    var landClass: (name: String, symbol: String) = ("water", ". ") // type of land and its representive symbol
    
    var symbol: String {get{return self.landClass.symbol}} // pictoral representation of landClass (landClass.symbol)
    
    var lType: String {get{return self.landClass.name}} // type of land (landClass.name)
}


struct worldMap {
    
    var landMasses = [String: landMass]() // array of all landMasses (continents, etc.)
    
    var gridSize: dimensions // width and height of map
    
    var locations = [Int: [Int: location]]() // reference points for all coordinates (i.e. the map)
    
    var numOfCon: Int = 0 // stat for # of continents
    init(_ gridSize: dimensions) {
        self.gridSize = gridSize
        // Generating blank canvas for the map
        print("Creating Blank Map - \(gridSize)")
        for i in 0...self.gridSize.height {self.locations[i] = [:]; for t in 0...self.gridSize.width {self.locations[i]![t] = location(); print("Blank Map - \(gridSize) {y: \(i), x: \(t)}")}}
        print("Finished Blank Map")
    }
    
    var readable: String {get{var readable = ""; for i in 0...self.gridSize.height {readable += "\n"; for t in 0...self.gridSize.width {readable += self.locations[i]![t]!.symbol}}; return readable}} // pictoral representation of map
    
    mutating func genContinent(_ cSize: Int, _ d: Int) {
        // add a landMass to worldMap
        // looking for point to place landmass
        let size = d + 7
        for p in 1...10000 {
            // get random coordinate (height - 10, width - 10)
            let randPoint: coor = (returnRandNumInRange(0, self.gridSize.width)-10, returnRandNumInRange(0, self.gridSize.height)-10)
            // scan around the point by a distance of parameter "size" checking if the scan is all "water"
            if scan(size, randPoint).filter({self.locations[$0.y] == nil || self.locations[$0.y]![$0.x] == nil || self.locations[$0.y]![$0.x]!.lType != "water"}).count > 0 {
                // scan failed ... try again
                print("Scan Attempt #\(p)/10000")
                continue
            } else {
                // scan succeded, starting the drawing process
                
                var newLandMass = landMass() // generate a new landMass
                print("<NEW CONTINENT> <\(newLandMass.name.readable)> START POINT: \(randPoint)")
                
                let startPoint = randPoint // landMass' starting point
                
                var point = startPoint // the pointer for where to draw (being set to startPoint)
                // draw land on point and add coors to newLandMass coors
                if self.locations[point.y]![point.x]!.landClass.name == "water" {newLandMass.coors.append(point)}
                self.locations[point.y]![point.x]!.landClass = ("land", "\(newLandMass.name.readable.first!) ")
                self.locations[point.y]![point.x]!.continentID = newLandMass.name
                // start drawing loop
                for p in 1...cSize {
                    // scan point by a distance of 5 looking for out of bounds or other landMasses
                    let sScan = scan(d+5, point).filter({$0.x < 0 || $0.x > self.gridSize.width || $0.y < 0 || $0.y > self.gridSize.height || self.locations[$0.y]![$0.x]!.continentID != nil && self.locations[$0.y]![$0.x]!.continentID!.readable != newLandMass.name.readable})
                    if sScan.count > 0 {
                        // scan has picked up an out of bounds or other landMass
                        print("\(newLandMass.name.readable)-DRAW SCAN-OUT OF BOUNDS-LOG: last point: \(point) {MOVE #\(p)/\(cSize)};\nfailing points: \(sScan)")
                        // set point back to startpoint (i.e. a draw location reset)
                        point = startPoint
                        // loop again
                    } else {
                        // scan succeeded
                        
                        point = getDirection(point: &point, d) // move point in random direction by distance of 2
                        
                        let scanedPoint = scan(d, point) // scan around new point by distance of 1
                        print("\(newLandMass.name.readable)-DRAW SUCCESS-POINTS: \(scanedPoint) {MOVE #\(p)/\(cSize)}")
                        // set scanned coordinates as land
                        for v in scanedPoint {if self.locations[v.y]![v.x]!.landClass.name == "water" {newLandMass.coors.append(v)}; self.locations[v.y]![v.x]!.landClass = ("land", "X "); self.locations[v.y]![v.x]!.continentID = newLandMass.name}
                        // add random coordinated around the scan by distance of one (it causes the landMass to form in a more natural apperance)
                        for v in ring(d+1, point) {if returnRandomBool(1, 2) { if self.locations[v.y]![v.x]!.landClass.name == "water" {newLandMass.coors.append(v); self.locations[v.y]![v.x]!.landClass = ("land", "X "); self.locations[v.y]![v.x]!.continentID = newLandMass.name}}}}
                }
                // add newLandMass to landMasses
                self.landMasses[newLandMass.name.readable] = newLandMass
                print("|\(newLandMass.name.readable) - Complete|")
                // DONE
                break
            }
        }
    }
    
    mutating func fullMapScan() {
        // goes through every location in map for various uses
        for i in 0...self.gridSize.height {
            for t in 0...self.gridSize.width {
                //print("SCANNING - {y: \(i), x: \(t)}")
                if self.locations[i]![t]!.symbol == "X " {
                    let smallScan = removeOutlyingCoors(coors: scan(1, (t, i)), mapSize: self.gridSize)
                    if smallScan.filter({self.locations[$0.y]![$0.x]!.lType == "water"}).count > 0 {
                        self.locations[i]![t]!.landClass.symbol = "S "
                        self.landMasses[self.locations[i]![t]!.continentID!.readable]!.shoreCoors.append((t, i))
                    } else if removeOutlyingCoors(coors: ring(3, (t, i)), mapSize: self.gridSize).filter({self.locations[$0.y]![$0.x]!.lType == "water"}).count > 0 {
                        self.locations[i]![t]!.landClass.symbol = "C "
                        self.landMasses[self.locations[i]![t]!.continentID!.readable]!.coastalCoors.append((t, i))
                    } else {
                        self.locations[i]![t]!.landClass.symbol = "L "
                        self.landMasses[self.locations[i]![t]!.continentID!.readable]!.inlandCoors.append((t, i))
                    }
                }
            }
        }
    }
    
    mutating func genMountains() {
        for (_, mass) in self.landMasses {
            if mass.inlandCoors.count > 100 {
                print()
            }
        }
    }
    
    func landMassDescription() {
        // print out info on all the landMasses
        print("LandMasses")
        for (_, mass) in self.landMasses {
            print("\(mass.name.readable): \(mass.kmSize) * 60 kilometers squared = \(mass.coors.count * 60) km squared")
            print("\(mass.name.readable): Shore: \(mass.shoreCoors.count) * 60 kilometers squared = \(mass.shoreCoors.count * 60) km squared")
            print("\(mass.name.readable): Coastal: \(mass.coastalCoors.count) * 60 kilometers squared = \(mass.coastalCoors.count * 60) km squared")
            print("\(mass.name.readable): Inland: \(mass.inlandCoors.count) * 60 kilometers squared = \(mass.inlandCoors.count * 60) km squared")
            print("\n")
        }
    }
}




