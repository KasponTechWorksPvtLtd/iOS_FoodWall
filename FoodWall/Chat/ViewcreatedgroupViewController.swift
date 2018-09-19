//
//  ViewcreatedgroupViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 30/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewcreatedgroupViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var headerView: UIView!
    @IBOutlet weak var chatimage: UIImageView!
    
    @IBOutlet weak var Mytable: UITableView!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label1: UILabel!
    
     var intArray = [Int]()
    
     var grouparray = [[String:AnyObject]]()
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var sendbutton: UIButton!
   
    
    var placeholderLabel : UILabel!
    var groupname : String = ""
    var groupicon : String = ""
    var groupid : String = ""
    var sessionid : String = ""
    var friendid : String = ""
    var memarray = [String]()
    var memid = [String]()
    
    var signlehistorychatarray = [[String:AnyObject]]()
    var individualchatarray =  [[String:AnyObject]]()
    //groupmem
     var groupmem =  [[String:AnyObject]]()
    var tablerowheight = 0
    
    //  let emojiView = ISEmojiView()
    // var bRec:Bool = true
    // let emojiView = ISEmojiView(emojis: [[String]])
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getchatfriendsgroup()
        
        Label1.text = groupname
        let string = memarray.joined(separator: ", ")
        Label2.text = string
        print(string)
        //Label2.text = ""
        chatimage.sd_setImage(with: URL(string: "\(groupicon)"), placeholderImage: UIImage(named: "default"))
        
        
        
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
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // headerView.frame.size =
        
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewcreatedcell", for: indexPath) as! ViewcreatedgroupTableViewCell
        print("\(indexPath.row)")
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.lefttextview.delegate = self
        cell.righttextview.delegate = self
        cell.maintextview.delegate = self
        cell.lefttextview.centerVertically()
        cell.righttextview.centerVertically()
        // cell.maintextview.centerVertically()
        cell.maintextview.sizeToFit()
        cell.leftview.sizeToFit()
        cell.rightview.sizeToFit()
        print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "fromuserid")!)")
        print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "type_message")!)")
        print("\(((self.signlehistorychatarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "message")!)")
        //type_message
        
        
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
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "mainchat") as! MainChatViewController
        
        
        // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        // page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //  page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        
        self.present(page, animated: false, completion: nil)
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        if textview.text != ""
        {
            
            let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"groupid" : "\(groupid)","chat_message" : "\(textview.text!.encodeEmoji)"]
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GROUP_CHAT)"
            
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
                            
                            let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"groupid" : "\(self.groupid)","sessionid" : "\(self.sessionid)"]
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
    
   
    func getchatfriendsgroup()
        
        
    {
        
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "groupid" : "\(groupid)"]
        //  let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_GROUP_FRIENDS_USER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.groupmem = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.groupmem.count != 0)
                {
                    for var i in 0..<self.groupmem.count
                    {
                        let membername = ((self.groupmem[i] as AnyObject).value(forKey: "first_name") as! String)
                        self.memarray.append("\(membername)")
                        let memberid = ((self.groupmem[i] as AnyObject).value(forKey: "friendid") as! String)
                        self.memid.append("\(memberid)")
                        
                        
                    }
                    
                    if self.memid.contains(Utils.getPreferenceValue(ForKey: Constant.USER_ID))
                    {
                        let indexOfA = self.memid.index(of: Utils.getPreferenceValue(ForKey: Constant.USER_ID))
                        self.memarray[indexOfA!] = "You"
                        
                    }
                    
                    let string = self.memarray.joined(separator: ", ")
                    self.Label2.text = string
                    //first_name
                    
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                    
                    print("No data")
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


