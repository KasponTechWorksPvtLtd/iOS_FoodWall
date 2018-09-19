//
//  reviewDetailsCell1.swift
//  nithya
//
//  Created by apple on 7/27/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class reviewDetailsCell1: UITableViewCell {

    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    var data : [String]?
    var data1 : [String]?
    var data2 : [String]?
    
    
    @IBOutlet weak var valueStar1: UIImageView!
    
    @IBOutlet weak var valueStar2: UIImageView!
    @IBOutlet weak var valueStar3: UIImageView!
    @IBOutlet weak var valueStar4: UIImageView!
    @IBOutlet weak var valueStar5: UIImageView!
    
    @IBOutlet weak var tasteStar1: UIImageView!
    @IBOutlet weak var tasteStar2: UIImageView!
    @IBOutlet weak var tasteStar3: UIImageView!
    @IBOutlet weak var tasteStar4: UIImageView!
    @IBOutlet weak var tasteStar5: UIImageView!
    
    @IBOutlet weak var serviceStar1: UIImageView!
     @IBOutlet weak var serviceStar2: UIImageView!
     @IBOutlet weak var serviceStar3: UIImageView!
     @IBOutlet weak var serviceStar4: UIImageView!
     @IBOutlet weak var serviceStar5: UIImageView!
   
    
    @IBOutlet weak var dishesToAvoidView: UIView!
    @IBOutlet weak var topDishesView: UIView!
    @IBOutlet weak var ambianceView: UIView!
    @IBOutlet weak var ambianceStar1: UIImageView!
     @IBOutlet weak var ambianceStar2: UIImageView!
     @IBOutlet weak var ambianceStar3: UIImageView!
     @IBOutlet weak var ambianceStar4: UIImageView!
     @IBOutlet weak var ambianceStar5: UIImageView!
    
    
    @IBOutlet weak var newCollectTable2: UICollectionView!
    @IBOutlet weak var newCollectTable1: UICollectionView!
    @IBOutlet weak var newCollectTable: UICollectionView!
    @IBOutlet weak var hotelNAME: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newCollectTable.tag = 0
        newCollectTable1.tag = 1
        newCollectTable2.tag = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
