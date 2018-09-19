//
//  ShadowView.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
    }

}
class ShadowViewlayer: UIView {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 0.0
        self.layer.masksToBounds = false
    }
    
}


