//
//  themesHandler.swift
//  Shift
//
//  Created by Joel Huggett on 2017-11-07.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import UIKit

typealias colorScheme = (name: String, background: UIColor, foreground: UIColor, bin: [UIColor], price: Int, id: String)




enum colorBins {
    
    
    static let alpha: colorScheme = ("alpha", UIColor.black, UIColor.white, [UIColor.blue, UIColor.white, UIColor.red, UIColor.green, UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange, UIColor.purple], 5000, UUID.init().uuidString)
    
    static let betaWhite: colorScheme = ("beta white", UIColor.white, UIColor.black, [UIColor.blue, UIColor.red, UIColor.black, UIColor.green, UIColor.purple], 1000, UUID.init().uuidString)
    
    static let betaBlack: colorScheme = ("beta black", UIColor.black, UIColor.white, [UIColor.blue, UIColor.red, UIColor.white, UIColor.green, UIColor.purple], 0, UUID.init().uuidString)
    
    static let greyWhite: colorScheme = ("Grey White", UIColor.white, UIColor.black, [UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1), UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1), UIColor.init(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)], 5000, UUID.init().uuidString)
    
    static let flat: colorScheme = ("Flat", UIColor.black, UIColor.init(red: 253/255, green: 227/255, blue: 167/255, alpha: 1), [UIColor.init(red: 235/255, green: 149/255, blue: 50/255, alpha: 1), UIColor.init(red: 247/255, green: 202/255, blue: 24/255, alpha: 1), UIColor.init(red: 63/255, green: 195/255, blue: 128/255, alpha: 1), UIColor.init(red: 27/255, green: 163/255, blue: 156/255, alpha: 1), UIColor.init(red: 148/255, green: 124/255, blue: 176/255, alpha: 1)], 10000, UUID.init().uuidString)
    
    static let beta2Black: colorScheme = ("beta2 black", UIColor.black, UIColor.orange, [UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange], 6000, UUID.init().uuidString)
    
    static let beta2White: colorScheme = ("beta2 white", UIColor.white, UIColor.orange, [UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange], 6000, UUID.init().uuidString)
    
    static let huggett: colorScheme = ("huggett", UIColor.purple, UIColor.orange, [UIColor.brown, UIColor.cyan, UIColor.magenta, UIColor.gray, UIColor.orange], 6000, UUID.init().uuidString)
}

let colorSets: [colorScheme] = [colorBins.betaBlack, colorBins.betaWhite, colorBins.flat, colorBins.greyWhite, colorBins.beta2Black, colorBins.huggett]



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
