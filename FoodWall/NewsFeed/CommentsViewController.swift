//
//  CommentsViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 22/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import IQKeyboardManagerSwift

class CommentsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{
    
    @IBOutlet weak var likesTable: UITableView!
    var myDict = NSArray()
    var selectedArray = NSMutableArray()
    var myArray = NSArray()
    var myArray1 = NSArray()
    var mySection = -10
    var sectionClicked = -99
    var mySize = 0
    var valueFor = -100
    var mySize1 = 0
    var myInt = -10
    var myInt2 = 0
    var myHeight = 1000
    var userid : String = ""
    var c : String = ""
    var reviewId : String = ""
    var hotelID : String = ""
    var eventID : String = ""
    var commentAnsID : String = ""
    var dataArray = [[String:AnyObject]]()
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var commentProfImage: UIImageView!
    @IBOutlet weak var footeView: UIView!
    var indexNumber : Int = 0
    @IBOutlet weak var addComment: UITextView!
    @IBOutlet weak var myadd: UITableView!
    var act = "0"
    
    
    
    @IBOutlet weak var commentsLbel: UILabel!
    var rowNumber : Int = 0
    var ab : Int = -10
    var dateArray = NSMutableArray()
    var nameArray = NSMutableArray()
    var commentid = NSMutableArray()
    var replyid = NSMutableArray()
    var commenteventid = NSMutableArray()
    @IBOutlet weak var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likesTable.isHidden = true
        likesTable.delegate = self
        likesTable.dataSource = self
        if c == "1"
        {
            commentsLbel.isHidden = false
            likesTable.isHidden = true
            myTable.isHidden = false
            apicall2()
        }
            
        else if c == "2"
        {
            
            commentsLbel.isHidden = true
            likesTable.isHidden = false
            myTable.isHidden = true
            getLikesAll()
        }
        else if c == "3"
        {
            commentsLbel.isHidden = false
            likesTable.isHidden = true
            myTable.isHidden = false
            apicall1()
        }
            
        else if c == "4"
        {
            commentsLbel.isHidden = true
            likesTable.isHidden = false
            myTable.isHidden = true
            getAllLikes()
        }
        else if c == "5"
        {
            commentsLbel.isHidden = false
            likesTable.isHidden = true
            myTable.isHidden = false
            getDiscussionAll()
            
        }
            
        else if c == "6"        {
            commentsLbel.isHidden = true
            likesTable.isHidden = false
            myTable.isHidden = true
            getAllLikesEvent()
        }
        else if c == "7"
        {
            commentsLbel.isHidden = true
            likesTable.isHidden = false
            myTable.isHidden = true
            getAllLikesQA()
        }
            
        else
        {
            commentsLbel.isHidden = false
            likesTable.isHidden = true
            myTable.isHidden = false
            getAllCommentsQA()
        }
        
        likesTable.tag = 2
        
        likesTable.tableFooterView = UIView()
        
        addComment.textColor = UIColor.black
        commentProfImage.layer.cornerRadius = commentProfImage.frame.size.height/2
        commentProfImage.clipsToBounds = true
        
        if (Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)) != ""
        {
            
            commentProfImage.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)), placeholderImage: UIImage(named: "default"))
            
            
            
        }
        
        headerView.addShadowViewhome()
        myTable.tag = 0
        likesTable.tag = 2
        addComment.delegate = self
        addComment.text = "Add a comment"
        addComment.textColor = UIColor.lightGray
        footeView.addShadowViewhome()
        // print(dataArray)
        //  headerView.addShadowView()
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        //  apicall2()
        //        apicall()
        addComment.delegate = self
        myTable.tag = 0
        myTable.delegate = self
        myTable.dataSource = self
        self.myTable.separatorColor = UIColor.clear
        self.myTable.separatorStyle = .none
        self.myTable.backgroundColor = UIColor.clear
        self.myTable.tableHeaderView?.backgroundColor = UIColor.clear
        self.myTable.tableFooterView?.backgroundColor = UIColor.clear
        headerView.addShadowViewhome()
        myTable.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if c == "2"
        {
            likesTable.isHidden = false
            myTable.isHidden = true
        }
    }
    
    
    
    func getAllCommentsQA()
    {
        let params: [String:String] = ["ansid" : commentAnsID, "userid" : userid]
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.GET_ANSWER_COMMENT_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                self.myDict = resData as! NSArray
                // self.myArray =  self.myDict.value(forKey: "Data") as! NSArray
                self.myArray = self.myDict
                self.myArray1 = self.myArray.value(forKey: "reply") as! NSArray
                if self.act == "0"
                {
                    self.myTable.reloadData()
                }
                else
                {
                    let indexPath = IndexPath(item: 0, section: self.rowNumber)
                    
                    
                    if self.ab == 2 || self.ab == 0
                    {
                        self.myTable.reloadData()
                    }else
                    {
                        self.myTable.reloadRows(at: [indexPath] , with: .none)
                    }
                }
            }
                
            else
            {
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
    }
    
    
    func  getAllLikesQA()
    {
        
        let params: [String:String] = ["cmmt_ans_id" : commentAnsID,"userid" : userid]
        
        let urlString = "\(Constant.BASEURL)\(Constant.get_QA_LIKES_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray = resData as! [[String:AnyObject]]
                
                if(self.dataArray.count != 0){
                    
                    
                    print(self.dataArray)
                    
                    self.likesTable.reloadData()
                    
                }
                    
                else
                    
                {
                    
                    self.showToast(message: "Server Error")
                    
                    
                    
                }
            }
                
            else{
                
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 0
        {
            if myArray.count != nil
            {
                return myArray.count
            }
            else
            {
                return 0
            }
        }
        else if tableView.tag == 2
        {
            if dataArray.count != 0
            {
                return dataArray.count
            }
            else
            {
                return 0
            }
        }
            
        else
        {
            if selectedArray.count != 0
            {
                return 1
            }
            else
            {
                mySection = -10
                return 0
            }
        }
        
        
        
    }
    
    
    
    func getLikesAll()
    {
        
        let params: [String:String] = ["timelineid" : (Utils.getPreferenceValue(ForKey: Constant.TIMELINE_ID)),"userid" : userid]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_TIMELINE_LIKES_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray = resData as! [[String:AnyObject]]
                
                if(self.dataArray.count != 0){
                    
                    
                    print(self.dataArray)
                    
                    self.likesTable.reloadData()
                    
                }
                    
                else
                    
                {
                    
                    self.showToast(message: "Server Error")
                    
                    
                    
                }
            }
                
            else{
                
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
        
        
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Add a Comment"
            textView.textColor = UIColor.lightGray
            
            //            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            //              let wordlength = addComment.text
            //             textView.selectedRange = NSMakeRange( (wordlength?.characters.count)!, 0);
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
            //            let wordlength = addComment.text
            //            textView.selectedRange = NSMakeRange( (wordlength?.characters.count)!, 0);
        }
        
        
        
        if text == "\n"  // Recognizes enter key in keyboard
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ sender: UITextView) {
        
        
        let wordlength = addComment.text
        addComment.selectedRange = NSMakeRange( (wordlength?.characters.count)!, 0);
        let fixedWidth = addComment.frame.size.width
        addComment.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = addComment.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = addComment.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        addComment.frame = newFrame
        footeView.sizeToFit()
        if newSize.height > 40.0
        {
            footeView.frame = CGRect( x : 0,y:self.view.frame.height - newSize.height, width : self.view.frame.size.width ,height : newSize.height + 10)
            
        }
        
        
    }
    
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.textAlignment = .left
            textView.text = "Add a Comment"
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
    
    @IBAction func backAct(_ sender: UIButton) {
        
        
        self.dismiss(animated: false, completion: nil)
        
        
    }
    
    
    @IBAction func postAction(_ sender: UIButton) {
        
        if ab == 1
        {
            
            if c == "3"
            {
                
                let params: [String:String] = ["comment_id" :"\((myArray[indexNumber] as! AnyObject).value(forKey: "cmmt_htl_id")!)","cmmt_rev_id":"\((myArray[indexNumber] as! AnyObject).value(forKey: "revrat_id")!)","comments":addComment.text!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                print(params)
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_HOTEL_COMMENTS_REPLY)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.addComment.text! = ""
                        self.apicall1()
                        self.ab = 0
                        self.act = "1"
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
            }
            else if c == "1"
            {
                let params: [String:String] = ["reply_id" :"0" ,"tl_cmmt_id" :"\((myArray[indexNumber] as! AnyObject).value(forKey: "cmmt_tl_id")!)" ,"comments" : addComment.text!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_COMMENT_REPLY)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.addComment.text! = ""
                        self.apicall2()
                        self.act = "1"
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
            }
                
                
            else
            {
                let params: [String:String] = ["comment_id" :"0" ,"cmmt_dis_id" :"\((myArray[indexNumber] as! AnyObject).value(forKey: "cmmt_dis_id")!)" ,"comments" : addComment.text!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted" : "0"]
                
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_DELETE_DISCUSSION_REPLY)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.addComment.text! = ""
                        self.getDiscussionAll()
                        self.act = "1"
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
                
            }
            
            
            
            
        }
        else if ab == -10
        {
            
            
            
            if c == "3"
            {
                
                let params: [String:String] = ["comment_id" :"0" ,"hotelid" :"\((myArray[sender.tag] as! AnyObject).value(forKey: "hotel_id")!)","reviewid" :"\((myArray[sender.tag] as! AnyObject).value(forKey: "revrat_id")!)" ,
                    "comments": addComment.text!,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                print(params)
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_HOTEL_COMMENTS)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.addComment.text! = ""
                        self.apicall1()
                        self.act = "1"
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
            }
                
            else if c == "1"
            {
                
                
                
                let params: [String:String] = ["comment_id" :"0" ,"timelineid" : (Utils.getPreferenceValue(ForKey: Constant.TIMELINE_ID))
                    ,"comments":addComment.text! ,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_COMMENTS)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json != nil
                    {
                        if json["ResponseMessage"] == "success"
                            
                        {
                            
                            self.addComment.text! = ""
                            self.apicall2()
                            
                            
                            
                        }
                        
                    }
                    
                }
                
                
                
            }
            else
            {
                
                
                let params: [String:String] = ["comment_id" :"0" ,"diss_id" :
                    "\((myArray[sender.tag] as! AnyObject).value(forKey: "dis_evt_id")!)","comments":addComment.text! ,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted" :"0"]
                
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DISCUSSION_COMMENT)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json != nil
                    {
                        if json["ResponseMessage"] == "success"
                            
                        {
                            
                            self.addComment.text! = ""
                            self.getDiscussionAll()
                            
                            
                            
                        }
                        
                    }
                    
                }
                
                
            }
            
            
        }
            
            
            
            
            
            
        else if ab == 2{
            
            if c == "3"
            {
                
                let params: [String:String] = ["comment_id" :"0" ,"cmmt_rev_id" :"\((myArray1[indexNumber] as! AnyObject).value(forKey: "hotel_id")!)","comments":addComment.text!,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                print(params)
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_HOTEL_COMMENTS_REPLY)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.addComment.text! = ""
                        self.apicall1()
                        self.act = "1"
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
            }
            else if c == "1"
            {
                let params: [String:String] = ["reply_id" :replyid[indexNumber] as! String ,"tl_cmmt_id" :commentid[indexNumber] as! String  ,"comments" : addComment.text!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_COMMENT_REPLY)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.apicall2()
                        self.addComment.text! = ""
                        self.act = "1"
                        // self.ab = 0
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
            }
                
            else
            {
                
                let params: [String:Any] = ["comment_id" :replyid[indexNumber] as! String ,"cmmt_dis_id" :commenteventid[indexNumber] as! String,
                                            "comments": addComment.text!,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted":"0"]
                
                print(params)
                rowNumber = sender.tag
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_DELETE_DISCUSSION_REPLY)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json["ResponseCode"] == 1
                    {
                        print("Nithya")
                        self.addComment.text! = ""
                        self.getDiscussionAll()
                        self.act = "1"
                        
                    }
                    else{
                        self.showToast(message: "Server Error")
                    }
                    
                }
                
            }
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView.tag == 0
        {
            if myArray.count == 0
            {
                return 0
            }
            else
            {
                return 1
            }
        }
        
        if tableView.tag == 2
        {
            if dataArray.count == 0
            {
                return 0
            }
            else
            {
                return 1
            }
            
        }
            
            
        else
        {
            if selectedArray.count == 0
            {
                return 0
            }
            else
            {
                
                if section != -10
                {
                    return selectedArray.count
                }
                else
                {
                    return 0
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView.tag == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "celll1", for: indexPath) as! myTableTableViewCell
            
            var name = "\((myArray[indexPath.section] as! AnyObject).value(forKey: "first_name")!)" + "\((myArray[indexPath.section] as! AnyObject).value(forKey: "last_name") as! String)"
            if c == "3"
            {
                let formattedString = NSMutableAttributedString()
                formattedString
                    .bold(name)
                    .normal(((myArray[indexPath.section] as! AnyObject).value(forKey: "htl_rev_comments") as? String)!)
                
                cell.myLabel.attributedText = formattedString
                // cell.myLabel.text =  name + ((myArray[indexPath.section] as! AnyObject).value(forKey: "htl_rev_comments") as? String)!
            }
            else if c == "1"
            {
                
                let formattedString = NSMutableAttributedString()
                formattedString
                    .bold(name)
                    .normal(((myArray[indexPath.section] as! AnyObject).value(forKey: "tl_comments") as? String)!)
                
                cell.myLabel.attributedText = formattedString
                //  cell.myLabel.text =  name + ((myArray[indexPath.section] as! AnyObject).value(forKey: "tl_comments") as? String)!
                
            }
                
            else if c == "5"
            {
                
                
                let formattedString = NSMutableAttributedString()
                formattedString
                    .bold(name)
                    .normal(((myArray[indexPath.section] as! AnyObject).value(forKey: "dis_comments") as? String)!)
                
                cell.myLabel.attributedText = formattedString
                // cell.myLabel.text =  name + ((myArray[indexPath.section] as! AnyObject).value(forKey: "dis_comments") as? String)!
            }
                
            else
            {
                let formattedString = NSMutableAttributedString()
                formattedString
                    .bold(name)
                    .normal(((myArray[indexPath.section] as! AnyObject).value(forKey: "ans_comments") as? String)!)
                
                cell.myLabel.attributedText = formattedString
            }
            cell.myLabel.font =  UIFont.boldSystemFont(ofSize: 12.0)
            
            cell.myButton.tag = indexPath.section + 1000
            cell.replyBtn.contentHorizontalAlignment = .left
            cell.replyBtn.tag = indexPath.section
            cell.replyBtn.addTarget(self, action: #selector(replyAct(_:)), for: .touchUpInside)
            
            cell.deleteBtn.tag = indexPath.section + 2000
            //            cell.deleteBtn.addTarget(self, action: #selector(deleteAct(_:)), for: .touchUpInside)
            let createdTime = "\((myArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.daysAgoLabel.text! =  myDate.timeAgoDisplay2()
            cell.heartBtn.tag = indexPath.section + 3000
            
            cell.myAddTableView.tag = 1
            if mySection == -10
            {
                cell.myAddTableView.isHidden = true
                
                if c == "1"
                {
                    
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String != "0"
                    {
                        cell.myButton.setTitle("---- View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String))", for: .normal)
                        cell.myButton.isHidden = false
                    }
                        
                        
                    else{
                        cell.myButton.isHidden = true
                    }
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "tl_cmmt_likes") as! String == "0"
                    {
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    }
                        
                        
                        
                    else{
                        
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                    }
                    
                }
                    
                else if c == "3"
                {
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "cmmt_tot_reply") as! String != "0"
                    {
                        cell.myButton.setTitle("---- View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "cmmt_tot_reply") as! String))", for: .normal)
                        cell.myButton.isHidden = false
                    }
                        
                        
                    else{
                        cell.myButton.isHidden = true
                    }
                    
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "cmmt_tot_likes") as! String == "0"
                    {
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    }
                        
                        
                    else{
                        
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                    }
                    
                }
                    
                else if c == "5"
                {
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String != "0"
                    {
                        cell.myButton.setTitle("---- View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String))", for: .normal)
                        cell.myButton.isHidden = false
                    }
                        
                        
                    else{
                        cell.myButton.isHidden = true
                    }
                    
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_likes") as! String == "0"
                    {
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    }
                        
                        
                    else{
                        
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                    }
                    
                }
                else
                {
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String != "0"
                    {
                        cell.myButton.setTitle("---- View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String))", for: .normal)
                        cell.myButton.isHidden = false
                    }
                        
                        
                    else{
                        cell.myButton.isHidden = true
                    }
                    
                    if  (myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_likes") as! String == "0"
                    {
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    }
                        
                        
                    else{
                        
                        cell.heartBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                    }
                }
                
            }
            else{
                
                
                if mySection == indexPath.section
                {
                    
                    cell.myAddTableView.delegate = self
                    cell.myAddTableView.dataSource = self
                    
                    
                    
                    print(cell.myAddTableView.contentSize.height)
                    
                    
                    cell.myAddTableView.reloadData()
                    
                    
                    cell.myAddTableView.frame = CGRect(x: cell.myAddTableView.frame.minX, y: cell.myAddTableView.frame.minY, width: cell.myAddTableView.frame.width, height: CGFloat(myHeight))
                    self.mySize = myHeight + 100
                    
                    if c == "3"
                    {
                        if  (myArray[indexPath.section] as AnyObject).value(forKey: "cmmt_tot_reply") as! String != "0"
                        {
                            cell.myButton.setTitle("--- View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "cmmt_tot_reply") as! String))", for: .normal)
                            cell.myButton.isHidden = false
                        }
                            
                            
                        else{
                            cell.myButton.isHidden = true
                        }
                    }
                        
                    else
                    {
                        if  (myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String != "0"
                        {
                            cell.myButton.setTitle("--- View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String))", for: .normal)
                            cell.myButton.isHidden = false
                        }
                            
                            
                        else{
                            cell.myButton.isHidden = true
                        }
                    }
                    
                    if myHeight != 1000
                    {
                        
                        myInt = +10
                        if cell.myAddTableView.isHidden
                        {
                            
                            self.valueFor = 1
                            cell.myAddTableView.isHidden = false
                            cell.myButton.setTitle("----Hide all replies", for: .normal)
                        }
                        else
                        {
                            mySection = -10
                            sectionClicked = -99
                            mySize = 0
                            valueFor = -100
                            mySize1 = 0
                            myInt = -10
                            myInt2 = 0
                            myHeight = 1000
                            
                            if c == "3"
                            {
                                
                                cell.myButton.setTitle("----View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "cmmt_tot_reply") as! String))", for: .normal)
                                cell.myAddTableView.isHidden = true
                            }
                                
                            else
                            {
                                cell.myButton.setTitle("----View all replies(\((myArray[indexPath.section] as AnyObject).value(forKey: "total_cmmt_reply") as! String))", for: .normal)
                                cell.myAddTableView.isHidden = true
                            }
                            
                        }
                        
                        
                    }
                    else
                    {
                        myInt = -10
                    }
                    
                    
                }
                else
                {
                    cell.myAddTableView.isHidden = true
                }
                
                
            }
            return cell
        }
            
            
        else if tableView.tag == 2
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! likesTableViewCell
            
            cell.img1.sd_setImage(with: URL(string: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "picture")!)"), placeholderImage: UIImage(named: "default"))
            cell.profName.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
            cell.subName.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
            return cell
        }
        else
        {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "second", for: indexPath) as! secondTableViewCell
            //            let name = "\((myArray1[indexPath.section] as AnyObject).value(forKey: "first_name")!)" + "\(String(describing: (myArray1[indexPath.section] as AnyObject).value(forKey: "last_name")))"
            let name =  "\(nameArray[indexPath.section])"
            cell1.mytesxt.text =  name + "\(selectedArray[indexPath.section])"
            
            
            cell1.editBtn.tag = indexPath.section
            //            cell1.editBtn.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
            cell1.deleteButton.tag = indexPath.section + 1000
            //            cell1.deleteButton.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
            let createdTime =  "\(dateArray[indexPath.section])"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell1.daysAgoLabel.text! =  myDate.timeAgoDisplay2()
            //  cell1.mytesxt.text = selectedArray[indexPath.row] as? String
            
            cell1.editBtn.contentHorizontalAlignment = .left
            cell1.mytesxt.numberOfLines = 10
            
            cell1.mytesxt.lineBreakMode = .byWordWrapping
            cell1.mytesxt.sizeToFit()
            cell1.view1.frame = CGRect( x: cell1.view1.frame.minX,y:cell1.mytesxt.frame.maxY,width: cell1.view1.frame.size.width,height:cell1.view1.frame.size.height)
            mySize1 =  Int(cell1.mytesxt.frame.height + cell1.view1.frame.height)
            print("label size 2 \(cell1.mytesxt.frame.height)")
            myInt2 = myInt2 + mySize1
            
            
            
            if indexPath.row == selectedArray.count - 1
            {
                if myInt == -10
                {
                    myHeight = myInt2 + 50
                    self.myTable.reloadData()
                }
            }
            
            return cell1
        }
        
    }
    
    @IBAction func deleteAct(_ sender: UIButton) {
        
        
        if c == "3"
        {
            
            
            let params: [String:String] = ["comment_id" :((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "cmmt_htl_id") as? String)! ,"hotelid" : ((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "hotel_id") as? String)!,"reviewid":((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "revrat_id") as? String)!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            rowNumber = sender.tag
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_HOTEL_COMMENT)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    print("Nithya")
                    self.apicall1()
                    self.act = "1"
                    
                }
                else{
                    self.showToast(message: "Server Error")
                }
                
            }
        }
        else if c == "1"
        {
            
            let params: [String:String] = ["comment_id" :((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "cmmt_tl_id") as? String)! ,"timelineid" : ((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "timeline_id") as? String)!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            rowNumber = sender.tag
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_COMMENT)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    print("Nithya")
                    self.apicall2()
                    self.act = "1"
                    
                }
                else{
                    self.showToast(message: "Server Error")
                }
                
            }
            
            
            
        }
            
        else
        {
            let params: [String:String] = ["comment_id" :((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "cmmt_dis_id") as? String)! ,"diss_id" : ((myArray[sender.tag - 2000] as! AnyObject).value(forKey: "dis_evt_id") as? String)!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted" : "1"]
            
            rowNumber = sender.tag - 2000
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DISCUSSION_COMMENT)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    print("Nithya")
                    self.getDiscussionAll()
                    self.act = "1"
                    
                }
                else{
                    self.showToast(message: "Server Error")
                }
            }
        }
        
    }
    
    //
    //    @objc func deleteAction(sender: UIButton!)
    //    {
    //
    //
    //
    //
    //    }
    //
    //
    //    @objc func editAction(sender: UIButton!)
    //    {
    //
    //
    //
    //
    //    }
    
    
    @IBAction func likeAct(_ sender: UIButton) {
        
        
        let indexPath = IndexPath(row : 0 ,section : sender.tag - 3000)
        let cell = myTable.cellForRow(at: indexPath) as! myTableTableViewCell
        var likes : String = ""
        if  cell.heartBtn.image(for: .normal) == UIImage(named : "like_symbol")
            
        {
            cell.heartBtn.setImage(UIImage(named : "like-2"), for: .normal)
            likes = "1"
        }
        else
        {
            cell.heartBtn.setImage(UIImage(named : "like_symbol"), for: .normal)
            likes = "0"
        }
        
        var comtID : String = ""
        if c == "3"
        {
            comtID = ((myArray[sender.tag - 3000] as! AnyObject).value(forKey: "cmmt_htl_id") as? String)!
        }
            
        else if c == "1"
        {
            comtID = ((myArray[sender.tag - 3000] as! AnyObject).value(forKey: "cmmt_tl_id") as? String)!
        }
        else
        {
            comtID = ((myArray[sender.tag - 3000] as! AnyObject).value(forKey: "cmmt_dis_id") as? String)!
        }
        
        
        
        let params: [String:String] = ["tl_cmmt_id" :comtID,"likes" : likes,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        rowNumber = sender.tag - 3000
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_LIKE_COMMENT_REPLY)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseCode"] == 1
            {
                print("Nithya")
                if self.c == "3"
                {
                    self.apicall1()
                }
                else
                {
                    self.apicall2()
                }
                self.act = "1"
                
            }
            else{
                self.showToast(message: "Server Error")
            }
            
        }
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if mySection == indexPath.section
        {
            
        }
    }
    
    @IBAction func replyAct(_ sender: UIButton) {
        
        
        addComment.text! = "@\("\((myArray[sender.tag] as! AnyObject).value(forKey: "first_name")!)")"
        indexNumber = sender.tag
        addComment.textColor = UIColor.black
        let wordlength = addComment.text
        addComment.selectedRange = NSMakeRange( (wordlength?.characters.count)!, 0);
        ab = 1
        //
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.tag == 0
        {
            if mySection == -10
            {
                return 110
            }
            else{
                if mySection == indexPath.section
                {
                    if valueFor == 1
                    {
                        
                        return CGFloat(mySize + 50)
                    }
                    else
                    {
                        return 110
                    }
                    
                    
                }
                else
                {
                    return 110
                }
                
            }
        }
            
        else if tableView.tag == 2
        {
            return 100.0
        }
        else
        {
            return CGFloat(mySize1 + 20)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 0
        {
            return 5
        }
        else
        {
            return 2
        }
    }
    
    @IBAction func tapMyButton(_ sender: UIButton) {
        
        let indexPath = IndexPath(row :0 ,section : sender.tag - 1000)
        let cell = myTable.cellForRow(at: indexPath) as! myTableTableViewCell
        mySection = sender.tag - 1000
        
        if "\(myArray1[mySection] as AnyObject)" == "<null>"
        {
            selectedArray.removeAllObjects()
        }
        else{
            
            if c == "1"
            {
                selectedArray = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "tl_cmmt_reply") as! NSArray)
            }
            else if c == "3"
            {
                
            }
                
            else
            {
                selectedArray = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "dis_cmmt_reply") as! NSArray)
            }
            
            
            dateArray = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "created_on") as! NSArray)
            nameArray = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "first_name") as! NSArray)
            replyid = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "reply_id") as! NSArray)
            commentid = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "cmmt_tl_id") as! NSArray)
            commenteventid = NSMutableArray(array:(myArray1[mySection] as AnyObject).value(forKey: "cmmt_dis_id") as! NSArray)
            
        }
        
        cell.myButton.setTitle("Hide all Replies", for: .normal)
        act = "0"
        self.myTable.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 13)!
        header.backgroundView?.backgroundColor = UIColor.clear
    }
    
    func getDiscussionAll()
    {
        let params: [String:String] = ["discuss_id" : eventID, "userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.GET_DISCUSSION_COMMENTS_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                self.myDict = resData as! NSArray
                // self.myArray =  self.myDict.value(forKey: "Data") as! NSArray
                self.myArray = self.myDict
                self.myArray1 = self.myArray.value(forKey: "reply") as! NSArray
                if self.act == "0"
                {
                    self.myTable.reloadData()
                }
                else
                {
                    let indexPath = IndexPath(item: 0, section: self.rowNumber)
                    
                    
                    if self.ab == 2 || self.ab == 0
                    {
                        self.myTable.reloadData()
                    }else
                    {
                        //                        self.myTable.reloadRows(at: [indexPath] , with: .none)
                        self.myTable.reloadData()
                    }
                }
            }
                
            else
            {
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
    }
    
    
    func apicall2()
    {
        
        
        let params: [String:String] = ["timelineid" : (Utils.getPreferenceValue(ForKey: Constant.TIMELINE_ID)), "userid" : userid]
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.GET_TIMELINE_COMMENTS_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                self.myDict = resData as! NSArray
                // self.myArray =  self.myDict.value(forKey: "Data") as! NSArray
                self.myArray = self.myDict
                self.myArray1 = self.myArray.value(forKey: "reply") as! NSArray
                if self.act == "0"
                {
                    self.myTable.reloadData()
                }
                else
                {
                    let indexPath = IndexPath(item: 0, section: self.rowNumber)
                    
                    
                    if self.ab == 2 || self.ab == 0
                    {
                        self.myTable.reloadData()
                    }else
                    {
                        self.myTable.reloadRows(at: [indexPath] , with: .none)
                    }
                }
            }
                
            else
            {
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
    }
    
    
    func apicall1()
    {
        
        let params: [String:String] = ["hotelid" : hotelID, "reviewid" : reviewId,"userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        print(params)
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.GET_REVIEW_COMMENTS_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                self.myDict = resData as! NSArray
                // self.myArray =  self.myDict.value(forKey: "Data") as! NSArray
                self.myArray = self.myDict
                self.myArray1 = self.myArray.value(forKey: "reply") as! NSArray
                if self.act == "0"
                {
                    self.myTable.reloadData()
                }
                else
                {
                    let indexPath = IndexPath(item: 0, section: self.rowNumber)
                    
                    
                    if self.ab == 2 || self.ab == 0
                    {
                        self.myTable.reloadData()
                    }else
                    {
                        self.myTable.reloadData()
                    }
                }
            }
                
            else
            {
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
    }
    
    
    func getAllLikesEvent()
    {
        let params: [String:String] = ["hotelid" : hotelID, "reviewid" : reviewId,"userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.GET_REVIEW_LIKES_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                self.myDict = resData as! NSArray
                // self.myArray =  self.myDict.value(forKey: "Data") as! NSArray
                self.myArray = self.myDict
                self.myArray1 = self.myArray.value(forKey: "reply") as! NSArray
                if self.act == "0"
                {
                    self.myTable.reloadData()
                }
                else
                {
                    let indexPath = IndexPath(item: 0, section: self.rowNumber)
                    
                    
                    if self.ab == 2 || self.ab == 0
                    {
                        self.myTable.reloadData()
                    }else
                    {
                        self.myTable.reloadRows(at: [indexPath] , with: .none)
                    }
                }
            }
                
            else
            {
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
    }
    
    
    
    
    func getAllLikes()
    {
        
        
        let params: [String:String] = ["hotelid" : hotelID, "reviewid" : reviewId,"userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.GET_REVIEW_LIKES_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                self.myDict = resData as! NSArray
                // self.myArray =  self.myDict.value(forKey: "Data") as! NSArray
                self.myArray = self.myDict
                self.myArray1 = self.myArray.value(forKey: "reply") as! NSArray
                if self.act == "0"
                {
                    self.myTable.reloadData()
                }
                else
                {
                    let indexPath = IndexPath(item: 0, section: self.rowNumber)
                    
                    
                    if self.ab == 2 || self.ab == 0
                    {
                        self.myTable.reloadData()
                    }else
                    {
                        self.myTable.reloadRows(at: [indexPath] , with: .none)
                    }
                }
            }
                
            else
            {
                self.showToast(message: "Server Error")
            }
            
            
        }
        
        
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        
        
        addComment.text! = "@\(nameArray[sender.tag])"
        addComment.textColor = UIColor.black
        let wordlength = addComment.text
        addComment.selectedRange =
            NSMakeRange( (wordlength?.characters.count)!, 0);
        indexNumber = sender.tag
        ab = 2
        
        
    }
    
    
    @IBAction func deleteAction(_ sender: UIButton) {
        
        if c == "1"
        {
            
            let params: [String:String] = ["reply_id" :replyid[sender.tag - 1000] as! String ,"tl_cmmt_id" :commentid[sender.tag - 1000] as! String,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            rowNumber = sender.tag - 1000
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_COMMENT_REPLY)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    print("Nithya")
                    self.apicall2()
                    self.act = "1"
                    // self.ab = 2
                    
                }
                else{
                    self.showToast(message: "Server Error")
                }
                
            }
        }
            
            
            
        else if c == "3"
        {
            let params: [String:String] = ["comment_id" :replyid[sender.tag - 1000] as! String ,"cmmt_rev_id" :commentid[sender.tag - 1000] as! String,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            rowNumber = sender.tag - 1000
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_HOTEL_REPLY)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    print("Nithya")
                    self.apicall1()
                    self.act = "1"
                    // self.ab = 2
                    
                }
                else{
                    self.showToast(message: "Server Error")
                }
                
            }
        }
            
            
        else
        {
            let params: [String:String] = ["comment_id" :replyid[sender.tag - 1000] as! String ,"cmmt_dis_id" :commenteventid[sender.tag - 1000] as! String,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted" : "1"]
            
            rowNumber = sender.tag - 1000
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_DELETE_DISCUSSION_REPLY)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    print("Nithya")
                    self.getDiscussionAll()
                    
                    self.act = "1"
                    // self.ab = 2
                    
                }
                else{
                    self.showToast(message: "Server Error")
                }
                
            }
        }
    }
    
    
    
    
    
}
extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}

