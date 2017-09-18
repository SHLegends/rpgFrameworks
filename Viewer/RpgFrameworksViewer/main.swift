///Users/jhuggett/SandBox/RpgFrameworksViewer/RpgFrameworksViewer/main.swift
//  main.swift
//  RpgFrameworksViewer
//
//  Created by Joel Huggett on 2017-08-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation

import Cocoa


let startTime = NSDate().timeIntervalSince1970

print("\n\nRPGFrameworks/Viewer/Ver.0.0.2.0\n(designed for terminal with background: black and font: green)\n")


start: while true {
    print("\nModules:\n1. ItemGen\n2. NameGen\n3. TitleGen\n4. MapGen\n0. exit")
    let startChoice = readLine()
    if let choice = startChoice {
        if choice == "1" {
            ItemGenLoop: while true {
                print("\nTypes:\n1. Base Material\n2. Weapon Components\n3. Weapons\n4. Armour\n0. back")
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
                    } else if choice == "4" {
                        print("Armour...")
                        armourLoop: while true {
                            print("\n1. Cape\n2. Shield\n3. Armour\n4. Clothing\n5. Headdress\n6. Hood\n7. Crown\n8. Helmet\n0. back")
                            let weaponComponentChoice = readLine()
                            if let choice = weaponComponentChoice {
                                if choice == "1" {
                                    let foo = cape(); foo.description()
                                } else if choice == "2" {
                                    let foo = shield(); foo.description()
                                } else if choice == "3" {
                                    let foo = armour(); foo.description()
                                } else if choice == "4" {
                                    let foo = clothing(); foo.description()
                                } else if choice == "5" {
                                    let foo = headdress(); foo.description()
                                } else if choice == "6" {
                                    let foo = hood(); foo.description()
                                } else if choice == "7" {
                                    let foo = crown(); foo.description()
                                } else if choice == "8" {
                                    let foo = helmet(); foo.description()
                                } else if choice == "0" {
                                    break armourLoop
                                }
                            } else {
                                continue armourLoop
                            }
                        }
                    } else if choice == "g" {
                        print("\n---\n")
                        let a = cape(); print(a.name)
                        let b = armour(); print(b.name)
                        let e = helmet(); print(e.name)
                        let c = shield(); print(c.name)
                        let d = sword(); print(d.name)
                        print("\n---\n")
                    } else if choice == "0" {
                        break ItemGenLoop
                        
                    } else {
                        continue ItemGenLoop
                    }
                } else {
                    continue ItemGenLoop
                }
            }
        } else if choice == "2" {
            nameLoop: while true {
                print("Number of Syllables?\n0. Back")
                let weaponComponentChoice = readLine()
                if let choice = weaponComponentChoice {
                    if choice == "0" {
                        break nameLoop
                    }
                    else if let num = Int(choice) {
                        let foo = randName(syllNum: num); foo.description()
                    } else {
                        continue nameLoop
                    }
                } else {
                    continue nameLoop
                }
            }
        } else if choice == "3" {
            titleLoop: while true {
                print("1. N\n2. I\n3. NI\n4. IN\n0. Back")
                let weaponComponentChoice = readLine()
                if let choice = weaponComponentChoice {
                    if choice == "1" {
                        let foo = randTitle(effect: "N"); print(foo.readable)
                    } else if choice == "2" {
                        let foo = randTitle(effect: "I"); print(foo.readable)
                    } else if choice == "3" {
                        let foo = randTitle(effect: "NI"); print(foo.readable)
                    } else if choice == "4" {
                        let foo = randTitle(effect: "IN"); print(foo.readable)
                    } else if choice == "0" {
                        break titleLoop
                    } else {
                        continue titleLoop
                    }
                } else {
                    continue titleLoop
                }
            }
        } else if choice == "4" {
            mapLoop: while true {
                
                print("Welcome to the Map Generator\nPlease Enter Map Height(e.g. 100)")
                let h = readLine()
                if let h = h {
                    if let intH = Int(h) {
                        let height = intH
                        print("Thank you...\nPlease Enter Map Width(e.g. 100):")
                        let w = readLine()
                        if let w = w {
                            if let intW = Int(w) {
                                let width = intW
                                var foo = worldMap((height, width))
                                print("Your Map has been Generated")
                                mapOptionLoop: while true {
                                    print("1. Add Landmass\n2. Scan Map\n3. Print Map\n4. Print Info\n0. Exit")
                                    let option = readLine()
                                    if let option = option {
                                        if option == "1" {
                                            print("Please Enter Size(e.g. 100):")
                                            let s = readLine()
                                            if let s = s {
                                                if let s = Int(s) {
                                                    let size = s
                                                    print("Thank you...\nPlease Enter Draw Size(e.g. 1 (do NOT exceed 3)):")
                                                    let ds = readLine()
                                                    if let ds = ds {
                                                        if let ds = Int(ds) {
                                                            foo.genContinent(size, ds)
                                                            print("Complete...")
                                                        }  else {print("Let us try this again...");continue mapOptionLoop}
                                                    } else {print("Let us try this again...");continue mapOptionLoop}
                                                } else {print("Let us try this again...");continue mapOptionLoop}
                                            } else {print("Let us try this again...");continue mapOptionLoop}
                                        } else if option == "2" {
                                            foo.fullMapScan()
                                            print("Map Scanned")
                                        } else if option == "3" {
                                            foo.printOut()
                                            print("Map Printed...")
                                        } else if option == "4" {
                                            foo.landMassDescription()
                                            print("Info Printed...")
                                        } else if option == "0" {
                                            print("Farewell...")
                                            break mapOptionLoop
                                        } else {print("Let us try this again...");continue mapOptionLoop}
                                    
                                    } else {print("Let us try this again...");continue mapOptionLoop}
                                }
                            } else {print("Let us try this again...");continue mapLoop}
                        } else {print("Let us try this again...");break mapLoop}
                    } else {print("Let us try this again...");break mapLoop}
                } else {print("Let us try this again...");continue mapLoop}
            }
        } else if choice == "m" {
            var foo = worldMap((100, 100)); foo.genContinent(500, 2); foo.genContinent(500, 2); foo.genContinent(500, 2); foo.genContinent(100, 1); foo.genContinent(100, 1); foo.genContinent(100, 1); foo.genContinent(100, 1); foo.genContinent(100, 1); foo.fullMapScan(); foo.landMassDescription(); foo.printOut()
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


