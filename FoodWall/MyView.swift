//
//  MyView.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class MyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     
     
     */
    override func draw(_ rect: CGRect) {
     let c = UIGraphicsGetCurrentContext()
        c!.addRect(CGRect(x:10,y: 10,width:80, height:80))
        c!.setStrokeColor(UIColor.red.cgColor)
        c!.strokePath()
    }
  

}
