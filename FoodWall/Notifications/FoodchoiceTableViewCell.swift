//
//  FoodchoiceTableViewCell.swift
//  FoodWall
//
//  Created by MacOsHighSierra on 19/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class FoodchoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodimage: UIImageView!
    
    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var smallname: UILabel!
    
    @IBOutlet weak var Nobutton: UIButton!
    @IBOutlet weak var Acceptbutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        foodimage.layer.cornerRadius = foodimage.frame.size.height/2
        foodimage.layer.borderWidth = 0.2
        foodimage.clipsToBounds = true
        Acceptbutton.layer.cornerRadius = 15
        
             Acceptbutton.applyGradient()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
