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
    DispatchQueue(label: "ScanQueue", attributes: .concurrent).sync {
        for i in point.x-distance...point.x+distance {
            for t in point.y-distance...point.y+distance {
                coors += [(i, t)]
            }
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

func getDirection(point: inout coor, _ distance: Int, direction: String? = nil)-> coor {
    // choose a random direction and return the modified point
    switch (direction != nil ? direction! : returnRandomItem(["n", "e", "s", "w"])) {
    case "e":
        return coor((point.x+distance, point.y)) // east
    case "w":
        return coor((point.x-distance, point.y)) // west
    case "n":
        return coor((point.x, point.y+distance)) // north
    case "s":
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
    
    var landClass: (name: String, symbol: String) = ("water", "..") // type of land and its representive symbol
    
    var symbol: String {get{return self.landClass.symbol}} // pictoral representation of landClass (landClass.symbol)
    
    var lType: String {get{return self.landClass.name}} // type of land (landClass.name)
}


class worldMap {
    
    var landMasses = [String: landMass]() // array of all landMasses (continents, etc.)
    
    var gridSize: dimensions = (99, 99) // width and height of map
    
    var locations = [Int: [Int: location]]() // reference points for all coordinates (i.e. the map)
    
    var numOfCon: Int = 0 // stat for # of continents
//    init(_ gridSize: dimensions) {
//        self.gridSize = gridSize
//        // Generating blank canvas for the map
//        print("Creating Blank Map - \(gridSize)")
//        // TODO: thread for every y to speed it up
////        var localLocations = [Int: [Int: location]]()
////        for i in 0...self.gridSize.height {
////            let len = self.gridSize.width
////            DispatchQueue.global(qos: .background).async {
////                print("START")
////                var foo = [Int: location]()
////                for t in 0...len {
////                    print("WORKING #\(t)")
////                    foo[t] = location()
////                }
////                print("DONE")
////                localLocations[i] = foo
////
////            }
////
////        }
////        self.locations = localLocations
//
//        for i in 0...self.gridSize.height {self.locations[i] = [:]; for t in 0...self.gridSize.width {self.locations[i]![t] = location(); print("Blank Map - \(gridSize) {y: \(i), x: \(t)}")}}
//        print("Finished Blank Map")
//    }
    
    var readable: String {get{var readable = ""; for i in 0...self.gridSize.height {readable += "\n"; for t in 0...self.gridSize.width {readable += "\(self.locations[i]![t]!.symbol)"}}; return readable}} // pictoral representation of map
    
    func printOut() {
        for i in 0...self.gridSize.height {
            var m = ""
            for t in 0...self.gridSize.width {m += self.locations[i]![t]!.symbol}
            print(m)
        }
    }
    
     func canvasSetup(_ size: dimensions? = nil) {
        
        let startTime = NSDate.timeIntervalSinceReferenceDate
        if size != nil {self.gridSize = size!; self.gridSize.height -= 1; self.gridSize.width -= 1}
        let asyncQueue = DispatchQueue(label: "canvasQueue", attributes: .concurrent)
        
        
        asyncQueue.sync {
            for i in 0...self.gridSize.height {
                let len = self.gridSize.width
                
                var foo = [Int: location]()
                for t in 0...len {
                    foo[t] = location()
                }
                
                self.locations[i] = foo
            }
        }
        
        
//        for i in 0..<self.gridSize.height {
//            let len = self.gridSize.width
//            asyncQueue.async {
//                var foo = [Int: location]()
//                for t in 0..<len {
//                foo[t] = location()
//                }
//
//            self.locations[i] = foo
//
//            }
//
//
//        }
//
        print("height : \(self.locations.count) | width : \(self.locations[1]!.count)")
        print("Canvas Setup - DONE: \(NSDate.timeIntervalSinceReferenceDate - startTime)s")
            
            
        
        

    }
    
     func genContinent(_ cSize: Int, _ d: Int) {
        // add a landMass to worldMap
        // looking for point to place landmass
        let size = d + 7
        for p in 1...1000 {
            // get random coordinate (height - 10, width - 10)
            let randPoint: coor = (returnRandNumInRange(0, self.gridSize.width)-10, returnRandNumInRange(0, self.gridSize.height)-10)
            // scan around the point by a distance of parameter "size" checking if the scan is all "water"
            if scan(size, randPoint).filter({self.locations[$0.y] == nil || self.locations[$0.y]![$0.x] == nil || self.locations[$0.y]![$0.x]!.lType != "water"}).count > 0 {
                // scan failed ... try again
                //print("Scan Attempt #\(p)/1000")
//                if p == 10000 {
//                    print("---MAP IS FULL---")
//                }
                continue
            } else {
                // scan succeded, starting the drawing process
                
                var newLandMass = landMass() // generate a new landMass
                //print("<NEW CONTINENT> <\(newLandMass.name.readable)> START POINT: \(randPoint)")
                
                let startPoint = randPoint // landMass' starting point
                
                var point = startPoint // the pointer for where to draw (being set to startPoint)
                // draw land on point and add coors to newLandMass coors
                if self.locations[point.y]![point.x]!.landClass.name == "water" {newLandMass.coors.append(point)}
                self.locations[point.y]![point.x]!.landClass = ("land", "\(newLandMass.name.readable.first!) ")
                self.locations[point.y]![point.x]!.continentID = newLandMass.name
                // start drawing loop
                var x = 0
                var oldDirection: String? = nil
                for _ in 0...cSize {
                    if x == 10 {
                        self.locations[point.y]![point.x]!.landClass.symbol = "\u{001B}[0;31mX \u{001B}[0;32m"
//                        print("\u{001B}[2J")
                        print(self.readable)
                        x = 0
                    } else {
                        x += 1
                    }
                    
                    
                    // scan point by a distance of 5 looking for out of bounds or other landMasses
                    let sScan = scan(d+5, point).filter({$0.x < 0 || $0.x > self.gridSize.width || $0.y < 0 || $0.y > self.gridSize.height || self.locations[$0.y]![$0.x]!.continentID != nil && self.locations[$0.y]![$0.x]!.continentID!.readable != newLandMass.name.readable})
                    if sScan.count > 0 {
                        // scan has picked up an out of bounds or other landMass
                        //print("\(newLandMass.name.readable)-DRAW SCAN-OUT OF BOUNDS-LOG: last point: \(point) {MOVE #\(p)/\(cSize)};\nfailing points: \(sScan)")
                        // set point back to startpoint (i.e. a draw location reset)
                        point = startPoint
                        // loop again
                    } else {
                        // scan succeeded
                        
                        let direction = (oldDirection != nil ? returnRandomItem(["n", "e", "s", "w"].filter({$0 != oldDirection!})) : returnRandomItem(["n", "e", "s", "w"]))
                        oldDirection = direction
                        point = getDirection(point: &point, d, direction: direction) // move point in random direction by distance of 2
                        
                        let scanedPoint = scan(d, point) // scan around new point by distance of 1
                        //print("\(newLandMass.name.readable)-DRAW SUCCESS-POINTS: \(scanedPoint) {MOVE #\(p)/\(cSize)}")
                        // set scanned coordinates as land
                        for v in scanedPoint {if self.locations[v.y]![v.x]!.landClass.name == "water" {newLandMass.coors.append(v)}; self.locations[v.y]![v.x]!.landClass = ("land", "OO"); self.locations[v.y]![v.x]!.continentID = newLandMass.name}
                        // add random coordinated around the scan by distance of one (it causes the landMass to form in a more natural apperance)
                        for v in ring(d+1, point) {if returnRandomBool(1, 2) { if self.locations[v.y]![v.x]!.landClass.name == "water" {newLandMass.coors.append(v); self.locations[v.y]![v.x]!.landClass = ("land", "OO"); self.locations[v.y]![v.x]!.continentID = newLandMass.name}}}}
                }
                // add newLandMass to landMasses
                self.landMasses[newLandMass.name.readable] = newLandMass
                //print("|\(newLandMass.name.readable) - Complete|")
                // DONE
                break
            }
        }
    
        
    }
    
    
    func generatorBrancher(point: coor, ringSizes: Int) {
        
        
        var newLandMass = landMass()
        if self.locations[point.y]![point.x]!.landClass.name == "water" {newLandMass.coors.append(point)}
        self.locations[point.y]![point.x]!.landClass = ("land", "\(newLandMass.name.readable.first!) ")
        self.locations[point.y]![point.x]!.continentID = newLandMass.name
        let start = ring(ringSizes, point)
        for i in 0...returnRandNumInRange(2, 4) {
            
        }
        
    }
    
    func blah(point: coor, size: Int, newLandMass: landMass) {
        var getRing = ring(size, point)
        if getRing.filter({$0.x < 0 || $0.x > self.gridSize.width || $0.y < 0 || $0.y > self.gridSize.height || self.locations[$0.y]![$0.x]!.continentID != nil && self.locations[$0.y]![$0.x]!.continentID!.readable != newLandMass.name.readable}).count == 0 {
            getRing = getRing.filter({self.locations[$0.y]![$0.x]!.lType == "water"})
            for v in scan(size, point) {if self.locations[v.y]![v.x]!.landClass.name == "water" {self.landMasses[newLandMass.name.readable]!.coors.append(v)}; self.locations[v.y]![v.x]!.landClass = ("land", "OO"); self.locations[v.y]![v.x]!.continentID = newLandMass.name}
            
        }
    }
    
    
    
    func genFindPoint(searchSize: Int)-> coor? {
        var found: coor? = nil
        let startTime = NSDate.timeIntervalSinceReferenceDate
        while found == nil {
            let searchQueue = DispatchQueue(label: "serchQueue", attributes: .concurrent)
            searchQueue.sync {
                let newCoor = (returnRandNumInRange(0, self.gridSize.width)-10, returnRandNumInRange(0, self.gridSize.height)-10)
                if scan(searchSize, newCoor).filter({self.locations[$0.y] == nil || self.locations[$0.y]![$0.x] == nil || self.locations[$0.y]![$0.x]!.lType != "water"}).count == 0 {
                    found = newCoor
                }
            }
        }
        print("Search - DONE: \(NSDate.timeIntervalSinceReferenceDate - startTime)s \(found != nil ? "-SUCCEEDED-" : "-FAILED-")")
        if found != nil {return found!} else {return nil}
    }

    func experimentalGen(drawSize: Int, branches: Int, branchLength: Int, searchSize: Int) {
        let found = self.genFindPoint(searchSize: searchSize)
        if found != nil {generatorBrancher(point: found!, ringSizes: 1)} else {return}
    }
    
     func fullMapScan() {
//        let scanQueue = DispatchQueue(label: "fullMapScanQueue", attributes: .concurrent)
//        var localLocations = self.locations
//        for i in self.gridSize.height {
//            scanQueue.s
//        }
        
        
        // goes through every location in map for various uses
        for i in 0...self.gridSize.height {
            for t in 0...self.gridSize.width {
                //print("SCANNING - {y: \(i), x: \(t)}")
                if self.locations[i]![t]!.symbol == "OO" || self.locations[i]![t]!.symbol == "\u{001B}[0;31mX \u{001B}[0;32m" {
                    let smallScan = removeOutlyingCoors(coors: scan(1, (t, i)), mapSize: self.gridSize)
                    if smallScan.filter({self.locations[$0.y]![$0.x]!.lType == "water"}).count > 0 {
                        self.locations[i]![t]!.landClass.symbol = "ss"
                        self.landMasses[self.locations[i]![t]!.continentID!.readable]!.shoreCoors.append((t, i))
                    } else if removeOutlyingCoors(coors: ring(3, (t, i)), mapSize: self.gridSize).filter({self.locations[$0.y]![$0.x]!.lType == "water"}).count > 0 {
                        self.locations[i]![t]!.landClass.symbol = "cc"
                        self.landMasses[self.locations[i]![t]!.continentID!.readable]!.coastalCoors.append((t, i))
                    } else {
                        self.locations[i]![t]!.landClass.symbol = "LL"
                        self.landMasses[self.locations[i]![t]!.continentID!.readable]!.inlandCoors.append((t, i))
                    }
                }
            }
        }
    }
    
     func genMountains() {
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
    // generate a readable array for bitmap drawing
}




