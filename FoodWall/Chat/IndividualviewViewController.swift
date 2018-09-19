//
//  IndividualviewViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 01/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import MXParallaxHeader
import Alamofire
import SwiftyJSON
class IndividualviewViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
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
    var tablerowheight = 0
    
    var rowNumber : Int = 0
    var rowIndex : Int = 0
    var memarray = [String]()
       var data : [String]?
    var storiesArray : NSArray = []
    let topicView = UILabel()
    var preImage = UIImageView()
    var getbucketarray : NSArray = []
   //  var getbucketarray = [[String:AnyObject]]()
     var getgrouparray = [[String:AnyObject]]()
    weak var headerImageView: UIView?
    var btn: UIButton = UIButton()
     let lblName = UILabel()
    @IBOutlet weak var Mytable: UITableView!
    
      var testArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setParallaxHeader()
        
        getgroupuser()
        getbucketindividual()
        
        Mytable.isHidden = false
        Mytable.delegate = self
        Mytable.dataSource = self
        
        Mytable.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setParallaxHeader()
    {
        
        
        
        preImage.frame = CGRect(x : 0 ,y : 15 ,width : UIScreen.main.bounds.width ,height : 300)
       
        preImage.sd_setImage(with: URL(string: "\(self.userimage)"), placeholderImage: UIImage(named: "default"))
       // preImage.image = UIImage(named: "img1")
        preImage.contentMode = .scaleAspectFill
        
        //  topicView.isHidden = true
        
        
        headerImageView = preImage
        
        Mytable.parallaxHeader.view = preImage
        
        
        
        Mytable.parallaxHeader.height = 300
        // tableView.parallaxHeader.height = 400
        Mytable.parallaxHeader.minimumHeight = 55
        
        
        
        
        topicView.isHidden = false
        topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 55)
        //topicView.layer.backgroundColor = UIColor.red.cgColor
        //7  topicView.layer.backgroundColor = UIColor(red: 255/255, green: 222/255, blue: 141/255, alpha: 1.0).cgColor
        topicView.textAlignment = .center
        // topicView.text = "vishnuK.M"
        topicView.textColor = UIColor.black
        
        topicView.isUserInteractionEnabled = true
        Mytable.contentSize = CGSize(width : Mytable.frame.size.width,height:Mytable.frame.size.height)
        // topicView.addGestureRecognizer(tap1)
        
        
        let viewDemo = UIView()
        viewDemo.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
         viewDemo.layer.backgroundColor=UIColor.white.cgColor
        self.view.addSubview(viewDemo)
        
        
        
        
        
         var btn1: UIButton = UIButton()
        btn1.frame = CGRect(x: 05, y: 15, width: 30, height: 30)
        btn1.backgroundColor=UIColor.clear
        btn1.setImage(#imageLiteral(resourceName: "left-arrow"), for: UIControlState.normal)
        // btn.setTitle("button", for: UIControlState.normal)
        btn1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
     //   btn1.addTarget(self, action: "back", for: UIControlEvents.touchUpInside)
        btn1.clipsToBounds = true
        self.view.addSubview(btn1)

//         btn.frame = CGRect(x: 250, y: 100, width: 20, height: 20)
//                 btn.backgroundColor=UIColor.clear
//        btn.setImage(#imageLiteral(resourceName: "editgroup"), for: UIControlState.normal)
//               // btn.setTitle("button", for: UIControlState.normal)
//               btn.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
//       btn.clipsToBounds = true
//       self.view.addSubview(btn)
        
        lblName.frame = CGRect(x: 20, y: 100, width: 200, height: 22)
        lblName.text = username1
        lblName.textColor = UIColor.white
        lblName.font = UIFont.systemFont(ofSize: 26)
        lblName.clipsToBounds = true
        preImage.addSubview(lblName)
      
        
        
        
        
        
        
    }
    
    @objc func buttonAction() {
        
         self.dismiss(animated: true, completion: nil)
       
    }
//    @objc func buttonAction1() {
//        let page = self.storyboard?.instantiateViewController(withIdentifier: "editgroupview") as! EditgroupViewController
//        
//        //
//        //        page.username1 = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
//        //        page.username2 = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
//        //        page.userimage = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"
//        //        page.friendid = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "follower_id") as! String))"
//        
//        
//        
//        self.present(page, animated: false, completion: nil)
//        
//    }
    //scrollviewDidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        btn.frame = CGRect(x: 250, y: height - 30, width: 200, height: 22)
        lblName.frame = CGRect(x: 20, y: height - 30, width: 200, height: 22)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
            
        {
            return 300.0
        }
            
       
        else {
            return 90
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return 1
        case 1:
            
            if getgrouparray.count == 0
        
            {
                return 0
            }
            else
            
           
            {
            return getgrouparray.count
            
            }
            
            
        //
        default:
            return 0
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0
        {
          let cell = tableView.dequeueReusableCell(withIdentifier: "groupeditcell1", for: indexPath) as! GroupeditmainTableViewCell1
//
//             testArray.removeAll()
//            print(getbucketarray)
            
              cell.selectionStyle = .none
            if getbucketarray.count != 0
            {
             print("\(((self.getbucketarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "hotel_name")!)")
             print("\(((self.getbucketarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "photo_reference")!)")
             print("\(((self.getbucketarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "reviewid")!)")
             print("\(((self.getbucketarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "bucket_id")!)")


            //hotel_name
            //photo_reference
            //reviewid
            //bucket_id
              
            
           }
            cell.setData(data: ((getbucketarray as NSArray) as! [NSDictionary]))
          return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "createchatcell", for: indexPath) as! creategroupTableViewCell
            print(self.getgrouparray)
           print("\(((self.getgrouparray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "group_icon")!)")
           print( "\(((self.getgrouparray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "group_name")!)".decodeEmoji)
            cell.Firstnamebold.text! =   "\(((self.getgrouparray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "group_name")!)".decodeEmoji
          
            cell.followerimage.sd_setImage(with: URL(string: "\(((self.getgrouparray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "group_icon")!)"), placeholderImage: UIImage(named: "default"))
            
            return cell
        }
        
        
        
    }
    
    // getgroupuser()
    //getbucketindividual()
    
    func getgroupuser()
    {
        
        let params: [String:String] = ["userid" : "\(friendid)"]
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GETGROUPUSER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.getgrouparray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.getgrouparray.count != 0)
                {
//                      self.rowNumber = self.getgrouparray.count
//                    print(self.getgrouparray)
//                    let indexPath = IndexPath(item: self.rowNumber - 1 , section: 1)
//                    self.Mytable.reloadRows(at: [indexPath], with: .none)
                    self.Mytable.reloadData()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                  
                    print("No data")
                }
            }
        }
        
        
        
        
        
        
        
    }
    
    func getbucketindividual()
    {
        
        let params: [String:String] = ["userid" : "\(friendid)"]
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GETBUCKETINDIVIDUAL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
          
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    if  (dict["ResponseMessage"] as! String)  == "success"
                    {
                        self.getbucketarray = (innerDict as! NSArray)
                        //self.rowNumber = self.getbucketarray.count
                        if self.getbucketarray != nil{
                            
//                            print(self.getbucketarray)
//                            let indexPath = IndexPath(item: 0, section: 0)
//                            self.Mytable.reloadRows(at: [indexPath], with: .none)
                            self.Mytable.reloadData()
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
        
    
    
    
}
