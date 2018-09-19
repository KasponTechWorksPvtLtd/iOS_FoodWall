//
//  timelineCollectionCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 05/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class timelineCollectionCell: UICollectionViewCell,UIScrollViewDelegate


    
{
    
    
    @IBOutlet weak var homeScroll: UIScrollView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet var bgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homeScroll.delegate = self
        
        
        
    }
    
}
