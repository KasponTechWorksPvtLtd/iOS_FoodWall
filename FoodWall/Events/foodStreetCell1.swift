//
//  foodStreetCell1.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 22/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class foodStreetCell1: UITableViewCell {
    
    @IBOutlet weak var optionMenu: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentbtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var PrevImahe: UIImageView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var likeallbtn: UIButton!
    @IBOutlet weak var viewAllbtn: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        profImage.layer.cornerRadius = profImage.frame.size.width/2
        profImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
