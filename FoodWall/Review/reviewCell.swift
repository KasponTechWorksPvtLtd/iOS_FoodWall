//
//  reviewCell.swift
//  nithya
//
//  Created by apple on 7/26/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class reviewCell: UITableViewCell {
   
    
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var topDishesLabel: UILabel!
    var data1 = [[String:AnyObject]]()
    var thisWidth:CGFloat = 0
    var delegate:CategoryRowDelegate?
    @IBOutlet weak var collectTable: UICollectionView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var reviewText: UILabel!
    @IBOutlet weak var dishesToAvoidLabel: UILabel!
    @IBOutlet weak var bucketList: UIButton!
    @IBOutlet weak var progImage: UIImageView!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var reviewFollwersLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mainRating: UILabel!
    @IBOutlet weak var rating4: UILabel!
    @IBOutlet weak var rating3: UILabel!
    @IBOutlet weak var rating2: UILabel!
    @IBOutlet weak var rating1: UILabel!
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var hotelReview: UIView!
    @IBOutlet weak var dishesToAvoidView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var topDishesView: UIView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var moreLessBtn: UIButton!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var dishView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var servicePackageLabel: UILabel!
    @IBOutlet weak var hotelAmbianceView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var commentsTextView: UITextView!
    
    @IBOutlet weak var collectTable1: UICollectionView!
    
    @IBOutlet weak var collectTable2: UICollectionView!
    
    @IBOutlet weak var editDeleteBtn: UIButton!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var bucketListBtn: UIButton!
    
    @IBOutlet weak var TopdishNameView: UIView!
    
    @IBOutlet weak var dishtoAvoidNameView: UIView!
    
    @IBOutlet weak var likesAllBtn: UIButton!
    
    @IBOutlet weak var commentsAllBtn: UIButton!
    
   // @IBOutlet weak var commentsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rating1.layer.cornerRadius = 12.0
        rating1.clipsToBounds = true
     
        rating2.layer.cornerRadius =  12.0
        rating2.clipsToBounds = true
        rating3.layer.cornerRadius =  12.0
        rating3.clipsToBounds = true
        rating4.layer.cornerRadius =  12.0
        rating4.clipsToBounds = true
        mainRating.layer.cornerRadius =  15.0
        mainRating.clipsToBounds = true
        progImage.layer.cornerRadius = progImage.frame.size.width/2
        progImage.clipsToBounds = true
        commentImage.layer.cornerRadius = commentImage.frame.size.width/2
        commentImage.clipsToBounds = true
        
//        commentsView.layer.cornerRadius = 30.0
//        commentsView.layer.borderWidth = 1.0
//        commentsView.layer.borderColor = UIColor.lightGray.cgColor
//        commentsView.clipsToBounds = true
        postBtn.layer.cornerRadius = 12.0
        postBtn.clipsToBounds = true
        postBtn.applyGradient()
       // cell.delegate = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
