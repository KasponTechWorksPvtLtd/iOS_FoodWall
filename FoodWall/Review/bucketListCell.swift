//
//  bucketListCell.swift
//  FoodWall
//
//  Created by apple on 8/2/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class bucketListCell: UITableViewCell {

    @IBOutlet weak var profName: UILabel!
    
   // @IBOutlet weak var profImage: UIButton!
    
    @IBOutlet weak var reviewFollowerslabel: UILabel!
    
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var servicePackageLabel: UILabel!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet weak var timaAgoLabel: UILabel!
    
    @IBOutlet weak var reviewTextLabel: UILabel!
   // @IBOutlet weak var bucketListbtn: UIButton!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var mainRating: UILabel!
    @IBOutlet weak var rating4: UILabel!
    @IBOutlet weak var rating2: UILabel!
    
    @IBOutlet weak var rating3: UILabel!
    @IBOutlet weak var rating1: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profImage.layer.cornerRadius = profImage.frame.size.width / 2
        profImage.clipsToBounds = true
        rating1.layer.cornerRadius = 12.0
        rating1.clipsToBounds = true
        rating2.layer.cornerRadius = 12.0
        rating2.clipsToBounds = true
        rating3.layer.cornerRadius = 12.0
        rating3.clipsToBounds = true
        rating4.layer.cornerRadius = 12.0
        rating4.clipsToBounds = true
        mainRating.layer.cornerRadius = 15.0
        mainRating.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
