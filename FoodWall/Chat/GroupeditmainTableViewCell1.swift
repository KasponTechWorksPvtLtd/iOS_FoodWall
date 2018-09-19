//
//  GroupeditmainTableViewCell1.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 31/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class GroupeditmainTableViewCell1: UITableViewCell {

    @IBOutlet weak var namelabel: UILabel!
     var data : [NSDictionary]?
    @IBOutlet weak var mycollection: UICollectionView!
    @IBOutlet weak var hourslabel: UILabel!
    // collectbucketview
    
    
 
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
