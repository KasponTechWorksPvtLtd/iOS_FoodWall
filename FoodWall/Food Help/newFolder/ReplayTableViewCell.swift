//
//  ReplayTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 05/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class ReplayTableViewCell: UITableViewCell {

    
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
