//
//  BucketGrpFollowerController.swift
//  FoodWall
//
//  Created by apple on 8/9/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BucketGrpFollowerController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var addbtn: UIButton!
    @IBOutlet weak var newTable: UITableView!
    var userID : String = ""
    var followArray : NSArray = []
    var groupArray : NSArray = []
    var friendArray : NSMutableArray = []
    var friendNames : NSMutableArray = []
    var grpArray : NSMutableArray = []
    var REviewID : String = ""
     var dict:NSDictionary!
   //  var originalFollowersList = [[String:AnyObject]]()
    var followersList : NSMutableArray = []
     var groupList : NSMutableArray = []
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchHeaderView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var headerView: UIView!
    var userName : String = ""
    var a : Int!
    
    var filteredCall : [String] = []
    var filteredCall1 : [String] = []
    var filteredArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.addShadowViewProfile()
        newTable.delegate = self
        newTable.dataSource = self
        searchTable.delegate = self
        searchTable.dataSource = self
        newTable.tableFooterView = UIView()
        searchTable.tag = 1
        addbtn.applyGradientYellow()
        addbtn.layer.cornerRadius = 15.0
        addbtn.clipsToBounds = true
        selectFollowers()
        searchView.isHidden = true
        searchTextField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        addbtn.frame = CGRect(x : 140.0, y : self.searchTable.frame.maxY + 30,width : 135.0,height : 35.0)
       // selectGroups()
        // Do any additional setup after loading the view.
    }
    
    
    
    func selectGroups()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_GROUP_USER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.groupArray = (resData as! [[String:AnyObject]] as NSArray)
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.groupArray.count != 0)
                {
                    
                    
                    print(self.groupArray)
                    self.filteredCall1.removeAll()
                    
                    for i in 0..<self.groupArray.count
                        
                    {
                        
                        self.filteredCall1.append((self.groupArray[i] as! NSDictionary).value(forKey: "group_name") as! String)
                        print("filteredCall : \(self.filteredCall1)")
                    }
                    
                    self.newTable.reloadData()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                    self.showToast(message: "No data Found")
                }
            }
        }
        
    }
    
    func selectFollowers()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWERS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followArray = (resData as! [[String:AnyObject]] as NSArray)
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.followArray.count != 0)
                {
                    print(self.followArray)
                    self.filteredCall.removeAll()
                    
                    for i in 0..<self.followArray.count
                        
                    {
                        
                        self.filteredCall.append((self.followArray[i] as! NSDictionary).value(forKey: "first_name") as! String)
                        
                    }
                    

                    self.selectGroups()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                    self.showToast(message: "No data Found")
                }
            }
        }
        
    }

    
    @IBAction func addBucketList(_ sender: UIButton) {
        
        addBucketIndividual()
        
        
        
        
    }
    
    @objc func searchRecords(_ textField: UITextField) {
       
        filteredArray.removeAll()
        groupList.removeAllObjects()
        followersList.removeAllObjects()
        
        if a == 1
        {
            filteredCall = filteredCall1
        }
        
        filteredArray = filteredCall.filter( { (text) -> Bool in
            
            let tmp = text as! String
            
            let range = tmp.range(of: searchTextField.text! as! String,options:NSString.CompareOptions.caseInsensitive)
           
            
            return range != nil
            
        })
       

        searchTable.isHidden = false
        searchTable.reloadData()
    }
    
    @IBAction func bCKACT(_ sender: Any) {
        
        searchView.isHidden = true
       
    }
    
    @IBAction func closeAct(_ sender: UIButton) {
        
        searchTextField.text = ""
        searchRecords(searchTextField)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView.tag == 0
        {
        if section == 0
        {
            if followArray.count != 0
            {
            return followArray.count
            }
            else
            {
                return 0
            }
        }
//        else if section == 1
//        {
//            return 1
//        }
        else if section == 1
        {
            if groupArray.count != 0
            {
            return groupArray.count
            }
            else
            {
                return 0
            }
        }
        else
        {
            return 0
        }
        
        }
        
        else
        {
            
           return 1
           
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 0
        {
        return 2
        }
        else
        {
            return filteredArray.count
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0
        {
        
        
//        if indexPath.section == 1
//        {
//
//            let cell = UITableViewCell()
//            let btn1:UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width/3 + 15, y: 10, width: 100, height: 30))
//            cell.selectionStyle = .none
//            btn1.addTarget(self, action: #selector(addBucketIndividual), for: .touchUpInside)
//            btn1.setTitle("Add", for: .normal)
//            //  btn1.addShadowViewProfile()
//            btn1.applyGradientYellow()
//            btn1.layer.cornerRadius = 15.0
//            btn1.clipsToBounds = true
//            btn1.titleColor(for: .normal)
//            cell.contentView.addSubview(btn1)
//            return cell
//        }
//
//        else if indexPath.section == 3
//        {
//            let cell = UITableViewCell()
//            let btn2:UIButton = UIButton.init(frame: CGRect.init(x: self.view.frame.size.width/3 + 15, y: 10, width: 100, height: 30))
//            cell.selectionStyle = .none
//            btn2.addTarget(self, action: #selector(addBucketGroup), for: .touchUpInside)
//            btn2.setTitle("Add", for: .normal)
//            btn2.layer.cornerRadius = 20.0
//            btn2.clipsToBounds = true
//            btn2.applyGradientYellow()
//            btn2.layer.cornerRadius = 15.0
//            btn2.backgroundColor = UIColor.yellow
//            btn2.titleColor(for: .normal)
//            cell.contentView.addSubview(btn2)
//            return cell
//        }
//
//        else
//        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FollowSelectTableViewCell
            cell.selectionStyle = .none
            if indexPath.section == 0
            {
            //cell.profImage.image = #imageLiteral(resourceName: "confused")
            cell.profImage.sd_setImage(with: URL(string: (followArray[indexPath.row] as! AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
            cell.profImage.isHidden = false
            cell.checkBoxImage.isHidden = false
            cell.userName.isHidden = false
            cell.selctBtn.isHidden = false
            cell.userName.text = (followArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String
                cell.selctBtn.tag = indexPath.row
                cell.selectBtn1.isHidden = true
//                cell.selctBtn.tag = indexPath.section + 1000
               // cell.selctBtn.tag
                cell.selctBtn.addTarget(self, action: #selector(selectAct), for: .touchUpInside)
                
            }
            else
            {
             cell.profImage.sd_setImage(with: URL(string: (groupArray[indexPath.row] as! AnyObject).value(forKey: "group_icon") as! String), placeholderImage: UIImage(named: "default"))
              cell.userName.text = (groupArray[indexPath.row] as AnyObject).value(forKey: "group_name") as! String
             cell.selectBtn1.tag = indexPath.row
                cell.selctBtn.isHidden = true
                cell.selectBtn1.isHidden = false
              //   cell.selctBtn.tag = indexPath.section + 2000
                cell.selectBtn1.addTarget(self, action: #selector(selectAct1), for: .touchUpInside)
            }
            
            
            if cell.checkBoxImage.image == #imageLiteral(resourceName: "square_check")
            {
                cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
                
            }
            else
            {
                cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
            }
            
            return cell
//        }
        
        }
        
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FollowSelectTableViewCell
    
            if a == 1
            {
            for i in 0..<groupArray.count
                
            {
                
                if filteredArray.count > 0
                    
                {
                    
                    if (groupArray[i] as! AnyObject).value(forKey: "group_name") as! String == filteredArray[indexPath.section]
                        
                    {
                        
                        groupList.add(groupArray[i] as! AnyObject)
                        print(groupList)
                        
                    }
                    
                }
                    
                else
                    
                {
                    
                    print("anu")
                    
                }
                
            }

            
            cell.profImage.sd_setImage(with: URL(string: (groupList[indexPath.section] as AnyObject).value(forKey: "group_icon") as! String), placeholderImage: UIImage(named: "default"))
          
            cell.selctBtn.isHidden = false
          
            cell.selctBtn.tag = indexPath.section
            cell.selctBtn.addTarget(self, action: #selector(selectAction1), for: .touchUpInside)
            cell.userName.text = (groupList[indexPath.section] as AnyObject).value(forKey: "group_name") as! String
            addbtn.frame = CGRect(x : 140.0, y : self.searchTable.frame.maxY + 30,width : 135.0,height : 35.0)
            return cell
                
            }
        
           else
            {
                
                for i in 0..<followArray.count
                    
                {
                    
                    if filteredArray.count > 0
                        
                    {
                        
                        if (followArray[i] as! AnyObject).value(forKey: "first_name") as! String == filteredArray[indexPath.section]
                            
                        {
                            
                            followersList.add(followArray[i] as! AnyObject)
                            print(followersList)
                            
                        }
                        
                    }
                        
                    else
                        
                    {
                        
                        print("anu")
                        
                    }
                    
                }
                
                
                cell.profImage.sd_setImage(with: URL(string: (followersList[indexPath.section] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
                
                cell.selctBtn.isHidden = false
                
                cell.selctBtn.tag = indexPath.section
                cell.selctBtn.addTarget(self, action: #selector(selectAction), for: .touchUpInside)
                cell.userName.text = (followersList[indexPath.section] as AnyObject).value(forKey: "first_name") as! String
                addbtn.frame = CGRect(x : 140.0, y : self.searchTable.frame.maxY + 30,width : 135.0,height : 35.0)
                return cell
                
              
            }
        
        
        }
        
        
        
    }


     @objc func selectAct1(sender : UIButton!)
     {
        
        
        let cell = newTable.cellForRow(at: IndexPath(row :sender.tag ,section : 1)) as! FollowSelectTableViewCell
        
        
        if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
            grpArray.add((groupArray[sender.tag] as AnyObject).value(forKey: "group_id") as! String)
            print(grpArray)
//            friendNames.add("\(String(describing: (followArray[sender.tag ] as AnyObject).value(forKey: "group_name")!))  \((followArray[sender.tag] as AnyObject).value(forKey: "last_name")!)")
            
        }
        else
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
            var cnt : Int = 0
            cnt = grpArray.count
            for i in 0..<cnt
            {
                
                if i == cnt
                {
                    
                    print("Nothing")
                    
                }
                else if grpArray[i] as! String == (groupArray[sender.tag] as AnyObject).value(forKey: "group_id") as! String
                {
                    
                    grpArray.removeObject(at: i)
                    cnt = cnt - 1
                }
            }
            
            print(grpArray)
        }

    }
    
    @IBAction func backAct(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @objc func selectAct(sender : UIButton!)
    {
        
        let cell = newTable.cellForRow(at: IndexPath(row :sender.tag ,section : 0)) as! FollowSelectTableViewCell
        
        
                    if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
                    {
                        cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
                        friendArray.add((followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
                        
                        friendNames.add("\(String(describing: (followArray[sender.tag] as AnyObject).value(forKey: "first_name")!))  \((followArray[sender.tag] as AnyObject).value(forKey: "last_name")!)")
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
    
    @objc func selectAction(sender : UIButton!)
    {
        
        let cell = searchTable.cellForRow(at: IndexPath(row :0 ,section : sender.tag)) as! FollowSelectTableViewCell
        
        
        if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
            friendArray.add((followersList[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
            
//            friendNames.add("\(String(describing: (dict[sender.tag] as AnyObject).value(forKey: "first_name")!))  \((dict[sender.tag] as AnyObject).value(forKey: "last_name")!)")
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
                else if friendArray[i] as! String == (followersList[sender.tag] as AnyObject).value(forKey: "follower_id") as! String
                {
                    
                    friendArray.removeObject(at: i)
                    cnt = cnt - 1
                }
            }
            
            print(friendArray)
        }
        
        
        
        
    }
    
    @objc func selectAction1(sender : UIButton!)
    {
        
        let cell = searchTable.cellForRow(at: IndexPath(row :0 ,section : sender.tag)) as! FollowSelectTableViewCell
        
        
        if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
            grpArray.add((groupList[sender.tag] as AnyObject).value(forKey: "group_id") as! String)
            
            //            friendNames.add("\(String(describing: (dict[sender.tag] as AnyObject).value(forKey: "first_name")!))  \((dict[sender.tag] as AnyObject).value(forKey: "last_name")!)")
            print(grpArray)
            
        }
        else
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
            var cnt : Int = 0
            cnt = grpArray.count
            for i in 0..<cnt
            {
                
                if i == cnt
                {
                    
                    print("Nothing")
                    
                }
                else if grpArray[i] as! String == (groupList[sender.tag] as AnyObject).value(forKey: "group_id") as! String
                {
                    
                    grpArray.removeObject(at: i)
                    cnt = cnt - 1
                }
            }
            
            print(grpArray)
        }
        
        
        
        
    }
    
    
    
    
    @IBAction func addMyBucket(_ sender: UIButton) {
        
     
        
        
        let params: [String:Any] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"reviewid" :REviewID,"bucket_username":userName,"post_type":"1"]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_BUCKET_MYSELF)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseCode"] == 1
            {
                let alert = UIAlertController(title: "Message!", message: "Added to My Bucket List", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    
                    let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketList") as! BucketListController
                   
                    self.present(page, animated: false, completion: nil)
                    
                })
                self.present(alert, animated: true)
            }
            
            
            
        }
        
        
    }
    
   func addBucketGroup()
    {
        
        // let indexPath = IndexPath
     //   let cell = newTable.cellForRow(at: IndexPath(row : 0,section: 3)) as! UITableViewCell
     
        
        let params: [String:Any] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"reviewid" :REviewID,"timelineid":"","bucket_username":userName,"group": grpArray,"post_type":"3"]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_BUCKET_GROUP)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["ResponseCode"] == 1
            {
                let alert = UIAlertController(title: "Message!", message: "Added to Bucket List", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketList") as! BucketListController
                    
                    
                    self.present(page, animated: false, completion: nil)
                    
                })
                self.present(alert, animated: true)
            }
            
            
            
        }
        
    }
    
    
  func addBucketIndividual()
    {
        
         //let indexPath = IndexPath
          if friendArray.count != 0
          {
            friendArray.add(Utils.getPreferenceValue(ForKey: Constant.USER_ID))
          }
     //   let cell = newTable.cellForRow(at: IndexPath(row : 0,section: 1)) as! UITableViewCell

        let params: [String:Any] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"reviewid" :REviewID,"timelineid":"","bucket_username":userName,"friends": friendArray,"post_type":"2"]

        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_BUCKET_INDIVIDUAL)"

        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)

            if json["ResponseCode"] == 1
            {

                
                self.addBucketGroup()
            }
            
            
            
        }
        


        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        
        
        if tableView.tag == 0
        {
        if section == 0
        {
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
            // view.backgroundColor =
            let label1 : UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 5, width: self.view.bounds.size.width, height: 18))
            let label2 : UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 30, width: self.view.bounds.size.width, height: 18))
            label1.text = "Followers bucket list"
            label1.textColor = UIColor(red: 39.0/255.0, green: 125.0/255.0, blue: 115.0/255.0, alpha: 1)
            label1.font = UIFont.boldSystemFont(ofSize: 14.0)
            // label1.font = UIFont.sys
            label2.text = "You can add this item to your followers bucket list"
            label2.font = UIFont.systemFont(ofSize: 14.0)
            
            //  label2.textColor = UIColor(red: 39.0/255.0, green: 125.0/255.0, blue: 115.0/255.0, alpha: 1)
            let searchBtn : UIButton = UIButton.init(frame: CGRect.init(x: self.view.bounds.size.width - 50, y: 20, width: 25.0, height: 25.0))
         //  searchBtn.addTarget(self, action: #selector(searchAct), for: .touchUpInside)
            searchBtn.setImage(#imageLiteral(resourceName: "magnifying-glass"), for: .normal)
            view.addSubview(searchBtn)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapRecognizer.delegate = self
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            view.addGestureRecognizer(tapRecognizer)
            view.addSubview(label2)
            view.addSubview(label1)
            view.backgroundColor = UIColor.white
            tableView.addSubview(view)
            
            return view
        }
        else
        {
            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
            view.backgroundColor =  UIColor(red: 39.0/255.0, green: 125.0/255.0, blue: 115.0/255.0, alpha: 1)
            let label1 : UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 5, width: self.view.bounds.size.width, height: 18))
            let label2 : UILabel = UILabel.init(frame: CGRect.init(x: 10, y: 30, width: self.view.bounds.size.width, height: 18))
            label1.text = "Group's Bucket list"
            label1.font =  UIFont.boldSystemFont(ofSize: 14.0)
            label1.textColor = UIColor(red: 39.0/255.0, green: 125.0/255.0, blue: 115.0/255.0, alpha: 1)
            label2.text = "You can add this item to your group bucket list"
            label2.font = UIFont.systemFont(ofSize: 14.0)
            // label2.textColor = UIColor(red: 39.0/255.0, green: 125.0/255.0, blue: 115.0/255.0, alpha: 1)
            let searchBtn : UIButton = UIButton.init(frame: CGRect.init(x: self.view.bounds.size.width - 50, y: 20, width: 25.0, height: 25.0))
            searchBtn.setImage(#imageLiteral(resourceName: "magnifying-glass"), for: .normal)
            view.addSubview(searchBtn)
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap1))
            tapRecognizer.delegate = self
            tapRecognizer.numberOfTapsRequired = 1
            tapRecognizer.numberOfTouchesRequired = 1
            view.addGestureRecognizer(tapRecognizer)
            view.addSubview(label2)
            view.addSubview(label1)
            view.backgroundColor = UIColor.white
            
            // view.backgroundColor = UIColor.white
            return view
        }
        }
        else
        {
           let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
            view.backgroundColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1)
            return view
        }
        
        
        
    }
    
    
  
    @IBAction func addAct(_ sender: UIButton) {
        
        if a == 0
        {
         
            
            let params: [String:Any] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"reviewid" :REviewID,"timelineid":"","bucket_username":userName,"friends": friendArray,"post_type":"2"]
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_BUCKET_INDIVIDUAL)"
            
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    let alert = UIAlertController(title: "Message!", message: "Added to Individual Bucket List", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketList") as! BucketListController
                        
                        self.present(page, animated: false, completion: nil)
                        
                    })
                    self.present(alert, animated: true)
                }
                
                
                
            }
        }
        
        else
        {
          
            let params: [String:Any] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"reviewid" :REviewID,"timelineid":"","bucket_username":userName,"group": grpArray,"post_type":"3"]
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_BUCKET_GROUP)"
            
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json["ResponseCode"] == 1
                {
                    let alert = UIAlertController(title: "Message!", message: "Added to Group Bucket List", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketList") as! BucketListController
                        
                        self.present(page, animated: false, completion: nil)
                        
                    })
                    self.present(alert, animated: true)
                }
                
                
                
            }
            
        }
    }
    
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        
        
         a = 0
        searchTextField.placeholder = "Select Followers"
        searchTextField.becomeFirstResponder()
        searchView.isHidden = false
        searchTable.isHidden = true
       // selectFollowers()
        
        
    }
    
    @objc func handleTap1(gestureRecognizer: UIGestureRecognizer) {
        
        searchTextField.placeholder = "Select Groups"
        a = 1
        searchTextField.becomeFirstResponder()
        searchView.isHidden = false
        // selectFollowers()
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView.tag == 0
        {
//        if section == 1
//        {
//            return 0
//        }
//        else if section == 3
//        {
//            return 0
//        }
//        else
//        {
            return 70
//        }
        }
        
        else
        {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0
        {
        return 80.0
        }
        else
        {
            return 80.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
