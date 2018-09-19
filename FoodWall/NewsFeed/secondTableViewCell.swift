//
//  secondTableViewCell.swift
//  nithya
//
//  Created by Ramesh Ponnuvel on 14/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class secondTableViewCell: UITableViewCell {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var mytesxt: UILabel!
    
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var editBtn: UIButton!
    
  //  @IBOutlet weak var deleteBtn1: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var daysAgoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        profImage.layer.cornerRadius = profImage.frame.size.width/2
        profImage.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
