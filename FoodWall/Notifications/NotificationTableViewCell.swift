//
//  NotificationTableViewCell.swift
//  FoodWall
//
//  Created by MacOsHighSierra on 15/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var foodimage: UIImageView!
    
    @IBOutlet weak var notificationlabel: UILabel!
    
    @IBOutlet weak var timelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        foodimage.layer.cornerRadius = foodimage.frame.size.height/2
        foodimage.layer.borderWidth = 0.2
        foodimage.clipsToBounds = true
     
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
