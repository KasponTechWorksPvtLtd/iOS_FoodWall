//
//  myEventsTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 14/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class myEventsTableViewCell: UITableViewCell {
    
    
    @IBOutlet var startDate: UILabel!
    
   
    @IBOutlet var view2: UIView!
    
    @IBOutlet weak var prevImage: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteImage: UIImageView!
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventTitle: UILabel!
    //@IBOutlet var eventsPrevImage: UIImageView!
    @IBOutlet var view1: UIView!
   // @IBOutlet var viewButton: UIButton!

    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
