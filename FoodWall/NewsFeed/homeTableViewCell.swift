//
//  homeTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class homeTableViewCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet var collectionView2: UICollectionView!
    @IBOutlet var profName: UILabel!
    
    @IBOutlet weak var homeScroll: UIScrollView!
    var data : [String]?
    var thisWidth:CGFloat = 0
   
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var likesClick: UIButton!
    @IBOutlet weak var profilePageBUtton: UIButton!
    @IBOutlet weak var commentsNewText: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var daysAgoLabel: UILabel!
    @IBOutlet var commentView: UIView!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var postFollowersLabel: UILabel!
    
    @IBOutlet var optionsMenu: UIButton!
    @IBOutlet var commentimage: UIImageView!
    @IBOutlet var totalLikes: UILabel!
   
    @IBOutlet var storyProfImage: UIImageView!
    
    @IBOutlet weak var postCommentButton: UIButton!
    @IBOutlet var viewallButton: UIButton!
    @IBOutlet var totalComments: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var descText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        commentimage.layer.cornerRadius = commentimage.frame.width/2
        commentimage.clipsToBounds = true
        postCommentButton.layer.cornerRadius = 15.0
        postCommentButton.clipsToBounds = true
       // postCommentButton.isHidden = true
        
        
        commentView.layer.cornerRadius = 20.0
        commentView.clipsToBounds = true
        commentView.layer.borderColor = UIColor.lightGray.cgColor
        commentView.layer.borderWidth = 1.0
        commentTextView.layer.borderWidth = 0.0
       // commentView
        profileImage.layer.cornerRadius = profileImage.frame.width/2
        profileImage.clipsToBounds = true
        commentTextView.text = "Add a Comment"
        commentTextView.textColor = UIColor.lightGray
        commentsNewText.isHidden = true
        collectionView2.bounces = collectionView2.contentOffset.y > 100
        
        
        var frame = self.commentTextView.frame
        frame.size.height = self.commentTextView.contentSize.height
        self.commentTextView.frame = frame

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state 
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
}


    







