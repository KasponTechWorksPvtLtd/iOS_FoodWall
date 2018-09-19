//
//  qaTimelineCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class qaTimelineCell: UITableViewCell {

    
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var totalcomments: UIButton!
    @IBOutlet weak var totalLikes: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
   
    @IBOutlet weak var quesLabel: UILabel!
    @IBOutlet weak var PROFPIC: UIImageView!
    @IBOutlet weak var userNAME: UILabel!
    
    @IBOutlet weak var ansLabel: UILabel!
    @IBOutlet weak var daysagoLabel: UILabel!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var commentsTextView: UITextView!
    
    
    @IBOutlet weak var commentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentView.layer.cornerRadius = 20.0
        commentView.clipsToBounds = true
        commentView.layer.borderColor = UIColor.lightGray.cgColor
        commentView.layer.borderWidth = 1.0
        commentsTextView.layer.borderWidth = 0.0
        
        
        PROFPIC.layer.cornerRadius = PROFPIC.frame.size.width/2
        PROFPIC.clipsToBounds = true
        commentImage.layer.cornerRadius = commentImage.frame.size.width/2
        commentImage.clipsToBounds = true
        
        postBtn.layer.cornerRadius = 15.0
        postBtn.clipsToBounds = true
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
