//
//  RestaurantVisitCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 05/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class RestaurantVisitCell: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var hotelPic: UIImageView!
    @IBOutlet weak var withFriendLabel: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    
    @IBOutlet weak var photosCountLabel: UILabel!
    
    @IBOutlet weak var totalRestaurants: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
