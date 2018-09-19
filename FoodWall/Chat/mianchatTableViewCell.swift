//
//  mianchatTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 23/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class mianchatTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var friendsimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        friendsimage.layer.cornerRadius = friendsimage.frame.size.height/2
        friendsimage.layer.borderWidth = 0.2
        friendsimage.clipsToBounds = true
        // Configure the view for the selected state
    }

}
