//
//  likesTableViewCell.swift
//  FoodWall
//
//  Created by MacOsHighSierra on 18/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class likesTableViewCell: UITableViewCell {

    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var subName: UILabel!
    
    @IBOutlet weak var profName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img1.layer.cornerRadius = img1.frame.size.height/2
        img1.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
