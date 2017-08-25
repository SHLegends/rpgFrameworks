///Users/jhuggett/SandBox/RpgFrameworksViewer/RpgFrameworksViewer/main.swift
//  main.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

let startTime = NSDate().timeIntervalSince1970


start: while true {
    print("\nModules:\n1. ItemGen\n0. exit")
    let startChoice = readLine()
    if let choice = startChoice {
        if choice == "1" {
            ItemGenLoop: while true {
                print("\nTypes:\n1. Base Material\n2. Weapon Components\n3. Weapons\n0. back")
                let typeChoice = readLine()
                if let choice = typeChoice {
                    if choice == "1" {
                        print("Base Material...")
                        baseMaterialLoop: while true {
                            print("\n\nBase Materials:\n1. Gemstone\n2. Fabric\n3. Leather\n4. Wood\n5. Metal\n6. Etching\n7. Bone\n0. back")
                            let baseMaterialChoice = readLine()
                            if let choice = baseMaterialChoice {
                                if choice == "1" {
                                    let foo = gemstone(); foo.description()
                                } else if choice == "2" {
                                    let foo = fabric(); foo.description()
                                } else if choice == "3" {
                                    let foo = leather(); foo.description()
                                } else if choice == "4" {
                                    let foo = wood(); foo.description()
                                } else if choice == "5" {
                                    let foo = metal(); foo.description()
                                } else if choice == "6" {
                                    let foo = etching(); foo.description()
                                } else if choice == "7" {
                                    let foo = bone(); foo.description()
                                } else if choice == "0" {
                                    break baseMaterialLoop
                                } else {
                                    continue baseMaterialLoop
                                }
                            } else {
                                continue baseMaterialLoop
                            }
                        }
                    } else if choice == "2" {
                        print("Weapon Components...")
                        weaponComponentLoop: while true {
                            print("\n\nWeapon Components:\n1. Pommel\n2. Handle\n3. Crossguard\n4. Blade\n5. Long Handle\n6. Haft\n7. Axe Head\n8. Mace Head\n9. Spear Head\n0. back")
                            let weaponComponentChoice = readLine()
                            if let choice = weaponComponentChoice {
                                if choice == "1" {
                                    let foo = pommel(); foo.description()
                                } else if choice == "2" {
                                    let foo = handle(); foo.description()
                                } else if choice == "3" {
                                    let foo = crossguard(); foo.description()
                                } else if choice == "4" {
                                    let foo = blade(); foo.description()
                                } else if choice == "5" {
                                    let foo = longHandle(); foo.description(); print(foo.simpleDescription)
                                } else if choice == "6" {
                                    let foo = haft(); foo.description(); print(foo.simpleDescription)
                                } else if choice == "7" {
                                    let foo = axeHead(); foo.description(); print(foo.simpleDescription)
                                } else if choice == "8" {
                                    let foo = maceHead(); foo.description(); print(foo.simpleDescription)
                                } else if choice == "9" {
                                    let foo = spearHead(); foo.description(); print(foo.simpleDescription)
                                    
                                } else if choice == "0" {
                                    break weaponComponentLoop
                                }
                            } else {
                                continue weaponComponentLoop
                            }
                        }
                        
                    } else if choice == "3" {
                        print("Weapons...")
                        weaponsLoop: while true {
                            print("\n\nWeapons:\n1. Sword\n2. Dagger\n3. Knife\n4. Long Sword\n5. Sword Staff\n6. One-Handed Axe\n7. Two-Handed Axe\n8. One-Handed Mace\n9. Two-Handed Mace\n10. Spear\n0. back")
                            let weaponComponentChoice = readLine()
                            if let choice = weaponComponentChoice {
                                if choice == "1" {
                                    let foo = sword(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "2" {
                                    let foo = dagger(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "3" {
                                    let foo = knife(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "4" {
                                    let foo = longSword(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "5" {
                                    let foo = swordStaff(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "6" {
                                    let foo = shortAxe(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "7" {
                                    let foo = longAxe(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "8" {
                                    let foo = shortMace(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "9" {
                                    let foo = longMace(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "10" {
                                    let foo = spear(); foo.description(); foo.basicDescription(); foo.simpleDescription()
                                } else if choice == "0" {
                                    break weaponsLoop
                                }
                            } else {
                                continue weaponsLoop
                            }
                        }
                        
                    } else if choice == "0" {
                        break ItemGenLoop
                        
                    } else {
                        continue ItemGenLoop
                    }
                } else {
                    continue ItemGenLoop
                }
            }
        } else if choice == "0" {
            break start
        } else {
            continue start
        }
    } else {
        continue start
    }
    
}



print("\n\nRUNTIME: \(Double(Int((NSDate().timeIntervalSince1970 - startTime) * 100))/100)")


