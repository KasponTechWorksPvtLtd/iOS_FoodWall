//
//  BucketListController.swift
//  FoodWall
//
//  Created by apple on 8/2/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class BucketListController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var headingTab3: UILabel!
    @IBOutlet weak var headingTab1: UILabel!
    @IBOutlet weak var headingTab2: UILabel!
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var imageBucketTable: UITableView!

    @IBOutlet weak var bucketTable: UITableView!
    @IBOutlet weak var myListLabel: UILabel!
    @IBOutlet weak var individualListLabel: UILabel!
    @IBOutlet weak var grpListLabel: UILabel!
    var dishType : String = ""
    var hotelNAME : String = ""
  //  var userId : String = ""
    var  dataArray1 = [[String:AnyObject]]()
    var totalposts : String = ""
    var totalFollowers : String = ""
    var action1 : String = ""
    var rowNumber : Int = 0
    var a : String = ""
    var reviewId : String = ""
    var imageArray : NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bucketTable.tag = 0
        imageBucketTable.tag = 1
        
        grpListLabel.isHidden = true
        individualListLabel.isHidden = true
        myListLabel.isHidden = false
        bucketTable.delegate = self
        bucketTable.dataSource = self
       // indicator1.isHidden = true
        imageBucketTable.delegate = self
        imageBucketTable.dataSource = self
        
        if a == "0"
        {
        getMyBucketList()
        headingTab1.text = "My Bucket List"
        headingTab2.text = "Individual Bucket List"
        headingTab3.text = "Group Bucket List"
        bucketTable.isHidden = false
        imageBucketTable.isHidden = true
            bucketTable.estimatedRowHeight = 100.0
            bucketTable.rowHeight = UITableViewAutomaticDimension
        }
        else
        {
            headingTab1.text = "Top Dishes"
            headingTab2.text = "Dishes to Avoid"
            headingTab3.text = "Ambiance"
            dishType = "1"
            imageBucketTable.estimatedRowHeight = 100.0
            imageBucketTable.rowHeight = UITableViewAutomaticDimension
            getDishesAll()
        imageBucketTable.isHidden = false
        bucketTable.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backAct(_ sender: UIButton) {
        
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func getDishesAll()
    {
     
        Utils.svprogressHudShow(title: "Loading...", view: self)
       
//        indicator1.isHidden = false
//        indicator1.hidesWhenStopped = true
//        indicator1.startAnimating()
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"dish_type":dishType,"reviewid": reviewId]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_DISHES_IMAGES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count != 0){
                    
                    if self.action1 == "1"
                    {
                     
                        Utils.svprogressHudDismiss(view: self)
                      //  self.indicator1.stopAnimating()
                        print(self.dataArray1)
                        self.topicLabel.text = self.hotelNAME
                        let indexPath = IndexPath(item: self.rowNumber, section: 0)
                        self.imageBucketTable.reloadRows(at: [indexPath], with: .none)
                    }
                    else
                    {
                        self.topicLabel.text = self.hotelNAME
                        self.imageArray = ((self.dataArray1[0] as AnyObject).value(forKey: "image") as! NSArray)
//                        self.indicator1.stopAnimating()
//
                        Utils.svprogressHudDismiss(view: self)
                        self.imageBucketTable.reloadData()
                    }
                    
                }
                    
                else
                    
                {
                    self.topicLabel.text = self.hotelNAME
                  
                    Utils.svprogressHudDismiss(view: self)
                    //self.indicator1.stopAnimating()
                    self.showToast(message: "Server Error")
                    
                    
                }
            }
            else
            {
                self.topicLabel.text = self.hotelNAME
                
                Utils.svprogressHudDismiss(view: self)
//                self.indicator1.stopAnimating()
                self.showToast(message: "Data not Found")
            }
            
        }
        
    }
    
    func  getMyBucketList()
    {
        Utils.svprogressHudShow(title: "Loading...", view: self)
       // utils.svprogressHudDismiss(view: self)
//        indicator1.isHidden = false
//        indicator1.hidesWhenStopped = true
//        indicator1.startAnimating()
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) ]
       
        let urlString = "\(Constant.BASEURL)\(Constant.GET_MY_BUCKET_LIST)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count != 0){
                    
                    if self.action1 == "1"
                    {
                     
                        Utils.svprogressHudDismiss(view: self)
                         // self.indicator1.stopAnimating()
                        print(self.dataArray1)
                        let indexPath = IndexPath(item: self.rowNumber, section: 0)
                        self.bucketTable.reloadRows(at: [indexPath], with: .none)
                    }
                    else
                    {
                      
                        Utils.svprogressHudDismiss(view: self)
                       // self.indicator1.stopAnimating()
                        self.bucketTable.reloadData()
                    }
                    
                }
                    
                else
                    
                {
                   
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator1.stopAnimating()
                    self.showToast(message: "Server Error")
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources talsehat can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
        //        view.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 0.1)
        //        view.layer.shadowOpacity = 0.1
        
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 0.1)
        
        // view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if dataArray1.count == 0
        {
            return 0
            imageBucketTable.isHidden = true
        }
        else
        {
        imageBucketTable.isHidden = false
        return dataArray1.count
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bucketListCell
        
        
         cell.profImage.sd_setImage(with: URL(string: "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "picture")!)"), placeholderImage: UIImage(named: "default"))
        
        cell.wholeView.addDropShadowToView(targetView: cell.wholeView)
//        cell.bucketListbtn.tag = indexPath.section + 1000
//        cell.bucketListbtn.addTarget(self, action: #selector(bucketAct), for: .touchUpInside)
        cell.hotelName.text = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "hotel_name")!)"
        
        let createdTime = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "created_on")!)"
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatterr.date(from: createdTime)!
        cell.timaAgoLabel.text! =  myDate.timeAgoDisplay()
        
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_ambiance") as? String)! == "1"
        {
            cell.rating1.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_ambiance") as? String)! == "2"
        {
            cell.rating1.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_ambiance") as? String)! == "3"
        {
            cell.rating1.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_ambiance") as? String)! == "4"
        {
            cell.rating1.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating1.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
        }
        
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "category_type") as? String)! == "1"
        {
            cell.servicePackageLabel.text = "Service"
        }
        else{
            cell.servicePackageLabel.text = "Package"
        }
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_value_money") as? String)! == "1"
        {
            cell.rating2.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_value_money") as? String)! == "2"
        {
            cell.rating2.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_value_money") as? String)! == "3"
        {
            cell.rating2.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_value_money") as? String)! == "4"
        {
            cell.rating2.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating2.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
        
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_taste") as? String)! == "1"
        {
            cell.rating3.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_taste") as? String)! == "2"
        {
            cell.rating3.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_taste") as? String)! == "3"
        {
            cell.rating3.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_taste") as? String)! == "4"
        {
            cell.rating3.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating3.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_service") as? String)! == "1"
        {
            cell.rating4.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_service") as? String)! == "2"
        {
            cell.rating4.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_service") as? String)! == "3"
        {
            cell.rating4.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_service") as? String)! == "4"
        {
            cell.rating4.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating4.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
        
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_food_exprience") as? String)! == "1"
        {
            cell.mainRating.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_food_exprience") as? String)! == "2"
        {
            cell.mainRating.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_food_exprience") as? String)! == "3"
        {
            cell.mainRating.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_food_exprience") as? String)! == "4"
        {
            cell.mainRating.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.mainRating.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
        if "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review") as! String)" == "1"
        {
            totalposts = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review") as! String) Review"
        }
        else if "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review") as! String)" == "0"
        {
            totalposts = ""
        }
        else
        {
            totalposts = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review") as! String) Reviews"
        }
        
        if (dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review_users") as? String == "1"
        {
            totalFollowers = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review_users") as! String) Follower"
        }
        else if (dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review_users") as? String == "0"
        {
            totalFollowers = ""
        }
        else
        {
            totalFollowers = ((dataArray1[indexPath.section] as AnyObject).value(forKey: "total_review_users") as? String)! + "Followers"
        }
        
        cell.reviewFollowerslabel.text = "\(totalposts)" + (" ") + (",") + (" ")
            + "\(totalFollowers)"
        
        cell.profName.text = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "first_name")!)" + "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "last_name")!)"
        
        cell.reviewTextLabel.text = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "hotel_review")!)"
        return cell
        }
        else
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! imageDisplayCell
       cell.image1.sd_setImage(with: URL(string: (imageArray[indexPath.section] as! AnyObject).value(forKey: "img") as! String), placeholderImage: UIImage(named: "default"))
            
            cell.headingLabel.text = "\((dataArray1[indexPath.section] as AnyObject).value(forKey: "dish_name")!)"
            return cell
            
        }
    }
    
    
   
    @IBAction func groupBucketAct(_ sender: UIButton) {
        
        grpListLabel.isHidden = false
        individualListLabel.isHidden = true
        myListLabel.isHidden = true
       
        if a == "0"
        {
            getGroupBucketList()
        }
        else
        {
            dishType = "3"
            getDishesAll()
           
        }
        
    }
    
    @IBAction func individualBucketAct(_ sender: UIButton) {
        
        grpListLabel.isHidden = true
        individualListLabel.isHidden = false
        myListLabel.isHidden = true
       
        if a == "0"
        {
             getIndividaulBucketList()
        }
        else
        {
            dishType = "2"
            getDishesAll()
           
        }
        
        
    }
    
    
    func  getGroupBucketList()
    {
        Utils.svprogressHudShow(title: "Loading...", view: self)
       
//        indicator1.isHidden = false
//        indicator1.hidesWhenStopped = true
//        indicator1.startAnimating()
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_MY_BUCKET_LIST)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count != 0){
                    
                    if self.action1 == "1"
                    {
                    
                        Utils.svprogressHudDismiss(view: self)
                        //self.indicator1.stopAnimating()
                        print(self.dataArray1)
                        let indexPath = IndexPath(item: self.rowNumber, section: 0)
                        self.bucketTable.reloadRows(at: [indexPath], with: .none)
                    }
                    else
                    {
                       
                        Utils.svprogressHudDismiss(view: self)
                        // self.indicator1.stopAnimating()
                        self.bucketTable.reloadData()
                    }
                    
                }
                    
                else
                    
                {
                    
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator1.stopAnimating()
                    self.showToast(message: "Server Error")
                    
                    
                }
            }
            
            
        }
        
        
        
        
    }
    
    
    func  getIndividaulBucketList(){
        Utils.svprogressHudShow(title: "Loading...", view: self)
        
//        indicator1.isHidden = false
//        indicator1.hidesWhenStopped = true
//        indicator1.startAnimating()
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_MY_BUCKET_LIST)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count != 0){
                    
                    if self.action1 == "1"
                    {
                      
                        Utils.svprogressHudDismiss(view: self)
//                        self.indicator1.stopAnimating()
                        print(self.dataArray1)
                        let indexPath = IndexPath(item: self.rowNumber, section: 0)
                        self.bucketTable.reloadRows(at: [indexPath], with: .none)
                    }
                    else
                    {
                       
                        Utils.svprogressHudDismiss(view: self)
//                        self.indicator1.stopAnimating()
                        self.bucketTable.reloadData()
                    }
                    
                }
                    
                else
                    
                    
                {
                   
                    Utils.svprogressHudDismiss(view: self)
//                    self.indicator1.stopAnimating()
                    self.showToast(message: "Server Error")
                    
                    
                }
            }
            
            
        }
    }
    
    
    
    
    @IBAction func myBucketAct(_ sender: UIButton) {
        
        grpListLabel.isHidden = true
        individualListLabel.isHidden = true
        myListLabel.isHidden = false
        if a == "0"
        {
        getMyBucketList()
        }
        else
        {
            dishType = "1"
            getDishesAll()
            
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
