//
//  ReviewViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import SJSegmentedScrollView
import Alamofire
import SwiftyJSON
import IQKeyboardManagerSwift
import SVProgressHUD


var myIndexPath : Int!
 var index1 : Int!
 var a :Int = 1

var revieWPicID : String = ""
var hotelName : String = ""
class ReviewViewController: UIViewController,UITabBarDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,CategoryRowDelegate{
    
    @IBOutlet var bottomBar: UITabBar!
    var window1: UIWindow?
    
  
    @IBOutlet weak var newTable1: UITableView!
    var dataArray1 = [[String:AnyObject]]()
//    var picArray1 = [String]()
//      var picArray2 = [String]()
//      var picArray3 = [String]()
    
    var like : Int = 0
    var rowIndex : Int = 0
     var rowNumber : Int = 0
 
     var searchingdetailarray = [[String:AnyObject]]()
      var action1 : String = ""
   
    var totalposts : String = ""
    var totalFollowers : String = ""
    var cellSpacingHeight = 670.0
    
    var categoryType : String = "0"
//    var topDishNameArray = [String]()
//    var worstDishNameArray = [String]()
    
    @IBOutlet weak var tableContainer: UIView!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
  //  @IBOutlet weak var label2: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var currentLocationTExt: UITextField!
    @IBOutlet var menuBarItem: UITabBarItem!
    @IBOutlet var notificationsButton: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!
   // let cellSpacingHeight1: CGFloat = 440
   
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var newCollectTable: UICollectionView!
    @IBOutlet var bottomView: UIView!
   // @IBOutlet var scrollBgView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    var restaurantsArray : NSArray = []
      var onceOnly = true
    
    
    
    @IBOutlet weak var mainstackview: UIStackView!
    @IBOutlet weak var headerview: UIView!
    
    @IBOutlet weak var stackview: UIStackView!
    
    
    @IBOutlet weak var tabledisplayview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // bottomView.isHidden = true
        
//        tableView.delegate = self
//        tableView.dataSource = self
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        view1.isHidden = true
        bottomBar.selectedItem = reviewButton
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        bottomBar.selectedItem?.title = "Review"
        bottomBar.isHidden = false
        currentLocationTExt.layer.borderWidth = 0.0
        newCollectTable.delegate = self
        newCollectTable.dataSource = self
        currentLocationTExt.delegate = self
        label1.isHidden = false
        label2.isHidden = true
        newTable1.delegate = self
        newTable1.dataSource = self
        newTable1.estimatedRowHeight = 100.0
        newTable1.rowHeight = UITableViewAutomaticDimension
        
        
        
        
        
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            getReviewsCommonAll()
        }
        else {
            getReviewsAll()
        }
        
        // indicator1.isHidden = true
        
        label3.isHidden = true
        
        
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            headerview.isHidden = true
            view1.isHidden = true
            stackview.isHidden = true
            
            headerview.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            headerview?.translatesAutoresizingMaskIntoConstraints = true
            tabledisplayview.frame = CGRect(x:0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height)
            tabledisplayview?.translatesAutoresizingMaskIntoConstraints = true
            stackview.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            stackview?.translatesAutoresizingMaskIntoConstraints = true
            view2.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            view2?.translatesAutoresizingMaskIntoConstraints = true
            
            
            headerview.addDropShadowToView(targetView: headerview)
            view1.addDropShadowToView(targetView: view1)
            stackview.addDropShadowToView(targetView: stackview)
            
            newTable1.reloadData()
        }
        else {
            headerview.isHidden = false
            //  view1.isHidden = false
            stackview.isHidden = false
            tabledisplayview.frame.size.width = self.view.frame.size.width
            tabledisplayview.frame.size.height = self.view.frame.size.height
            
        }
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.bottomBar.isHidden = false
    }
    
    
    
    func getReviewsAll()
        {
//        indicator1.isHidden = false
            Utils.svprogressHudShow(title: "Loading...", view: self)
//
//        indicator1.hidesWhenStopped = true
//        indicator1.startAnimating()
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID ),"cate_type" :categoryType ]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_REVIEW_ALL)"
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
                    let indexPath = IndexPath(item: self.rowNumber, section: 0)
                    self.newTable1.reloadRows(at: [indexPath], with: .none)
                       
                    }
                    else
                    {
                        
                        Utils.svprogressHudDismiss(view: self)
                       // self.indicator1.stopAnimating()
                        self.newTable1.reloadData()
                        
                    }
                    
                }
                    
                else
                    
                {
                   
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator1.stopAnimating()
                    self.showToast(message: "Server Error")
                    
                    
                }
            }
            
            else
            {
               
                Utils.svprogressHudDismiss(view: self)
                
                self.showToast(message: "Server Error")
                
            }
            
            
        }
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return cellSpacingHeight
    
    
    
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       
        return restaurantsArray.count
       
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
        
        cell.view1.addShadowViewProfile()
        cell.view1.layer.cornerRadius = 5.0
        cell.view1.clipsToBounds = true
        
      
        cell.hotelAddress.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "formatted_address") as! String
        cell.hotelName.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        //        load_image(image_url_string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=\(((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String)&key=AIzaSyBCmiAi-SgtYNvYzuwwCNjR2rFDtdoOKlo", view:cell.hotelPic)
        searchPhotoFromGoogle(photo_Ref: ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String ,imageView : cell.hotelPic)
            
        
        return cell
    }
  
     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if action1 == "2" {
            if indexPath.row + 10 < restaurantsArray.count
            {
            //set the row and section you need.
            let indexToScrollTo = IndexPath(row: indexPath.row + 10, section: 0)
            self.newCollectTable.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            onceOnly = true
            action1 = ""
        }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let page:hotelDetailController = self.storyboard?.instantiateViewController(withIdentifier: "hotelDetail") as! hotelDetailController
        page.hotelname = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        page.hoteladdress = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "formatted_address") as! String
        page.imgString = ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String
           page.pageIden = "3"
        self.present(page, animated: false, completion: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currentLocationTExt
        {
             view1.isHidden = false
            searchPlaceFromGoogle(place: currentLocationTExt.text!)
           // self.newCollectTable.reloadData()
        }
        return true
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
    
    
    func searchPlaceFromGoogle(place:String) {
        
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+\(place)&key=AIzaSyDTV3YxP-zWn4ss-UD4dTXB4dbzwiNxJqk"
        //AIzaSyBCmiAi-SgtYNvYzuwwCNjR2rFDtdoOKlo
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                // let json = JSON(data: response.data!)
                if var dict = jsonDict as? Dictionary<String,AnyObject>{
                    if  let innerDict = dict["results"]{
                        if  (dict["status"] as! String)  == "OK"
                        {
                            self.restaurantsArray = (innerDict as! NSArray)
                            print(self.restaurantsArray.count)
                            
                            
                        }
                        
                    }
                    else{
                        
                    }
                }
                else
                {
                    
                }
            } else {
                //we have error connection google api
            }
        }
        
        self.newCollectTable.reloadData()
        task.resume()
        
    }

    @IBAction func allAct(_ sender: UIButton) {
        
        
        label1.isHidden = false
        label2.isHidden = true
        label3.isHidden = true
        categoryType = "0"
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            self.getReviewsCommonAll()
        }
        else {
            self.getReviewsAll()
        }
        
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        if(bottomBar.selectedItem == homeButton){
            //            print("Segue Buzz")
            
            let page:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
            self.present(page, animated: true, completion: nil)
            
        }
        
        if(bottomBar.selectedItem == foodHelpButton){
            //            self.performSegue(withIdentifier: "hiveTasks", sender: self)
            
            let page:FoodHelpController = self.storyboard?.instantiateViewController(withIdentifier: "foodhelp") as! FoodHelpController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == notificationsButton){
            
            
            let page:NotificationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "notifications") as! NotificationsViewController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == menuBarItem){
            
            
            let page:MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuview") as! MenuViewController
            self.present(page, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func createREview(_ sender: UIButton) {
        
        let page:CreateReviewController = self.storyboard?.instantiateViewController(withIdentifier: "createreview") as! CreateReviewController
        self.present(page, animated: true, completion: nil)
        
    }
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 10))
//    view.backgroundColor = #colorLiteral(red: 0.8614041548, green: 0.8614041548, blue: 0.8614041548, alpha: 1)
//
//    return view
//
//
//        if section == 0
//        {
//
//        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 0 ))
//
//
//        view.backgroundColor = UIColor.clear
//        return view
//        }
//
//
//        else
//        {
//            let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5 ))
//
//
//            view.backgroundColor = UIColor.clear
//            return view
//
//
//        }
//
//    }
    
    @IBAction func dineInAct(_ sender: UIButton) {
        
        label1.isHidden = true
        label2.isHidden = false
        label3.isHidden = true
        categoryType = "1"
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            self.getReviewsCommonAll()
        }
        else {
            self.getReviewsAll()
        }
        
        
    }
    
    
    
    @IBAction func viewAll(_ sender: UIButton) {
        
           action1 = "2"
            onceOnly = false
           newCollectTable.reloadData()
        
        
        
        
    }
    
    
    
    
    
    @IBAction func deliveryAct(_ sender: UIButton) {
        
        label1.isHidden = true
        label2.isHidden = true
        label3.isHidden = false
        categoryType = "2"
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            self.getReviewsCommonAll()
        }
        else {
            self.getReviewsAll()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10.0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReviewTableViewCell
//
//
//        return cell
  //  }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        if dataArray1.count == 0
        {
            return 0
            
        }
        else
        {
            
            return dataArray1.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

       return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! reviewCell
        
        cell.selectionStyle = .none
        cell.delegate = self

       myIndexPath = indexPath.row
        
       // cell.like
        
        
        
        cell.reviewText.text = (dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_review") as? String
        cell.hotelNameLabel.text = (dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_name") as? String
        cell.progImage.sd_setImage(with: URL(string:((dataArray1[indexPath.row] as AnyObject).value(forKey: "picture") as? String)!), placeholderImage: UIImage(named: "default"))
        
        cell.commentsLabel.text = (dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_name") as? String
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "1"
        {
            cell.rating1.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "2"
        {
             cell.rating1.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "3"
        {
            cell.rating1.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "4"
        {
            cell.rating1.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
         
            cell.rating1.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
        }
        
        
        if a == 2 && indexPath.row == index1
        {
           cell.hotelAmbianceView.isHidden = false
           myIndexPath = index1
           cell.moreLessBtn.isHidden = true
          
           index1 = -1
        }
        else
        {
           cell.hotelAmbianceView.isHidden = true
            myIndexPath = indexPath.row
            cell.moreLessBtn.isHidden = false
//           cell.setData1(data1: dataArray1)
        }
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "category_type") as? String)! == "1"
        {
            cell.servicePackageLabel.text = "Service"
        }
        else{
             cell.servicePackageLabel.text = "Package"
        }
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "1"
        {
            cell.rating2.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "2"
        {
            cell.rating2.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "3"
        {
            cell.rating2.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "4"
        {
            cell.rating2.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating2.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
    
      
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "1"
        {
            cell.rating3.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "2"
        {
            cell.rating3.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "3"
        {
            cell.rating3.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "4"
        {
            cell.rating3.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating3.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "1"
        {
            cell.rating4.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "2"
        {
            cell.rating4.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "3"
        {
            cell.rating4.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "4"
        {
            cell.rating4.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.rating4.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
        
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "1"
        {
            cell.mainRating.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "2"
        {
            cell.mainRating.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "3"
        {
            cell.mainRating.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "4"
        {
            cell.mainRating.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        }
        else
        {
            
            cell.mainRating.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            
        }
     
        cell.rating1.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! + "*"
        cell.rating2.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! + "*"
        cell.rating3.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! + "*"
       cell.rating4.text = "\(((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)!)*"
        cell.mainRating.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! + "*"
        cell.commentImage.sd_setImage(with: URL(string:((dataArray1[indexPath.row] as AnyObject).value(forKey: "picture") as? String)!), placeholderImage: UIImage(named: "default"))
        cell.userName.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "first_name") as? String)! + (" ") + ((dataArray1[indexPath.row] as AnyObject).value(forKey: "last_name") as? String)!
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! == "0"
        {
         cell.likesLabel.isHidden = true
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! == "1"
        {
             cell.likesLabel.isHidden = false
        cell.likesLabel.text! = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! + "Like"
        }
        else
        {
            cell.likesLabel.isHidden = false
            
            
          cell.likesLabel.text! = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! + "Likes"
        }
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "htl_rev_likes") as? String)!  == "0"
        {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol") , for: .normal)
        }
        else
        {
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }
        
        
        if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_comments") as? String)! == "0"
        {
            cell.commentsLabel.isHidden = true
        }
        else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! == "1"
        {
            cell.commentsLabel.isHidden = false
            cell.commentsLabel.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_comments") as? String)!  + "Comment"
        }
        else
        {
             cell.commentsLabel.isHidden = false
            cell.commentsLabel.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_comments") as? String)! + "Comments"
        }
        
        
       
//        cell.likesLabel.text = (dataArray1[indexPath.row] as AnyObject).value(forKey: "total_comments") as? String
        
        
        cell.postBtn.tag = indexPath.row + 9000
        
        
        cell.editDeleteBtn.addTarget(self, action: #selector(deleteEVENT), for: .touchUpInside)
        cell.editDeleteBtn.tag = indexPath.row + 5000
//
//        cell.commentBtn.addTarget(self, action: #selector(deleteEVENT), for: .touchUpInside)
        cell.commentsAllBtn.tag = indexPath.row + 6000
        cell.likesAllBtn.tag = indexPath.row + 7000
        cell.commentsTextView.delegate = self
        cell.commentsTextView.text = "Add a comment"
        cell.commentsTextView.textColor = UIColor.lightGray
        if "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String)" == "1"
        {
            totalposts = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String) Review"
        }
        else if "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String)" == "0"
        {
            totalposts = ""
        }
        else
        {
            totalposts = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String) Reviews"
        }
        
        if (dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as? String == "1"
        {
            totalFollowers = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String) Follower"
        }
        else if (dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as? String == "0"
        {
            totalFollowers = ""
        }
        else
        {
            if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
            {
                
                
            }
            else {
                totalFollowers = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as? String)! + "Followers"
            }
        }
        
        cell.reviewFollwersLabel.text = "\(totalposts)" + (" ") + (",") + (" ")
            + "\(totalFollowers)"
        
        //        cell.reviewFollwersLabel.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as? String) review"
        let createdTime = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatterr.date(from: createdTime)!
        cell.timeAgoLabel.text! =  myDate.timeAgoDisplay()

        
        
        
        cell.topDishesLabel.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "topdish")!)"
        cell.dishesToAvoidLabel.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "avoiddish")!)"
   
        if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "top_count") as! Int) == 0
        {
         cell.topDishesView.isHidden = true
        }
        
        else
        {
            cell.topDishesView.isHidden = false
        }
        
        if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoid_count") as! Int) == 0
        {
            cell.dishesToAvoidView.isHidden = true
        }
            
        else
        {
            cell.dishesToAvoidView.isHidden = false
        }
        
        
        if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "topdish") as! String) == ""
        {
            cell.TopdishNameView.isHidden = true
        }
            
        else
        {
            cell.TopdishNameView.isHidden = false
        }
        
        if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoiddish") as! String) == ""
        {
            cell.dishtoAvoidNameView.isHidden = true
        }
            
        else
        {
            cell.dishtoAvoidNameView.isHidden = false
        }
        
       if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoiddish") as! String) == "" && ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoid_count") as! Int) == 0
       {
        
        cell.topView.isHidden = true
        }
        
        else
       {
          cell.topView.isHidden = false
        }
        
        
        if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "topdish") as! String) == "" && ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "top_count") as! Int) == 0
        {
            
            cell.dishView.isHidden = true
        }
            
        else
        {
            cell.dishView.isHidden = false
        }
        
        if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "ambi_image_count") as! Int) == 0
        {
            cell.moreLessBtn.isHidden = true
        }
            
        else
        {
            cell.moreLessBtn.isHidden = false
        }
        
        
        
        
         cell.setData1(data1: dataArray1)

        
        cell.bucketListBtn.tag = indexPath.row + 3000
        cell.bucketListBtn.addTarget(self, action: #selector(bucketListAct), for: .touchUpInside)
        cell.likeBtn.tag = indexPath.row + 2000
        
         cell.likeBtn.addTarget(self, action: #selector(likeEVENT), for: .touchUpInside)
        cell.commentBtn.tag = indexPath.row + 4000
        
        cell.commentBtn.addTarget(self, action: #selector(commentEVENT), for: .touchUpInside)
        cell.moreLessBtn.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        cell.moreLessBtn.tag = indexPath.row
      //  a = 0
        return cell
        
    }
    
    
    @objc func bucketListAct(sender : UIButton)
    {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketGrp") as! BucketGrpFollowerController
        page.userID = "\((dataArray1[sender.tag - 3000] as AnyObject).value(forKey: "user_id")!)"
         page.REviewID = "\((dataArray1[sender.tag - 3000] as AnyObject).value(forKey: "revrat_id")!)"
        page.userName = "\((dataArray1[sender.tag - 3000] as AnyObject).value(forKey: "first_name")!)"
        self.present(page, animated: false, completion: nil)
        
    }
    
    
    @IBAction func ViewAllCommentsBtn(_ sender: UIButton) {
 
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray1[sender.tag - 6000] as AnyObject).value(forKey: "user_id")!)"
        page.c = "3"
        page.reviewId = (dataArray1[sender.tag - 6000] as AnyObject).value(forKey: "revrat_id") as! String
        page.hotelID = (self.dataArray1[sender.tag - 6000] as AnyObject).value(forKey: "hotel_id") as! String
//        page.d = "123"
        
        self.present(page, animated: false, completion: nil)
        
        
        
        
    }
    
    
    @IBAction func likesAllBtn(_ sender: UIButton) {
        
//        Utils.setPreferenceValue(setValue: "\((dataArray1[sender.tag - 7000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        
//        Utils.setPreferenceValue(setValue: "\((dataArray1[sender.tag - 7000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray1[sender.tag - 7000] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "4"
        page.reviewId = (dataArray1[sender.tag - 7000] as AnyObject).value(forKey: "revrat_id") as! String
        page.hotelID = (self.dataArray1[sender.tag - 7000] as AnyObject).value(forKey: "hotel_id") as! String
       // page.d = "123"
        self.present(page, animated: false, completion: nil)
    }
    
    
    @IBAction func postComment(_ sender: UIButton) {
        
        let cell = newTable1.cellForRow(at: NSIndexPath(row: sender.tag - 9000, section:0) as IndexPath) as! reviewCell
        
        let params: [String:String] = ["comment_id" :"0" ,"hotelid" : (self.dataArray1[sender.tag - 9000] as AnyObject).value(forKey: "revrat_id") as! String,"reviewid" :(self.dataArray1[sender.tag - 9000] as AnyObject).value(forKey: "hotel_id") as! String,
            "comments": cell.commentsTextView.text! ,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_HOTEL_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    
                    self.rowNumber = self.rowIndex
                    self.action1 = "1"
                    cell.commentsTextView.text = ""
                    // self.getCommentsAll()ha
                    if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
                    {
                        self.getReviewsCommonAll()
                    }
                    else {
                        self.getReviewsAll()
                    }
                    
                    
                }
                
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    @objc func deleteEVENT(sender : UIButton)
    {
        
         let cell = newTable1.cellForRow(at: NSIndexPath(row: sender.tag - 5000, section:0) as IndexPath) as! reviewCell
        
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Bucket List Options", style: .default, handler: { _ in
           
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            
            let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to delete this comment?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: " Yes,Delete it!", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                let params: [String:String] = ["reviewid" :(self.dataArray1[sender.tag - 5000] as AnyObject).value(forKey: "hotel_id") as! String ,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                
                let urlString = "\(Constant.BASEURL)\(Constant.DELETE_HOTEL_REVIEW)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    if result != nil{
                        if   json["ResponseCode"] ==  1
                        {
                            
                            self.action1 = "1"
                            self.rowNumber = self.rowIndex
                            if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
                            {
                                self.getReviewsCommonAll()
                            }
                            else {
                                self.getReviewsAll()
                            }
                            
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
            let cancelAction = UIAlertAction(title: "No,Cancel!", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
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
    
  
    
    
     @objc func commentEVENT(sender: UIButton!){
    
    
     let cell = newTable1.cellForRow(at: NSIndexPath(row: sender.tag - 4000, section:0) as IndexPath) as! reviewCell
    
     cell.commentsTextView.becomeFirstResponder()
    
   
    
    }
    
    
    @objc func likeEVENT(sender: UIButton!){
        
        
        let cell = newTable1.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:0) as IndexPath) as! reviewCell
        
        
        rowIndex = sender.tag - 2000
        
        
        if cell.likeBtn.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.likesLabel.isHidden = false
            let cont = ((dataArray1[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
              //  cell.likesLabel.setTitle("\(cont1) like", for: .normal)
                cell.likesLabel.text = "\(cont1) like"
            }
            else if cont1 == 0
            {
                cell.likesLabel.isHidden = true
                
            }
                
            else
            {
               // cell.likesLabel.setTitle("\(cont1) likes", for: .normal)
                 cell.likesLabel.text = "\(cont1) likes"
                
            }
            like = 1
        }
        else
        {
            
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((dataArray1[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.likesLabel.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    //cell.likesLabel.setTitle("\(cont1) like", for: .normal)
                     cell.likesLabel.text = "\(cont1) like"
                }
                    
                else if cont1 == 0
                {
                    cell.likesLabel.isHidden = true
                    
                }
                else
                {
                    //cell.likesLabel.setTitle("\(cont1) likes", for: .normal)
                     cell.likesLabel.text = "\(cont1) likes"
                }
            }
            
            like = 0
        }
        
        likeFuncCall()
        
        
        
    }
    
    
    
    
    
    
    func likeFuncCall()
    {
        
        let params: [String:String] = ["hotelid" : (dataArray1[rowIndex] as AnyObject).value(forKey: "hotel_id") as! String,"reviewid":(dataArray1[rowIndex] as AnyObject).value(forKey: "revrat_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_HOTEL_REVIEW_LIKES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    
                    self.action1 = "1"
                    self.rowNumber = self.rowIndex
                    if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
                    {
                        self.getReviewsCommonAll()
                    }
                    else {
                        self.getReviewsAll()
                    }
                    
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
    
    
    @objc func performAction(sender:UIButton!)
    {
        let cell = newTable1.cellForRow(at: IndexPath(row : sender.tag,section : 0)) as! reviewCell
        
        
       // myIndexPath = sender.tag
        index1 = sender.tag
        a = 2
     
        cell.hotelAmbianceView.isHidden = false
        cell.moreLessBtn.isHidden = true
        let indexPath = IndexPath(item: sender.tag, section: 0)
        self.newTable1.reloadRows(at: [indexPath], with: .none)
        
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
    
    
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.textAlignment = .left
            textView.text = "Add a Comment"
            textView.textColor = UIColor.lightGray
        }
    }
    
    internal func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.textAlignment = .left
        
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "hotelDetail") as! hotelDetailController
        page.hotelname = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_name") as? String)!
        page.reviewID = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "revrat_id") as? String)!
        page.category_type = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "category_type") as? String)!
        page.ambienceRate = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)!
        page.valueMoney = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)!
        page.tasteRate = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)!
        page.serviceRate = "\(((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)!)"
        page.mainRate = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)!
        page.photoRef = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "photo_reference") as? String)!
           page.pageIden = "2"
        self.present(page, animated: false, completion: nil)
        
        
    }
    func cellTapped()
    {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketList") as! BucketListController
        
        page.a = "1"
        page.reviewId = revieWPicID
        page.hotelNAME = hotelName
        self.present(page, animated: false, completion: nil)
    }
    
    func getReviewsCommonAll()
    {
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let username = "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"
        let parameters = ["userid": username,"search_text" : searchtext]
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)", method: .post, parameters: parameters)
            
            .responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if let resData = json["Data"].arrayObject {
                    
                    if json["Data"] != "Novalue"
                    {
                        self.searchingdetailarray = (((resData as! NSArray) as! [[String : AnyObject]] ))
                        //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                        // "\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"
                        
                        
                    }
                    else {
                        self.showToast(message: "No search found!!!")
                    }
                    if(self.searchingdetailarray.count != 0)
                    {
                        print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        
                        self.dataArray1 = (((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray) as! [[String : AnyObject]])
                        
                        print("\((((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                        print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        print("\((((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                        print("\((((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                        
                        if(self.dataArray1.count != 0){
                            var  searchvalue =  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as! String)
                            if self.action1 == "1"
                            {
                                
                                
                                if searchvalue != "0"
                                {
                                    let indexPath = IndexPath(item: self.rowNumber, section: 0)
                                    self.newTable1.reloadRows(at: [indexPath], with: .none)
                                  
                                    Utils.svprogressHudDismiss(view: self)
                                   // self.indicator1.stopAnimating()
                                }
                                else {
                                    
                                    Utils.svprogressHudDismiss(view: self)
                                  //  self.indicator1.stopAnimating()
                                    
                                }
                            }
                            else
                            {
                                
                                if searchvalue != "0"
                                {
                                    self.newTable1.reloadData()
                                    
                                    Utils.svprogressHudDismiss(view: self)
//                                    self.indicator1.stopAnimating()
                                }
                                else {
                                   
                                    Utils.svprogressHudDismiss(view: self)
//                                    self.indicator1.stopAnimating()
                                }
                                
                            }
                            
                            
                            //  self.nochatlable.isHidden = false
                            
                            // self.Mytable.isHidden = false
                            
                        }
                        else {
                           
                            Utils.svprogressHudDismiss(view: self)
//                            self.indicator1.stopAnimating()
                            self.showToast(message: "Server Error")
                        }
                    }
                    else {
                       
                        Utils.svprogressHudDismiss(view: self)
//                        self.indicator1.stopAnimating()
                        self.showToast(message: "Server Error")
                    }
                    
                    
                }
                else {
                    
                }
                
                
                
        }
        
        
    }
    
    
    
  
    

   
}


extension reviewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        if a == 2
//        {
//            myIndexPath = index1
//        }
        if collectionView == collectTable
        {
            
            if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
            {
                myIndexPath = 0
            }
            if (data1[myIndexPath] as NSDictionary).value(forKey: "ambi_image_count") as! Int == 0
            {
                return 0
            }
            else
            {
            return (data1[myIndexPath] as NSDictionary).value(forKey: "ambi_image_count") as! Int
            }
        }
        else if collectionView == collectTable1
        {
            if (data1[myIndexPath] as NSDictionary).value(forKey: "top_count") as! Int == 0
            {
                return 0
            }
            else
            {
            return (data1[myIndexPath] as NSDictionary).value(forKey: "top_count") as! Int
            }
        }
        else
        {
            if (data1[myIndexPath] as NSDictionary).value(forKey: "avoid_count") as! Int == 0
            {
                return 0
            }
            
            else{
                
            return (data1[myIndexPath] as NSDictionary).value(forKey: "avoid_count") as! Int
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//
//        if a == 2 && myIndexPath == index1
//        {
//            myIndexPath = index1
//        }
        
        if collectionView == collectTable
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
//            var dict =  (((data1[indexPath.row] as AnyObject).value(forKey: "topdishimage") as! NSArray))
     
            
            if  (data1[myIndexPath] as NSDictionary).value(forKey: "ambi_image_count") as! Int == 0
            {
               // return 0
                collectTable.isHidden = true
            }
            else
            {
                collectTable.isHidden = false
                 cell.hotelPic.sd_setImage(with: URL(string:(((data1[myIndexPath] as AnyObject).value(forKey: "ambi_image") as! NSArray)[indexPath.row] as! NSDictionary).value(forKey: "img") as! String), placeholderImage: UIImage(named: "default"))
            }
          
       
        cell.view1.addDropShadowToView(targetView: cell.view1)
        return cell
        }
        else if collectionView == collectTable1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
          if  (data1[myIndexPath] as NSDictionary).value(forKey: "top_count") as! Int != 0
          {
            collectTable1.isHidden = false
       cell.hotelPic.sd_setImage(with: URL(string:(((data1[myIndexPath] as AnyObject).value(forKey: "topdishimage") as! NSArray)[indexPath.row] as! NSDictionary).value(forKey: "img") as! String), placeholderImage: UIImage(named: "default"))
            cell.hotelName.text = (((data1[myIndexPath] as AnyObject).value(forKey: "topdishimage") as! NSArray)[indexPath.row] as! NSDictionary).value(forKey: "dishname") as! String
            
            }
            
            else
          {
            collectTable1.isHidden = true
            }
            cell.view1.addDropShadowToView(targetView: cell.view1)
            return cell
            
        }
        
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            if (data1[myIndexPath] as NSDictionary).value(forKey: "avoid_count") as! Int != 0
            {
                collectTable2.isHidden = false
          cell.hotelPic.sd_setImage(with: URL(string:(((data1[myIndexPath] as AnyObject).value(forKey: "avoiddishimage") as! NSArray)[indexPath.row] as! NSDictionary).value(forKey: "img") as! String), placeholderImage: UIImage(named: "default"))
            cell.hotelName.text = (((data1[myIndexPath] as AnyObject).value(forKey: "avoiddishimage") as! NSArray)[indexPath.row] as! NSDictionary).value(forKey: "dishname") as! String
            }
            
            else
            {
                collectTable2.isHidden = true
            }
            cell.view1.addDropShadowToView(targetView: cell.view1)
            return cell
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       revieWPicID = (data1[myIndexPath] as NSDictionary).value(forKey: "revrat_id") as! String
        hotelName = (data1[myIndexPath] as NSDictionary).value(forKey: "hotel_name") as! String
        if delegate != nil {
            delegate?.cellTapped()
        }
    }
    
    
     func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "mySegue"?:
//            guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else { return }
            guard let bucketlistcontroller = segue.destination as? BucketListController else { return }
            
//            detailViewController.selectedImageName = cellImages[indexPath.row]
//            detailViewController.selectedLabel = cellLabels[indexPath.row]
            
        default: return
        }
    }
    
    
    
    //    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    //       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! timelineCollectionCell
    //        return cell.bgImage
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        self.pageCtrl.currentPage = indexPath.row
    //        // self.pageCtrl.transform.cu = CGAffineTransform(scaleX: 2, y: 2)
    //    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //thisWidth = CGFloat(self.frame.width)
//        
//        if collectionView == collectTable
//        {
//        return CGSize(width: 165.0, height: 120.0)
//        }
//        else
//        {
//          return CGSize(width: 165.0, height: 150.0)
//        }
//    }
    
    
    func initCollection()
    {
        self.collectTable.dataSource = self
        self.collectTable.delegate = self
        self.collectTable1.delegate = self
        self.collectTable1.dataSource = self
        self.collectTable2.delegate = self
        self.collectTable2.dataSource = self
        // self.collectionView2.register(UINib(nibName:"timelineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "parts")
    }
    
    
    func setData1(data1: [[String:AnyObject]])
    {
        self.data1 = data1
        self.initCollection()
        collectTable.reloadData()
        collectTable1.reloadData()
        collectTable2.reloadData()
        
    }


}
