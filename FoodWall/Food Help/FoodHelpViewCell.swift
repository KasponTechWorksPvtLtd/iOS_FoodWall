//
//  FoodHelpViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class FoodHelpViewCell: UITableViewCell {
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var editDeleteBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var reviewFollowers: UILabel!
    
    @IBOutlet weak var quesAskedLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var question1: UILabel!
    
    @IBOutlet var imageButton: UIButton!
    
    @IBOutlet weak var view1: ShadowView!
   // @IBOutlet var view1: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
