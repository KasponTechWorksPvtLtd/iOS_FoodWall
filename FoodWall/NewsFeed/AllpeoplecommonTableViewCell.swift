//
//  AllpeoplecommonTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class AllpeoplecommonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var peopleimage: UIImageView!
    
    @IBOutlet weak var peoplelabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        peopleimage.layer.cornerRadius = peopleimage.frame.size.height/2
        peopleimage.layer.borderWidth = 0.2
        peopleimage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
