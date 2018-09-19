//
//  commentsControllerFoodHelp.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 05/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class commentsControllerFoodHelp: UITableViewCell{

    @IBOutlet weak var viewallRepliesLabel: UILabel!
    @IBOutlet weak var c: UILabel!
    @IBOutlet weak var viewComments: UITextView!
    @IBOutlet weak var viewAllRepliesBtn: UIButton!
    @IBOutlet weak var replyTable: UITableView!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        replyTable.delegate = self
        replyTable.dataSource = self
        let nib = UINib.init(nibName: "ReplayTableViewCell", bundle: nil)
        self.replyTable.register(nib, forCellReuseIdentifier: "replyCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

}

extension commentsControllerFoodHelp:UITableViewDelegate,UITableViewDataSource

{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if replyValue == 1
        {
            return rowVal
        }
        else
        {
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! ReplayTableViewCell
//        cell.replyText.text = ((CommentRepliesArray[indexPath.row] as AnyObject).value(forKey: "reply") as! NSArray).value(forKey: "ans_cmmt_reply") as! String
        cell.replyText.text! =  ((((CommentRepliesArray[indexPath.row] as AnyObject).value(forKey: "reply") as! NSArray)[0] as AnyObject).value(forKey: "ans_cmmt_reply") as? String)!
        if  (CommentRepliesArray[indexPath.row] as AnyObject).value(forKey: "total_cmmt_reply") as! String == "0"
       {
        cell.replyView.isHidden = true
        
        }
        
        else
       {
        cell.replyView.isHidden = false
        }
        cell.replyText.numberOfLines = 0
       // cell.replyText.numberOfLines = 0
        cell.replyText.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.replyText.sizeToFit()
        //cell.replyView.sizeToFit()
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }







}

