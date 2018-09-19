////
//  ViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreLocation
import SVProgressHUD



class ViewController: UIViewController,UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{
    
    var locationManager = CLLocationManager()
    var window: UIWindow?
    
    
    var currentLongitude = 0.0
    var currentLatitude = 0.0
    var imgStr : String = ""
    var withWhom : String = ""
    
    //var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    var pic : UIImage = UIImage(named : "img1")!
    var imageArray = [URL]()
    var friendArray : NSMutableArray = []
    var sendImgArray : NSMutableArray = []
   // @IBOutlet weak var indicator: InstagramActivityIndicator!
    var imagePost1 :UIImage = UIImage(named : "img1")!
    var dataArray : NSArray = []
    // let image1 :UIImage = []
    let imageUrl = "\(Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL))"
    var ImageArray = [String]()
    var dateArray = [String]()
    var profImageArray = [String]()
    var ImageFilter: NSMutableArray = []
    var ImageFilter1: NSMutableArray = []
    var testArray = [String]()
    var nameArray = [String]()
    @IBOutlet var scrollBgView: UIScrollView!
    var created_by : String = ""
    var like : Int = 0
    let imagView = UIImageView()
    //    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var FoodWallLabel: UILabel!
    @IBOutlet var bottomBar: UITabBar!
    @IBOutlet var headerView: UIView!
    var a :Int = 1
    var k :Int = 0
    var myIndex : Int = 0
    var dataArray1 = [[String:AnyObject]]()
    var commentsNew : String = ""
    var action1 : String = ""
    var rowNumber : Int = 0
    var rowIndex : Int = 0
    var commentsText : String = ""
    var storiesArray : NSArray = []
    
    let imagePicker = UIImagePickerController()
    //var imgStr : String = ""
    var imageFilePath:URL! = nil
    @IBOutlet var imageButton: UIButton!
    @IBOutlet var notifications: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet var previewImage: UIImageView!
    @IBOutlet var menuButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!
    var totalposts : String = ""
    var totalFollowers : String = ""
    
    //  var s = String(repeating: " ", count: 3)
    
    
    var imgCount : Int = 0
    let cellSpacingHeight: CGFloat = 485
    
    
    
    
    @IBOutlet weak var searchbutton: UIButton!
    
    @IBOutlet weak var seachview: UIView!
    
    //  var s = String(repeating: " ", count: 3)
    var searchingdetailarray = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  ImageFilter1.removeAllObjects()
        
        tableView.delegate = self
        tableView.dataSource = self
        
      //  indicator.hidesWhenStopped = true
        imagePicker.delegate = self
        // headerView.addShadowViewhome()
        
        // statusView.isHidden = true
        //imageButton.clipsToBounds = true
        bottomBar.selectedItem = homeButton
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.title = "Home"
        timelineFunction()
        getStoriesAll()
        
        //   getCommentsAll()
        
        headerView.addDropShadowToView(targetView: headerView)
        
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        
        locationManager.delegate=self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
            
        {
            
            if let lat = self.locationManager.location?.coordinate.latitude {
                
                currentLatitude = lat
                
            }else {
                
            }
            
            if let long = self.locationManager.location?.coordinate.longitude {
                
                currentLongitude = long
                
            }else {
                
            }
            
        }
        
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied {
            
        }else{
            
            let alertController = UIAlertController(title: "FieldPro", message: "Location services are disabled in your App settings Please enable the Location Settings. Click Ok to go to Location Settings.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: {(alert :UIAlertAction!) in
                
                // UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString) as! URL)
                
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
                
                alertController.dismiss(animated: true, completion: nil)
                
            })
            
            // let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            
            // alertController.addAction(cancelAction)
            
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
        self.locationmethod()
        

        
        
    }
    
    func locationmethod () -> Void
        
    {
        
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            
            if let lat = self.locationManager.location?.coordinate.latitude {
                
                currentLatitude = lat
                Utils.setPreferenceValue(setValue: "\(currentLatitude)", ForKey: Constant.LATITUDE)
              
                
            }else {
                
            }
            
            if let long = self.locationManager.location?.coordinate.longitude {
                
                currentLongitude = long
                  Utils.setPreferenceValue(setValue: "\(currentLongitude)", ForKey: Constant.LONGITUDE)
            }else {
                
            }
            
        }
            
        else
            
        {
            
         
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                
                self.locationmethod()
                
            }
            
        }
        
        
        
        gettingcordinate()
        
        
        
    }
    
    func gettingcordinate()
    {
//        2. method name : get_afterlogin_user
//
//        Input Request Parameter:
//
//        userid :
//        latitude
//        longitude
        
       
        let params: [String:String] = ["userid" :Utils.getPreferenceValue(ForKey: Constant.USER_ID),"latitude" : Utils.getPreferenceValue(ForKey: Constant.LATITUDE),"longitude": Utils.getPreferenceValue(ForKey: Constant.LONGITUDE)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_AFTERLOGIN_USER)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    
                 self.showToast(message: "location shared")
                    
                }
                
            }
            else {
                self.showToast(message: "Error in location sharing")
            }
            
        }
        
        
        
    }

    
    
    @IBAction func Searchbar(_ sender: Any) {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "FirstsearchpageViewController") as! FirstsearchpageViewController
        
        
        // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        // page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //  page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        
        self.present(page, animated: false, completion: nil)
        
        
    }
    
    
    
    @IBAction func chat(_ sender: Any) {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "mainchat") as! MainChatViewController
        
        
        // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        // page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //  page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        
        self.present(page, animated: false, completion: nil)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func getStoriesAll()
    {
      //  indicator.hidesWhenStopped = true
       // indicator.startAnimating()
        
        
        Utils.svprogressHudShow(title: "Loading...", view: self)
        
        
        
        
        let params: [String:String] = ["deleted" : "0","userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)] //
        let urlString = "\(Constant.BASEURL)\(Constant.GET_STORIES_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.storiesArray = (innerDict as! NSArray)
                        
                        if self.storiesArray != nil{
                            Utils.svprogressHudDismiss(view: self)
                           // self.indicator.stopAnimating()
                            self.tableView.reloadData()
                            
                        }
                    }
                        
                    else
                    {
                          Utils.svprogressHudDismiss(view: self)
                        self.showToast(message: "No Stories yet")
                    }
                    
                    
                }
            }
            
            
        }
        
        
        
    }
    
    
    @IBAction func imageUpload(_ sender: UIButton) {
        
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "writepost") as! writePostController
        self.present(page, animated: false, completion: nil)
   
        
    }
    
    
    
    func newPage()
    {
        
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "post") as! PostTimelineController
        
        
        page.imagePost = imagePost1
        
        self.present(page, animated: false, completion: nil)
        //self.navigationController?.pushViewController(page, animated: true)
    }
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func colour(_ sender: AnyObject)
    {
        
        sender.layer.shadowOffset = CGSize.zero
        sender.layer.shadowRadius = 1
        sender.layer.shadowOpacity = 3.0
        
        //        sender.clipsToBounds = true
        sender.layer.cornerRadius = sender.frame.size.height/2
        sender.layer.borderWidth = 1
    }
    
    @objc func tapFunction()
    {
        
        let page:SignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        self.present(page, animated: false, completion: nil)
        
        
    }
    
    
    
    
    
    //    func textViewDidChange(_ textView: UITextView) {
    //
    //
    //
    //      //  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! homeTableViewCell
    //
    //        let fixedWidth = textView.frame.size.width
    //        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    //        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    //        var newFrame = textView.frame
    //        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    //        textView.frame = newFrame
    //
    //
    //    }
    
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        
        
        
        if bottomBar.selectedItem == reviewButton
        {
         
            
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            self.present(page, animated: false, completion: nil)
            
        }
        
        if bottomBar.selectedItem == notifications{
            //            self.performSegue(withIdentifier: "hiveTasks", sender: self)
            
            let page:NotificationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "notifications") as! NotificationsViewController
            self.present(page, animated: false, completion: nil)
        }
        
        if bottomBar.selectedItem == menuButton {
            
            
            let page:MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuview") as! MenuViewController
            self.present(page, animated: false, completion: nil)
        }
        
        if bottomBar.selectedItem == foodHelpButton{
            
            
            let page:FoodHelpController = self.storyboard?.instantiateViewController(withIdentifier: "foodhelp") as! FoodHelpController
            self.present(page, animated: false, completion: nil)
        }
        
    }
    
    
    func colour1(_ sender: AnyObject)
    {
        
        // sender.layer.shadowOffset = CGSize.zero
        sender.layer.shadowRadius = 1
        sender.layer.shadowOpacity = 2.0
        //        sender.layer.shadowColor = UIColor.gray as! CGColor
        
        //        sender.clipsToBounds = true
        //  sender.layer.cornerRadius = sender.frame.size.height/2
        //sender.layer.borderWidth = 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            
            return 1
        case 1:
            return 1
            
        case 2 :
            if dataArray != nil
            {
                return dataArray.count
            }
            else
            {
                return 0
            }
            
            
            
        //
        default:
            return 0
        }
        //      return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
        
    }
    
    
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 10
    //    }
    //
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //
    //
    //    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
    //        //        view.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 0.1)
    //        //        view.layer.shadowOpacity = 0.1
    //
    //        view.backgroundColor = UIColor(red: 225/255, green: 224/255, blue: 226/255, alpha: 0.1)
    //
    //        // view.backgroundColor = UIColor.white
    //        return view
    //    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
            
        {
            return 150.0
        }
        
        if indexPath.section == 1
        {
            return 80.0
        }
        
        if indexPath.section == 2
        {
            if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "0" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "6" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "7" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "5"
                
            {
                return cellSpacingHeight
            }
            else if  "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "3" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "2"
            {
                return 540.0
            }
            else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "8" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "9" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "10"
            {
                return 360.0
            }
                
            else
            {
                return 80.0
            }
            
            
            
            
            
        }
            
        else
        {
            return 0.0
        }
        
    }
    
    //    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
    //        let attributedString = NSMutableAttributedString(string: string,
    //                                                         attributes: [NSAttributedStringKey.font: font])
    //        let boldFontAttribute: [String: Any] = [NSAttributedStringKey.font.rawValue: UIFont.boldSystemFont(ofSize: font.pointSize)]
    //        let range = (string as NSString).range(of: boldString)
    //        attributedString.addAttributes(boldFontAttribute, range: range)
    //        return attributedString
    //    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
            
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as! storyTableViewCell
            
            cell.setData(data: (storiesArray as NSArray))
            
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "writeCell", for: indexPath) as! writeTableViewCell
            cell.selectionStyle = .none
            cell.writeBtn.tag = indexPath.row
            cell.writeBtn.addTarget(self, action: #selector(writeAction), for: .touchUpInside)
            cell.writeBtn.contentHorizontalAlignment = .left
            cell.profilePic.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.IMAGE_VALUE)), placeholderImage: UIImage(named: "default"))
            
            return cell
        }
        else
        {
            
            
            
            if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "0" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "6" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "7" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "5"
                
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! homeTableViewCell
                cell.selectionStyle = .none
                cell.profName.numberOfLines = 0
                cell.profName.lineBreakMode = NSLineBreakMode.byWordWrapping
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "6"
                {
                    
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String) liked your review on \((dataArray[indexPath.row] as AnyObject).value(forKey: "hotel") as! String)"
                    
                    
                    
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "review")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "7"
                {
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String) commented your review on \((dataArray[indexPath.row] as AnyObject).value(forKey: "hotel") as! String)"
                    
                    
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "review")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "5"
                {
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String) created new review on \((dataArray[indexPath.row] as AnyObject).value(forKey: "hotel") as! String)"
                    
                    
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "review")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                    
                else
                {
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String)"
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "timeline_description")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                
                
                //test.removeAllObjects()
                
                
                let dict = dataArray[indexPath.row] as! NSDictionary
                //   cell.selectionStyle = .none
                
                let createdTime = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate = dateFormatterr.date(from: createdTime)!
                cell.daysAgoLabel.text! =  myDate.timeAgoDisplay()
                
                
                
                
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" == "1"
                {
                    totalposts = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String) Post"
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" == "0"
                {
                    totalposts = ""
                }
                else
                {
                    totalposts = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String) Posts"
                }
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String)" == "1"
                {
                    totalFollowers = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String) Follower"
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String)" == "0"
                {
                    totalFollowers = ""
                }
                else
                {
                    totalFollowers = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String) Followers"
                }
                if "\(totalFollowers)" == ""
                {
                    cell.postFollowersLabel.text = "\(totalposts)"
                }
                else if "\(totalposts)" == ""
                {
                    cell.postFollowersLabel.text =  "\(totalFollowers)"
                }
                else
                {
                    cell.postFollowersLabel.text = "\(totalposts)" + (" ") + (",") + "\(totalFollowers)"
                    
                    
                }
                
                
                if "\(dict.value(forKey: "total_likes") as! String)" == "0"
                {
                    cell.totalLikes.isHidden = true
                }
                else if  "\(dict.value(forKey: "total_likes") as! String)" == "1"
                {
                    cell.totalLikes.isHidden = false
                    
                    cell.totalLikes.text! = "\(dict.value(forKey: "total_likes") as! String) like"
                    
                }
                else
                {
                    cell.totalLikes.isHidden = false
                    cell.totalLikes.text! = "\(dict.value(forKey: "total_likes") as! String) likes"
                    
                }
                
                
                
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "tl_likes")!)" == "0"
                {
                    
                    cell.likeButton.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    
                    
                }
                    
                    
                    
                    
                else
                {
                    
                    cell.likeButton.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
                    
                    
                    
                }
                
                
                
                
                
                if  "\(dict.value(forKey: "total_comments") as! String)" == "0"
                    
                {
                    
                    cell.viewallButton.isHidden = true
                    
                }
                    
                    
                else if  "\(dict.value(forKey: "total_comments") as! String)" == "1"
                    
                {
                    
                    cell.viewallButton.isHidden = false
                    //cell.view.text! = "\(dict.value(forKey: "total_likes") as! String) like"
                    cell.viewallButton.setTitle("\(dict.value(forKey: "total_comments") as! String) Comment", for: .normal)
                    cell.viewallButton.contentHorizontalAlignment = .left
                }
                    
                    
                else
                {
                    cell.viewallButton.isHidden = false
                    cell.viewallButton.setTitle("\(dict.value(forKey: "total_comments") as! String) Comments", for: .normal)
                    cell.viewallButton.contentHorizontalAlignment = .left
                }
                
                
                
                
                cell.commentTextView.delegate = self
                cell.commentTextView.text = "Add a comment"
                cell.commentTextView.textColor = UIColor.lightGray
                
                // cell.commentTextView.delegate = self
                
                cell.postCommentButton.tag = indexPath.row + 3000
                cell.postCommentButton.addTarget(self, action: #selector(postCommentBUTTON), for: .touchUpInside)
                cell.postCommentButton.applyGradient()
                
                cell.likeButton.tag = indexPath.row + 2000
                cell.likeButton.addTarget(self, action: #selector(likeBUTTON), for: .touchUpInside)
                
                cell.likesClick.tag = indexPath.row + 11000
                cell.likesClick.addTarget(self, action: #selector(ViewLikes), for: .touchUpInside)
                
                cell.commentButton.tag = indexPath.row + 1000
                cell.commentButton.addTarget(self, action: #selector(commentBUTTON), for: .touchUpInside)
                cell.viewallButton.tag = indexPath.row
                cell.viewallButton.addTarget(self, action: #selector(ViewAction), for: .touchUpInside)
                cell.optionsMenu.tag = indexPath.row
                cell.optionsMenu.addTarget(self, action: #selector(optionMenuAction), for: .touchUpInside)
                cell.profilePageBUtton.tag = indexPath.row + 4000
                cell.profilePageBUtton.addTarget(self, action: #selector(profilePageDisplay), for: .touchUpInside)
                
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_by") as! String)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
                {
                    cell.commentsNewText.isHidden = false
                    cell.optionsMenu.isHidden = false
                    // cell.commentsNewText.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "tl_comments") as! String)"
                    
                }
                    
                else
                {
                    cell.optionsMenu.isHidden = true
                    cell.commentsNewText.isHidden = true
                }
                
                
                cell.commentimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "default"))
                
                cell.profileImage.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                testArray.removeAll()
                
                if   "\(dict.value(forKey:"post_type") as! String)" == "1" || "\(dict.value(forKey:"post_type") as! String)" == "2" || "\(dict.value(forKey:"post_type") as! String)" == "6" || "\(dict.value(forKey:"post_type") as! String)" == "7"
                {
                    testArray.removeAll()
                    if ((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi_count") as! Int) != 0
                    {
                        
                        for i in 0..<((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi") as! NSArray).count
                        {
                            
                            testArray.append((((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi") as! NSArray)[i] as AnyObject).value(forKey : "picture") as! String)
                            print("testArray:\((((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi") as! NSArray)[i] as AnyObject).value(forKey : "picture") as! String)")
                            cell.setData(data: testArray)
                            
                            
                        }
                    }
                    else
                    {
                        testArray.removeAll()
                        cell.setData(data: testArray)
                        
                    }
                }
                else if "\(dict.value(forKey:"post_type") as! String)" == "5" || "\(dict.value(forKey:"post_type") as! String)" == "4" || "\(dict.value(forKey:"post_type") as! String)" == "0"
                {
                    testArray.removeAll()
                    if ((dataArray[indexPath.row] as! AnyObject).value(forKey : "image_count") as! Int) != 0
                    {
                        for i in 0..<((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray).count
                        {
                            
                            testArray.append((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)
                            print("testArray:\((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)")
                            cell.setData(data: testArray)
                            
                            
                        }
                    }
                        
                    else
                    {
                        testArray.removeAll()
                        cell.setData(data: testArray)
                    }
                    
                }
                else
                {
                    if ((dataArray[indexPath.row] as! AnyObject).value(forKey : "image_count") as! Int) != 0
                    {
                        
                        testArray.removeAll()
                        for i in 0..<((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray).count
                        {
                            
                            testArray.append((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)
                            print("testArray:\((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)")
                            cell.setData(data: testArray)
                            
                        }
                    }
                        
                        
                    else
                    {
                        testArray.removeAll()
                        cell.setData(data: testArray)
                    }
                    
                }
                return cell
            }
                
            else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "3" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "2"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "eventscell", for: indexPath) as! eventsTimelineCell
                //  cell.selectionStyle = .none
                cell.selectionStyle = .none
                cell.totalLikes.contentHorizontalAlignment = .left
                cell.totalcomments.contentHorizontalAlignment = .left
                let dict = dataArray[indexPath.row] as! NSDictionary
                let startDate = "\(dict.value(forKey:"start_date") as! String)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate = dateFormatterr.date(from: startDate)!
                let created_Date = "\(dict.value(forKey:"created_on") as! String)"
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate1 = dateFormatterr.date(from: created_Date)!
                // let  myDate2 = dateFormatterr.string(from: myDate1)
                dateFormatterr.dateFormat = "LLLL"
                let  month = dateFormatterr.string(from: myDate)
                dateFormatterr.dateFormat = "dd"
                let  day = dateFormatterr.string(from: myDate)
                
                cell.eventDate.text! = month + " " + day
                if "\(dict.value(forKey:"total_likes") as! String)" == "0"
                {
                    cell.totalLikes.isHidden = true
                    
                    
                }
                else if "\(dict.value(forKey:"total_likes") as! String)" == "1"
                {
                    cell.totalLikes.isHidden = false
                    cell.totalLikes.setTitle("\(dict.value(forKey:"total_likes") as! String) like", for: .normal)
                }
                else
                {
                    cell.totalLikes.isHidden = false
                    cell.totalLikes.setTitle("\(dict.value(forKey:"total_likes") as! String) likes", for: .normal)
                }
                if "\(dict.value(forKey:"total_comments") as! String)" == "0"
                {
                    cell.totalcomments.isHidden = true
                    
                }
                else if "\(dict.value(forKey:"total_comments") as! String)" == "1"
                {
                    cell.totalcomments.isHidden = false
                    cell.totalcomments.setTitle("\(dict.value(forKey:"total_comments") as! String) Comment", for: .normal)
                }
                else
                {
                    cell.totalcomments.isHidden = false
                    cell.totalcomments.setTitle("\(dict.value(forKey:"total_comments") as! String) Comments", for: .normal)
                }
                
                
                if "\(dict.value(forKey:"tl_likes") as! String)" == "0"
                {
                    
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    
                    
                }
                    
                    
                    
                    
                else
                {
                    
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
                    
                    
                    
                }
                
                cell.likeBtn.tag = indexPath.row + 2000
                cell.likeBtn.addTarget(self, action: #selector(likeEVENT), for: .touchUpInside)
                cell.commentBtn.tag = indexPath.row + 1000
                cell.commentBtn.addTarget(self, action: #selector(commentEvent), for: .touchUpInside)
                cell.postBtn.tag = indexPath.row + 3000
                cell.postBtn.addTarget(self, action: #selector(postCommentBUTTON1), for: .touchUpInside)
                cell.event_headingLabel.text = "\(dict.value(forKey:"event_name") as! String)"
                
                cell.eventLocation.text = "\(dict.value(forKey:"location") as! String)"
                
                if "\(dict.value(forKey:"post_type") as! String)" == "3"
                {
                    cell.userNAME.numberOfLines = 0
                    cell.userNAME.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.userNAME.text = "\(dict.value(forKey:"first_name") as! String) \(dict.value(forKey:"last_name") as! String) interested in this event  \(dict.value(forKey:"event_name") as! String)"
                }
                    
                else
                {
                    cell.userNAME.numberOfLines = 0
                    cell.userNAME.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.userNAME.text = "\(dict.value(forKey:"first_name") as! String) \(dict.value(forKey:"last_name") as! String) going to this event \(dict.value(forKey:"event_name") as! String)"
                    
                }
                cell.commentImage.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                
                cell.PROFPIC.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                
                cell.commentsTextView.delegate  = self
                cell.commentsTextView.text = "Add a comment"
                cell.commentsTextView.textColor = UIColor.lightGray
                cell.postBtn.applyGradient()
                cell.daysagoLabel.text! =  myDate1.timeAgoDisplay()
                return cell
                
                
                
            }
            else if  "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "8" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "9" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "10"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "qacell", for: indexPath) as! qaTimelineCell
                cell.selectionStyle = .none
                //   cell.selectionStyle = .none
                cell.totalLikes.contentHorizontalAlignment = .left
                cell.totalcomments.contentHorizontalAlignment = .left
                
                let dict = dataArray[indexPath.row] as! NSDictionary
                if "\(dict.value(forKey:"post_type") as! String)" == "8"
                {
                    cell.userNAME.numberOfLines = 0
                    cell.userNAME.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.userNAME.text = "\(dict.value(forKey:"first_name") as! String) \(dict.value(forKey:"last_name") as! String) asked the question  \(dict.value(forKey:"ask_question") as! String)"
                }
                    
                else if "\(dict.value(forKey:"post_type") as! String)" == "9"
                {
                    cell.userNAME.numberOfLines = 0
                    cell.userNAME.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.userNAME.text = "\(dict.value(forKey:"first_name") as! String) \(dict.value(forKey:"last_name") as! String) answered the question \(dict.value(forKey:"ask_question") as! String)"
                    
                }
                else
                {
                    cell.userNAME.numberOfLines = 0
                    cell.userNAME.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.userNAME.text = "\(dict.value(forKey:"first_name") as! String) \(dict.value(forKey:"last_name") as! String) upvoted the question \(dict.value(forKey:"ask_question") as! String)"
                }
                
                let created_Date = "\(dict.value(forKey:"created_on") as! String)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate1 = dateFormatterr.date(from: created_Date)!
                // let  myDate2 = dateFormatterr.string(from: myDate1)
                
                if "\(dict.value(forKey:"total_likes") as! String)" == "0"
                {
                    cell.totalLikes.isHidden = true
                    
                }
                else if "\(dict.value(forKey:"total_likes") as! String)" == "1"
                {
                    cell.totalLikes.isHidden = false
                    cell.totalLikes.setTitle("\(dict.value(forKey:"total_likes") as! String) like", for: .normal)
                }
                else
                {
                    cell.totalLikes.isHidden = false
                    cell.totalLikes.setTitle("\(dict.value(forKey:"total_likes") as! String) likes", for: .normal)
                    
                }
                if "\(dict.value(forKey:"total_comments") as! String)" == "0"
                {
                    cell.totalcomments.isHidden = true
                    
                }
                else if "\(dict.value(forKey:"total_comments") as! String)" == "1"
                {
                    cell.totalcomments.isHidden = false
                    cell.totalcomments.setTitle("\(dict.value(forKey:"total_comments") as! String) Comment", for: .normal)
                }
                else
                {
                    cell.totalcomments.isHidden = false
                    cell.totalcomments.setTitle("\(dict.value(forKey:"total_comments") as! String) Comments", for: .normal)
                    
                }
                
                
                if "\(dict.value(forKey:"tl_likes") as! String)" == "0"
                {
                    
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    
                    
                }
                    
                else
                {
                    
                    cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
                    
                }
                
                cell.likeBtn.tag = indexPath.row + 2000
                cell.likeBtn.addTarget(self, action: #selector(likeQuestion), for: .touchUpInside)
                cell.commentBtn.tag = indexPath.row + 1000
                cell.commentBtn.addTarget(self, action: #selector(commentQuestion), for: .touchUpInside)
                cell.postBtn.tag = indexPath.row + 3000
                cell.postBtn.addTarget(self, action: #selector(postCommentBUTTON2), for: .touchUpInside)
                cell.quesLabel.text = "\(dict.value(forKey:"ask_question") as! String)"
                cell.totalLikes.tag = indexPath.row + 9000
                //cell.totalLikes.addTarget(self, action: #selector(commentQuestion), for: .touchUpInside)
                cell.totalcomments.tag = indexPath.row + 8000
                cell.quesLabel.numberOfLines = 0
                cell.quesLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                //            if "\(dict.value(forKey:"ask_answer") as! String)" != "0"
                //            {
                //            cell.ansLabel.text =  "\(dict.value(forKey:"ask_answer") as! String)"
                //                cell.ansLabel.numberOfLines = 0
                //                cell.ansLabel.lineBreakMode = NSLineBreakMode.byWordWrapping//
                //            }
                //            else
                //            {
                //              cell.ansLabel.text =  "No answers yet"
                //            }
                cell.commentImage.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                
                cell.PROFPIC.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                
                cell.commentsTextView.delegate  = self
                cell.commentsTextView.text = "Add a comment"
                cell.commentsTextView.textColor = UIColor.lightGray
                cell.postBtn.applyGradient()
                cell.daysagoLabel.text! =  myDate1.timeAgoDisplay()
                return cell
            }
                
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "followingCell", for: indexPath) as! FollowTimelineTableViewCell
                //    cell.selectionStyle = .none
                cell.selectionStyle = .none
                let dict = dataArray[indexPath.row] as! NSDictionary
                let created_Date = "\(dict.value(forKey:"created_on") as! String)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate1 = dateFormatterr.date(from: created_Date)!
                cell.profilePic.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                cell.username.text = "\(dict.value(forKey:"first_name") as! String)  \(dict.value(forKey:"last_name") as! String)  Started following  \(dict.value(forKey:"followuser_firstname") as! String) \(dict.value(forKey:"followuser_lastname") as! String)"
                cell.daysAgoLabel.text! =  myDate1.timeAgoDisplay()
                return cell
                
            }
            
        }
        
        
        
    }
    
    //    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
    //        let attributedString = NSMutableAttributedString(string: string,
    //                                                         attributes: [NSFontAttributeName: font])
    //        let boldFontAttribute: [String: Any] = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: font.pointSize)]
    //        let range = (string as NSString).range(of: boldString)
    //        attributedString.addAttributes(boldFontAttribute, range: range)
    //        return attributedString
    //    }
    
    
    @objc func profilePageDisplay(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 4000, section: 2) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
        created_by =  "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "created_by") as! String)"
        Utils.setPreferenceValue(setValue: created_by, ForKey: Constant.CREATED_BY_USERID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "following_id") as! String)", ForKey: Constant.FOLLOWERID)
        
        let page:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! ProfileViewController
        self.present(page, animated: false, completion: nil)
        
        
        
    }
    
    @objc func ViewLikes(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 11000, section:2) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "2"
        self.present(page, animated: false, completion: nil)
        
        
    }
    
 
    
    @objc func optionMenuAction(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag , section:2) as IndexPath) as! homeTableViewCell
        
        
        
        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) != "\((dataArray[sender.tag] as AnyObject).value(forKey: "user_id") as! String)"
        {
            
            let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { _ in
                //self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Copy Link", style: .default, handler: { _ in
                // self.openGallary()
            }))
            
            alert.addAction(UIAlertAction(title: "Turn On Post Notifications", style: .default, handler: { _ in
                // self.openGallary()
            }))
            alert.addAction(UIAlertAction(title: "Share Via", style: .default, handler: { _ in
                // self.openGallary()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            /*If you want work actionsheet on ipad
             then you have to use popoverPresentationController to present the actionsheet,
             otherwise app will crash on iPad */
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else
        {
            
            let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                
                let page = self.storyboard?.instantiateViewController(withIdentifier: "writepost") as! writePostController
                page.act = "1"
                
                //                if ((self.dataArray[sender.tag] as AnyObject).value(forKey :"whom_count") as! Int) != 0
                //                {
                //                    for i in 0..<((self.dataArray[sender.tag] as AnyObject).value(forKey :"whom") as! NSArray).count
                //                    {
                //                        self.friendArray.add((((self.dataArray[sender.tag] as AnyObject).value(forKey :"whom") as! NSArray)[i] as! NSArray).value(forKey: "first_name") as! String)
                //                    }
                //                    page.friendArr = self.friendArray
                //                }
                //
                //                else
                //                {
                //                 // page.friendArr =  AnyObject).value(forKey :"whom") as! NSArray)
                //                }
                //
                //
                //                if ((self.dataArray[sender.tag] as AnyObject).value(forKey :"image_count") as! Int) != 0
                //                {
                //                    for i in 0..<((self.dataArray[sender.tag] as AnyObject).value(forKey :"image") as! NSArray).count
                //                    {
                //                        self.sendImgArray.add((((self.dataArray[sender.tag] as AnyObject).value(forKey :"image") as! NSArray)[i] as! NSArray).value(forKey: "img") as! String)
                //                    }
                //                    page.imageArray = self.sendImgArray as NSArray
                //                }
                //
                //                else
                //                {
                //                    // page.friendArr =  AnyObject).value(forKey :"whom") as! NSArray)
                //                }
                
                page.USErID = ((self.dataArray[sender.tag] as AnyObject).value(forKey :"user_id") as! String)
                page.timelineId = ((self.dataArray[sender.tag] as AnyObject).value(forKey :"timeline_id") as! String)
                
                self.present(page, animated: false, completion: nil)
                
                
                
                
                
                
                
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                
                
                let params: [String:String] = ["timelineid" : "\((self.dataArray[sender.tag] as AnyObject).value(forKey: "timeline_id")!)","created_by" : "\((self.dataArray[sender.tag] as AnyObject).value(forKey: "user_id")!)"]
                
                
                let urlString = "\(Constant.BASEURL)\(Constant.DELETE_POST)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json != nil
                    {
                        if json["ResponseCode"] == 1
                            
                        {
                            
                            self.timelineFunction()
                            
                        }
                        
                    }
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { _ in
                // self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Copy Link", style: .default, handler: { _ in
                // self.openGallary()
            }))
            
            alert.addAction(UIAlertAction(title: "Turn On Post Notifications", style: .default, handler: { _ in
                // self.openGallary()
            }))
            alert.addAction(UIAlertAction(title: "Share Via", style: .default, handler: { _ in
                // self.openGallary()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            /*If you want work actionsheet on ipad
             then you have to use popoverPresentationController to present the actionsheet,
             otherwise app will crash on iPad */
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender
                alert.popoverPresentationController?.sourceRect = sender.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            
            self.present(alert, animated: true, completion: nil)
            
            
            
            
        }
        
        
        // cell.commentTextField.becomeFirstResponder()
        
        
    }
    
    
    
    @objc func likeBUTTON(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:2) as IndexPath) as! homeTableViewCell
        
        
        rowIndex = sender.tag - 2000
        
        
        if cell.likeButton.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeButton.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.totalLikes.isHidden = false
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                cell.totalLikes.text! = "\(cont1) like"
            }
            else if cont1 == 0
            {
                cell.totalLikes.isHidden = true
                
            }
                
            else
            {
                cell.totalLikes.text! = "\(cont1) likes"
                
            }
            like = 1
        }
        else
        {
            
            cell.likeButton.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.totalLikes.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    cell.totalLikes.text! = "\(cont1) like"
                }
                    
                else if cont1 == 0
                {
                    cell.totalLikes.isHidden = true
                    
                }
                else
                {
                    cell.totalLikes.text! = "\(cont1) likes"
                }
            }
            
            like = 0
        }
        
        likeFuncCall()
        
        
        
    }
    
    @objc func likeEVENT(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:2) as IndexPath) as! eventsTimelineCell
        
        
        rowIndex = sender.tag - 2000
        
        
        if cell.likeBtn.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.totalLikes.isHidden = false
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                cell.totalLikes.setTitle("\(cont1) like", for: .normal)
            }
            else if cont1 == 0
            {
                cell.totalLikes.isHidden = true
                
            }
                
            else
            {
                cell.totalLikes.setTitle("\(cont1) likes", for: .normal)
                
            }
            like = 1
        }
        else
        {
            
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.totalLikes.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    cell.totalLikes.setTitle("\(cont1) like", for: .normal)
                }
                    
                else if cont1 == 0
                {
                    cell.totalLikes.isHidden = true
                    
                }
                else
                {
                    cell.totalLikes.setTitle("\(cont1) likes", for: .normal)
                }
            }
            
            like = 0
        }
        
        likeFuncCall()
        
        
        
    }
    @objc func likeQuestion(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:2) as IndexPath) as! qaTimelineCell
        
        
        rowIndex = sender.tag - 2000
        
        
        if cell.likeBtn.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.totalLikes.isHidden = false
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                cell.totalLikes.setTitle("\(cont1) like", for: .normal)
            }
            else if cont1 == 0
            {
                cell.totalLikes.isHidden = true
                
            }
                
            else
            {
                cell.totalLikes.setTitle("\(cont1) likes", for: .normal)
                
            }
            like = 1
        }
        else
        {
            
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.totalLikes.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    cell.totalLikes.setTitle("\(cont1) like", for: .normal)
                }
                    
                else if cont1 == 0
                {
                    cell.totalLikes.isHidden = true
                    
                }
                else
                {
                    cell.totalLikes.setTitle("\(cont1) likes", for: .normal)
                }
            }
            
            like = 0
        }
        
        likeFuncCall()
        
    }
    
    
    func likeFuncCall()
    {
        
        let params: [String:String] = ["timelineid" : (dataArray[rowIndex] as AnyObject).value(forKey: "timeline_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_TIMELINE_LIKES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    //                    let alert = UIAlertController(title: "", message: "Interest shown", preferredStyle: UIAlertControllerStyle.alert)
                    //                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    //                    self.present(alert, animated: true, completion: nil)
                    self.action1 = "1"
                    self.rowNumber = self.rowIndex
                    self.timelineFunction()
                    
                    print("success")
                    
                }
                    
                else
                    
                {
                    
                    print("error")
                }
            }
            else
                
            {
                
                print("error")
            }
            
            
        }
    }
    
    @IBAction func totalLikesQA(_ sender: UIButton) {
        
        
        
        
        //        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 8000, section:2) as IndexPath) as! qa
        
        
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag - 9000] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "7"
        page.commentAnsID = "\((dataArray[sender.tag - 9000] as AnyObject).value(forKey: "ans_id") as! String)"
        self.present(page, animated: false, completion: nil)
        
        
        
        
    }
    
    @IBAction func totalCommentsQA(_ sender: UIButton) {
        
        
        
        //        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 8000, section:2) as IndexPath) as! homeTableViewCell
        
        //        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        //
        //        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag - 8000] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "8"
        page.commentAnsID = "\((dataArray[sender.tag - 8000] as AnyObject).value(forKey: "ans_id") as! String)"
        self.present(page, animated: false, completion: nil)
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func postActQA(_ sender: UIButton) {
        
        
        
        
        
    }
    
    
    
    
    
    @objc func postCommentBUTTON(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section: 2) as IndexPath) as! homeTableViewCell
        rowIndex = sender.tag - 3000
        commentsText = cell.commentTextView.text!
        cell.postCommentButton.isHidden = true
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        postAct()
        
    }
    @objc func postCommentBUTTON2(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section:2) as IndexPath) as! qaTimelineCell
        rowIndex = sender.tag - 3000
        commentsText = cell.commentsTextView.text!
        cell.postBtn.isHidden = true
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        postAct()
        
    }
    
    @objc func postCommentBUTTON1(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section:2) as IndexPath) as! eventsTimelineCell
        rowIndex = sender.tag - 3000
        commentsText = cell.commentsTextView.text!
        cell.postBtn.isHidden = true
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        postAct()
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let pageCur = indexPath.row
        //
        Utils.setPreferenceValue(setValue: "\(pageCur)", ForKey: Constant.PAGECUR)
        
        //        let page = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
        //
        //
        //       // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        //        page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //        page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        //
        //        self.present(page, animated: false, completion: nil)
        
        if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "1" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "2" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "3"
        {
            
            let page = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
            
            
            page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
            page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
            
            self.present(page, animated: false, completion: nil)
            
        }
            
            
        else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "4"
        {
            let page:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! ProfileViewController
            Utils.setPreferenceValue(setValue: (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String, ForKey: Constant.SELECTED_USER_ID)
            self.present(page, animated: false, completion: nil)
            
        }
            
        else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "5" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "6" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "7"
        {
            
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            page.categoryType = "0"
            self.present(page, animated: false, completion: nil)
            
            
        }
            
            
        else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "8" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "9" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "10"
        {
            
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
            page.question_id = (dataArray[pageCur] as AnyObject).value(forKey: "quest_id") as! String
            self.present(page, animated: false, completion: nil)
            
        }
        
        
        
        
    }
    
    
    
    
    func postAct()
    {
        
        let params: [String:String] = ["comment_id" :"0" ,"timelineid" : (Utils.getPreferenceValue(ForKey: Constant.TIMELINE_ID))
            ,"comments": commentsText ,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    
                    self.rowNumber = self.rowIndex
                    self.action1 = "1"
                    // self.getCommentsAll()
                    self.timelineFunction()
                    
                }
                
            }
            
        }
        
        
        
        
        
    }
    
    
    func getCommentsAll()
    {
        let params: [String:String] = ["timelineid" : (Utils.getPreferenceValue(ForKey: Constant.TIMELINE_ID)), "userid" : Utils.getPreferenceValue(ForKey: Constant.COMMENTS_USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_TIMELINE_COMMENTS_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count == 0){
                    
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                    print(self.dataArray1)
                    let indexPath = IndexPath(item: self.rowNumber, section: 2)
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    
    
    @objc func commentBUTTON(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section:2) as IndexPath) as! homeTableViewCell
        
        cell.postCommentButton.isHidden = false
        cell.commentTextView.becomeFirstResponder()
        
        
    }
    
    @objc func commentEvent(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section:2) as IndexPath) as! eventsTimelineCell
        cell.postBtn.isHidden = false
        cell.commentsTextView.becomeFirstResponder()
        
        
    }
    
    @objc func writeAction(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag , section:1) as IndexPath) as! writeTableViewCell
        let page:writePostController = self.storyboard?.instantiateViewController(withIdentifier: "writepost") as! writePostController
        
        self.present(page, animated: false, completion: nil)
        
        
    }
    @objc func commentQuestion(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section:2) as IndexPath) as! qaTimelineCell
        cell.postBtn.isHidden = false
        cell.commentsTextView.becomeFirstResponder()
        
        
    }
    
    
    /***/
    
    @objc func ViewAction(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag, section:2) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "1"
        
        self.present(page, animated: false, completion: nil)
        
        
    }
    
    // funcs
    
    
    func timelineFunction()
    {
        if self.action1 != "1"
        {
           
           // indicator.hidesWhenStopped = true
           
            //indicator.startAnimating()
            Utils.svprogressHudShow(title: "Loading...", view: self)
            
        }
        
        let params: [String:String] = ["deleted" : "0","userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_TIMELINE_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.dataArray = innerDict as! NSArray
                        if self.dataArray != nil{
                            //                        self.ImageArray = self.dataArray.value((forKey: "image") as! NSArray
                            //                            ) as! [String]
                            if self.action1 == "1"
                            {
                                Utils.svprogressHudDismiss(view: self)
                                //self.indicator.stopAnimating()
                                let indexPath = IndexPath(item: self.rowNumber, section: 2)
                                self.tableView.reloadRows(at: [indexPath], with: .none)
                                self.action1 = ""
                            }
                                
                            else
                            {
                                Utils.svprogressHudDismiss(view: self)
                                //self.indicator.stopAnimating()
                                self.tableView.reloadData()
                                
                            }
                        }
                    }
                        
                    else
                    {
                       
                        
                        Utils.svprogressHudDismiss(view: self)
                        

                      //  self.indicator.stopAnimating()
                        self.showToast(message: "No posts yet")
                    }
                    
                    
                    
                }
                else
                {
                
                     Utils.svprogressHudDismiss(view: self)
                    self.showToast(message: "No posts yet")
                }
            }
                
            else
            {
                
                Utils.svprogressHudDismiss(view: self)
               // self.indicator.stopAnimating()
                self.showToast(message: "No posts yet")
            }
            
            
        }
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Add a Comment"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.textAlignment = .left
            textView.text = "Add a Comment"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.textAlignment = .left
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    override func viewDidLayoutSubviews() {
        headerView.layer.masksToBounds =  false
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset =  CGSize(width: 2, height: 3)
        headerView.layer.shadowOpacity = 1.0
    }
    
    
}

extension UIView {
    
    func addShadowViewhome() {
        //Remove previous shadow views
        superview?.viewWithTag(119900)?.removeFromSuperview()
        
        //Create new shadow view with frame
        let shadowView = UIView(frame: frame)
        shadowView.tag = 119900
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 3)
        shadowView.layer.masksToBounds = false
        
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true
        
        superview?.insertSubview(shadowView, belowSubview: self)
    }
    
    
    
    func addDropShadowToView(targetView:UIView? ){
        targetView!.layer.masksToBounds =  false
        targetView!.layer.shadowColor = UIColor.lightGray.cgColor
        targetView!.layer.shadowOffset = CGSize(width: 2, height: 3)
        targetView!.layer.shadowOpacity = 1.0
    }
}

extension homeTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data?.count == 0
        {
            return 0
        }
        else
        {
            return (data?.count)!
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! timelineCollectionCell
        //cell.bgImage.image = data?[indexPath.item]
        cell.bgImage.sd_setImage(with: URL(string: data![indexPath.row]), placeholderImage: UIImage(named: "default"))
        self.pageCtrl.numberOfPages = (data?.count)!
        //        cell.homeScroll.delegate = self
        //        self.homeScroll.minimumZoomScale = 0.5
        //        self.homeScroll.maximumZoomScale = 3.5
        
        //self.pageCtrl.transform = CGAffineTransform(scaleX: 2, y: 2)
        return cell
    }
    
    //    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    //       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! timelineCollectionCell
    //        return cell.bgImage
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageCtrl.currentPage = indexPath.row
        // self.pageCtrl.transform.cu = CGAffineTransform(scaleX: 2, y: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        thisWidth = CGFloat(self.frame.width)
        return CGSize(width: thisWidth, height: self.frame.height)
    }
    
    
    func initCollection()
    {
        self.collectionView2.dataSource = self
        self.collectionView2.delegate = self
        // self.collectionView2.register(UINib(nibName:"timelineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "parts")
    }
    
    
    func setData(data: [String])
    {
        self.data = data
        self.initCollection()
        self.collectionView2.reloadData()
    }
}
extension UIViewController
{
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.view.frame.size.height-100, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 15;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showToast1(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 60, y: 5, width: 120, height: 20))
        toastLabel.backgroundColor = UIColor.lightGray
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 7.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    //    func showToast2(message : String) {
    //
    //        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 50, y: 5, width: 120, height: 20))
    //        toastLabel.backgroundColor = UIColor.lightGray
    //        toastLabel.textColor = UIColor.white
    //        toastLabel.textAlignment = .center;
    //        toastLabel.font = UIFont(name: "Montserrat-Light", size: 9.0)
    //        toastLabel.text = message
    //        toastLabel.alpha = 1.0
    //        toastLabel.layer.cornerRadius = 10;
    //        toastLabel.clipsToBounds  =  true
    //        self.view.addSubview(toastLabel)
    ////                UIView.animate(withDuration: 0.001, delay: 0.1, options: .curveEaseOut, animations: {
    ////                    toastLabel.alpha = 0.0
    ////                }, completion: {(isCompleted) in
    ////                    toastLabel.removeFromSuperview()
    ////                })
    //        toastLabel.re
    //    }
    
    
}

//extension NSMutableAttributedString {
//    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
//        let attrs:[String:Any] = [NSAttributedStringKey.font.rawValue: UIFont(name: "AvenirNext-Medium", size: 12)!]
//        let boldString = NSMutableAttributedString(string: text, attributes:attrs)
//        self.append(boldString)
//        return self
//    }
//
//    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
//        let normal =  NSAttributedString(string: text)
//        self.append(normal)
//        return self
//    }
//}



