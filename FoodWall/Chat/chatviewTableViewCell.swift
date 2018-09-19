//
//  chatviewTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 24/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class chatviewTableViewCell: UITableViewCell {

    @IBOutlet weak var leftview: UIView!
    
    @IBOutlet weak var lefttextview: UITextView!
    
    @IBOutlet weak var rightview: UIView!
    
    @IBOutlet weak var righttextview: UITextView!
    
    @IBOutlet weak var maintextview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //lefttextview.translatesAutoresizingMaskIntoConstraints = false
         //righttextview.translatesAutoresizingMaskIntoConstraints = false
        lefttextview.isScrollEnabled = false
        righttextview.isScrollEnabled = false
        lefttextview.isUserInteractionEnabled = false
        righttextview.isUserInteractionEnabled = false
        lefttextview.layer.borderColor = UIColor.black.cgColor
        lefttextview.layer.borderWidth = 0.2
        lefttextview.layer.cornerRadius = 10
        righttextview.layer.cornerRadius = 10
        maintextview.isUserInteractionEnabled = false
        maintextview.isScrollEnabled = false
        maintextview.layer.borderWidth = 0.2
        maintextview.layer.cornerRadius = 10
       // lefttextview.isHidden = true
       // righttextview.isHidden = true
        
        
//        let contentSize = lefttextview.sizeThatFits(lefttextview.bounds.size)
//        var frame = lefttextview.frame
//        frame.size.height = contentSize.height
//        lefttextview.frame = frame
//
//        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: lefttextview, attribute: .height, relatedBy: .equal, toItem: lefttextview, attribute: .width, multiplier: lefttextview.bounds.height/lefttextview.bounds.width, constant: 1)
//        lefttextview.addConstraint(aspectRatioTextViewConstraint)
        
        
        let contentSize = lefttextview.sizeThatFits(lefttextview.bounds.size)
        var frame = lefttextview.frame
        frame.size.width = contentSize.width
        lefttextview.frame = frame
        
//        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: lefttextview, attribute: .height, relatedBy: .equal, toItem: lefttextview, attribute: .width, multiplier: lefttextview.bounds.height/lefttextview.bounds.width, constant: 1)
//        lefttextview.addConstraint(aspectRatioTextViewConstraint)
        
        
        
        
        
        
        
//        let fixedWidth = lefttextview.frame.size.width
//        
//        lefttextview.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        
//        let newSize = lefttextview.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        
//        var newFrame = lefttextview.frame
//        
//        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
//        
//        lefttextview.frame = newFrame
//        
//        lefttextview.setContentOffset(.zero, animated: false)
//         lefttextview.isUserInteractionEnabled = false
//       
//        let fixedWidth1 = righttextview.frame.size.width
//        
//        righttextview.sizeThatFits(CGSize(width: fixedWidth1, height: CGFloat.greatestFiniteMagnitude))
//        
//        let newSize1 = righttextview.sizeThatFits(CGSize(width: fixedWidth1, height: CGFloat.greatestFiniteMagnitude))
//        
//        var newFrame1 = righttextview.frame
//        
//        newFrame.size = CGSize(width: max(newSize1.width, fixedWidth1), height: newSize1.height)
//        
//        righttextview.frame = newFrame1
//        
//        righttextview.setContentOffset(.zero, animated: false)
//        righttextview.isUserInteractionEnabled = false
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
    }

}
