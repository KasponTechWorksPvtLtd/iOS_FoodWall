//
//  followtableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 13/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class followtableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var bioDetails: UILabel!
    
    @IBOutlet weak var selctBtn: UIButton!
    @IBOutlet weak var checkBoxImage: UIImageView!
    
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
