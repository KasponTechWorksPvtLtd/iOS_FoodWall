//
//  DemoView.swift
//  newProject
//
//  Created by MacosHighSierra10.13.4 on 27/06/18.
//  Copyright © 2018 MacosHighSierra10.13.4. All rights reserved.
//

import UIKit

class DemoView: UIView {

    
 

  
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
                            byRoundingCorners: [.topLeft, .bottomRight,.bottomLeft],
                            cornerRadii: CGSize(width: 75.0, height: 0.0))
       // UIColor.orange.setFill()
       // path.fill()
        
        UIColor(red: 255/255, green: 114/255, blue: 41/255, alpha: 1.0).setFill()
        path.fill()
        
        // Specify a border (stroke) color.
        UIColor.orange.setStroke()
        path.stroke()
    }
func createTriangle() {
    path = UIBezierPath()
    path.move(to: CGPoint(x: self.frame.width/2, y: 0.0))
    path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
    path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
    path.close()
}
}
