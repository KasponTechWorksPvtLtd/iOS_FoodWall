//
//  myTableTableViewCell.swift
//  nithya
//
//  Created by Ramesh Ponnuvel on 14/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class myTableTableViewCell: UITableViewCell {

    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    @IBOutlet weak var myAddTableView: UITableView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var profImage: UIImageView!
    
  //  @IBOutlet weak var deletebtn: UIImageView!
    
    @IBOutlet weak var daysAgoLabel: UILabel!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profImage.layer.cornerRadius = profImage.frame.size.width/2
        profImage.clipsToBounds = true
        myAddTableView.tableFooterView = UIView()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
