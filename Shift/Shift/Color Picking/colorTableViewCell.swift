//
//  colorTableViewCell.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-22.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

enum actionState {
    case normal
    case wasTapped
    case onInitialization
    case wasTappedAgain
    
}

class colorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var stateOfAction: actionState = .onInitialization {
        didSet {
            self.updateActionLabel()
        }
    }
    
    
    var tappedOnce: Bool = false
    
    func updateActionLabel() {
        
        switch self.stateOfAction {
        case .onInitialization:
            self.priceLabel.text = ""
        case .normal:
            switch DataManager.stateOfSets[colorHandler.indexFor(scheme: self.cColorScheme)] {
            case .unowned:
                self.priceLabel.text = "\(self.cColorScheme.price) pts"
            case .owned:
                self.priceLabel.text = "owned"
            case .inUse:
                self.priceLabel.text = "currently in use"
            }
        case .wasTapped:
            switch DataManager.stateOfSets[colorHandler.indexFor(scheme: self.cColorScheme)] {
            case .unowned:
                self.priceLabel.text = "tap again to purchase"
            case .owned:
                self.priceLabel.text = "tap again to use"
            case .inUse:
                self.priceLabel.text = "currently in use"
            }
        case .wasTappedAgain:
            switch DataManager.stateOfSets[colorHandler.indexFor(scheme: self.cColorScheme)] {
            case .unowned:
                if DataManager.totalCredits - self.cColorScheme.price >= 0 {
                    DataManager.totalCredits -= self.cColorScheme.price
                    DataManager.setOwned(of: colorHandler.indexFor(scheme: self.cColorScheme))
                    colorHandler.changeThemeFromScheme(scheme: self.cColorScheme)
                } else {
                    self.priceLabel.shake()
                }
                
                self.stateOfAction = .normal
            case .owned:
                colorHandler.changeThemeFromScheme(scheme: self.cColorScheme)
                self.stateOfAction = .normal
            case .inUse:
                self.stateOfAction = .normal
            }
        }
        
    }
    
    
    var cColorScheme: colorScheme = colorSets[0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    

}
