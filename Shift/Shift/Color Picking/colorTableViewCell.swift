//
//  colorTableViewCell.swift
//  Shift
//
//  Created by Joel Huggett on 2017-10-22.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit

class colorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var firstColor: UILabel!
    @IBOutlet weak var secondColor: UILabel!
    @IBOutlet weak var thirdColor: UILabel!
    @IBOutlet weak var fourthColor: UILabel!
    @IBOutlet weak var fifthColor: UILabel!
    
    
    
    var cColorScheme: colorScheme = colorSets[0]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
