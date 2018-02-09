//
//  themesHandler.swift
//  Shift
//
//  Created by Joel Huggett on 2017-11-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit


let colorAlpha: CGFloat = 1.0


enum allColors {
    static let white = UIColor.white
    static let black = UIColor.black
    static let blue = UIColor.blue
    static let red = UIColor.red
    static let green = UIColor.green
    static let brown = UIColor.brown
    static let yellow = UIColor.yellow
    static let cyan = UIColor.cyan
    static let orange = UIColor.orange
    static let gray = UIColor.gray
    static let darkGray = UIColor.darkGray
    static let lightGray = UIColor.lightGray
    static let magenta = UIColor.magenta
    static let purple = UIColor.purple
    static let indianRed = UIColor.init(red: 176/255, green: 23/255, blue: 31/255, alpha: colorAlpha)
    static let crimson = UIColor.init(red: 220/255, green: 20/255, blue: 60/255, alpha: colorAlpha)
    static let darkSlateBlue = UIColor.init(red: 72/255, green: 61/255, blue: 139/255, alpha: colorAlpha)
    static let ghostWhite = UIColor.init(red: 248/255, green: 248/255, blue: 255/255, alpha: colorAlpha)
    static let royalBlue = UIColor.init(red: 65/255, green: 105/255, blue: 225/255, alpha: colorAlpha)
    static let midnightBlue = UIColor.init(red: 25/255, green: 25/255, blue: 112/255, alpha: colorAlpha)
    static let slateGray = UIColor.init(red: 112/255, green: 128/255, blue: 144/255, alpha: colorAlpha)
    static let steelBlue = UIColor.init(red: 70/255, green: 130/255, blue: 180/255, alpha: colorAlpha)
    static let deepSkyBlue = UIColor.init(red: 0/255, green: 191/255, blue: 255/255, alpha: colorAlpha)
    static let lightSkyBlue = UIColor.init(red: 135/255, green: 206/255, blue: 250/255, alpha: colorAlpha)
    static let powderBlue = UIColor.init(red: 176/255, green: 224/255, blue: 230/255, alpha: colorAlpha)
    static let azure = UIColor.init(red: 240/255, green: 255/255, blue: 255/255, alpha: colorAlpha)
    static let coldGray = UIColor.init(red: 128/255, green: 138/255, blue: 135/255, alpha: colorAlpha)
    static let turquoiseBlue = UIColor.init(red: 0/255, green: 199/255, blue: 140/255, alpha: colorAlpha)
    static let seaGreen = UIColor.init(red: 78/255, green: 238/255, blue: 148/255, alpha: colorAlpha)
    static let emeraldGreen = UIColor.init(red: 0/255, green: 201/255, blue: 87/255, alpha: colorAlpha)
    static let honeydew = UIColor.init(red: 224/255, green: 238/255, blue: 224/255, alpha: colorAlpha)
    static let darkGreen = UIColor.init(red: 0/255, green: 100/255, blue: 0/255, alpha: colorAlpha)
    static let darkOlive = UIColor.init(red: 110/255, green: 139/255, blue: 34/255, alpha: colorAlpha)
    static let ivory = UIColor.init(red: 255/255, green: 255/255, blue: 240/255, alpha: colorAlpha)
    static let darkYellow = UIColor.init(red: 139/255, green: 139/255, blue: 0/255, alpha: colorAlpha)
    static let lighGoldenRod = UIColor.init(red: 250/255, green: 250/255, blue: 210/255, alpha: colorAlpha)
    static let olive = UIColor.init(red: 128/255, green: 128/255, blue: 0/255, alpha: colorAlpha)
    static let gold = UIColor.init(red: 205/255, green: 190/255, blue: 112/255, alpha: colorAlpha)
    static let lemonShiffon = UIColor.init(red: 139/255, green: 137/255, blue: 112/255, alpha: colorAlpha)
    static let goldenRod = UIColor.init(red: 218/255, green: 165/255, blue: 32/255, alpha: colorAlpha)
    static let darkOrange = UIColor.init(red: 139/255, green: 90/255, blue: 0/255, alpha: colorAlpha)
    static let wheat = UIColor.init(red: 245/255, green: 222/255, blue: 179/255, alpha: colorAlpha)
    static let moccasin = UIColor.init(red: 255/255, green: 228/255, blue: 181/255, alpha: colorAlpha)
    static let ivoryBlack = UIColor.init(red: 41/255, green: 36/255, blue: 33/255, alpha: colorAlpha)
    static let rawSienna = UIColor.init(red: 199/255, green: 97/255, blue: 20/255, alpha: colorAlpha)
    static let coral = UIColor.init(red: 255/255, green: 127/255, blue: 80/255, alpha: colorAlpha)
    static let sepia = UIColor.init(red: 94/255, green: 38/255, blue: 18/255, alpha: colorAlpha)
    static let firebrick = UIColor.init(red: 178/255, green: 34/255, blue: 34/255, alpha: colorAlpha)
    static let maroon = UIColor.init(red: 128/255, green: 0/255, blue: 0/255, alpha: colorAlpha)
    static let beet = UIColor.init(red: 142/255, green: 56/255, blue: 142/255, alpha: colorAlpha)
    static let chartreuse = UIColor.init(red: 113/255, green: 198/255, blue: 113/255, alpha: colorAlpha)
    static let oliveDrab = UIColor.init(red: 142/255, green: 142/255, blue: 56/255, alpha: colorAlpha)
    static let gray1 = UIColor.init(red: 42/255, green: 42/255, blue: 42/255, alpha: colorAlpha)
    static let gray2 = UIColor.init(red: 85/255, green: 85/255, blue: 85/255, alpha: colorAlpha)
    static let gray3 = UIColor.init(red: 127/255, green: 127/255, blue: 127/255, alpha: colorAlpha)
    static let gray4 = UIColor.init(red: 169/255, green: 169/255, blue: 169/255, alpha: colorAlpha)
    static let gray5 = UIColor.init(red: 211/255, green: 211/255, blue: 211/255, alpha: colorAlpha)





    
    
    
    
    
}

typealias colorScheme = (name: String, background: UIColor, foreground: UIColor, bin: [UIColor], price: Int, id: String)



enum colorBins {

    static let classic: colorScheme = ("Classic", .black, .white, [.blue, .red, .white, .green, .purple], 0, UUID.init().uuidString)
    
    static let classicW: colorScheme = ("Classic(White)", .white, .black, [.blue, .red, .black, .green, .purple], 0, UUID.init().uuidString)
    
    static let bumblebee: colorScheme = ("Bumblebee", .black, .yellow, [.yellow, .orange, .red, .green, .purple], 2500, UUID.init().uuidString)
    
    static let faded: colorScheme = ("Faded", allColors.ghostWhite, allColors.coldGray, [allColors.sepia, allColors.coral, allColors.royalBlue, allColors.lightSkyBlue, allColors.chartreuse], 5000, UUID.init().uuidString)
    
    static let wildwood: colorScheme = ("Wildwood", allColors.darkOlive, allColors.ghostWhite, [allColors.sepia, allColors.beet, allColors.wheat, allColors.crimson, allColors.turquoiseBlue], 7500, UUID.init().uuidString)
    
    static let inferno: colorScheme = ("Inferno", allColors.wheat, allColors.ivoryBlack, [allColors.goldenRod, allColors.darkOrange, allColors.rawSienna, allColors.firebrick, allColors.gold], 10000, UUID.init().uuidString)
    
    static let honeydew: colorScheme = ("Honeydew", allColors.honeydew, allColors.ivoryBlack, [allColors.ivory, allColors.ivoryBlack, allColors.royalBlue, allColors.darkGreen, allColors.firebrick], 12500, UUID.init().uuidString)
    
    static let slate: colorScheme = ("Slate", allColors.coldGray, allColors.ghostWhite, [allColors.indianRed, allColors.midnightBlue, allColors.maroon, allColors.azure, allColors.chartreuse], 15000, UUID.init().uuidString)
    
    static let grayscale: colorScheme = ("Greyscale", allColors.ivory, allColors.ivoryBlack, [allColors.gray1, allColors.gray2, allColors.gray3, allColors.gray4, allColors.gray5], 0, UUID.init().uuidString)
    
    static let tenebrous: colorScheme = ("Tenebrous", allColors.black, allColors.ivory, [allColors.indianRed, allColors.goldenRod, allColors.gold, allColors.ivory, allColors.midnightBlue], 17500, UUID.init().uuidString)
    
    static let soft: colorScheme = ("Soft", allColors.powderBlue, allColors.black, [allColors.brown, allColors.maroon, allColors.coral, allColors.lemonShiffon, allColors.chartreuse], 20000, UUID.init().uuidString)
    
    static let x: colorScheme = ("X", allColors.black, allColors.red, [allColors.brown, allColors.maroon, allColors.midnightBlue, allColors.orange, allColors.yellow], 50000, UUID.init().uuidString)
    
    
}

let colorSets: [colorScheme] = [colorBins.classic, colorBins.classicW, colorBins.grayscale, colorBins.bumblebee, colorBins.faded, colorBins.wildwood, colorBins.inferno, colorBins.honeydew, colorBins.slate, colorBins.tenebrous, colorBins.soft, colorBins.x]

class themeHandler {
    var themeInUseIndex: Int
    var themeInUse: colorScheme {get{return colorSets[self.themeInUseIndex]}}
    var masterColorSets: [colorScheme] = colorSets
    var background: UIColor {get{return self.themeInUse.background}}
    var foreground: UIColor {get{return self.themeInUse.foreground}}
    var Colors: [UIColor] {get{return self.themeInUse.bin}}
    var name: String {get{return self.themeInUse.name}}
    
    
    init() {
        self.themeInUseIndex = DataManager.themeInUse
    }
    
    var setWithCurrentFirst: [colorScheme] {        
        var newArray = [colorScheme]()
        newArray.append(self.themeInUse)
        for i in self.masterColorSets.filter({$0.id != self.themeInUse.id}) {
            newArray.append(i)
        }
        return newArray
    }
    
    
    func changeTheme(index: Int) {
        self.themeInUseIndex = index
    }
    
    
    func indexFor(scheme: colorScheme) -> Int {
        var idArray: [String] { get{
            var idArray = [String]()
            for i in self.masterColorSets {
                idArray.append(i.id)
            }
            return idArray
            }
            
        }
       
        return idArray.index(of: scheme.id)!
    }
    
    func changeThemeFromScheme(scheme: colorScheme) {
        self.themeInUseIndex = self.indexFor(scheme: scheme)
        DataManager.themeInUse = self.themeInUseIndex
    }
}

var colorHandler = themeHandler()

var AudioHandler = SoundHandler()
