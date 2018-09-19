//
//  EditbuttonTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 01/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class EditbuttonTableViewCell: UITableViewCell {

    @IBOutlet weak var exitbutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        exitbutton.layer.cornerRadius = exitbutton.frame.size.height/2
        exitbutton.layer.borderWidth = 0.2
        exitbutton.clipsToBounds = true
        // Configure the view for the selected state
    }

}
