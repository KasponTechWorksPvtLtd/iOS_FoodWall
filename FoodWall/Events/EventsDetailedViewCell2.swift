//
//  EventsDetailedViewCell2.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 24/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit


protocol HeightForTextView {
    func heightOfTextView(height: CGFloat)
    
}
var extendHeightto : CGFloat = 0
var extendHeightto1 : CGFloat = 0
class EventsDetailedViewCell2: UITableViewCell {
    
     var delgate:HeightForTextView?
    
    @IBOutlet var editorDeletemenu: UIButton!
    @IBOutlet var deleterowBtn: UIButton!
    @IBOutlet var editrowBtn: UIButton!
    @IBOutlet var editView: UIView!
    @IBOutlet var profName: UILabel!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var rowComments: UITextView!
    
    @IBOutlet var timesAgoLabel: UILabel!
    @IBOutlet var cancelBUtton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rowComments.sizeThatFits(CGSize(width: rowComments.frame.size.width, height: rowComments.frame.size.height))
         extendHeightto = rowComments.frame.size.height
        
        editView.isHidden = true
        postButton.isHidden = true
        cancelBUtton.isHidden = true
        // Initialization code
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        var fixedWidth: CGFloat = rowComments.frame.size.width
        var newSize: CGSize = rowComments.sizeThatFits(CGSize(width: rowComments.frame.size.width, height: rowComments.frame.size.height))
        
        if let iuDelegate = self.delgate {
            
            iuDelegate.heightOfTextView(height: newSize.height)
        }
        
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
