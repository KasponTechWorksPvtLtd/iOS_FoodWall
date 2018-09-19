//
//  HistoryChatViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 26/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HistoryChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var chatimage: UIImageView!
     var myHeight = 0
    @IBOutlet weak var Mytable: UITableView!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var nolongerlabel: UILabel!
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var sendbutton: UIButton!
    //@IBOutlet weak var emoji: UIButton!
    var memid = [String]()
    var placeholderLabel : UILabel!
    var createdon : String = ""
    var username1 : String = ""
    var username2 : String = ""
    var userimage : String = ""
    var sessionid : String = ""
    var friendid : String = ""
    var groupname : String = ""
    var groupicon : String = ""
    var groupid : String = ""
    var lastseen : String = ""
    var activestatus : String = ""
     var groupcreatedbyname : String = ""
     var chatmembers = [[String:AnyObject]]()
    var tablerowheight = 0
    var a = 0
    var currentcount = 0
    var previouscount = 0
    var value = 0
    
   
    
    var indexinput = -1
    var memarray = [String]()
    //var individualchatarray : NSArray = []
    var signlehistorychatarray = [[String:AnyObject]]()
    var individualchatarray =  [[String:AnyObject]]()
   
    //  let emojiView = ISEmojiView()
    // var bRec:Bool = true
    // let emojiView = ISEmojiView(emojis: [[String]])
    override func viewDidLoad() {
        
         headerView.addDropShadowToView(targetView: headerView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HistoryChatViewController.connect(_:)))
        headerView.isUserInteractionEnabled = true
       
        headerView.addGestureRecognizer(tapGestureRecognizer)
        
     //   getchathistorysingle()
        //gettypingstatus()
        
        
        super.viewDidLoad()
        
        Mytable.rowHeight = UITableViewAutomaticDimension
        Mytable.estimatedRowHeight = 300
        
        
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
       
        for var i in 0..<chatmembers.count
        {
            let membername = ((self.chatmembers[i] as AnyObject).value(forKey: "first_name") as! String)
            memarray.append("\(membername)")
            let memberid = ((self.chatmembers[i] as AnyObject).value(forKey: "friendid") as! String)
            memid.append("\(memberid)")
            
            
        }
       
        
        if groupid == "0" as String
        {
            self.textview.isHidden = false
            self.sendbutton.isHidden = false
            self.nolongerlabel.isHidden = true
        Label1.text = username1
            print(activestatus)
            
             if activestatus == "0" as String
             {
                
            
                
            let createdTime = lastseen
           if createdTime != "" && createdTime != "0"
           {
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
                 Label2.text = myDate.timeAgoDisplay()
                }
           else {
            
                 Label2.text = ""
            
                }
            
   
            
            }
             else {
                  Label2.text = "Online"
            }
            
        
        chatimage.sd_setImage(with: URL(string: "\(userimage)"), placeholderImage: UIImage(named: "default"))
            

            
        }
        else {
            Label1.text = groupname.decodeEmoji
            
            if memid.contains(Utils.getPreferenceValue(ForKey: Constant.USER_ID))
            {
                let indexOfA = memid.index(of: Utils.getPreferenceValue(ForKey: Constant.USER_ID))
                memarray[indexOfA!] = "You"
                self.textview.isHidden = false
                self.sendbutton.isHidden = false
                self.nolongerlabel.isHidden = true
            }
            else {
                
                self.textview.isHidden = true
                self.sendbutton.isHidden = true
                self.nolongerlabel.isHidden = false
                
            }
            
            
         let string = memarray.joined(separator: ", ")
            Label2.text = string
            print(string)
            chatimage.sd_setImage(with: URL(string: "\(groupicon)"), placeholderImage: UIImage(named: "default"))
        }
        
        
        
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
    //    func emojiViewDidSelectEmoji(emojiView: ISEmojiView, emoji: String) {
    //        textview.insertText(emoji)
    //    }
    //    func emojiViewDidPressDeleteButton(emojiView: ISEmojiView) {
    //        textview.deleteBackward()
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "0" && "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" != Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "send", for: indexPath) as! senderTableViewCell
         
       
        
               cell.sendtextview.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            cell.sendtextview.text = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
            
           
          
            return cell
            
            
        }
        else if  "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)" == "0" && "\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)  {
             let cell = tableView.dequeueReusableCell(withIdentifier: "receive", for: indexPath) as! receiverTableViewCell

          
           cell.receivetextview.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
            cell.proimage.sd_setImage(with: URL(string: "\(((self.signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "to_picture") as! String))"), placeholderImage: UIImage(named: "default"))
            cell.receivetextview.text = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
           
            
         
            return cell
            
        }
            
            
            
        else  {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "chathistorycell", for: indexPath) as! chathistoryTableViewCell
//
            cell.maintextview.text = "\((signlehistorychatarray[indexPath.row] as AnyObject).value(forKey: "message")!)".decodeEmoji
                cell.maintextview.padding = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
           
            return cell
        }
        
        
        
        
        

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
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
    
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
   
    @IBAction func Back(_ sender: Any) {
//         var viewcontroller = MainChatViewController()
//        viewcontroller.getChatHistoryNew()
            let page = self.storyboard?.instantiateViewController(withIdentifier: "mainchat") as! MainChatViewController
        
        self.present(page, animated: false, completion: nil)
        
       // self.dismiss(animated: true, completion: nil)
    }
    
     @objc func connect(_ sender:AnyObject){
      
            
            if groupid == "0" as String
            {
                
                let page = self.storyboard?.instantiateViewController(withIdentifier: "individualeditmain") as! IndividualviewViewController
                
                page.username1 = self.username1
                
                
                page.username2 = self.username2
                
                page.userimage = self.userimage
                
                page.sessionid = self.sessionid
                
                page.friendid = self.friendid
                
                page.groupname = self.groupname.decodeEmoji
                
                page.groupicon = self.groupicon
                
                page.groupid =  self.groupid
                
                page.lastseen =  self.lastseen
                
                page.activestatus = self.activestatus
                
                page.memarray = self.memarray
                
                
                
                self.present(page, animated: false, completion: nil)
                
            }
            else {
                let page = self.storyboard?.instantiateViewController(withIdentifier: "groupeditmain") as! GroupeditmianpageViewController
                page.username1 = self.username1
                
                page.group_created_lastname = self.groupcreatedbyname
                
                page.username2 = self.username2
                
                page.userimage = self.userimage
                
                page.sessionid = self.sessionid
                
                page.friendid = self.friendid
                
                page.groupname = self.groupname.decodeEmoji
                
                page.groupicon = self.groupicon
                
                page.groupid =  self.groupid
                
                page.lastseen =  self.lastseen
                
                page.activestatus = self.activestatus
                
                page.memarray = self.memarray
                
                page.createdon = self.createdon
                
                
                
                
                self.present(page, animated: false, completion: nil)
            }
            
            
   
        print("Connected")
       
        
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
        self.value = 0
        // let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"groupid" : "0","sessionid" : "\(self.sessionid)"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_SINGLE_CHAT_HISTORY)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.signlehistorychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                //lastseen
                if let resData = json["Data"].arrayObject {
                    
                    self.signlehistorychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                    //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                    self.currentcount = self.signlehistorychatarray.count
                    if(self.currentcount > self.previouscount)
                    {
                        self.value = 1
                        self.previouscount = self.currentcount
                        print(self.signlehistorychatarray)
                        self.Mytable.reloadData()
                        
                        self.Mytable.isHidden = false
                        self.textview.text! = ""
                        
                    }
                        
                    else
                    {
                        self.value = 0
                        print("No update")
                        
                    }
                }
                else {
                    
                    print("No data")
                }
            
            
            }
        
        
        }
        
    }
    
//    method name :  get_chat_typing_status
//
//    Input Request Parameter:
//
//    sessionid: xxxxxxxx
//    userid : 2
    
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
    
    
    //    @IBAction func emojibutton(_ sender: Any) {
    //
    //
    //        bRec = !bRec
    //        if (bRec == true) {
    //           self.emoji.setImage(#imageLiteral(resourceName: "emojiforchat"), for: .normal)
    //
    //        textview.inputView = emojiView
    //           self.textview.becomeFirstResponder()
    //
    //        } else {
    //           self.emoji.setImage(#imageLiteral(resourceName: "Keyboard"), for: .normal)
    //            textview.inputView =  textview
    //             self.textview.becomeFirstResponder()
    //        }
    
    
    
    
    
    
    
    //    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }
    
    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets!, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
        } else {
            self.drawText(in: rect)
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }
        
        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        
        if let insets = padding {
            textWidth -= insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
        }
        
        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedStringKey.font: self.font], context: nil)
        
        contentSize.height = ceil(newSize.size.height) + insetsHeight
        
        return contentSize
    }
}
extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}

