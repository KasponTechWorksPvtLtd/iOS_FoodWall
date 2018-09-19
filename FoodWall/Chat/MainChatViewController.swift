//
//  MainChatViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 23/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SystemConfiguration

class MainChatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var nochatlable: UILabel!
    @IBOutlet var headerView: UIView!
     @IBOutlet weak var Mytable: UITableView!
    var historychatarray = [[String:AnyObject]]()
     var chatmembers = [[String:AnyObject]]()
  var memarray = [String]()
     var memid = [String]()
    var groupid : String = ""
    var sessionid : String = ""
    var lastseen : String = ""
   
    
 
    var clickingvalue = 0
   
     let refreshControl = UIRefreshControl()
    
     @IBOutlet weak var profileview: UIView!
    
    @IBOutlet weak var profileimageview: UIImageView!
    
    @IBOutlet weak var profilelabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Mytable.delegate = self
        Mytable.dataSource = self
        self.nochatlable.isHidden = true
        Mytable.separatorStyle = .none
        Mytable.isHidden = true
        profileview.isHidden = true
        headerView.addShadowView()
       
        
        if (currentReachabilityStatus != .notReachable) == true {
            self.nochatlable.isHidden = true
          //  indicator.hidesWhenStopped = true
            Utils.svprogressHudShow(title: "Loading..", view: self)
              self.getChatHistoryNew()
            
        }
        else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Check your internet..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
       
        
//        if #available(iOS 10.0, *) {
//
//            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
//
//                // Your code is here:
//                self.getchatHistory()
//            }
//        }
//        else {
//
//            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.getchatHistory), userInfo: nil, repeats: true)
//        }

        

    }
    
    
    func appDelegate () -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let page = self.storyboard?.instantiateViewController(withIdentifier: "historychat") as! HistoryChatViewController
    let defaults = UserDefaults.standard
    
    
  page.username1 = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_lastname") as! String))"
   page.groupcreatedbyname = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "group_created_firstname") as! String))\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "group_created_lastname") as! String))"
    
   page.username2 = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_lastname") as! String))"
  
    page.userimage = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_picture") as! String))"

    page.sessionid = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "sessionid") as! String))"
  
     page.friendid = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "friendid") as! String))"
  
    page.groupname = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "group_name") as! String).decodeEmoji)"
  
    page.groupicon = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "group_icon") as! String))"
 
    page.groupid =  "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "groupid") as! String))"

    page.lastseen =  "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastseen")!)"
  page.createdon = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "created_on") as! String))"
    page.activestatus = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_online_status") as! String))"
    if  "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "groupid") as! String))" != "0"
    {
 page.chatmembers =  (((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "member") as! NSArray) as! [[String : AnyObject]])
    }
 
    self.present(page, animated: false, completion: nil)
    
    
    }
   
    @IBAction func chatbutton(_ sender: AnyObject) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "historychat") as! HistoryChatViewController
    
      
       print("\(clickingvalue)")
        page.username1 = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_lastname") as! String))"
        
        
        page.username2 = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_lastname") as! String))"
       
        page.userimage = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_picture") as! String))"
        
        page.sessionid = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "sessionid") as! String))"
       
        page.friendid = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "friendid") as! String))"
        
        page.groupname = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "group_name") as! String).decodeEmoji)"
      
        page.groupicon = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "group_icon") as! String))"
        
        page.groupid =  "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "groupid") as! String))"
       
        page.lastseen =  "\((historychatarray[clickingvalue] as AnyObject).value(forKey: "lastseen")!)"
       
        page.activestatus = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_online_status") as! String))"
       
        if  "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "groupid") as! String))" != "0"
        {
        
        page.chatmembers = (((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "member") as! NSArray) as! [[String : AnyObject]])
        }
      //  page.memarray = self.memarray
        
       // page.memid = self.memid
       
        self.present(page, animated: false, completion: nil)
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainchatcell", for: indexPath) as! mianchatTableViewCell
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainChatViewController.connected(_:)))
        cell.friendsimage.isUserInteractionEnabled = true
        cell.friendsimage.tag = indexPath.row
         cell.friendsimage.addGestureRecognizer(tapGestureRecognizer)
          cell.selectionStyle = UITableViewCellSelectionStyle.none
        
         sessionid = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "sessionid") as! String))"
        
         groupid =   "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "groupid") as! String))"
        
        
        groupid = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "groupid") as! String))"
        
        if groupid == "0" as String
            
        {
            
            cell.Name.text! = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_firstname") as! String!)!)\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_lastname") as! String!)!)"
            
            cell.friendsimage.sd_setImage(with: URL(string: "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_picture") as! String))"), placeholderImage: UIImage(named: "default"))
            
        }
            
        else
            
            //if groupid != "0" as String
            
        {
            
            cell.Name.text! = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "group_name") as! String).decodeEmoji)"
            
            cell.friendsimage.sd_setImage(with: URL(string: "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "group_icon") as! String))"), placeholderImage: UIImage(named: "default"))
            
        }
     
        
        let onlinestatus = "\(((self.historychatarray[indexPath.row] as AnyObject).value(forKey: "to_online_status") as! String))"
        
    
        
        let dateFormatterr = DateFormatter()
        
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let createdTime = "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastseen")!)"
        
        if onlinestatus == "0" as String
            
        {
            
            if createdTime != "" && createdTime != "0"
                
            {
                
                if groupid == "0" as String
                    
                {
                    
                    let myDate = dateFormatterr.date(from: createdTime)!
                    
                    cell.hours.text! = myDate.timeAgoDisplay()
                    
                }
                    
                else
                    
                {
                    
                    cell.hours.text! = ""
                    
                }
                
                if "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)" == "0"
                    
                {
                    
                }
                    
                else
                    
                {
                    
                    cell.status.text! = "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)".decodeEmoji
                    
                }
                
            }
                
            else
                
            {
                
                if "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)" == "0"
                    
                {
                    
                    cell.status.text! = ""
                    
                }
                    
                else
                    
                {
                    
                    cell.status.text! = "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)".decodeEmoji
                    
                }
                
                cell.hours.text! = ""
                
            }
            
        }
            
        else {
            
            if groupid != "0" as String
                
            {
                
                cell.status.text! = "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)".decodeEmoji
                
            }
                
            else  { //else if "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)" == "0" {
            
                cell.status.text! = "Active"
                
            }
                
//            else {
//
//                let myDate = dateFormatterr.date(from: createdTime)!
//
//                cell.hours.text! = myDate.timeAgoDisplay()
//
//                cell.status.text! = "\((historychatarray[indexPath.row] as AnyObject).value(forKey: "lastmessage")!)".decodeEmoji
//
//            }
            
            cell.hours.text! = " "
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return historychatarray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    @objc func connected(_ sender:AnyObject){
        
        print("you tap image number : \(sender.view.tag)")
        
        let clicktag = sender.view.tag
       clickingvalue = clicktag
        
        let userpic = "\(((self.historychatarray[clicktag] as AnyObject).value(forKey: "to_picture") as! String))"
        UserDefaults.standard.set("\(((self.historychatarray[clicktag] as AnyObject).value(forKey: "to_picture") as! String))", forKey: "userimage")
      let grouppic =  "\(((self.historychatarray[clicktag] as AnyObject).value(forKey: "group_icon") as! String))"
        if groupid == "0" as String {
            profileimageview.sd_setImage(with: URL(string: "\(userpic)"), placeholderImage: UIImage(named: "default"))
            profilelabel.text = "\(((self.historychatarray[clicktag] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clicktag] as AnyObject).value(forKey: "to_lastname") as! String))"
        }
        else {
            profileimageview.sd_setImage(with: URL(string: "\(grouppic)" ), placeholderImage: UIImage(named: "default"))
            profilelabel.text = "\(((self.historychatarray[clicktag] as AnyObject).value(forKey: "group_name") as! String).decodeEmoji)"
        }
        Mytable.reloadData()
       
        
        
     profileview.isHidden = false
        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
             profileview.isHidden = true
    }
    
    @IBAction func navigatechatpage(_ sender: Any) {
        
        
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "createchat") as! CreategorupchatViewController
        
        
        // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        // page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //  page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        
   
        
        
        self.present(page, animated: false, completion: nil)
        
        
        
    }
    
   
    @IBAction func infobutton(_ sender: Any) {
        print("\(clickingvalue)")
     
            if groupid == "0" as String
            {
                
                let page = self.storyboard?.instantiateViewController(withIdentifier: "individualeditmain") as! IndividualviewViewController
                
                page.username1 = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_lastname") as! String))"
                
                
                page.username2 = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_lastname") as! String))"
                
                page.userimage = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_picture") as! String))"
                
                page.sessionid = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "sessionid") as! String))"
                
                page.friendid = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "friendid") as! String))"
                
                page.groupname = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "group_name") as! String).decodeEmoji)"
                
                page.groupicon = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "group_icon") as! String))"
                
                page.groupid =  "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "groupid") as! String))"
                
                page.lastseen =  "\((historychatarray[clickingvalue] as AnyObject).value(forKey: "lastseen")!)"
                
                page.activestatus = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_online_status") as! String))"
                
               // page.memarray = self.memarray
                
                
                
                self.present(page, animated: false, completion: nil)
                
            }
            else {
                let page = self.storyboard?.instantiateViewController(withIdentifier: "groupeditmain") as! GroupeditmianpageViewController
                page.username1 = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_lastname") as! String))"
                
                
                page.username2 = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_firstname") as! String))\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_lastname") as! String))"
                
                page.userimage = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_picture") as! String))"
                
                page.sessionid = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "sessionid") as! String))"
                
                page.friendid = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "friendid") as! String))"
                
                page.groupname = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "group_name") as! String).decodeEmoji)"
                
                page.groupicon = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "group_icon") as! String))"
                
                page.groupid =  "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "groupid") as! String))"
                
                page.lastseen =  "\((historychatarray[clickingvalue] as AnyObject).value(forKey: "lastseen")!)"
                
                page.activestatus = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "to_online_status") as! String))"
                //created_on
                print( "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "created_on") as! String))")
                page.createdon = "\(((self.historychatarray[clickingvalue] as AnyObject).value(forKey: "created_on") as! String))"
                
                page.memarray = self.memarray
                
                
                
                
                
                self.present(page, animated: false, completion: nil)
            }
        
        
    }
    
    func getChatHistoryNew()
        
    {
        
        let parameters = ["userid" : "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"]
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_CHAT_HISTORY)", method: .post, parameters: parameters)
            
            .responseJSON { response in
                
                if response.result.value != nil {
                    
                    let myValue = response.result.value as! NSDictionary
                    
                    self.historychatarray = ((myValue.value(forKey: "Data") as! NSArray) as AnyObject) as! [[String : AnyObject]]
                    
                    self.Mytable.reloadData()
                    
                    self.nochatlable.isHidden = false
                    
                    self.Mytable.isHidden = false
                    
                    Utils.svprogressHudDismiss(view: self)
                    //self.indicator.stopAnimating()
                    
                }
                    
                else
                    
                {
                    
                    Utils.svprogressHudDismiss(view: self)
                    //self.indicator.stopAnimating()
                    self.showToast(message: "No Chat available")
                    self.nochatlable.isHidden = true
                    print("No data")
                }
                
        }
        
    }
    

//    @objc func getchatHistory()
//    {
//      //  indicator.hidesWhenStopped = true
//      //  indicator.startAnimating()
//        
//         let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
//       // let params: [String:String] = ["userid" : "4"]
//        let urlString = "\(Constant.BASEURL)\(Constant.GET_CHAT_HISTORY)"
//        
//        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
//            let result = response.result
//            let json = JSON(data: response.data!)
//            
//            if let resData = json["Data"].arrayObject {
//                
//                self.historychatarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
//                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
//                
//                
//                if(self.historychatarray.count != 0)
//                {
//                    print(self.historychatarray)
//                    
//                    self.Mytable.reloadData()
//                    self.nochatlable.isHidden = false
//                     self.indicator.stopAnimating()
//                    self.Mytable.isHidden = false
//                    //  self.indicator.stopAnimating()
//                    // self.followTable.reloadData()
//                    
//                }
//                    
//                else
//                {
//                     self.indicator.stopAnimating()
//                    self.showToast(message: "No Chat available")
//                     self.nochatlable.isHidden = true
//                    print("No data")
//                }
//            }
//        }
//        
//        
//    }
//   
    @IBAction func creategroupbutton(_ sender: Any) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "chatcreate") as! ChatcreationViewController
        
        let controller = "mainchatviewcontroller"
        
        page.controller = controller
        // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        // page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //  page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        
        
        
        
        self.present(page, animated: false, completion: nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //println("cancel")
        
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

//let decodedString = yourString.decodeEmoji
//let encodedString = yourString.encodeEmoji
extension String {
    var decodeEmoji: String{
        let data = self.data(using: String.Encoding.utf8);
        let decodedStr = NSString(data: data!, encoding: String.Encoding.nonLossyASCII.rawValue)
        if let str = decodedStr{
            return str as String
        }
        return self
    }
}
extension String {
    var encodeEmoji: String{
        if let encodeStr = NSString(cString: self.cString(using: .nonLossyASCII)!, encoding: String.Encoding.utf8.rawValue){
            return encodeStr as String
        }
        return self
    }
}
protocol Utilities {
}

extension NSObject:Utilities{
    
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var currentReachabilityStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
}
