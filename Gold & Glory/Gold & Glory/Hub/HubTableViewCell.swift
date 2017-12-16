//
//  HubTableViewCell.swift
//  Gold & Glory
//
//  Created by Joel Huggett on 2017-12-09.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import UIKit



class HubTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wellbeingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .default
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
