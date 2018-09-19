//
//  ReviewTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit



class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var view1: UIView!
    @IBOutlet var profileImage: UIButton!
    @IBAction func profileImage(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
