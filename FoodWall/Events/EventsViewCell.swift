//
//  EventsViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 30/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class EventsViewCell: UITableViewCell {

    @IBOutlet weak var goView: UIView!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var goinButton: UIButton!
    @IBOutlet var goinImage: UIImageView!
    @IBOutlet var view2: UIView!
    @IBOutlet var interestImage: UIImageView!
    @IBOutlet var interestedButton: UIButton!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var eventsPrevImage: UIImageView!
    @IBOutlet var view1: UIView!
    @IBOutlet var viewButton: UIButton!
    
    @IBOutlet weak var acceptBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     //  eventsPrevImage.center = self.view1.center
        // Configure the view for the selected state
    }

}
