//
//  foodStreetCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 20/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class foodStreetCell: UITableViewCell {
    
    
    
    

    @IBOutlet weak var likeAllBtn: UIButton!
    @IBOutlet weak var viewAllBtn: UIButton!
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        profImage.layer.cornerRadius = profImage.frame.size.width/2
        profImage.clipsToBounds = true

        // Configure the view for the selected state
    }

}
