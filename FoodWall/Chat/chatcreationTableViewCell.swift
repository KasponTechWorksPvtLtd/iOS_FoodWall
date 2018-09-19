//
//  chatcreationTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class chatcreationTableViewCell: UITableViewCell {
    @IBOutlet weak var followerimage: UIImageView!
    @IBOutlet weak var Firstnamebold: UILabel!
    @IBOutlet weak var firstnamesmall: UILabel!
    
    @IBOutlet weak var checkbox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        followerimage.layer.cornerRadius = followerimage.frame.size.height/2
        followerimage.layer.borderWidth = 0.2
        followerimage.clipsToBounds = true
        // Configure the view for the selected state
    }

}
