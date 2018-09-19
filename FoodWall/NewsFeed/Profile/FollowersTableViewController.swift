//
//  FollowersTableViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 09/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class FollowersTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
 
    
    @IBOutlet weak var FollowHeaderLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var FollowersName: UILabel!
    @IBOutlet var followTable: UITableView!
    var pro : String = ""
    var userid1 :String = ""
    var followText :String = ""
    var followArray =  [[String:AnyObject]]()
    var userFollowingsArray : NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.addShadowView()
        followTable.delegate = self
        followTable.dataSource = self
        if pro == "1"
        {
        FollowHeaderLabel.text = "Followers"
        getFollwers()
        }
        
        else
        {
            FollowHeaderLabel.text = "Followings"
            getFollowings()
        }
        followTable.tableFooterView = UIView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backAct(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
    // MARK: - Table view data source
    
   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if followArray.count == 0
        {
            
            
            return 0
        }
        else
        {
        return followArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FollowerTableViewCell
        
        if pro == "1"
        {
        
        cell.followerName.text = "\((followArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((followArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
        cell.FollowButton.applyGradient()
        cell.bioDetail.text = "\((followArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((followArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
        cell.profPicture.sd_setImage(with: URL(string:"\((followArray[indexPath.row] as AnyObject).value(forKey: "picture")!)"), placeholderImage: UIImage(named: "default"))
        cell.FollowButton.tag = indexPath.row
        
        if "\((followArray[indexPath.row] as AnyObject).value(forKey: "friend")!)" != "0"
        {
            
            cell.FollowButton.setTitle("Following", for: .normal)
            
        }
        
        else
        {
            
           cell.FollowButton.setTitle("Follow", for: .normal)
            
        }
//        cell.FollowButton.addTarget(self, action: #selector(followBUTTON), for: .touchUpInside)
            
        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == "\((followArray[indexPath.row] as AnyObject).value(forKey: "follower_id")!)"
        {
            cell.FollowButton.isHidden = true
            
        }
        
            
        return cell
        }
        
        else
        {
            
            cell.followerName.text = "\((followArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((followArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
            cell.FollowButton.applyGradient()
            cell.bioDetail.text = "\((followArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((followArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
            cell.profPicture.sd_setImage(with: URL(string:"\((followArray[indexPath.row] as AnyObject).value(forKey: "picture")!)"), placeholderImage: UIImage(named: "default"))
            cell.FollowButton.tag = indexPath.row
            
            if "\((followArray[indexPath.row] as AnyObject).value(forKey: "friend")!)" != "0"
            {
                
                cell.FollowButton.setTitle("UnFollow", for: .normal)
                
            }
                
            else
            {
                
                cell.FollowButton.setTitle("Follow", for: .normal)
                
            }
            cell.FollowButton.addTarget(self, action: #selector(followBUTTON), for: .touchUpInside)
            if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == "\((followArray[indexPath.row] as AnyObject).value(forKey: "following_id")!)"
            {
                cell.FollowButton.isHidden = true
                
            }
            
            return cell
        }
        
    }
    
    
    @objc func followBUTTON( _ sender : UIButton)
    {
        
        
        
     let cell = followTable.cellForRow(at: NSIndexPath(row: sender.tag , section:0) as IndexPath) as! FollowerTableViewCell
        
        if pro == "1"
        {
        
     userid1 = "\((followArray[sender.tag] as AnyObject).value(forKey: "follower_id")!)"
        
        }
        
        else
        {
            userid1 = "\((followArray[sender.tag] as AnyObject).value(forKey: "following_id")!)"
        }
        
        if cell.FollowButton.title(for: .normal) == "Follow"
        {
            
            cell.FollowButton.setTitle("UnFollow", for: .normal)
            self.followText = "1"
            self.create_editFollower()
            
            
        }
            
        else
        {
            let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to want to UnFollow?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                 cell.FollowButton.setTitle("Follow", for: .normal)
                self.followText = "0"
                self.create_editFollower()
                
              
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
    
        
        
    }
    
    
    func create_editFollower()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"followerid" : userid1 , "follow" : followText]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_FOLLOWER)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    print("success")
                    
                }
                
            }
            
        }
        
        
    }
    
    
    func getFollwers()
    {
        
        var userid :String = ""
        
        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) != Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)
        {
            
            userid = Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)
            
        }
        else
        {
            
            userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            
        }
//
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
        Utils.svprogressHudShow(title: "Loading...", view: self)
      
        let params: [String:String] = ["userid" : userid,"yourid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
       
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWER)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followArray = (resData as! [[String:AnyObject]])
                
           
               
                if(self.followArray.count != 0)
                    
                {
                    
                    print(self.followArray)
                     print(self.followArray.count)
                    var cnt = self.followArray.count
                   for i in 0..<cnt
                   {
                    
                    if i == cnt
                    {
                        
                        print("no value")
                        
                    }
                    else
                    {
                    
                    if Utils.getPreferenceValue(ForKey: Constant.CREATED_BY_USERID) ==  "\((self.followArray[i] as AnyObject).value(forKey: "follower_id")!)"
                    {
                        
                        self.followArray.remove(at: i)
                        cnt = cnt - 1
                        print(cnt)
                    
                    }
                   
                    
                    }
                    
                    }
                 
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator.stopAnimating()
                    //self.showToast(message: "Interest Shown")
                    self.followTable.reloadData()
                    
                    
                    
                }
                
                else
                {
                   print("No data")
                }
            }
            
        }
        
        
        
    }
    
    func  getFollowings()
    {
        
        var userid :String = ""
        
        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) != Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)
        {
            
            userid = Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)
            
        }
        else
        {
            
             userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            
        }
        
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
        Utils.svprogressHudShow(title: "Loading...", view: self)
      
        
        let params: [String:String] = ["userid" : userid ,"yourid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWINGS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followArray = (resData as! [[String:AnyObject]])
                
                    if(self.followArray.count == 0){
                    
                    print("ANUSHA")
//                        self.indicator.stopAnimating()
                   
                        Utils.svprogressHudDismiss(view: self)
                }
                    
                else
                    
                {
                    
                    print(self.followArray)
                    
                    var cnt = self.followArray.count
                    for i in 0..<cnt
                    {
                        
                        if i == cnt
                        {
                            
                            print("no value")
                            
                        }
                        else
                        {
                            
                            if Utils.getPreferenceValue(ForKey: Constant.CREATED_BY_USERID) ==  "\((self.followArray[i] as AnyObject).value(forKey: "following_id")!)"
                            {
                                
                                self.followArray.remove(at: i)
                                cnt = cnt - 1
                                print(cnt)
                                
                                
                            }
                            
                            
                        }
                        
                    }
                  
                    Utils.svprogressHudDismiss(view: self)
                    //self.indicator.stopAnimating()
                    self.followTable.reloadData()
            
                    
                    
                    
                }
            }
            
            
            else
            {
                self.showToast(message: "Server Error")
                 // self.indicator.stopAnimating()
                
                Utils.svprogressHudDismiss(view: self)
            }
            
        }
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

