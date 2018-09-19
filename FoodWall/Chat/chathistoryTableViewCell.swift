//
//  chathistoryTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 26/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class chathistoryTableViewCell: UITableViewCell {

   
    
    
    @IBOutlet weak var maintextview: UILabel!
    
  
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        maintextview.layer.borderColor = UIColor.black.cgColor
        maintextview.layer.borderWidth = 0.2
        maintextview.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

class senderTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var sendtextview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        sendtextview.layer.borderColor = UIColor.black.cgColor
        sendtextview.layer.borderWidth = 0.2
        sendtextview.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
}
}
class receiverTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var receivetextview: UILabel!
    @IBOutlet weak var proimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        receivetextview.layer.borderColor = UIColor.black.cgColor
        receivetextview.layer.borderWidth = 0.2
        receivetextview.layer.cornerRadius = 10
        proimage.layer.cornerRadius = proimage.frame.size.width/2
        proimage.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
