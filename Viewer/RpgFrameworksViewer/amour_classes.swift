//
//  amour_classes.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-28.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

// garments(types of cloth - colour - symbols - pelts) - armour(type - metal - symbols - etchings) - cape(type of cloth - colour - symbols - type) - hat(type(e.g. crown) - material - other details pertaining to hat type)

protocol wearable {
    var name: String {get}
    var value: Int {get}
}


protocol headPiece {
    
}



protocol clothing {
    
}





struct cape: wearable {
    var cColours: [(name: String, value: Int)]
    var cPelts: [leather]?
    var cMaterial: baseMaterial
    var embroidery: baseMaterial?
    var cSymbol: String?
    
    var name: String {return ""}
    var value: Int {return 0}
}



protocol armour {
    
}




protocol shield {
    
}



// Ornate Gold Crown with Diamonds, Rubies, and Saphires
// Wolf Pelt Headpiece
// Large Brimmed Green Fine Wool Hat with a Long Blue Feather


// Black Smooth Wool Cape
// Blue Fine Silk Cloak with White Embroidery (with a Symbol of a Sunrise)
// Long Panther Pelt Cloak

// Red, Green, and Blue Fine Silk Garments with Gold Embroidery
// Black Wool Garments with Mink and Fox Pelts


// Heavy Steel Lammalar Armour with Gold Etching (with a Symbol of a Sunrise)
// Scarse Copper Banded Armour


// Tall Steel Kite Shield (with a Symbol of a Tree)
// Small Bronze Buckler




// for pelts pass a pelt to a leather struct
