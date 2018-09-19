//
//  eventsDetailsTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 12/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class eventsDetailsTableViewCell: UITableViewCell,UITextViewDelegate {

    @IBOutlet var newLabel: UILabel!
   
    @IBOutlet var editBigButton: UIButton!
    @IBOutlet var commentsTextField: UITextField!
    @IBOutlet var deleteRow: UIButton!
    @IBOutlet var editCommentView: UIView!
    
    
    @IBOutlet var cancelEditButton: UIButton!
    @IBOutlet var addCommentEdit: UILabel!
    @IBOutlet var postEditButton: UIButton!
    @IBOutlet var posteditedComment: UITextView!
    @IBOutlet var editRow: UIButton!
    @IBOutlet var editView: UIView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var CommentsTextView: UITextView!
    @IBOutlet var daysText: UILabel!
    @IBOutlet var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        let fixedWidth = CommentsTextView.frame.size.width
        
        CommentsTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let newSize = CommentsTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        var newFrame = CommentsTextView.frame
        
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        CommentsTextView.frame = newFrame
        
        CommentsTextView.setContentOffset(.zero, animated: false)
       // CommentsTextView.isUserInteractionEnabled = false
        // Initialization code
          postEditButton.isHidden = true
          cancelEditButton.isHidden = true
        
        editView.isHidden = true
        CommentsTextView.delegate = self
        CommentsTextView.text = "Add a comment"
        CommentsTextView.textColor = UIColor.lightGray
        editView.isHidden = true
       // editView.layer.backgroundColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        
       
        super.setSelected(selected, animated: animated)
        
      

        // Configure the view for the selected state
    }

}
