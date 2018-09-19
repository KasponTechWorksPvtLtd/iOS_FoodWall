//
//  viewQuestionController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



 var dispCellHeight : CGFloat = 0.0
 var CommentRepliesArray : NSArray = []
 var red = viewQuestionController()
class viewQuestionController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    
   
    @IBOutlet weak var RequestView: UIView!
    @IBOutlet weak var displayTable: UITableView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    var question_id : String = ""
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var quesLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var reQmainView: UIView!
    @IBOutlet weak var borderLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var askedLabell: UILabel!
    @IBOutlet weak var userName: UILabel!
    var quesAnsArray : NSArray = []
     var heightArray : NSMutableArray = []
   
    var act : String = ""
    var rowNum : Int = 0
    var a : Int = 0
    var b : Int = 0
    var followid : String = "0"
   
    var rowNumber : Int = 1000
    
   
    
    @IBOutlet weak var topAnswer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getAnsAll()
        red = self
        displayTable.delegate = self
        displayTable.dataSource = self
        displayTable.estimatedRowHeight = 160.0
        displayTable.rowHeight = UITableViewAutomaticDimension
        
        headerView.addDropShadowToView(targetView: headerView)
        

        scroll.delegate = self
        scroll.contentSize = CGSize(width : self.view.frame.size.width,height : self.displayTable.frame.height)
        
//        topAnswer.lineBreakMode = .byWordWrapping // notice the 'b' instead of 'B'
//        topAnswer.numberOfLines = 0
         // headerView.addShadowView()
        print(question_id)
        Utils.setPreferenceValue(setValue: question_id , ForKey: Constant.QUESTION_ID)
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        headerView.layer.masksToBounds =  false
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset =  CGSize(width: 2, height: 3)
        headerView.layer.shadowOpacity = 1.0
    }
    
    func cont()
    {
        reQmainView.isHidden = true
        RequestView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismmissAction(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if quesAnsArray.count == 0
        {
            if indexPath.section == 0
            {
                return UITableViewAutomaticDimension
            }
            else {
            return 0
            }
        }
        else
        {
        if indexPath.section == 0
        {
        return UITableViewAutomaticDimension
        }
        else
        {
            if rowNumber == indexPath.row && a == 1
            {
              
                return 900.0

            }
            else
            {
                
           return UITableViewAutomaticDimension
            }
            return UITableViewAutomaticDimension
        }
        }
    }
  func  getAnsAll()
    {
        Utils.svprogressHudShow(title: "Loading...", view: self)

//    indicator.hidesWhenStopped = true
//    indicator.startAnimating()
    let params: [String:String] = [ "userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "quesid":question_id ]
    
    
    let urlString = "\(Constant.BASEURL)\(Constant.GET_ANSWER_ALL)"
    
    Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
    let result = response.result
    let json = JSON(data: response.data!)
    
    if let resData = json["Data"].arrayObject {
    
        self.quesAnsArray = resData as!  NSArray
    
    if(self.quesAnsArray.count != 0){
    
    
    print(self.quesAnsArray)
    
       if self.act == ""
        {
           
            Utils.svprogressHudDismiss(view: self)
           // self.indicator.stopAnimating()
       self.displayTable.reloadData()
        }
        else
        {
           
            Utils.svprogressHudDismiss(view: self)
//            self.indicator.stopAnimating()
            let indexPath = IndexPath(item:  self.rowNum, section: 1)
            self.displayTable.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    else
    
    {
       
        Utils.svprogressHudDismiss(view: self)
  //  self.indicator.stopAnimating()
    
    
    }
    }
        
        
        else
       {
       
        Utils.svprogressHudDismiss(view: self)
         //self.indicator.stopAnimating()
        
        }
    
    
    }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       if quesAnsArray.count != 0
      {
        if section == 0
        {
            return 1
        }
        else
        {
            return quesAnsArray.count
        }
        }
        else
        {
            if section == 0
            {
                return 1
            }
            else {
                return 0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! viewQuesTableCell
            
              if quesAnsArray.count == 0
              {
            cell.topAns.text = "Not yet answered"
            }
              else {
            
            cell.topAns.text = ("  ") + "\((quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "total_answers") as! String)  Answers"
            cell.profname.text! = Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME) + " " + Utils.getPreferenceValue(ForKey: Constant.LAST_NAME)
            cell.selectionStyle = .none
            cell.commentTextView.text = "Add your Answer"
            cell.commentTextView.delegate = self
            cell.commentTextView.textColor = UIColor.lightGray
            
            cell.questn.text = (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "ask_question") as! String
            cell.questn.numberOfLines = 0
            cell.questn.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.questn.sizeToFit()
            }
//            cell.upvoteBtn.tag = indexPath.row
//            cell.downVoteBtn.tag = indexPath.row
            
            if followid == "1"
            
            {
                cell.followimage.image = #imageLiteral(resourceName: "wifi-waves-Blue")
                cell.followLabel.textColor = UIColor.blue
                cell.followLabel.text = "Following"
            }
            else
            {
                cell.followimage.image = #imageLiteral(resourceName: "wifi-waves")
                cell.followLabel.textColor = UIColor.black
                cell.followLabel.text = "Follow"
            }
//            if (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "up_down_vote") as! String == "1"
//               {
//
//                cell.upvoteimg.image =  #imageLiteral(resourceName: "colourup")
//                cell.downvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
//
//               }
//
////                else if (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "up_down_vote") as! String == "2"
////                {
////                cell.upvoteimg.image =  #imageLiteral(resourceName: "up-chevron-button-2")
////                cell.downvoteimg.image = #imageLiteral(resourceName: "color_down")
////                }
////                
////                else
////                {
////                    cell.upvoteimg.image =  #imageLiteral(resourceName: "up-chevron-button-2")
////                    cell.downvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
////                }
           
            
//            cell.upvoteBtn.addTarget(self, action: #selector(voteActn), for: .touchUpInside)
//            cell.downVoteBtn.addTarget(self, action: #selector(voteActn1), for: .touchUpInside)
            cell.ansButton.addTarget(self, action: #selector(ansActn), for: .touchUpInside)
            cell.postBtn.addTarget(self, action: #selector(postActnNew), for: .touchUpInside)
            cell.followButton.addTarget(self, action: #selector(FollowAct), for: .touchUpInside)
            cell.requestBtn.addTarget(self, action: #selector(RequestAct), for: .touchUpInside)
            
             return cell
        
        }
        else
        {
            
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! viewQuesCommentsCell
            
            cell.postButton.tag = indexPath.row + 1000
            cell.cancelButton.tag = indexPath.row + 2000
            cell.upvoteBtn.tag = indexPath.row + 3000
            cell.downVoteBtn.tag = indexPath.row + 4000
            
            cell.editDeleteBtn.tag = indexPath.row + 5000
             cell.giveComments.delegate = self
            cell.selectionStyle = .none
            cell.userComments.delegate = self
          //  cell.userComments.text = "Add your answer"
            cell.userComments.textColor = UIColor.lightGray
            cell.userComments.isUserInteractionEnabled = true
            cell.userName.text! = "\(String(describing: (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)) \(String(describing: (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "last_name")!))"
            let createdTime = "\((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
            let date1 = UTCToLocal(UTCDateString: createdTime)
            
            
            let dateFormatter = DateFormatter()
            
            
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let UTCToCurrentFormat = dateFormatter.date(from: date1)!
            
            cell.dateTImeLabel.text = (UTCToCurrentFormat.getElapsedInterval())
            
            cell.editDeleteBtn.addTarget(self, action: #selector(editDeleteAction), for: .touchUpInside)
            
            cell.upvoteBtn.addTarget(self, action: #selector(upvoteActn(sender:)), for: .touchUpInside)
            cell.downVoteBtn.addTarget(self, action: #selector(downvoteActn(sender:)), for: .touchUpInside)
            
            cell.label2.text = (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "ask_answer") as! String
            
            cell.label2.numberOfLines = 0
            cell.label2.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.label2.sizeToFit()
            cell.view2.sizeToFit()
            cell.userComments.text = (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "ask_answer") as! String
           // cell.userComments.sizeToFit()
            if Utils.getPreferenceValue(ForKey: Constant.USER_ID) ==  (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "created_by") as! String
            {
                cell.editDeleteBtn.isHidden = false
                

            }

            else
            {
               cell.editDeleteBtn.isHidden = true
            }
            
            
            
            if (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "up_down_vote") as! String == "1"
            {
                cell.upvoteimg.image =  #imageLiteral(resourceName: "colourup")
                cell.downvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
                
            }
                
            else if (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "up_down_vote") as! String == "2"
            {
                cell.upvoteimg.image =  #imageLiteral(resourceName: "up-chevron-button-2")
                cell.downvoteimg.image = #imageLiteral(resourceName: "color_down")
            }
                
            else
            {
                cell.upvoteimg.image =  #imageLiteral(resourceName: "up-chevron-button-2")
                cell.downvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
            }
            

            
            cell.viewAllComts.addTarget( self ,action: #selector(viewAllComments),for : .touchUpInside)
            cell.viewAllComts.tag = indexPath.row + 7000
            if (quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "total_comments") as! String == "0"
            {
                cell.commentView.isHidden = true
            }
            else
            {
                cell.commentView.isHidden = false
            }
            

            cell.commentsTable.frame.size.height = cell.commentsTable.contentSize.height
            dispCellHeight = cell.commentsTable.frame.size.height
            
             return cell
        }
        
        
       
    }
    
    @objc func viewAllComments(sender:UIButton!)
    {
        let cell = displayTable.cellForRow(at: IndexPath(row : sender.tag - 7000 ,section : 1)) as! viewQuesCommentsCell
        //dispCell = "1"
        rowNumber = sender.tag - 7000
        heightArray.add(rowNumber)
        a = 1
        
        let params: [String:String] = [ "userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"ansid":(quesAnsArray[sender.tag - 7000] as! AnyObject).value(forKey: "ans_id") as! String]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_ANSWER_COMMENT_ALL)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
             CommentRepliesArray = resData as! [[String:AnyObject]] as! NSArray
                
                if(CommentRepliesArray.count != 0){
                    
                    
                    let indexPath = IndexPath(item: sender.tag - 7000, section: 1)
                    self.displayTable.reloadRows(at: [indexPath], with: .none)
                    cell.commentsTable.reloadData()
                    
                }
                    
                else
                    
                {
                    
//                    print(self.dataArray1)
                   
                    
                }
            }
            
            
        }
        
        
        displayTable.reloadRows(at: [IndexPath(row : sender.tag - 7000,section : 1 )], with: .none)
        cell.commentsTable.reloadData()
        
        
        
    }
    
    
    
    
    
    
    @objc func editDeleteAction(sender:UIButton!)
    {
        
        let cell = displayTable.cellForRow(at: IndexPath(row: sender.tag - 5000 ,section: 1)) as! viewQuesCommentsCell
        
        let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
           // let cell = displayTable.cellForRow(at: IndexPath(row:sender.tag,section:1)) as! tableCell2
//            self.rowNum = sender.tag - 5000
//            self.editCall()
          //  let cell = self.displayTable.cellForRow(at: IndexPath(row: sender.tag - 5000 ,section: 1)) as! viewQuesCommentsCell
            
            cell.label2.isHidden = true
            let heightContraints = NSLayoutConstraint(item: cell.view2, attribute:
                .height, relatedBy: .equal, toItem: nil,
                         attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                         constant: 110)
            
            let widthContraints = NSLayoutConstraint(item: cell.view2, attribute:
                .width, relatedBy: .equal, toItem: nil,
                        attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                        constant: 375)
            NSLayoutConstraint.activate([heightContraints,widthContraints])
            cell.userComments.isHidden = false
            cell.view2.sizeToFit()
            cell.postButton.isHidden = false
            cell.cancelButton.isHidden = false
            
            
            // cell.view2.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            
            cell.postButton.addTarget(self, action: #selector(self.postActn(sender:)), for: .touchUpInside)
            cell.cancelButton.addTarget(self, action: #selector(self.cancelAction(sender:)), for: .touchUpInside)
           
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            
            let params: [String:String] = [ "created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "question_id":self.question_id ,"ansid": (self.quesAnsArray[sender.tag - 5000] as! AnyObject).value(forKey: "ans_id") as! String]
            
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_ANSWER)"
            
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseMessage"] == "success" {
                    
                    print("Success:")
                    self.getAnsAll()
                    
                    
                }
                    
                else
                {
                    
                    print("Nothing")
                }
                
                
            }
            
            
           
        }))
        
        
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func editCall()
    {
        
        let cell = displayTable.cellForRow(at: IndexPath(row: rowNum ,section: 1)) as! viewQuesCommentsCell
        
        cell.label2.isHidden = true
        let heightContraints = NSLayoutConstraint(item: cell.view2, attribute:
            .height, relatedBy: .equal, toItem: nil,
                     attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                     constant: 110)
        
        let widthContraints = NSLayoutConstraint(item: cell.view2, attribute:
            .width, relatedBy: .equal, toItem: nil,
                    attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                    constant: 375)
        NSLayoutConstraint.activate([heightContraints,widthContraints])
        cell.userComments.isHidden = false
        cell.view2.sizeToFit()
        cell.postButton.isHidden = false
        cell.cancelButton.isHidden = false
        
        
        // cell.view2.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        cell.postButton.addTarget(self, action: #selector(self.postActn(sender:)), for: .touchUpInside)
        cell.cancelButton.addTarget(self, action: #selector(self.cancelAction(sender:)), for: .touchUpInside)
    }
    
    
    @objc func voteActn(sender:UIButton!)
    {
    
        
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag,section:0)) as! viewQuesTableCell
        
        var voteValue : String = ""
        if cell.upvoteimg.image == #imageLiteral(resourceName: "up-chevron-button-2")
        {
           voteValue = "1"
           cell.upvoteimg.image = #imageLiteral(resourceName: "colourup")
            if cell.downvoteimg.image == #imageLiteral(resourceName: "color_down")
            
            {
               cell.downvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
                
            }
            
        }
        
        else
        {
            voteValue = "0"
            cell.upvoteimg.image = #imageLiteral(resourceName: "up-chevron-button-2")
            
        }
        
        
        let params: [String:String] = [ "created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "vote":voteValue ,"ansid" :(quesAnsArray[sender.tag] as! AnyObject).value(forKey: "ans_id") as! String ]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER_VOTES)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseMessage"] == "success" {
                
                print("Success:")
                
                
            }
            
            else
            {
                
                print("Nothing")
            }
            
            
        }
        
        
       
        
        
        
    }
    @objc func downvoteActn(sender:UIButton!)
    {
        
        
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag - 4000,section:1)) as! viewQuesCommentsCell
        
        var voteValue : String = ""
        if cell.downvoteimg.image == #imageLiteral(resourceName: "chevron-sign-down")
        {
            voteValue = "2"
            cell.downvoteimg.image = #imageLiteral(resourceName: "color_down")
            
            if cell.upvoteimg.image == #imageLiteral(resourceName: "colourup")
                
            {
                cell.upvoteimg.image = #imageLiteral(resourceName: "up-chevron-button-2")
                
            }
            
        }
            
        else
        {
            voteValue = "0"
            cell.upvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
            
        }
        
        
        let params: [String:String] = [ "created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "vote":voteValue ,"ansid" :(quesAnsArray[sender.tag-4000] as! AnyObject).value(forKey: "ans_id") as! String ]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER_VOTES)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseMessage"] == "success" {
                
                print("Success:")
                
                
            }
                
            else
            {
                
                print("Nothing")
            }
            
            
        }
        
        
        
        
        
        
    }
    @objc func upvoteActn(sender:UIButton!)
    {
        
        
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag - 3000,section:1)) as! viewQuesCommentsCell
        
        var voteValue : String = ""
        if cell.upvoteimg.image == #imageLiteral(resourceName: "up-chevron-button-2")
        {
            voteValue = "1"
            cell.upvoteimg.image = #imageLiteral(resourceName: "colourup")
            if cell.downvoteimg.image == #imageLiteral(resourceName: "color_down")
                
            {
                cell.downvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
                
            }
            
        }
            
        else
        {
            voteValue = "0"
            cell.upvoteimg.image = #imageLiteral(resourceName: "up-chevron-button-2")
            
        }
        
        
        let params: [String:String] = [ "created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "vote":voteValue ,"ansid" :(quesAnsArray[sender.tag-3000] as! AnyObject).value(forKey: "ans_id") as! String ]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER_VOTES)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseMessage"] == "success" {
                
                print("Success:")
                
                
            }
                
            else
            {
                
                print("Nothing")
            }
            
            
        }
        
        
        
        
        
        
    }
    @objc func ansActn(sender:UIButton!)
    {
        
        
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag,section:0)) as! viewQuesTableCell
        
       cell.commentTextView.becomeFirstResponder()
        
        }
    
    @objc func RequestAct(sender:UIButton!)
    {
        
        reQmainView.isHidden = false
        RequestView.isHidden = false
      //  displayContentController(content: FollowsSelectTableVC)
        
        
           // remove(asChildViewController: sessionsViewController)
         //  add(asChildViewController: summaryViewController)
        
//        remove(asChildViewController: FollowsSelectTableVC)
//            add(asChildViewController: sessionsViewController)
       
    }
    
   
    
    
    
    @objc func FollowAct(sender:UIButton!)
    {
        
        
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag,section:0)) as! viewQuesTableCell
        
        var follow : String = "0"
        
        if cell.followimage.image == #imageLiteral(resourceName: "wifi-waves")
        {
            
            cell.followimage.image = #imageLiteral(resourceName: "wifi-waves-Blue")
            cell.followLabel.text = "Following"
            cell.followLabel.textColor = UIColor.blue
            follow = "1"
            
        }
        
        else
        {
            cell.followimage.image = #imageLiteral(resourceName: "wifi-waves")
            follow = "0"
            cell.followLabel.text = "Follow"
            cell.followLabel.textColor = UIColor.black
        }
        
        
        
        let params: [String:String] = ["quesid" :question_id, "ques_created_by" : (quesAnsArray[sender.tag] as! AnyObject).value(forKey: "created_by") as! String,"follow" : follow,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID) ]
       // self.rowNum = sender.tag
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_QUESTION_FOLLOWER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if  json["ResponseMessage"] == "success" {
                
                print("Follow Success")
                
                
                
                
            }
                
            else
                
            {
                
                print("Nothing")
                
                
            }
            
            
            
        }
        
       
        
    }
    @objc func postActn(sender:UIButton!)
    {
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag - 1000,section:1)) as! viewQuesCommentsCell
        
      //  print("postAction")
        
       
        
        let params: [String:String] = ["question_id" :question_id, "created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID),"latitude" : "12.78861","longitude" : "80.54645","ask_answer" :cell.userComments.text!,"poll_id":"","ques_type":"0","ansid":(quesAnsArray[sender.tag-1000] as AnyObject).value(forKey: "ans_id") as! String]
        self.rowNum = sender.tag - 1000
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if  json["ResponseMessage"] == "success" {
                
                print("Post Success")
                
                self.getAnsAll()
                self.act = "1"
                
                
               }
                
            else
                
            {
                
                print("Nothing")
                
                
            }
            
            
            
        }
        
        
        }
    
    @objc func postActnNew(sender:UIButton!)
    {
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag,section:0)) as! viewQuesTableCell
        
        //  print("postAction")
        
        
        
        let params: [String:String] = ["question_id" :question_id, "created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID),"latitude" : "12.78861","longitude" : "80.54645","ask_answer" :cell.commentTextView.text!,"poll_id":"","ques_type":"0","ansid":"0"]
       // self.rowNum = sender.tag
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if  json["status"] == 200 {
                
                print("Post Success")
                
                self.getAnsAll()
                //self.act = "1"
                
                
            }
                
            else
                
            {
                
                print("Nothing")
                
                
            }
            
            
            
        }
        
        
    }
    
    @objc func cancelAction(sender:UIButton!)
    {
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag - 2000,section:1)) as! viewQuesCommentsCell
//        cell.commentsTextView.isUserInteractionEnabled = false
//        cell.commentsTextView.frame = CGRect(x:10,y:80,width:cell.commentsTextView.frame.width,height:cell.commentsTextView.frame.height)
        cell.postButton.isHidden = true
        cell.cancelButton.isHidden = true
        cell.userComments.isHidden = true
        cell.label2.isHidden = false
        cell.label2.text = (quesAnsArray[sender.tag - 2000] as! AnyObject).value(forKey: "ask_answer") as! String
        
        print("Cancel Action")
        
        
    }
    
    
    
    @objc func voteActn1(sender:UIButton!)
    {
        
        
        let cell = displayTable.cellForRow(at: IndexPath(row :sender.tag,section:0)) as! viewQuesTableCell
        
        var voteValue : String = ""
        if cell.downvoteimg.image == #imageLiteral(resourceName: "chevron-sign-down")
        {
            voteValue = "2"
            cell.downvoteimg.image = #imageLiteral(resourceName: "color_down")
            
            if cell.upvoteimg.image == #imageLiteral(resourceName: "colourup")
                
            {
                cell.upvoteimg.image = #imageLiteral(resourceName: "up-chevron-button-2")
                
            }
            
        }
            
        else
        {
            voteValue = "0"
            cell.upvoteimg.image = #imageLiteral(resourceName: "chevron-sign-down")
            
        }
        
        
        let params: [String:String] = [ "created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "vote":voteValue ,"ansid" :(quesAnsArray[sender.tag] as! AnyObject).value(forKey: "ans_id") as! String ]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER_VOTES)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseMessage"] == "success" {
                
                print("Success:")
                
                
            }
                
            else
            {
                
                print("Nothing")
            }
            
            
        }
        
        
        
        
        
        
    }

    
    
    
    
    
    
    
    func UTCToLocal(UTCDateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Input Format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let UTCDate = dateFormatter.date(from: UTCDateString)
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss" // Output Format
        dateFormatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
    }
    
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Add your Answer"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.textAlignment = .left
            textView.text = "Add your Answer"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.textAlignment = .left
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
   
    
   
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


