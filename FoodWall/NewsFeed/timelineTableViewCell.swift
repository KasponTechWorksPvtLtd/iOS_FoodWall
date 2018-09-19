//
//  timelineTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 14/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class timelineTableViewCell: UITableViewCell {

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeBUtton: UIButton!
    @IBOutlet weak var daysAgo: UILabel!
    @IBOutlet weak var nooflikes: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var optionmenu: UIButton!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var collectionview1: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
