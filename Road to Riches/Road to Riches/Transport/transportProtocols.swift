//
//  transportProtocols.swift
//  Road to Riches
//
//  Created by Joel Huggett on 2017-12-05.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation



func returnRandomItem<T>( _ list: [T])-> T {
    return list[Int(arc4random_uniform(UInt32(list.count)))]
}

typealias vehicleType = (name: String, baseWeight: Double, load: Double)

let vehicles: [vehicleType] = [("Wagon", 10.0, 60.0)]

protocol vehicle {
    var baseType: vehicleType {get}
    var currentLoad: Double {get set}
}

extension vehicle {
    var weight: Double {
        get {
            return self.baseType.baseWeight + self.currentLoad
        }
    }
}

class loadbearingVehicle: vehicle {
    var baseType: vehicleType
    
    var currentLoad: Double = 0
    
    init(_ vType: vehicleType?) {
        if let vType = vType {
            self.baseType = vType
        } else {
            self.baseType = returnRandomItem(vehicles)
        }
    }
    
    
}
