//
//  viewQuesTableCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class viewQuesTableCell: UITableViewCell,UITextViewDelegate {

    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet var profileView: UIView!
   

    @IBOutlet var ansButton: UIButton!
    @IBOutlet var profname: UILabel!
   
    @IBOutlet weak var upvoteBtn: UIButton!
   
    
   
    @IBOutlet var questn: UILabel!
    
    @IBOutlet var requestBtn: UIButton!
  
    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var upvoteimg: UIImageView!
    
    @IBOutlet var followButton: UIButton!
    @IBOutlet weak var followimage: UIImageView!
 
    @IBOutlet weak var downvoteimg: UIImageView!
  
    @IBOutlet var askedLabel: UILabel!
    @IBOutlet weak var downVoteBtn: UIButton!
   
    
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var postBtn: UIButton!
    @IBOutlet var topAns: UILabel!
    @IBOutlet var profImage: UIImageView!
    
    @IBOutlet var commentTextView: UITextView!
    //  @IBOutlet weak var commentsView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profImage.layer.cornerRadius = profImage.frame.size.width/2
        profImage.clipsToBounds = true
        
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true
        postBtn.layer.cornerRadius = 10.0
        postBtn.clipsToBounds = true
        
      
       postBtn.applyGradientButtongreen()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
