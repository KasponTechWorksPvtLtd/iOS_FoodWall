//
//  TimelineDetailViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 09/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TimelineDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource ,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var postText: UITextView!
    var imgCount : Int = 0
      var dataArray : NSArray = []
    var ImageArray : NSArray = []
     var myIndex : Int = 0
    var ImageFilter : NSMutableArray = []
    var looPValue : Int = 10
    var imgString : String = ""
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    var timeLine_id : String = ""
    var user_id : String = ""
    var time = 0
    var timer = Timer()
    var imgStr :String = ""
    var storyImage : UIImage = UIImage(named : "default")!
    var progressView: UIProgressView?
    @IBOutlet weak var uploadStoryView: UIView!
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var profname: UILabel!
    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var headerView: UIView!
    var testArray : NSArray = []
    var testArray1 : NSArray = []
    var progressValue : CGFloat = 0.1
    var countValue : Int = 0
    let imagePicker = UIImagePickerController()
    //let label1 = UILabel()
    @IBOutlet weak var optionMenu: UIButton!
    @IBOutlet weak var proGRssView: UIProgressView!
    @IBOutlet weak var progrssView: UIProgressView!
    var a : Int = 0
    var b : Int = 0
    var storyId : String = ""
    var edit : Int = 0
    var searchLocation : String = ""
    @IBOutlet weak var timelineTable: UITableView!
    
    
    var searchingdetailarray = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //search
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            headerView.isHidden = true
            
            timelineTable.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            timelineTable?.translatesAutoresizingMaskIntoConstraints = true
            headerView.addDropShadowToView(targetView: headerView)
             timelineFunctionCommonSearch()
            timelineTable.reloadData()



        }
        else {
            headerView.isHidden = false
            timelineTable.frame.size.width = self.timelineTable.frame.size.width
            timelineTable.frame.size.height = self.timelineTable.frame.size.height
            timelineTable.isHidden = false
            timelineTable?.translatesAutoresizingMaskIntoConstraints = false
            timelineTable.reloadData()
            headerView.addShadowView()
        
        }
        //search
        
       
        
        
        //progressView1.frame.size.width = 400.0
       // self.progressView1.transform = CGAffineTransform(scaleX: 1, y: 3)
       // label1.frame = CGRect(x:100,y:self.statusImage.frame.maxY + 30,width : 150,height :40)
        //label1.textColor = UIColor.lightGray
        progrssView.isHidden = false
        locationLabel.layer.cornerRadius = 5.0
        locationLabel.clipsToBounds = true
        proGRssView.isHidden = true
        imagePicker.delegate = self
        if b == 1
        {
        //statusViewAct()
            statusView.isHidden = false
            uploadStoryView.isHidden = true
            profname.numberOfLines = 0
            profname.lineBreakMode = NSLineBreakMode.byWordWrapping
            profImage.layer.cornerRadius = profImage.frame.size.width/2
            profImage.clipsToBounds = true
            self.postText.textColor = UIColor.white

           statusView.isHidden = false
           countValue = testArray1.count - (a)
            print(countValue)
          // secValue = countValue * 10
           timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TimelineDetailViewController.actions), userInfo: nil, repeats: true)
           //self.progressView1.setProgress(0.0, animated: true)
           
           // print(secValue)
//                i = a
//
//            }
           // self.view.addSubview(statusImage)
        }
        else if b == 2{
            
           
//            uploadStoryView.isHidden = false
            //uploadImage.image = storyImage
            statusView.isHidden = true
            uploadImage.isHidden = false
            
//            uploadImage.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.STORY_IMAGE)), placeholderImage: UIImage(named: "default"))
            uploadImage.image = storyImage
            
            UserDefaults.standard.register(defaults: ["key":UIImageJPEGRepresentation(uploadImage.image!, 100)!])
            UserDefaults.standard.set(UIImageJPEGRepresentation(uploadImage.image!, 100), forKey: "key")
        
            let seleImg_Data = UIImageJPEGRepresentation(uploadImage.image! , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            imgStr = base64_str!
            // display the image
            
            
//            imagePicker.allowsEditing = false
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//            present(imagePicker, animated: true, completion: nil)
        }
        else if b == 3
        {
            statusView.isHidden = true
            uploadImage.isHidden = false
            if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
                let imageFromData = UIImage(data: imageData)
                //mLogoImageView.image = imageFromData!
                uploadImage.image = imageFromData
               // let reduced_sizeImg:UIImage = RBResizeImage(image: postIMage.image! ,targetSize: CGSize(width:500,height:500))
                            let seleImg_Data = UIImageJPEGRepresentation(uploadImage.image! , 1)
                            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
                            imgString = base64_str!
            }
        }
        
        else
        {
            statusView.isHidden = true
            uploadStoryView.isHidden = true
            //self.view.removeFromSuperview(statusImage)
         //   timelineFunction()
             timelineFunctionCommonSearch()
            
        }
        
        
        postText.delegate = self
        postText.text = "Add caption"
        postText.textColor = UIColor.lightGray
        timelineTable.delegate = self
        timelineTable.dataSource = self
        headerView.addShadowView()
        timelineTable.tableFooterView = UIView()
        locationLabel.text = searchLocation
            
            
     
      //  uploadImage.image = Utils.getPreferenceValue(ForKey: Constant.STORY_IMAGE)
//        var mLogoImageView = UIImageView()
//
//        if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
//            let imageFromData = UIImage(data: imageData)
//            mLogoImageView.image = imageFromData!
//            uploadImage.image = mLogoImageView.image
//        }

        // Do any additional setup after loading the view.
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
//            let imageFromData = UIImage(data: imageData)
//            //mLogoImageView.image = imageFromData!
//            uploadImage.image = imageFromData
//        }
//    }
    
    @IBAction func searchAct(_ sender: UIButton) {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "searchView") as! SearchViewController
        
        self.present(page, animated: false, completion: nil)
        
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
        
        self.present(page, animated: false, completion: nil)
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Add caption"
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
            textView.text = "Add caption"
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
    
    
    @objc func actions()
    {
      if a < testArray1.count
      {
       
       if time != 20
        
       {
        
//        var progressView: UIProgressView?
//        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
//       // progressView?.center = self.view.center
//        progressView?.frame = CGRect(x:10,y:30,width:375,height:4)
//        progressView?.progressTintColor = UIColor.white
//        progressView?.trackTintColor = UIColor.orange
        self.progrssView?.transform = CGAffineTransform(scaleX: 2, y: 3)
        progrssView?.setProgress(Float(progressValue), animated: true)
       // proGRssView.setProgress(Float(progressValue), animated: true)
        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == (self.testArray1[self.a] as! AnyObject).value(forKey: "created_by") as! String
        {
        self.optionMenu.isHidden = true
        }
        else
        {
            self.optionMenu.isHidden = false
        }
        self.statusImage.sd_setImage(with: URL(string: (self.testArray1[self.a] as! AnyObject).value(forKey: "stories_image") as! String), placeholderImage: UIImage(named: "default"))
        self.profImage.sd_setImage(with: URL(string: (self.testArray1[self.a] as! AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
        let createdDAte = (self.testArray1[self.a] as! AnyObject).value(forKey: "created_on") as! String
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate1 = dateFormatterr.date(from: createdDAte)!
        let dateString = myDate1.timeAgoDisply()
        self.profname.text = "\((self.testArray1[self.a] as! AnyObject).value(forKey: "first_name") as! String)  \(dateString)"
        self.label1.numberOfLines = 0
        self.label1.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.label1.text = (self.testArray1[self.a] as! AnyObject).value(forKey: "stories_description") as! String
        storyId = (self.testArray1[self.a] as! AnyObject).value(forKey: "stories_id") as! String
        time = time + 1
        progressValue = progressValue + 0.05
      
       }
        
        else
       {
        
        a = a + 1
        time = 0
       // proGRssView.isHidden = false
       // progrssView?.setProgress(Float(0.0), animated: true)
        progressValue = 0.0
        progrssView?.setProgress(Float(progressValue), animated: false)
        }
        
       //self.progressView1.setProgress(0.0, animated: true)
        }
        
      else{
        
        timer.invalidate()
        let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
        
        self.present(page, animated: false, completion: nil)
        }
    
    }

    
    @IBAction func POSTACT(_ sender: UIButton) {
      if edit == 0
      {
        let story_id = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let storyDescription:Data = postText.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
     
        
        
        let ImageExists:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let createdBY:Data = Utils.getPreferenceValue(ForKey: Constant.USER_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!
       
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                //                if(self.imageFilePath != nil)
                //                {
                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                //                }
                
                if(self.imgString != "")
                {
                    let dataDecoded2:NSData = NSData(base64Encoded: (self.imgString ), options: NSData.Base64DecodingOptions(rawValue: 1))!
                    let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("prevemp1.jpg")
                    dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                    
                    multipartFormData.append(fileDestinationUrl2, withName: "image")
                }
                    
                else
                {
                    print("Nothing")
                }
                multipartFormData.append(story_id, withName: "stories_id")
                multipartFormData.append(storyDescription, withName: "stories_description")
               
                multipartFormData.append(ImageExists, withName: "image_exists")
                multipartFormData.append(createdBY, withName: "created_by")
                
                
                
        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_STORY)",
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
                           self.showToast(message: "Created Story Successfully")
                            let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                            
                            self.present(page, animated: false, completion: nil)
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
        
        else
      {
        
        let story_id = self.storyId.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let storyDescription:Data = self.label1.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        
        
        let ImageExists:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let createdBY:Data = Utils.getPreferenceValue(ForKey: Constant.USER_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                //                if(self.imageFilePath != nil)
                //                {
                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                //                }
                
                if(self.imgStr != "")
                {
                    let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
                    let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("prevemp1.jpg")
                    dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                    
                    multipartFormData.append(fileDestinationUrl2, withName: "image")
                }
                    
                else
                {
                    print("Nothing")
                }
                multipartFormData.append(story_id, withName: "stories_id")
                multipartFormData.append(storyDescription, withName: "stories_description")
                
                multipartFormData.append(ImageExists, withName: "image_exists")
                multipartFormData.append(createdBY, withName: "created_by")
                
                
                
        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_STORY)",
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
                            self.showToast(message: "Edited Story Successfully")
                            let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                            
                            self.present(page, animated: false, completion: nil)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer.invalidate()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(TimelineDetailViewController.actions), userInfo: nil, repeats: true)
    }
    

    @IBAction func create_stories(_ sender: UIButton) {
        
      
      
        let storyId:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let stories_Description:Data = postText.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let Address:Data = "new address".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let Area:Data = "chennai".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let City:Data = "chennai".data(using: String.Encoding.utf8, allowLossyConversion: false)!
       
        let image_Exists:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let created_By:Data = Utils.getPreferenceValue(ForKey: Constant.USER_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                //                if(self.imageFilePath != nil)
                //                {
                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                //                }
                
                if(self.imgStr != "")
                {
                    let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
                    let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("prevemp1.jpg")
                    dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                    
                    multipartFormData.append(fileDestinationUrl2, withName: "image")
                }
               
             
                multipartFormData.append(storyId, withName: "stories_id")
                multipartFormData.append(stories_Description, withName: "stories_description")
                multipartFormData.append(City, withName: "city")
                multipartFormData.append(Address, withName: "address")
                multipartFormData.append(Area, withName: "area")
                multipartFormData.append(image_Exists, withName: "image_exists")
                multipartFormData.append(created_By, withName: "created_by")
                
                
        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_STORY)",
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
                            self.showToast(message: "Created Story Successfully")
                            let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                            
                            self.present(page, animated: false, completion: nil)
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
   
    
    @IBAction func closeAct(_ sender: UIButton) {
        
//        let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
//
//        self.present(page, animated: false, completion: nil)
        timer.invalidate()
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            //self.openCamera()
            
            self.uploadStoryView.isHidden = false
            self.statusView.isHidden = true
            self.uploadImage.image = self.statusImage.image
            self.postText.text! = self.label1.text!
            self.postText.textColor = UIColor.darkGray
            self.edit = 1
            let reduced_sizeImg:UIImage = self.RBResizeImage(image: self.uploadImage.image!,targetSize: CGSize(width:200,height:200))
            
            let seleImg_Data = UIImageJPEGRepresentation(reduced_sizeImg , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            self.imgStr = base64_str!
            
                 }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            
            
            
            let params: [String:String] = ["stories_id" : self.storyId,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_STORIES)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                
                let result = response.result
                
                let json = JSON(data: response.data!)
                
                if result != nil{
                    if   json["ResponseCode"] ==  1
                    {
                        self.showToast(message: "Deleted Successfully")
                        
                        let page = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                        
                        self.present(page, animated: false, completion: nil)
                        print("success")
                        // self.dataArray1 = innerDict as! NSArray
                        
                        // self.tableView.reloadData()
                        
                        
                        
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
    
    
    
    
    
    @IBAction func backAct(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
            
            if imgCount == 0
            {
                
                return 1
            }
                
            else if testArray != nil
            {
                return (testArray[myIndex] as AnyObject).count!
                
            }
            else
            {
                return 0
            }
            
        
    }
    
   
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "timelinecell", for: indexPath) as! timelineTableViewCell
        let dict = dataArray[indexPath.row] as! NSDictionary
       
       // cell.addShadowView()
        
        let createdTime = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatterr.date(from: createdTime)!
        cell.daysAgo.text! =  myDate.timeAgoDisplay()
        
        
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
           cell.postLabel.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)  Posts"
        
        }
        else {
            cell.postLabel.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)  Posts ,\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String) Followers"
        }
        
        
        
        //        cell.totalLikes.text! = "\(dict.value(forKey: "total_likes") as! String) likes"
        
        let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "timeline_description")!)" as NSString

        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])

        let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]

        // Part of string to be bold
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
        
        if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "tl_likes")!)" == "0"
        {
            
            cell.likeBUtton.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            
        }
            
            
        else
        {
            
            cell.likeBUtton.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
        }
        
        
        cell.descText.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String)\("")\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String)  \(dict.value(forKey: "timeline_description") as! String)"
        cell.descText.attributedText = attributedString
        
//        if  "\(dict.value(forKey: "total_comments") as! String)" == "0"
//
//        {
//
//            cell.totalComments.isHidden = true
//
//        }
//
//        else  if  "\(dict.value(forKey: "total_comments") as! String)" == "1"
//
//        {
//
//            cell.totalComments.isHidden = false
//            cell.totalComments.text! = "View 1 Comment"
//
//        }
//
//        else
//        {
//            cell.totalComments.text! = "View All \(dict.value(forKey: "total_comments") as! String) Comments"
//
//        }

        if  "\(dict.value(forKey: "total_likes") as! String)" == "0"

        {

            cell.nooflikes.isHidden = true

        }


        else if  "\(dict.value(forKey: "total_likes") as! String)" == "1"

        {

            cell.nooflikes.isHidden = false
            cell.nooflikes.text! = "\(dict.value(forKey: "total_likes") as! String) like"

        }


        else
        {
            cell.nooflikes.isHidden = false
            cell.nooflikes.text! = "\(dict.value(forKey: "total_likes") as! String) likes"

        }
        
        
        cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String)\(" ")\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String)"
        
//        cell.commentTextView.delegate = self
//        cell.commentTextView.text = "Add a comment"
//        cell.commentTextView.textColor = UIColor.lightGray
//
//        // cell.commentTextView.delegate = self
//
//        cell.postCommentButton.tag = indexPath.row + 3000
//        cell.postCommentButton.addTarget(self, action: #selector(postCommentBUTTON), for: .touchUpInside)
//        cell.postCommentButton.applyGradient()
//
//        cell.likeButton.tag = indexPath.row + 2000
//        cell.likeButton.addTarget(self, action: #selector(likeBUTTON), for: .touchUpInside)
//
//        cell.commentButton.tag = indexPath.row + 1000
//        cell.commentButton.addTarget(self, action: #selector(commentBUTTON), for: .touchUpInside)
//        cell.viewallButton.tag = indexPath.row
//        cell.viewallButton.addTarget(self, action: #selector(ViewAction), for: .touchUpInside)
//        cell.optionmenu.tag = indexPath.row
//        cell.optionmenu.addTarget(self, action: #selector(optionMenuAction), for: .touchUpInside)
//        cell.profilePageBUtton.tag = indexPath.row + 4000
//        cell.profilePageBUtton.addTarget(self, action: #selector(profilePageDisplay), for: .touchUpInside)
//
        
//        if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_by") as! String)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
//        {
//            cell.commentsNewText.isHidden = false
//            // cell.commentsNewText.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "tl_comments") as! String)"
//
//        }
//
//        else
//        {
//
//            cell.commentsNewText.isHidden = true
//        }
//
//
//        cell.commentimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "default"))
//
        cell.userImage.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
        
        testArray = ImageArray.value(forKey: "img") as! NSArray
        
        // imgCount = (((dataArray[indexPath.row] as AnyObject).value(forKey: "image_count") as! NSNumber))
        imgCount = Int((dataArray[indexPath.row] as! NSDictionary).value(forKey: "image_count") as! NSNumber)
        
        myIndex = indexPath.row
        cell.collectionview1.delegate = self
        cell.collectionview1.dataSource = self
        cell.collectionview1.reloadData()
        
        
        return cell
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        
        
        // picker.dismiss(animated: true, completion: nil)
        if var imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            
            
            let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
            
            let seleImg_Data = UIImageJPEGRepresentation(reduced_sizeImg , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            imgStr = base64_str!
            print("the img str : \(base64_str?.characters.count)")
            uploadImage.image = imag
            
            picker.dismiss(animated: true, completion: nil)
            
            
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
            let cell :imageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! imageCollectionCell
            
            
            if imgCount == 0
            {
                
                let imageUrl1 = ""
                cell.imgeView.sd_setImage(with: URL(string: imageUrl1 as! String), placeholderImage: UIImage(named: "img1"))
            }
            else
            {
                let imageUrl1 = (testArray[myIndex] as! NSArray)[indexPath.row]
                
                
                cell.imgeView.sd_setImage(with: URL(string: imageUrl1 as! String), placeholderImage: UIImage(named: "img1"))
            }
            
            return cell
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return  CGSize(width: self.view.frame.width, height: 250)
        
        
        
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

    
    
    
    func timelineFunction()
    {
        
        let params: [String:String] = ["timelineid" : timeLine_id,"userid" :user_id]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_TIMELINE_SINGLE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
//            if var dict = result.value as? Dictionary<String,AnyObject>{
//                if  let innerDict = dict["Data"]{
//                    self.dataArray = innerDict as! NSArray
//
//                    if self.dataArray != nil{
//                        self.ImageArray = self.dataArray.value(forKey: "image") as! NSArray
//
//                        self.timelineTable.reloadData()
//                    }
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray = (resData as! NSArray)
                
                if(self.dataArray.count != 0){
                    
                    
                    print("Nodata")
                    self.ImageArray = self.dataArray.value(forKey: "image") as! NSArray
                    
                    self.timelineTable.reloadData()
                    
                }
            }
            
                    //                    for i in 0..<(((ImageArray[indexPath.row] as AnyObject).value(forKey: "image")) as! NSArray).count
                    //                    {
                    //                        ImageFilter.add(((ImageArray[indexPath.row] as AnyObject).value(forKey: "img") as! NSArray)[i] as! NSString)
                    //                        // imgCount = (((dataArray[indexPath.row] as AnyObject).value(forKey: "image_count") as! NSNumber))
                    //
                    //                        print(self.ImageFilter)
                    //                        //        }
                    //                    }
                    
                    
                    for i in 0..<json["Data"].count
                    {
                        
                        print(json["Data"][i]["image_count"])
                        self.ImageFilter.add(json["Data"][i]["image_count"])
                    }
                    
                }
            }
            
   //   timelineFunctionCommonSearch()
    
    func timelineFunctionCommonSearch()
    {
        
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let username = "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"
        let parameters = ["userid": username,"search_text" : searchtext]
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)", method: .post, parameters: parameters).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            //            if var dict = result.value as? Dictionary<String,AnyObject>{
            //                if  let innerDict = dict["Data"]{
            //                    self.dataArray = innerDict as! NSArray
            //
            //                    if self.dataArray != nil{
            //                        self.ImageArray = self.dataArray.value(forKey: "image") as! NSArray
            //
            //                        self.timelineTable.reloadData()
            //                    }
            
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
                    print("\((((self.searchingdetailarray[0] as AnyObject).value(forKey: "people") as! NSArray)))")
                    
                    
                    
                    
                    self.dataArray = (((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray))
                    
                    print("\((((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                    print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                    
                    print("\((((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                    print("\((((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                    if(self.dataArray.count != 0){
                        var  searchvalue =  ((self.dataArray[0] as AnyObject).value(forKey: "search_val") as! String)
                        
                        if searchvalue != "0"
                        {
                            print("Nodata")
                            self.ImageArray = self.dataArray.value(forKey: "image") as! NSArray
                            
                            self.timelineTable.reloadData()
                            
                            
                            for i in 0..<json["Data"].count
                            {
                                
                                print(json["Data"][i]["image_count"])
                                self.ImageFilter.add(json["Data"][i]["image_count"])
                            }
                            
                            
                        }
                        else {
                            
                        }
                        
                       
                    }
                    
                    
                    //  self.nochatlable.isHidden = false
                    
                    // self.Mytable.isHidden = false
                    
                }
                else {
                    //  self.Mytable.isHidden = true
                    // self.showToast(message: "No search found!!!")
                    // self.indicator.stopAnimating()
                }
            }
            else {
                //   self.indicator.stopAnimating()
                // self.showToast(message: "No search found!!!")
                //  self.nochatlable.isHidden = true
                print("No data")
            }
            
            
            
            //                    for i in 0..<(((ImageArray[indexPath.row] as AnyObject).value(forKey: "image")) as! NSArray).count
            //                    {
            //                        ImageFilter.add(((ImageArray[indexPath.row] as AnyObject).value(forKey: "img") as! NSArray)[i] as! NSString)
            //                        // imgCount = (((dataArray[indexPath.row] as AnyObject).value(forKey: "image_count") as! NSNumber))
            //
            //                        print(self.ImageFilter)
            //                        //        }
            //                    }
            
           
            
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
