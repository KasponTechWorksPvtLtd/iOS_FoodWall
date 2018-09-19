//
//  demoView1.swift
//  newProject
//
//  Created by MacosHighSierra10.13.4 on 28/06/18.
//  Copyright © 2018 MacosHighSierra10.13.4. All rights reserved.
//

import UIKit

class demoView1: UIView {

    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(_ rect: CGRect) {
        //    self.createRectangle()
        //  self.createTriangle()
        
        // Specify the fill color and apply it to the path.
        
        path = UIBezierPath(roundedRect: self.bounds,
                            byRoundingCorners: [.topRight, .bottomRight,.bottomLeft],
                            cornerRadii: CGSize(width: 75.0, height: 0.0))
         UIColor(red: 255/255, green: 114/255, blue: 41/255, alpha: 1.0).setFill()
        path.fill()
        // Specify a border (stroke) color.
        UIColor.orange.setStroke()
        path.stroke()
    }

}
