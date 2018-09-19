//
//  EventsDetailedViewCell1.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 24/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class EventsDetailedViewCell1: UITableViewCell {
    
    
    @IBOutlet weak var writePOst: UIButton!
    @IBOutlet weak var viewallDiscussLabel: UILabel!
    @IBOutlet var postBtn: UIButton!
    @IBOutlet var otherProgImage: UIImageView!
    @IBOutlet var createdBy: UILabel!
    
    @IBOutlet weak var viewAlldiscussionBtn: UIButton!
    @IBOutlet var userProfImage: UIImageView!
    @IBOutlet var addComments: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
