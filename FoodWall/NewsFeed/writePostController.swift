//
//  writePostController.swift
//  mapsLearn
//
//  Created by Ramesh Ponnuvel on 10/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GooglePlaces
import GoogleMaps
import BSImagePicker
import Photos
import IQKeyboardManagerSwift

class writePostController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    
    
    var act : String = ""
    var friendDone : String = ""
    var addressDone : String = ""
    @IBOutlet weak var friendsView: UITextView!
    @IBOutlet weak var followTable: UITableView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var editbtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var someTextView: UITextView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var collectTable: UICollectionView!
    var PhotoArray1 : NSMutableArray = []
    @IBOutlet weak var followView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bottomView: ShadowView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    var timeLineID : Int?
    var imgStr : String = ""
    var a :Int = 0
    var friendNames  : NSMutableArray = []
   var friendArray : NSMutableArray = []
    var  dataArray1 = [[String:AnyObject]]()
    var followArray : NSArray = []
    var imagePicker = UIImagePickerController()
    var PageCur : Int?
    var withWhom : String  = ""
     var urls = [NSURL]()
    
    var dataArr : NSArray = []
    @IBOutlet weak var photoView: UIView!
    var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    var pic : UIImage = UIImage(named : "img1")!
    var restaurantsArray : NSArray = []
    var placeName : String = ""
    
    @IBOutlet weak var smallHeaderView: UIView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
//
     var timelineId : String = ""
    var USErID : String = ""
//    var imageArray : NSArray = []
//    var descrip : String = ""
    var friendArr : NSMutableArray = []
    //var imgView = #imageLiteral(resourceName: "android-wallpapers-4")
    override func viewDidLoad() {
        super.viewDidLoad()
        collectTable.delegate = self
        collectTable.dataSource = self
        collectTable.tag = 0
        searchText.delegate = self
        friendsView.delegate = self
        friendsView.isHidden = true
        someTextView.delegate = self
        someTextView.isHidden = true
         IQKeyboardManager.sharedManager().enableAutoToolbar = false
        someTextView.text = "Write something about this event"
        someTextView.textColor = UIColor.lightGray
        postBtn.layer.cornerRadius = 5.0
        postBtn.clipsToBounds = true
        postBtn.layer.borderColor = UIColor.black.cgColor
        postBtn.layer.borderWidth = 1.0
        editbtn.isHidden = true
        searchView.layer.cornerRadius = 10.0
        searchView.clipsToBounds = true
        someTextView.layer.cornerRadius = 10.0
        someTextView.clipsToBounds = true
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.tag = 1
        photoView.isHidden = true
        bottomView.isHidden = true
        followView.isHidden = true
        headerView.addDropShadowToView(targetView: headerView)
        smallHeaderView.addDropShadowToView(targetView: smallHeaderView)
        followTable.delegate = self
        followTable.dataSource = self
        selectFollowers()
//         self.someTextView.frame = CGRect(x:10,y:self.searchText.frame.maxY + 100 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
//        screenSize = UIScreen.main.bounds
//        screenWidth = screenSize.width
//        screenHeight = screenSize.height
//
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: screenWidth, height: 200)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 4
//        photosCollectionView!.collectionViewLayout = layout
       // photosCollectionView.collectionViewLayout
        //getRestaurants()
        
        
        if act == "1"
        {
            //searchText.text = hotelName
           // searchBtn.setImage(#imageLiteral(resourceName: "pencil-edit-button"), for: .normal)
            searchBtn.isHidden = true
            editbtn.isHidden = false
            someTextView.isHidden = false
            collectTable.isHidden = true
            photosCollectionView.isHidden = true
            bottomView.isHidden = false
            callTimelineSingle()
          //  someTextView.text = descrip
            
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func callTimelineSingle()
    {
    
        let params: [String:String] = ["timelineid" : timelineId,"userid" :USErID]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_TIMELINE_SINGLE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArr = (resData as! NSArray)
                
                if(self.dataArr.count != 0){
                    
                     print("Nodata")
//                    self.ImageArray = self.dataArray.value(forKey: "image") as! NSArray
                    print(self.dataArr)
                      self.friendDone = "0"
                    self.addressDone = "1"
                    self.searchText.text = (self.dataArr[0] as AnyObject).value(forKey: "timeline_hotel") as! String
                    self.someTextView.text = (self.dataArr[0] as AnyObject).value(forKey: "timeline_description") as! String
                    if (self.dataArr[0] as AnyObject).value(forKey: "whom_count") as! Int != 0
                    {
                      for i in 0..<((self.dataArr[0] as AnyObject).value(forKey: "whom") as! NSArray).count
                      {
                        self.friendArr.add((((self.dataArr[0] as AnyObject).value(forKey: "whom") as! NSArray)[i] as! NSDictionary).value(forKey: "first_name") as! String)
                        
                        }
                        
                        if self.friendArr.count == 1
                        {
                           self.friendsView.text = "With - \(self.friendArr[0] as! String)"
                        }
                        else if self.friendArr.count == 2
                        {
                          self.friendsView.text = "With - \(self.friendArr[0] as! String) and \(self.friendArr[1] as! String) "
                        }
                        else
                        {
                          self.friendsView.text = "With - \(self.friendArr[0] as! String) and \(self.friendArr.count - 1) others"
                        }
                        
                        
                     
                       self.someTextView.frame = CGRect(x:10,y:self.friendsView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
                        self.friendsView.isHidden = false
                    }
                    if (self.dataArr[0] as AnyObject).value(forKey: "image_count") as! Int != 0
                    {
                        for i in 0..<((self.dataArr[0] as AnyObject).value(forKey: "image") as! NSArray).count
                        {
                            self.PhotoArray1.add((((self.dataArr[0] as AnyObject).value(forKey: "image") as! NSArray)[i] as! NSDictionary).value(forKey: "img") as! String)
                        }
                        self.photoView.isHidden = false
                        self.photoView.frame = CGRect(x:10,y:self.friendsView.frame.maxY + 30 ,width:self.photoView.frame.size.width,height:self.photoView.frame.size.height)
                        self.someTextView.frame = CGRect(x:10,y:self.photoView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
                        self.photosCollectionView.isHidden = false
                        self.photosCollectionView.reloadData()
                    }
                    
                  
                    
                }
            }
            
           
            
           
            
        }
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        callUrl()
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
                    self.followTable.reloadData()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                    self.showToast(message: "No data Found")
                }
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchPlaceFromGoogle(place: textField.text!)
        placeName = textField.text!
        return true
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        collectTable.isHidden = false
        someTextView.isHidden = true
        photosCollectionView.isHidden = false
        pageCtrl.isHidden = true
        photoView.isHidden = true
        collectTable.reloadData()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
        task.resume()
        
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0
        {
        return self.restaurantsArray.count
        }
        else
            
        {
            if act == "1"
            {
            return self.PhotoArray1.count
            }
            
            else
            {
                return  self.PhotoArray.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //thisWidth = CGFloat(self.frame.width)
        if collectionView.tag == 1
        {
        return CGSize(width: self.photoView.frame.size.width, height: 200.0)
        }
        
        else
        {
          return CGSize(width: 180.0, height: 200.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
        
        cell.view1.addShadowViewProfile()
        cell.view1.layer.cornerRadius = 5.0
        cell.view1.clipsToBounds = true
        PageCur = indexPath.row
        cell.hotelAddress.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "formatted_address") as! String
        cell.hotelName.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        //        load_image(image_url_string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=\(((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String)&key=AIzaSyBCmiAi-SgtYNvYzuwwCNjR2rFDtdoOKlo", view:cell.hotelPic)
        searchPhotoFromGoogle(photo_Ref: ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String ,imageView : cell.hotelPic)
        return cell
            
        }
        
        else
        {
            
            let cell :postCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! postCollectionViewCell
            if act == "1"
            {
                cell.prevIMage.sd_setImage(with: URL(string: PhotoArray1[indexPath.row] as! String), placeholderImage: UIImage(named : "default"))
                 self.pageCtrl.numberOfPages = PhotoArray1.count
            }else
            {
              cell.prevIMage.image = PhotoArray[indexPath.row]
              self.pageCtrl.numberOfPages = PhotoArray.count
            }
           
          
           return cell
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.tag == 1
        {
         self.pageCtrl.currentPage = indexPath.row
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return followArray.count
        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! followtableViewCell
        
        
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
    
    
    @IBAction func postAct(_ sender: Any) {
        
       /*
        let timeLineID:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let postTitle:Data = self.someTextView.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let CREATEDBY:Data = Utils.getPreferenceValue(ForKey: Constant.USER_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        
        let laTITUDE:Data = "12.971815".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let longTITUDE:Data = "80.24889".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                //                if(self.imageFilePath != nil)
                //                {
                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                //                }
                
                //        if(self.imgString != "")
                //                {
                //                    let dataDecoded2:NSData = NSData(base64Encoded: (self.imgString), options: NSData.Base64DecodingOptions(rawValue: 1))!
                //                    let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                //                    let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("newImage2.jpg")
                //                    dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                //
                //                    multipartFormData.append(fileDestinationUrl2, withName: "image")
                //                }
                
                multipartFormData.append(timeLineID, withName: "timeline_id")
                multipartFormData.append(postTitle, withName: "timeline_description")
                multipartFormData.append(laTITUDE, withName: "latitude")
                multipartFormData.append(longTITUDE, withName: "longitude")
                multipartFormData.append(CREATEDBY, withName: "created_by")
                
                
                
        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_TIMELINE)",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        
                        
                        
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
                        print("JSON : \(datastring)")
                        let json = JSON(data:response.data!)
                        // print(json["status"])
                        
                        // print(data:response.data!)
                        if("\(json["ResponseMessage"])" == "success")
                        {
                            // self.loadSpinner(option:"1",Message: "")
                            
                            //            let alert = UIAlertController(title: "Message!", message: "Created Successfully", preferredStyle: .alert)
                            //           alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                            //           let next = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                            //                    self.present(next, animated: false, completion: nil)
                            //                            })
                           // self.timeline_id = "\(json["Data"])"
                            
                           // self.g()
                            //                            self.present(alert, animated: true)
                        }
                        else
                        {
                           self.showToast(message: "Error")
                        }
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                    // self.loadSpinner(option:"1",Message: "")
                }
        }
        )
 */
//
//        func newFunc()
//        {
        
        
        if dataArr.count == 0
        {
            if friendArray.count == 0
            {
                withWhom = "0"
            }
            else
            {
                withWhom = "1"
            }
            
           
            
            let params : [String: Any] = [
                "timeline_id" : "0" ,
                "timeline_hotel_name" : searchText.text! ,
                "timeline_description" : someTextView.text!,
                "latitude" :Utils.getPreferenceValue(ForKey: Constant.LATITUDE) ,
                "longitude":Utils.getPreferenceValue(ForKey: Constant.LONGITUDE) ,
                "address":(self.restaurantsArray[PageCur!] as AnyObject).value(forKey: "formatted_address") as! String,
                "friends": friendArray,
                "with_whom":withWhom,
                "created_by":Utils.getPreferenceValue(ForKey: Constant.USER_ID)
                
                
            ]
            
            let urlString = "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_timeline"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json != nil
                {
                    if json["ResponseCode"] == 1
                        
                    {
                        let new = json
                        print(json["Data"])
                        let new1 = json["Data"].string
  //                      timeLineID = new1
//                       Utils.setPreferenceBoolValue(value: "\(new1)", ForKey: Constant.TIMELINE_ID)
                        
                        let params : [String: Any] = [
                            
                            
                            "timeline_id" : new1! ,
                            
                            "created_by":"11"
                            
                            
                        ]
                        
                        
                        
                        
                        Alamofire.upload(
                            multipartFormData: { multipartFormData in
                                
                                
                                //                if(self.imageFilePath != nil)
                                //                {
                                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                                //                }
                                for i in 0..<self.urls.count
                                {
                                    let filedest : URL = self.urls[i] as URL
                                    multipartFormData.append(filedest, withName: "image")
                                }
                                
                                for (key, value) in params {
                                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                }
                                
                                
                                
                        },
                            to: "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_timeline_image",
                            encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseJSON { response in
                                        debugPrint(response)
                                        
                                        // let result = response.result
                                        
                                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
                                        print("JSON : \(datastring)")
                                        let json = JSON(data:response.data!)
                                        // print(json["status"])
                                        
                                        // print(data:response.data!)
                                        if("\(json["ResponseMessage"])" == "success")
                                        {
                                          self.dismiss(animated: false, completion: nil)
                                            
                                            self.showToast(message: "Created Successfully")
                                        }
                                        else
                                        {
                                            // self.loadSpinner(option:"1",Message: "")
                                        }
                                    }
                                    
                                case .failure(let encodingError):
                                    print(encodingError)
                                    // self.loadSpinner(option:"1",Message: "")
                                }
                        }
                        )
                        //self.timelineFunction()
                      //  self.uploadImageAndData()
                        
                    }
                    
                }
                }
            
            
        }
        
        else
        {
            
            if friendDone == "1"
            {
            
            if friendArray.count == 0
            {
                withWhom = "0"
            }
            else
            {
                withWhom = "1"
            }
            }
            else
            {
                if friendArr.count == 0
                {
                    withWhom = "0"
                }
                else
                {
                    withWhom = "1"
                }
            }
            
            
            if self.addressDone == "1"
            {
                self.addressDone = (dataArr[0] as AnyObject).value(forKey: "address") as! String
            }
                
                
            else
            {
                self.addressDone = (self.restaurantsArray[PageCur!] as AnyObject).value(forKey: "formatted_address") as! String
            }
            
            
            let params : [String: Any] = [
                "timeline_id" : timelineId ,
                "timeline_hotel_name" : searchText.text! ,
                "timeline_description" : someTextView.text!,
                "latitude" :Utils.getPreferenceValue(ForKey: Constant.LATITUDE) ,
                "longitude":Utils.getPreferenceValue(ForKey: Constant.LONGITUDE) ,
                "address":self.addressDone,
                "friends": friendArray,
                "with_whom":withWhom,
                "created_by":Utils.getPreferenceValue(ForKey: Constant.USER_ID)
                
                
            ]
            
            let urlString = "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_timeline"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json != nil
                {
                    if json["ResponseCode"] == 1
                        
                    {
                        let new = json
                        print(json["Data"])
                        let new1 = json["Data"].string
                        //                      timeLineID = new1
                        //                       Utils.setPreferenceBoolValue(value: "\(new1)", ForKey: Constant.TIMELINE_ID)
                        
                        let params : [String: Any] = [
                            
                            
                            "timeline_id" : new1! ,
                            
                            "created_by": Utils.getPreferenceValue(ForKey: Constant.USER_ID)
                            
                            
                        ]
                        
                        
                        
                        
                        Alamofire.upload(
                            multipartFormData: { multipartFormData in
                                
                                
                                //                if(self.imageFilePath != nil)
                                //                {
                                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                                //                }
                                for i in 0..<self.urls.count
                                {
                                    let filedest : URL = self.urls[i] as URL
                                    multipartFormData.append(filedest, withName: "image")
                                }
                                
                                for (key, value) in params {
                                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                }
                                
                                
                                
                        },
                            to: "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_timeline_image",
                            encodingCompletion: { encodingResult in
                                switch encodingResult {
                                case .success(let upload, _, _):
                                    upload.responseJSON { response in
                                        debugPrint(response)
                                        
                                        // let result = response.result
                                        
                                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
                                        print("JSON : \(datastring)")
                                        let json = JSON(data:response.data!)
                                        // print(json["status"])
                                        
                                        // print(data:response.data!)
                                        if("\(json["ResponseMessage"])" == "success")
                                        {
                                            self.dismiss(animated: false, completion: nil)
                                            
                                            self.showToast(message: "Created Successfully")
                                        }
                                        else
                                        {
                                            // self.loadSpinner(option:"1",Message: "")
                                        }
                                    }
                                    
                                case .failure(let encodingError):
                                    print(encodingError)
                                    // self.loadSpinner(option:"1",Message: "")
                                }
                        }
                        )
                      
                        
                    }
                    
                }
            }
            
        }
                
                
            }
//        }

        
        
    
    
    
    func uploadImageAndData(){
      
        
//        if  (self.dataArray[sender.tag] as AnyObject).value(forKey: "whom_count") as! Int == 0
//        {
//            self.withWhom = "0"
//            
//        }
//        else
//        {
//            for i in 0..<((self.dataArray[sender.tag] as AnyObject).value(forKey: "whom") as! NSArray).count
//            {
//                friendArray.append(((dataArray[sender.tag] as AnyObject).value(forKey: "whom") as NSArray).value(forKey: "timeline_id") as! String)
//                print(self.friendArray)
//            }
//            self.withWhom = "1"
//        }
//        
//        let params : [String: Any] = [
//            "timeline_id" : (self.dataArray[sender.tag] as AnyObject).value(forKey: "timeline_id") as! String ,
//            "timeline_hotel_name" : "",
//            "timeline_description" : (self.dataArray[sender.tag] as AnyObject).value(forKey: "timeline_description") as! String,
//            "latitude" :Utils.getPreferenceValue(ForKey: Constant.LATITUDE) ,
//            "longitude":Utils.getPreferenceValue(ForKey: Constant.LONGITUDE) ,
//            "address":(self.dataArray[sender.tag] as AnyObject).value(forKey: "address") as! String,
//            "friends": self.friendArray,
//            "with_whom":self.withWhom,
//            "created_by":Utils.getPreferenceValue(ForKey: Constant.USER_ID)
//            
//            
//        ]
//        
//        let urlString = "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_timeline"
//        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
//            let result = response.result
//            let json = JSON(data: response.data!)
//            
//            if json != nil
//            {
//                if json["ResponseCode"] == 1
//                    
//                {
//                    let new = json
//                    print(json["Data"])
//                    let new1 = json["Data"].string
//                    //                      timeLineID = new1
//                    //                       Utils.setPreferenceBoolValue(value: "\(new1)", ForKey: Constant.TIMELINE_ID)
//                    
//                }
//            }
//        }
       
        
    }

    
    @IBAction func closeAct(_ sender: UIButton) {
        
       // outerView.isHidden = true
        followView.isHidden = true
    }
    
    @IBAction func doneAct(_ sender: UIButton) {
        
        friendDone = "1"
        if self.friendArray.count == 1
        {
            self.friendsView.text = "With - \(self.friendNames[0] as! String)"
        }
        else if self.friendArray.count == 2
        {
            self.friendsView.text = "With - \(self.friendNames[0] as! String) and \(self.friendNames[1] as! String) "
        }
        else
        {
            self.friendsView.text = "With - \(self.friendNames[0] as! String) and \(self.friendNames.count - 1) others"
        }
        
        if PhotoArray1.count != 0 || PhotoArray.count != 0
        {
            self.someTextView.frame = CGRect(x:10,y:self.photoView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
            self.friendsView.isHidden = false
        }
        else
        {
            if friendArray.count != 0
            {
                self.someTextView.frame = CGRect(x:10,y:self.friendsView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
                self.friendsView.isHidden = false
            }
        }
        
        self.followView.isHidden = true
    }
    
    @objc func selectAct(sender : UIButton!)
    {
        
        let cell = followTable.cellForRow(at: IndexPath(row :sender.tag,section :0)) as! followtableViewCell
        //        friendArray.add((followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
        //        print(friendArray)
        
        
        if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
            friendArray.add((followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
            friendNames.add("\(String(describing: (followArray[sender.tag] as AnyObject).value(forKey: "first_name")!))  \((followArray[sender.tag] as AnyObject).value(forKey: "last_name")!)")
            
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
    
   
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Write something about this event"
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
            textView.text = "Write something about this event"
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let dict = self.restaurantsArray[indexPath.row]
        searchText.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        
        collectTable.isHidden = true
        someTextView.isHidden = false
        searchBtn.isHidden = true
        editbtn.isHidden = false
        bottomView.isHidden = false
        someTextView.isHidden = false
        photoView.isHidden = false
        pageCtrl.isHidden = false
        self.addressDone = "2"
        if PhotoArray1.count != 0 || PhotoArray.count != 0
        {
            self.someTextView.frame = CGRect(x:10,y:self.photoView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
            self.friendsView.isHidden = false
        }
        else
        {
            if friendArray.count != 0
            {
                self.someTextView.frame = CGRect(x:10,y:self.friendsView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
                self.friendsView.isHidden = false
            }
            else
            {
                self.friendsView.isHidden = true
            }
        }
        
        
        resignFirstResponder()
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
    
    @IBAction func editAct(_ sender: UIButton) {
        
        searchPlaceFromGoogle(place: placeName)
        searchText.text = placeName
        someTextView.isHidden = true
        collectTable.isHidden = false
        photosCollectionView.isHidden = true
        friendsView.isHidden = true
        editbtn.isHidden = true
        searchBtn.isHidden = false
        pageCtrl.isHidden = true
       // collectTable.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       
       // self.photosCollectionView.reloadData()
        callUrl()
    }
    
    @IBOutlet weak var addFollowers: UIButton!
    
    @IBAction func addFollowers(_ sender: UIButton) {
      
        followView.isHidden = false
        
    
    }
    
  
    
    
    func callUrl()
    {
        for i in 0..<PhotoArray.count
        {
            
            let seleImg_Data = UIImageJPEGRepresentation(PhotoArray[i] , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            print("the img str : \(base64_str?.characters.count)")
            //img1.image = imag
            // editView.isHidden = true
            imgStr = base64_str!
            
            
            
            if(self.imgStr != "")
            {
                let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
                let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("prevemp\(a).jpg")
                dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                // let fileDestinationUrl1 : URL = self.urls[i] as URL
                // urls.removeAll()
                urls.append(fileDestinationUrl2 as NSURL)
                print(urls)
                a = 1
                //multipartFormData.append(fileDestinationUrl1, withName: "image")
            }
        }
        
        photosCollectionView.reloadData()
    }
    @IBAction func choosePic(_ sender: UIButton) {
        
                self.act = "0"
                let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))
        
                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallary()
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
    
    
        func openCamera()
        {
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
        func openGallary()
        {
//            PhotoArray.removeAll()
//            urls.removeAll()
            let vc = BSImagePickerViewController()
    
            bs_presentImagePickerController(vc, animated: true,
                                            select: { (asset: PHAsset) -> Void in
                                                // User selected an asset.
                                                // Do something with it, start upload perhaps?
            }, deselect: { (asset: PHAsset) -> Void in
                // User deselected an assets.
                // Do something, cancel upload?
            }, cancel: { (assets: [PHAsset]) -> Void in
                // User cancelled. And this where the assets currently selected.
            }, finish: { (assets: [PHAsset]) -> Void in
    
                for i in 0..<assets.count
                {
    
                    self.SelectedAssets.append(assets[i])
    
                }
    
    
                self.convertAssetsToImages()
                
            }, completion: nil)
            
            self.photosCollectionView.isHidden = false
            self.photoView.isHidden = false
            self.photoView.frame = CGRect(x:10,y:self.friendsView.frame.maxY + 30 ,width:self.photoView.frame.size.width,height:self.photoView.frame.size.height)
            self.someTextView.frame = CGRect(x:10,y:self.photoView.frame.maxY + 30 ,width:self.someTextView.frame.size.width,height:self.someTextView.frame.size.height)
    
    
        }
    
    
    
        func convertAssetsToImages()
        {
            if SelectedAssets.count != 0
            {
                for i in 0..<SelectedAssets.count
                {
                    let manager = PHImageManager.default()
                    let request = PHImageRequestOptions()
    
                    var thumbnail = UIImage()
    
                    manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width : 500, height :500), contentMode: .aspectFill, options: nil, resultHandler: {( result,info )-> Void in
                        thumbnail = result!
    
    
                    })
    
                    let data = UIImageJPEGRepresentation(thumbnail, 1)
    
                    let newImage = UIImage(data :data!)
    
    
  
                    PhotoArray.append(newImage!)
    
                   
                 
                 //   self.photosCollectionView.reloadData()

                    
                    
                    
    
    }
    
    
    
    
    
            }
    
    
         
         
    
    
        }
    
    
    
    
    
    
    
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    
    
    
           // picker.dismiss(animated: true, completion: nil)
            if var imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
    
    
    //            let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
    
            let seleImg_Data = UIImageJPEGRepresentation(imag , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
                imgStr = base64_str!
            print("the img str : \(base64_str?.characters.count)")
    
        }
        }
    
    
    
        func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
            let size = image.size
    
            let widthRatio  = targetSize.width  / image.size.width
            let heightRatio = targetSize.height / image.size.height
    
            // Figure out what our orientation is, and use that to form the rectangle
            var newSize: CGSize
            if(widthRatio > heightRatio) {
                newSize = CGSize(width: size.width * heightRatio,height: size.height * heightRatio)
            } else {
                newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
            }
    
            // This is the rect that we've calculated out and this is what is actually used below
            let rect = CGRect(x:0,y:0, width:newSize.width, height: newSize.height)
    
            // Actually do the resizing to the rect using the ImageContext stuff
            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
    
            return newImage!
        }
        func getDirectoryPath() -> String {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            return documentsDirectory
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

//extension UIView
//{
//
//    func addShadowViewProfile() {
//        //Remove previous shadow views
//        superview?.viewWithTag(119900)?.removeFromSuperview()
//
//        //Create new shadow view with frame
//        let shadowView = UIView(frame: frame)
//        shadowView.tag = 119900
//        shadowView.layer.shadowColor = UIColor.black.cgColor
//        shadowView.layer.shadowOffset = CGSize(width: 2, height: 3)
//        shadowView.layer.masksToBounds = false
//
//        shadowView.layer.shadowOpacity = 0.3
//        shadowView.layer.shadowRadius = 3
//        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        shadowView.layer.rasterizationScale = UIScreen.main.scale
//        shadowView.layer.shouldRasterize = true
//
//        superview?.insertSubview(shadowView, belowSubview: self)
//    }
//}

