///Users/jhuggett/SandBox/RpgFrameworksViewer/RpgFrameworksViewer/main.swift
//  main.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let startTime = NSDate().timeIntervalSince1970

var blah = crossguard()
blah.description()

var foo = handle()
foo.description()

var bar = pommel()
bar.description()

print("\n\nRUNTIME: \(Double(Int((NSDate().timeIntervalSince1970 - startTime) * 100))/100)")


