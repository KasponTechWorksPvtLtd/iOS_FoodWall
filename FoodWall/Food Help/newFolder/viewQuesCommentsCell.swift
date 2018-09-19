//
//  viewQuesCommentsCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 30/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

var replyValue : Int = 0
var rowVal : Int = 0

class viewQuesCommentsCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate{

   // @IBOutlet var label2: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var userImage: UIImageView!
//    @IBOutlet weak var userComments: UITextView!
//    @IBOutlet weak var voteView: UIView!
//    @IBOutlet weak var downvoteimg: UIImageView!
//    @IBOutlet weak var upvoteimg: UIImageView!
//    @IBOutlet weak var downVoteBtn: UIButton!
//    @IBOutlet weak var upvoteBtn: UIButton!
//    @IBOutlet weak var cancelBtn: UIButton!
//    @IBOutlet weak var postBtn: UIButton!
//    @IBOutlet weak var commentsTextView: UITextView!
//    @IBOutlet weak var dateTImeLabel: UILabel!
//    @IBOutlet weak var editDeleteBtn: UIButton!
    //@IBOutlet weak var userName: UILabel!
    
    
    @IBOutlet weak var commentView: UIView!
    
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var view1: UIView!
  //  @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var userComments: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet var view2: UIView!
    @IBOutlet var giveComments: UITextView!
    @IBOutlet var voteView: UIView!
    @IBOutlet var downvoteimg: UIImageView!
    @IBOutlet var upvoteimg: UIImageView!
    @IBOutlet var downVoteBtn: UIButton!
    @IBOutlet var upvoteBtn: UIButton!
    @IBOutlet var postBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
   // @IBOutlet var userComments: UITextView!
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var dateTImeLabel: UILabel!
    
    @IBOutlet var editDeleteBtn: UIButton!
    
    @IBOutlet weak var viewAllComts: UIButton!
    
    
    
    @IBOutlet weak var view4: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postButton.applyGradientButtongreen()
        postButton.layer.cornerRadius = 10.0
        postButton.clipsToBounds = true
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.borderWidth = 1.0
        cancelButton.layer.cornerRadius = 5.0
        cancelButton.clipsToBounds = true
        postButton.isHidden = true
        cancelButton.isHidden = true
        editDeleteBtn.isHidden = true
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.estimatedRowHeight = 100.0
        commentsTable.rowHeight = UITableViewAutomaticDimension
        let nib = UINib.init(nibName: "commentsControllerFoodHelp", bundle: nil)
        self.commentsTable.register(nib, forCellReuseIdentifier: "comntCell")
        
       // self.commentsTable.register(nib, forCellReuseIdentifier: "cell3")
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comntCell", for: indexPath) as! commentsControllerFoodHelp
        commentsTable.frame.size.height = commentsTable.contentSize.height
        dispCellHeight = commentsTable.frame.size.height
        cell.viewComments.text = (CommentRepliesArray[indexPath.row] as AnyObject).value(forKey: "ans_comments") as! String
        if (CommentRepliesArray[indexPath.row] as AnyObject).value(forKey: "total_cmmt_reply") as! String == "0"
        {
            cell.viewAllRepliesBtn.isHidden = true
            cell.viewallRepliesLabel.isHidden = true
            
            
        }
        
        else
        {
            cell.viewAllRepliesBtn.isHidden = false
             cell.viewallRepliesLabel.isHidden = false
        }
        cell.viewAllRepliesBtn.tag = indexPath.row
        cell.viewAllRepliesBtn.addTarget(self, action: #selector(viewAllReplies), for: .touchUpInside)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentRepliesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @objc func viewAllReplies(sender : UIButton!)
    {
        let cell = commentsTable.cellForRow(at: IndexPath(row:sender.tag,section : 0)) as! commentsControllerFoodHelp
       
        replyValue = 1
        rowVal = Int((CommentRepliesArray[sender.tag] as AnyObject).value(forKey: "total_cmmt_reply") as! String)!
        commentsTable.reloadRows(at: [IndexPath(row : sender.tag ,section : 0)], with: .none)
        cell.replyTable.reloadData()
        
    }
    
    

}



