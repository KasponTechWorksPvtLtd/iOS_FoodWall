//
//  writePostCell.swift
//  mapsLearn
//
//  Created by Ramesh Ponnuvel on 10/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
protocol CategoryRowDelegate:class {
    func cellTapped()
}


class writePostCell: UICollectionViewCell {
    
    @IBOutlet weak var hotelAddress: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelPic: UIImageView!
    @IBOutlet weak var view1: UIView!
}
