//
//  FollowerTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 09/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var FollowButton: UIButton!
    @IBOutlet weak var profPicture: UIImageView!
    @IBOutlet weak var bioDetail: UILabel!
    @IBOutlet weak var followerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profPicture.layer.cornerRadius = profPicture.frame.size.width/2
        profPicture.clipsToBounds = true
        FollowButton.layer.cornerRadius = 10.0
        FollowButton.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
