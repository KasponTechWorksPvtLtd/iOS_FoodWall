//
//  EventsDetailedViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 24/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//UIT

import UIKit

class EventsDetailedViewCell: UITableViewCell {
    
    
    @IBOutlet weak var goView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet var expandButton: UIButton!
    
    @IBOutlet weak var goingBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet var compressButton: UIButton!
    @IBOutlet var CompressImage: UIImageView!
    @IBOutlet var expandImage: UIImageView!
    @IBOutlet var eventMainStartMonth: UILabel!
    @IBOutlet var eventMainStartDate: UILabel!
    @IBOutlet var eventTitle: UILabel!
    @IBOutlet var ticketUrl: UILabel!
    @IBOutlet var interestedPplCount: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventDateandTIme: UILabel!
    @IBOutlet var goinImage: UIImageView!
    @IBOutlet var likeIMage: UIImageView!
    @IBOutlet var backBUTTON: UIButton!
    @IBOutlet var aboutEvent: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
      expandImage.frame = CGRect(x: 275 , y:  480 , width: 15, height: 15)
        
      expandButton.frame = CGRect(x: 260 , y:  465 , width: 46, height: 40)
        
//        compressButton.isHidden = true
//        CompressImage.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
