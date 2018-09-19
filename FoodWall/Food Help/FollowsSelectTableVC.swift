//
//  FollowsSelectTableVC.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 31/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FollowsSelectTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var headerView: UIView!
    
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var followsTable: UITableView!
    var followArray : NSArray = []
     var friendArray : NSMutableArray = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadowView()
        followsTable.delegate = self
        followsTable.dataSource = self
        followsTable.tableFooterView = UIView()
       // closeBtn.contentHorizontalAlignment = .left
        selectFollowers()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var DoneBTn: UIButton!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FollowSelectTableViewCell
        
        
        cell.selectionStyle = .none
        cell.profImage.sd_setImage(with: URL(string: (followArray[indexPath.row] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "img1"))
        cell.userName.text = "\(String(describing: (followArray[indexPath.row] as AnyObject).value(forKey: "first_name")!))  \((followArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
        if cell.checkBoxImage.image == #imageLiteral(resourceName: "square_check")
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
            
        }
        else
        {
        cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
        }
        cell.selctBtn.tag = indexPath.row
        
        cell.selctBtn.addTarget(self, action: #selector(selectAct), for: .touchUpInside)
      //  cell.bioDetails.text =
        return cell
    }
    
    
    
    @objc func selectAct(sender : UIButton!)
    {
    
        let cell = followsTable.cellForRow(at: IndexPath(row :sender.tag,section :0)) as! FollowSelectTableViewCell
        
       if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
       {
        cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
        friendArray.add((followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
        print(friendArray)
        
        }
      else
       {
         cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
        var cnt : Int = 0
        cnt = friendArray.count
         for i in 0..<cnt
         {
            
            if i == cnt
            {
                
            print("Nothing")
                
            }
            else if friendArray[i] as! String == (followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String
            {
                
                friendArray.removeObject(at: i)
                cnt = cnt - 1
            }
        }
        
        print(friendArray)
       }
        
        
    
    
    }
    
    @IBAction func closeAct(_ sender: UIButton) {
        
        red.cont()
        closePrivate.close()
        
     //  self.dismiss(animated: false, completion: nil)
        
    }
    func selectFollowers()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey : Constant.QA_CREATEDBY),"yourid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWER)"
       
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                
                if(self.followArray.count != 0)
                    
                {
                    
                   
                    print(self.followArray)
                    self.followsTable.reloadData()
                    
                    
                    
                    
                }
                    
                else
                {
                    print("No data")
                }
            }
    }
   
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    @IBAction func doneActn(_ sender: UIButton) {
       
        
        
        let params: [String:Any] = ["questid" :Utils.getPreferenceValue(ForKey: Constant.QUESTION_ID),"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"friends" :friendArray]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_QUESTION_REQUEST)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["status"] == 200 {
                
                if json["ResponseMessage"] == "success"
                    
                {
                 print("RequestSuccess")
                 self.dismiss(animated: false, completion: nil)
                 red.cont()
                }
                    
                else
                {
                    print("No data")
                }
            }
        }
        
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
