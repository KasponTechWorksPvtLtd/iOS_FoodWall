//
//  pollTableViewcell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 22/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class pollTableViewcell: UITableViewCell {

    @IBOutlet weak var segment2: UIView!
    @IBOutlet weak var segment1: UIView!
    
    @IBOutlet weak var undoBtn: UIButton!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var tick4: UIImageView!
    @IBOutlet weak var tick3: UIImageView!
    @IBOutlet weak var tick2: UIImageView!
    @IBOutlet weak var tick1: UIImageView!
    @IBOutlet weak var optionView: UIStackView!
    @IBOutlet weak var undoView: UIView!
    @IBOutlet weak var quesAskedLabel1: UILabel!
    @IBOutlet weak var progress4: UIProgressView!
    @IBOutlet weak var progress3: UIProgressView!
    @IBOutlet weak var progress2: UIProgressView!
    @IBOutlet weak var progress1: UIProgressView!
    @IBOutlet weak var optn4: UIButton!
    @IBOutlet weak var optn3: UIButton!
    @IBOutlet weak var optn2: UIButton!
    @IBOutlet weak var optn1: UIButton!
    @IBOutlet weak var reviewandFollowers: UILabel!
    @IBOutlet weak var question2: UILabel!
    @IBOutlet weak var userName1: UILabel!
    @IBOutlet weak var segment4: UIView!
    @IBOutlet weak var segment3: UIView!
    @IBOutlet weak var reviewsFollowers: UILabel!
    //@IBOutlet weak var userName: UILabel!
   // @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var pollView: UIView!
    
    @IBOutlet weak var progressSegment1: UIView!
    @IBOutlet weak var progressView: UIStackView!
    @IBOutlet weak var userImage1: UIImageView!
    
    @IBOutlet weak var progressSegment4: UIView!
    @IBOutlet weak var progressSegment3: UIView!
    @IBOutlet weak var progressSegment2: UIView!
    @IBOutlet weak var optnName1: UILabel!
    
    @IBOutlet weak var editDeleteBtn1: UIButton!
    @IBOutlet weak var optnName4: UILabel!
    @IBOutlet weak var optnName3: UILabel!
    @IBOutlet weak var optnName2: UILabel!
    @IBOutlet weak var percentDisplay4: UILabel!
    @IBOutlet weak var percentDisplay3: UILabel!
    @IBOutlet weak var percentDisplay2: UILabel!
    @IBOutlet weak var percentDisplay1: UILabel!
    //   @IBOutlet weak var userImage: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        progressSegment1.layer.borderWidth = 1.0
        progressSegment1.layer.borderColor = UIColor.lightGray.cgColor
        progressSegment2.layer.borderWidth = 1.0
        progressSegment2.layer.borderColor = UIColor.lightGray.cgColor
        progressSegment3.layer.borderWidth = 1.0
        progressSegment3.layer.borderColor = UIColor.lightGray.cgColor
        progressSegment4.layer.borderWidth = 1.0
        progressSegment4.layer.borderColor = UIColor.lightGray.cgColor
        segment1.layer.borderWidth = 1.0
        segment1.layer.borderColor = UIColor.lightGray.cgColor
        segment2.layer.borderWidth = 1.0
        segment2.layer.borderColor = UIColor.lightGray.cgColor
        segment3.layer.borderWidth = 1.0
        segment3.layer.borderColor = UIColor.lightGray.cgColor
        segment4.layer.borderWidth = 1.0
        segment4.layer.borderColor = UIColor.lightGray.cgColor
//        progress1.transform = CGAffineTransform(scaleX: 1, y: 50)
//        progress2.transform = CGAffineTransform(scaleX: 1, y: 50)
//        progress3.transform = CGAffineTransform(scaleX: 1, y: 50)
//        progress4.transform = CGAffineTransform(scaleX: 1, y: 50)
        // Initialization code
        
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
