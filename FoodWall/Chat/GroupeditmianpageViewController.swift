//
//  GroupeditmianpageViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 31/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import MXParallaxHeader
import SwiftyJSON
import Alamofire

class GroupeditmianpageViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
   
    var username1 : String = ""
    var username2 : String = ""
    var userimage : String = ""
    var memarray = [String]()
    var friendid : String = ""
    var groupname : String = ""
    var groupicon : String = ""
    var groupid : String = ""
     var sessionid : String = ""
    var lastseen : String = ""
    var activestatus : String = ""
    var createdon : String = ""
    var group_created_lastname : String = ""
    var tablerowheight = 0
    var friendnamesarray = [String]()
    var getmemarray = [[String:AnyObject]]()
    var storiesArray : NSArray = []
      let topicView = UILabel()
     let preImage = UIImageView()
    weak var headerImageView: UIView?
    var btn: UIButton = UIButton()
    let lblName = UILabel()
       var data : [String]?
    @IBOutlet weak var Mytable: UITableView!
     var getbucketarray : NSArray = []
   
    @IBOutlet weak var collectbucketview: UIView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setParallaxHeader()
        
         Mytable.isHidden = false
        Mytable.delegate = self
        Mytable.dataSource = self
        print(groupid)
        
        getgroupfriends()
        getbucketgroupall()
       
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
         preImage.sd_setImage(with: URL(string: "\(self.groupicon)"), placeholderImage: UIImage(named: "default"))
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
        headerImageView?.addSubview(topicView)
        
        
        let viewDemo = UIView()
        viewDemo.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
         viewDemo.layer.backgroundColor=UIColor.white.cgColor
        self.view?.addSubview(viewDemo)
        
        
        
        
        var btn1: UIButton = UIButton()
        btn1.frame = CGRect(x: 05, y: 15, width: 30, height: 30)
        btn1.backgroundColor=UIColor.clear
        btn1.setImage(#imageLiteral(resourceName: "left-arrow"), for: UIControlState.normal)
        // btn.setTitle("button", for: UIControlState.normal)
        btn1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //   btn1.addTarget(self, action: "back", for: UIControlEvents.touchUpInside)
        btn1.clipsToBounds = true
        self.view.addSubview(btn1)
        
        btn.frame = CGRect(x: 250, y: 100, width: 10, height: 10)
        btn.backgroundColor=UIColor.clear
        btn.setImage(#imageLiteral(resourceName: "pencil-edit-button"), for: UIControlState.normal)
        // btn.setTitle("button", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(buttonAction1), for: .touchUpInside)
        btn.clipsToBounds = true
        self.view.addSubview(btn)
        
        lblName.frame = CGRect(x: 20, y: 100, width: 200, height: 22)
        lblName.text = groupname
        lblName.textColor = UIColor.white
        lblName.font = UIFont.systemFont(ofSize: 26)
        lblName.clipsToBounds = true
        preImage.addSubview(lblName)
        
        
     
        
        
        
        
    }
    
    @IBAction func addmember(_ sender: Any) {
        
        
        
         if friendnamesarray.contains(Utils.getPreferenceValue(ForKey: Constant.USER_ID))
         {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "chatcreate") as! ChatcreationViewController
           let controller = "groupeditmainpageviewcontroller"
        

        page.controller = controller
       page.groupid = self.groupid
      
        
        self.present(page, animated: false, completion: nil)
        }
         else {
            let alert = UIAlertController(title: "FoodWall", message: "You are not a member to add friends", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func buttonAction() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func buttonAction1() {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "editgroupview") as! EditgroupViewController
        
       
                page.groupname = self.groupname
                page.groupicon = self.groupicon
                page.groupid = self.groupid
                page.sessionid = self.sessionid
        
        
        
        self.present(page, animated: false, completion: nil)
        
    }
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
        
       else  if indexPath.section == 1
        {
            return 90.0
        }
        else {
        return 50
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            return 1
        case 1:
            
            if getmemarray.count == 0
                
            {
                return 0
                
            }
            else
                
                
            {
                return getmemarray.count
                
            }
        case 2:
            if friendnamesarray.contains(Utils.getPreferenceValue(ForKey: Constant.USER_ID))
            {
            return 1
            }
            else {
                return 0
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
        cell.namelabel.text! = group_created_lastname
            
            cell.selectionStyle = .none
            //createdon
            
                        let createdTime = createdon
            if createdTime != "" && createdTime != "0"
            {
                        let dateFormatterr = DateFormatter()
                        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let myDate = dateFormatterr.date(from: createdTime)!
                        cell.hourslabel.text! = myDate.timeAgoDisplay()
            }
            else {
                 cell.hourslabel.text! = ""
            }
           // cell.hourslabel.text! = lastseen
           
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
        return cell
        }
           else if indexPath.section == 1
           {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createchatcell", for: indexPath) as! creategroupTableViewCell
            
              cell.selectionStyle = .none
            print(self.getmemarray)
            print("\(((self.getmemarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "first_name")!)")
            print( "\(((self.getmemarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "first_name")!)")
            //last_name
            cell.Firstnamebold.text! =  "\(((self.getmemarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.getmemarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
            cell.firstnamesmall.text! = "\(((self.getmemarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.getmemarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
            cell.followerimage.sd_setImage(with: URL(string: "\(((self.getmemarray as AnyObject)[indexPath.row] as AnyObject).value(forKey: "picture")!)"), placeholderImage: UIImage(named: "default"))
          
            
        
        return cell
        }
           else{
            //exit
             let cell = tableView.dequeueReusableCell(withIdentifier: "editcell", for: indexPath) as! EditbuttonTableViewCell
            cell.exitbutton.applyGradient()
            
            cell.selectionStyle = .none
           cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGFloat.greatestFiniteMagnitude)
                        cell.exitbutton.tag = indexPath.row
            cell.exitbutton.addTarget(self, action: #selector(ChatcreationViewController.btnAction(_:)), for: .touchUpInside)
            return cell
        }
        
        
    }
    
    @objc func btnAction(_ sender: AnyObject) {
        let cell = Mytable.cellForRow(at: IndexPath(row :sender.tag,section :2)) as! EditbuttonTableViewCell
        
        var uiAlert = UIAlertController(title: "FoodWall", message: "Do you want to exit from this group", preferredStyle: UIAlertControllerStyle.alert)
        self.present(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("Clicked Yes")
            
            
           
            
            let params: [String:String] = ["groupid" : "\(self.groupid)","exist_user_id": Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            // let params: [String:String] = ["userid" : "4"]
            let urlString = "\(Constant.BASEURL)\(Constant.UPDATEGETEXITUSER)"
            
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if let resData = json["ResponseMessage"].string {
                    
                    
                    //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                    
                    
                    
                    //let responsemessage = ((json ["ResponseMessage"].string)!)
                    if resData == "success"
                    {
                        
                        print("Exited Successfully")
                        
                        self.showToast(message: "No longer in this group")
                        cell.exitbutton.isHidden = true
                        self.Mytable.reloadData()
                        let page = self.storyboard?.instantiateViewController(withIdentifier: "mainchat") as! MainChatViewController
                        
                        
                        self.present(page, animated: false, completion: nil)
                        
                        
                        
                        
                        
                    }
                    else{
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
            
            
            
        }))
        
        uiAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            print("Clicked No")
            
            
            
            
            
            
            
            
            
            
        }))
      
        
        
        
        
        
        
        
        
                
            }
            
            
    
    
//    getgroupfriends()
//    getbucketgroupall()
    
    func getgroupfriends()
    {
        let params: [String:String] = ["groupid" : "\(groupid)","userid": Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GETGROUPFRIENDS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.getmemarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.getmemarray.count != 0)
                {
                    
                   
                    
                    for var i in 0..<self.getmemarray.count
                                {
                                    let membername = ((self.getmemarray[i] as AnyObject).value(forKey: "friendid") as! String)
                                    
                                    self.friendnamesarray.append("\(membername)")
                                }
                    
                    print(self.friendnamesarray)
                    
                    
                    
                    
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
    func getbucketgroupall() {
        //get_bucket_group_all
        let params: [String:String] = ["groupid" : "\(groupid)","userid": Utils.getPreferenceValue(ForKey: Constant.USER_ID) ]
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GETBUCKETGROUP)"
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension GroupeditmainTableViewCell1:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if data!.count == 0
       {
         return 0
        }
       else {
        return (data!.count)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupcollectioncell", for: indexPath) as! GroupeditCollectionViewCell
       

        if data?.count != 0
        {
            print("\(self.data![indexPath.row].value(forKey: "hotel_name")))")
            
        cell.bucketlabel.text! = ("\(((self.data as AnyObject)[indexPath.row] as AnyObject).value(forKey: "hotel_name")!)")
            
            print("\(((self.data as AnyObject)[indexPath.row] as AnyObject).value(forKey: "hotel_name")!)")
           
            cell.bucketlabel.text! = "\(((self.data as AnyObject)[indexPath.row] as AnyObject).value(forKey: "hotel_name")!)"
            
                print("\(((self.data as AnyObject)[indexPath.row] as AnyObject).value(forKey: "photo_reference")!)")
            
            searchPhotoFromGoogle(photo_Ref: ((self.data as AnyObject)[indexPath.row] as AnyObject).value(forKey: "photo_reference")! as! String ,imageView : cell.bucketimage)
            
           
        }
       
     
        return cell
    }
    
    
    func searchPhotoFromGoogle(photo_Ref:String,imageView : UIImageView) {
        // AIzaSyBntvQCBdlpx4Jcppk2yXsN_19M7R4km28
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=\(photo_Ref)&key=AIzaSyDTV3YxP-zWn4ss-UD4dTXB4dbzwiNxJqk"
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: strGoogleApi)!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { // Make sure you're on the main thread here
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
//        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupcollectioncell", for: indexPath) as! GroupeditCollectionViewCell
//            return cell.bucketimage
//        }
//
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //    self.pageCtrl.currentPage = indexPath.row
        // self.pageCtrl.transform.cu = CGAffineTransform(scaleX: 2, y: 2)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       let thisWidth = CGFloat(self.frame.width)
//        return CGSize(width: thisWidth, height: self.frame.height)
//    }
    
    
    func initCollection()
    {
        self.mycollection.dataSource = self
        self.mycollection.delegate = self
        // self.collectionView2.register(UINib(nibName:"timelineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "parts")
    }
    
    
    func setData(data: [NSDictionary])
    {
        self.data = data
        self.initCollection()
        self.mycollection.reloadData()
    }
    
    //chat
    
    
    
    
}
