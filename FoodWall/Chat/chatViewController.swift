//
//  chatViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 23/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved./Users/rameshponnuvel/Documents/Deepika_Foodwall/FoodWall-July15/FoodWall/Chat/chatViewController.swift
//

import UIKit
import Alamofire
import SwiftyJSON
//import MessageKit
//import ISEmojiView

class chatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var chatimage: UIImageView!
    let refreshControl = UIRefreshControl()
    // var messageList: [MockMessage] = []
    @IBOutlet weak var Mytable: UITableView!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var sendbutton: UIButton!
    //@IBOutlet weak var emoji: UIButton!
    
      var placeholderLabel : UILabel!
    var username1 : String = ""
    var username2 : String = ""
    var userimage : String = ""
    var sessionid : String = ""
    var friendid : String = ""
      var a = 0
    var friendsessionid = ""
    var friendlastseen = ""
    //var individualchatarray : NSArray = []
      var signlehistorychatarray = [[String:AnyObject]]()
    var individualchatarray =  [[String:AnyObject]]()
      var historychatarray =  [[String:AnyObject]]()
    //historychatarray
   var tablerowheight = 0
    
    
   
  //  let emojiView = ISEmojiView()
 // var bRec:Bool = true
     // let emojiView = ISEmojiView(emojis: [[String]])
    override func viewDidLoad() {
        super.viewDidLoad()
        
       getchatHistory()
        
        Label1.text = username1
//        let createdTime = friendlastseen
//        if createdTime != "" && createdTime != "0"
//        {
//            let dateFormatterr = DateFormatter()
//            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let myDate = dateFormatterr.date(from: createdTime)!
//            Label2.text! = myDate.timeAgoDisplay()
//        }
//        else {
//            Label2.text! = ""
//        }
             chatimage.sd_setImage(with: URL(string: "\(userimage)"), placeholderImage: UIImage(named: "default"))
        
       // loadMoreMessages()
       // refreshControl.addTarget(self, action: #selector(chatViewController.loadMoreMessages), for: .valueChanged)
      
//        let messagesToFetch = UserDefaults.standard.mockMessagesCount()
//        
//        DispatchQueue.global(qos: .userInitiated).async {
//          // urlstring.shared.getMessages(count: messagesToFetch) { messages in
//                DispatchQueue.main.async {
//                   // self.messageList = messages
//                    self.Mytable.reloadData()
//                  //  self.Mytable.scrollToBottom()
//                    print("super")
//              //  }
//            }
//        }
        
        if #available(iOS 10.0, *) {
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
                
                // Your code is here:
                self.getchathistorysingle()
                self.gettypingstatus()
                self.updatetypingstatus()
            }
        }
        else {
            
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getchathistorysingle), userInfo: nil, repeats: true)
        }
        
      
        
         getchathistorysingle()
      
        
        
         headerView.addShadowView()
        chatimage.layer.cornerRadius = chatimage.frame.size.height/2
        chatimage.layer.borderWidth = 0.2
        chatimage.clipsToBounds = true
        
        Mytable.delegate = self
        Mytable.dataSource = self
        Mytable.separatorStyle = .none
    
        textview.delegate = self
       
         //emojiView.delegate = self
       
        placeholderLabel = UILabel()
        placeholderLabel.text = "Write something here..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textview.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textview.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 20, y: (textview.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textview.text.isEmpty
        // Do any additional setup after loading the view.
        
      
        
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textview.text.isEmpty
        print("Typing")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("DidbeginEditing")
        
        a = 1
        updatetypingstatus()
        // headerView.frame.size =
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("DidEndEditing")
        a = 2
        updatetypingstatus()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcell", for: indexPath) as! chatviewTableViewCell
        print("\(indexPath.row)")
        cell.tag = indexPath.row
        
        let value = cell.tag
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.lefttextview.delegate = self
        cell.righttextview.delegate = self
        cell.maintextview.delegate = self
        cell.lefttextview.centerVertically()
      cell.righttextview.centerVertically()
       // cell.maintextview.centerVertically()
        cell.rightview.sizeToFit()
        cell.leftview.sizeToFit()
        cell.maintextview.sizeToFit()
        cell.righttextview.sizeToFit()
        cell.lefttextview.sizeToFit()
        print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)")
        print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)")
           print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message")!)")
        //type_message
        if indexPath.row == cell.tag {
        
        if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "0"
        
        {
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.righttextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.righttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.lefttextview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = false
                cell.maintextview.isHidden = true
                
                let sizeThatShouldFitTheContent = cell.righttextview.sizeThatFits(cell.righttextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                print("\(cell.righttextview.text!)")
                tablerowheight = Int(height) + 20
                
                
                
            }
            else {
                
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.lefttextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = false
                cell.maintextview.isHidden = true
                let sizeThatShouldFitTheContent = cell.lefttextview.sizeThatFits(cell.lefttextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 20
        
            }
            
        }
        
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "1" {
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
                
                
                
            }
            
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "2" {
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
                
                
                
            }
            
            
            
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "3" {
            
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
                
                
                
            }
            
            
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID) {
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
                
                
                
            }
            
            
            
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "5" {
            
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
                
                
                
            }
            
            
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "6" {
            
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
                
                
                
            }
            
            
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "7" {
          
            if "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message") as! String)")
                cell.maintextview.text! = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                //  cell.lefttextview.text! = "kdsfjsd foeiurewoi lsdkfjsd floewiuroweir lsdkjfsd oweriuweoir lskdfj sdoewiruweio lsdfkjsdlkf oweiruweoi lsdkjfdsl"
                cell.righttextview.isHidden = true
                cell.rightview.isHidden = true
                cell.leftview.isHidden = true
                cell.rightview.isHidden = true
                cell.maintextview.isHidden = false
                let sizeThatShouldFitTheContent = cell.maintextview.sizeThatFits(cell.maintextview.frame.size)
                let height = sizeThatShouldFitTheContent.height
                tablerowheight = Int(height) + 30
                
                
            }
            else {
                
               
                
                
            }
            
        }
        else {
            
        }
        
    }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if signlehistorychatarray.count != 0
        {
        return signlehistorychatarray.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return CGFloat(tablerowheight)
       
    }
    
    @IBAction func Back(_ sender: Any) {
       
               self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        if textview.text != ""
        {
            
            let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"friendid" : "\(friendid)","chat_message" : "\(textview.text!.encodeEmoji)"]
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_INDIVIDUAL_CHAT)"
            
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if let resData = json["Data"].arrayObject {
                    
                    self.individualchatarray = (((resData as! NSArray) as! [[String : AnyObject]] ))
                    //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                    
                    
                    if(self.individualchatarray.count != 0)
                    {
                        let responsemessage = ((json ["ResponseMessage"].string)!)
                         if responsemessage == "success"
                         {
                            self.sessionid = ((self.individualchatarray[0] as AnyObject).value(forKey: "sessionid") as! String)
                            
                            let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"groupid" : "0","sessionid" : "\(self.sessionid)"]
                            let urlString = "\(Constant.BASEURL)\(Constant.GET_SINGLE_CHAT_HISTORY)"
                            
                            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                                let result = response.result
                                let json = JSON(data: response.data!)
                                
                                if let resData = json["Data"].arrayObject {
                                    
                                    self.signlehistorychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                                    //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                                    
                                    
                                    if(self.signlehistorychatarray.count != 0)
                                    {
                                        
                                       
                                        print(self.signlehistorychatarray)
                                        self.Mytable.reloadData()
                                        
                                        self.Mytable.isHidden = false
                                        self.textview.text! = ""
                                        
                                    }
                                        
                                    else
                                    {
                                        
                                        print("No data")
                                    }
                                }
                            }
                            
                    
                        }
                         else {
                            
                        }
                    }
                        
                    else
                    {
                        
                        print("No data")
                    }
                }
            }
            
            
            
            
            
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    @objc func getchathistorysingle()
    {
        
        // let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"groupid" : "0","sessionid" : "\(self.sessionid)"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_SINGLE_CHAT_HISTORY)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.signlehistorychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.signlehistorychatarray.count != 0)
                {
                    print(self.signlehistorychatarray)
                    self.Mytable.reloadData()
                    
//                    for i in 0..<self.signlehistorychatarray.count
//                    {
//                        
//                        if (self.signlehistorychatarray as AnyObject)[i] as AnyObject).value(forKey: "lastseen") ==  ""
//                        {
//                            
//                        
//                        }
//                        
//                    }
                    
                  
                    self.Mytable.isHidden = false
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                   
                    print("No data")
                }
            }
        }
        
        
        
        
        
    }
    
    func gettypingstatus()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"sessionid" : "\(self.sessionid)"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_CHAT_TYPING_STATUS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                let responsemessage = ((json ["ResponseMessage"].string)!)
                if responsemessage == "success"
                {
                    
                    print("Success")
                    
                }
                
                
            }
        }
        
        
        
        
    }
    
    
     func getchatHistory()
    {
            
        //  indicator.hidesWhenStopped = true
        //  indicator.startAnimating()
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_CHAT_HISTORY)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.historychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.historychatarray.count != 0)
                {
                    print(self.historychatarray)
                    
                   // friendid
                    //sessionid
                    for i in 0..<self.historychatarray.count
                                        {
                               let correctvalue = ("\(((self.historychatarray as AnyObject)[i] as AnyObject).value(forKey: "friendid")!)")
                                            if correctvalue ==  "\(self.friendid)"
                                            
                                    {
                                                 let frndsessionid = ("\(((self.historychatarray as AnyObject)[i] as AnyObject).value(forKey: "sessionid")!)")
                                        self.friendsessionid = frndsessionid
                                        
                                    }
                                            
                                            
                                        }
                    
                               print(self.friendsessionid)
                           self.getchatsingle()
                    //  self.indicator.stopAnimating()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                 
                    print("No data")
                }
            }
        }
        
        
        
        
        
        
    }
    
    
     func getchatsingle()
    {
        
        // let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"groupid" : "0","sessionid" : "\(self.friendsessionid)"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_SINGLE_CHAT_HISTORY)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.signlehistorychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.signlehistorychatarray.count != 0)
                {
                    print(self.signlehistorychatarray)
                   
                    
                     print("\(((self.signlehistorychatarray as AnyObject)[0] as AnyObject).value(forKey: "lastseen")!)")
                    
                    
                    let frndseenid = ("\(((self.signlehistorychatarray as AnyObject)[0] as AnyObject).value(forKey: "lastseen")!)")
                    self.friendlastseen = frndseenid
 

                    print(self.friendlastseen)
                    let createdTime = self.friendlastseen
                    if createdTime != "" && createdTime != "0"
                    {
                        let dateFormatterr = DateFormatter()
                        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let myDate = dateFormatterr.date(from: createdTime)!
                        self.Label2.text! = myDate.timeAgoDisplay()
                    }
                    else {
                        self.Label2.text! = ""
                    }
          
                    
                }
                    
                else
                {
                    
                    print("No data")
                }
            }
        }
        
        
    }
    
    
    
    func updatetypingstatus()
    {
        //         update_chat_typing_status
        //
        //
        //        sessionid: xxxxxxxx
        //        yourid : 2
        
        //        type_status: (0 – not typing, 1- typing message)
        var type_status = 0
        if a == 1{
            type_status = 1
        }
        else if a == 2 {
            type_status = 0
        }
        
        
        let params: [String:String] = ["yourid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"type_status" : "\(type_status)","sessionid" : "\(self.sessionid)"]
        let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_TYPING_STATUS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                let responsemessage = ((json ["ResponseMessage"].string)!)
                if responsemessage == "success"
                {
                    if ((json ["ResponseCode"].string)!) == "1"
                    {
                        
                        self.Label2.text = "typing..."
                        
                    }
                    else {
                        
                        
                    }
                    
                }
                
                
            }
        }
        
        
        
        
        
        
        
        
    }


}




