//
//  storyCollectionViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 06/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class storyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var youLabel: UILabel!
    
    @IBOutlet var B1: UIButton!
    
    @IBOutlet weak var storyBorder: UILabel!
    @IBOutlet var storyLabel: UILabel!
    
    @IBOutlet var storyImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        storyImageView.layer.cornerRadius = storyImageView.frame.size.width/2
         storyImageView.clipsToBounds = true
        storyBorder.layer.cornerRadius = storyBorder.frame.size.width/2
        storyBorder.clipsToBounds = true
        storyBorder.layer.borderColor = UIColor.orange.cgColor
        storyBorder.layer.borderWidth = 2.0
        // storyImageView.layer.masksToBounds = false
        
        
    }
    
}
