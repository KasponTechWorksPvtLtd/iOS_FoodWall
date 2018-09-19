//
//  FollowchoiceViewController.swift
//  FoodWall
//
//  Created by MacOsHighSierra on 19/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FollowchoiceViewController: UIViewController,UITabBarDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var Mytable: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var bottomBar: UITabBar!
    @IBOutlet var menuBarItem: UITabBarItem!
    @IBOutlet var notificationsButton: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!
    var dataArray = [[String:AnyObject]]()
    var followerid = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Mytable.delegate = self
        Mytable.dataSource = self
        bottomBar.selectedItem = notificationsButton
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        bottomBar.selectedItem?.title = "Notifications"
        bottomBar.isHidden = false
        Mytable.separatorStyle = .none
        headerView.addShadowView()
        
        getfollowerrequest()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
   func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! FoodchoiceTableViewCell
        
        print((self.dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String)
        cell.Name.text = "\(((self.dataArray[indexPath.row] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.dataArray[indexPath.row] as! AnyObject).value(forKey: "last_name") as! NSString) )"
        cell.smallname.text = "\(((self.dataArray[indexPath.row] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.dataArray[indexPath.row] as! AnyObject).value(forKey: "last_name") as! NSString) )"
       cell.foodimage.sd_setImage(with: URL(string: "\(((self.dataArray[indexPath.row] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
        cell.Acceptbutton.tag = indexPath.row
        cell.Acceptbutton.addTarget(self, action: #selector(AcceptAction), for: .touchUpInside)
        cell.Nobutton.tag = indexPath.row
        cell.Nobutton.addTarget(self, action: #selector(DeclineAction), for: .touchUpInside)
         followerid = (self.dataArray[indexPath.row] as AnyObject).value(forKey: "follower_id") as! String
        //"follower_id"
        
        return cell
    }
    
    @objc func AcceptAction()
    {
        print("Accepted")
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"followerid" : "\(followerid)" , "follow" : "\(1)"]
        // let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        print("\(params)")
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_FOLLOWER_REQUEST)"
        
        
       
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["status"] == 200 {
                
                if json["ResponseMessage"] == "success"
                    
                {
                    print("AcceptedSuccess")
                    self.Mytable.reloadData()
                  self.navigationController?.popViewController(animated: true)
                }
                    
                else
                {
                    print("No data")
                }
            }
        }
        
    }
    @objc func DeclineAction()
    {
        print("Declined")
        print("Accepted")
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"followerid" : "\(followerid)" , "follow" : "\(0)"]
        // let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        print("\(params)")
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_FOLLOWER_REQUEST)"
        
        
        
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["status"] == 200 {
                
                if json["ResponseMessage"] == "success"
                    
                {
                    print("DeclinedSuccess")
                    self.Mytable.reloadData()
                    self.navigationController?.popViewController(animated: true)
                }
                    
                else
                {
                    print("No data")
                }
            }
        }
        
    }
    func getfollowerrequest()
    {
        //let params: [String:String] = ["userid" : "4"]
         let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        print("\(params)")
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWER_REQUEST)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray = resData as! [[String:AnyObject]]
                
                if(self.dataArray.count != 0){
                    self.Mytable.reloadData()
                    
                   
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                  
                    self.showToast(message: "No Followers yet")
                    
                }
            }
            
        }
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

