//
//  ChatcreationViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChatcreationViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var headerView: UIView!
       @IBOutlet weak var Mytable: UITableView!
     var controller = ""
    @IBOutlet weak var profileview: UIView!
    var followarray = [[String:AnyObject]]()
    var idarr = [String]()
     var groupid : String = ""
    var id : String = ""
    @IBOutlet weak var profileimageview: UIImageView!
    
    @IBOutlet weak var profilelabel: UILabel!
    
    @IBOutlet weak var showlabel: UILabel!
    
  
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadowView()
        profileview.isHidden = true
        Mytable.delegate = self
        Mytable.dataSource = self
      //  showlabel.layer.backgroundColor = UIColor.red.cgColor
       
       //  indicator.hidesWhenStopped = true
        
        Mytable.separatorStyle = .none
        self.Mytable.isHidden = true
      //  showlabel.isHidden = true
        print("controller")
        if controller == "groupeditmainpageviewcontroller"
        {
             showlabel.text! = "No new friends to add..."
            getchatfriendsgroup()
           
        }
        else
        {
              showlabel.text! = "No followers..."
        showfollowers()
          
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcreate", for: indexPath) as! chatcreationTableViewCell
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainChatViewController.connected(_:)))
        cell.followerimage.isUserInteractionEnabled = true
        cell.followerimage.tag = indexPath.row
        cell.followerimage.addGestureRecognizer(tapGestureRecognizer)
        
        
        profileimageview.sd_setImage(with: URL(string: "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"), placeholderImage: UIImage(named: "default"))
        profilelabel.text = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        
        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.Firstnamebold.text! =  "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        
        cell.firstnamesmall.text! = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        cell.followerimage.sd_setImage(with: URL(string: "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"), placeholderImage: UIImage(named: "default"))
       cell.checkbox.tag = indexPath.row
        cell.checkbox.addTarget(self, action: #selector(ChatcreationViewController.btnAction(_:)), for: .touchUpInside)

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return followarray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    @objc func connected(_ sender:AnyObject){
        
//        print("you tap image number : \(sender.view.tag)")
//
//        profileview.isHidden = false
        
        
    }
    @IBAction func dismiss(_ sender: Any) {
        profileview.isHidden = true
    }
    
     @objc func btnAction(_ sender: AnyObject) {
        let cell = Mytable.cellForRow(at: IndexPath(row :sender.tag,section :0)) as! chatcreationTableViewCell
        
        
              print(idarr)
        
        
        if cell.checkbox.currentImage == #imageLiteral(resourceName: "square")
        {
            cell.checkbox.setImage(#imageLiteral(resourceName: "square_check"), for: UIControlState.normal)
            print(sender.tag)
            print(followarray)
            
            
            
            //friendid
            if controller == "groupeditmainpageviewcontroller"
            {
                
            idarr.append((followarray[sender.tag] as AnyObject).value(forKey: "friendid") as! String)
            }
            else {
                 idarr.append((followarray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
            }
//            friendNames.add("\(String(describing: (followArray[sender.tag] as AnyObject).value(forKey: "first_name")!))  \((followArray[sender.tag] as AnyObject).value(forKey: "last_name")!)")
                 print(idarr)
        }
        else
        {
            cell.checkbox.setImage(#imageLiteral(resourceName: "square"), for: UIControlState.normal)
            
           
            if controller == "groupeditmainpageviewcontroller"
            {
            
            id = ((followarray[sender.tag] as AnyObject).value(forKey: "friendid") as! String)
            }
            else {
                 id = ((followarray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
            }
            if idarr.contains(id)
            {
                let indexOfA = idarr.index(of: id)
                idarr.remove(at: indexOfA!)
            }
            
           
                 print(idarr)
            }
        
            print(idarr)
        
        
   
        
        
    }
    func getchatfriendsgroup()
        
        
    {
        //  indicator.hidesWhenStopped = true
         // indicator.startAnimating()
        Utils.svprogressHudShow(title: "Loading", view: self)
        let params: [String:String] = ["yourid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID), "groupid" : "\(groupid)"]
        //  let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_CHAT_FRIENDS_GROUP)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.followarray.count != 0)
                {
                    print(self.followarray)
                      self.Mytable.isHidden = false
                    self.Mytable.reloadData()
                     self.showlabel.isHidden = true
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator.stopAnimating()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                   
                      self.Mytable.isHidden = true
                   self.showlabel.isHidden = false
//                    let alert = UIAlertController(title: "Alert", message: "No Members to add", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                     Utils.svprogressHudDismiss(view: self)
                // self.indicator.stopAnimating()
                  self.Mytable.isHidden = true
                self.showlabel.isHidden = false
//                let alert = UIAlertController(title: "Alert", message: "No Members to add", preferredStyle: UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
            }
        }
        
    
        
    }
    
    
    func showfollowers()
    {
       // indicator.hidesWhenStopped = true
      //  indicator.startAnimating()
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        //  let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWERS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.followarray.count != 0)
                {
                    print(self.followarray)
                      self.Mytable.isHidden = false
                    self.Mytable.reloadData()
                    self.showlabel.isHidden = true
                        Utils.svprogressHudDismiss(view: self)
                  // self.indicator.stopAnimating()
                  
                    
                }
                    
                else
                {
                         Utils.svprogressHudDismiss(view: self)
                      // self.indicator.stopAnimating()
                       self.Mytable.isHidden = true
                    self.showlabel.isHidden = false
                    print("No data")
                }
            }
            else{
                     Utils.svprogressHudDismiss(view: self)
                //self.indicator.stopAnimating()
                self.Mytable.isHidden = true
                self.showlabel.isHidden = false
                print("No data")
            }
        }
        
        
    }
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func Nextbutton(_ sender: Any) {
        
        if controller == "groupeditmainpageviewcontroller"
        {
        
//            method name : create_group_friends
//
//            Input Request Parameter:
//
//            groupid :
//            userid:
//            friends -( give id for each users).
//
//            Example:
//            Array format : friends'=>array(1,2,3).
             let intArray = [3,4]
            
       if idarr.count == 0  {
                let alert = UIAlertController(title: "FoodWall", message: "choose atleast one members to create a group", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { _ in
           
        
        
        
        
            let params:[String:Any] = ["groupid" : "\(self.groupid)" as AnyObject,"userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) as AnyObject,"friends" : intArray]
        //  let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GROUP_FRIENDS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                
                
                
                let responsemessage = ((json ["ResponseMessage"].string)!)
                if responsemessage == "success"
                {
                    
                    print("Created Successfully")
                    
                    let page = self.storyboard?.instantiateViewController(withIdentifier: "mainchat") as! MainChatViewController
                    self.present(page, animated: false, completion: nil)
                    
                    
                    
                    
                    
                }
                else{
                    
                    
                    
                    
                }
                
                
                
                
                
                
            }
            
        }
        
        }))
        
        
        
        
        
        
        
                self.present(alert, animated: true, completion: nil)
            }
            
            
      
            
        }
        else {
          
            if idarr.count <= 1 {
                let alert = UIAlertController(title: "FoodWall", message: "choose atleast two members to create a group", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
                
            }
            else {
                let page = self.storyboard?.instantiateViewController(withIdentifier: "creategrouppage") as! CreategrouppageViewController
                page.idarr = self.idarr
                
                
                self.present(page, animated: false, completion: nil)
            }

           
        }
        
        
    }
    
    @IBAction func chat(_ sender: Any) {
        
    }
    
    @IBAction func info(_ sender: Any) {
        
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

