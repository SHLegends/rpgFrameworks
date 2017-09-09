//
//  titleGen.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-09-04.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

struct randTitle {
    var effect: String
    var start: String
    var joiner: String
    var end: String
    
    init(effect: String = returnRandomItem(["N", "I", "NI", "IN"])) {
        self.effect = effect
        self.joiner = returnRandomItem(["of", "of the"])
        switch self.effect {
        case "N":
            self.start = returnRandomItem(nTitleStart)
            self.end = returnRandomItem(nTitleEnd[self.joiner]!)
        case "I":
            self.start = returnRandomItem(iTitleStart)
            self.end = returnRandomItem(iTitleEnd[self.joiner]!)
        case "NI":
            self.start = returnRandomItem(nTitleStart)
            self.end = returnRandomItem(iTitleEnd[self.joiner]!)
        case "IN":
            self.start = returnRandomItem(iTitleStart)
            self.end = returnRandomItem(nTitleEnd[self.joiner]!)
        default:
            self.start = returnRandomItem(nTitleStart)
            self.end = returnRandomItem(nTitleEnd[self.joiner]!)
        }
    }
    
    var readable: String {get{return "\(self.start) \(self.joiner) \(self.end)"}}
    


}




