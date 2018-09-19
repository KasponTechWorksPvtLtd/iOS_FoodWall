//
//  EventsDetailedController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 24/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import MXParallaxHeader
import Alamofire
import SwiftyJSON



class EventsDetailedController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,HeightForTextView ,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postView: UIView!
    var myValueInt = 0
     var textViewHeight = CGFloat()
    var commentsData : String = ""
    var timeAgoText : String = ""
    var dataArr :NSArray = []
    var dataArray = [[String:AnyObject]]()
     var cohostArray = [[String:AnyObject]]()
    var a : Int = 1
    var b : Int = 1
    var extendHeight : CGFloat = 0.0
    var  commentID : String = ""
    var editedComment : String = ""
    weak var headerImageView: UIView?
    let topicView = UILabel()
   // @IBOutlet var newTable: UITableView!
    let preImage = UIImageView()
    var userid :String = ""
    var eventID : String = ""
    var action1 : String = ""
    var rowNumber : Int = 0
     let imagePicker = UIImagePickerController()
    var discuss_type : String = "1"
   
    
 
    
    @IBOutlet weak var postHeaderView: UIView!
    
    @IBOutlet weak var scroll: UIScrollView!
    //  var timeAgoText: String = ""
    
    @IBOutlet weak var textView1: UITextView!
    
    
    @IBOutlet weak var userImageBtn: UIButton!
    
   // @IBOutlet weak var postHeaderView: UIView!
    @IBOutlet weak var uploadImage: UIImageView!
    
    @IBOutlet var newTable: UITableView!
    var imgStr : String = ""
    var ab : Int = 1
    var pageCUR : Int = 0
    
    var postArray : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.clipsToBounds = true

        if eventID == ""
        {
         getCohosts()
        }
        else{
            getEventSingle()
        }
        newTable.delegate = self
        newTable.dataSource = self
        scroll.delegate = self
        textView1.tag = 1
       // postHeaderView.add
        imagePicker.delegate = self
      //  postHeaderView.addDropShadowToView(targetView: postHeaderView)
//        newTable.estimatedRowHeight = 170.0
//        newTable.rowHeight = UITableViewAutomaticDimension
        
        setParallaxHeader()
       // eventDetailCall()
        textView1.delegate = self
        textView1.text = "Write something"
        textView1.textColor = UIColor.lightGray
        extendHeight = 550.0
       // var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        if ab == 0
        {
            postView.isHidden = false
            textView1.text = (postArray[pageCUR] as AnyObject).value(forKey: "dis_description") as! String
           userImage.sd_setImage(with: URL(string:(postArray[pageCUR] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "img1"))
            
            if "\((postArray[pageCUR] as AnyObject).value(forKey: "dis_image") as! String)" != "0"
            {
       
            uploadImage.sd_setImage(with: URL(string:(postArray[pageCUR] as AnyObject).value(forKey: "dis_image") as! String), placeholderImage: UIImage(named: "img1"))
            }
            
        }
    

        // Do any additional setup after loading the view.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if ab == 0
        {
             postView.isHidden = false
        }
        else
        {
        postView.isHidden = true
        }
        
//        let cell = newTable.cellForRow(at: IndexPath(row : 0,section : 0)) as! EventsDetailedViewCell
//        self.view.addSubview(cell.backBUTTON)
        newTable.estimatedRowHeight = 55.0
        newTable.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getEventSingle()
    {
        Utils.svprogressHudShow(title: "Loading...", view: self)
       
//        indicator1.hidesWhenStopped = true
//        indicator1.startAnimating()
        let params: [String:String] = ["userid" : (Utils.getPreferenceValue(ForKey: Constant.USER_ID)),"eventid" : eventID]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENT_SINGLE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArr = resData as! [[String:AnyObject]] as NSArray
                
                if(self.dataArr.count != 0){
                    
                    
                    print(self.dataArr)
//                    self.indicator1.stopAnimating()
                  
                    Utils.svprogressHudDismiss(view: self)
                    self.newTable.reloadData()
                    
                }
                    
                else
                    
                {
                    
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator1.stopAnimating()
                    print("NIthya")
                    
                    
                    
                }
            }
            
            
        }
       
    }
    
    @IBAction func viewAllAct(_ sender: UIButton) {
        
        postView.isHidden = false
    }
    
    @IBAction func postAct(_ sender: UIButton) {
        if ab != 0
        {
        
        var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        
        let discss_id = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
            let Event_id:Data = ((dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as AnyObject).value(forKey: "event_id")! as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let DiscussType:Data = discuss_type.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let discussDesc:Data = textView1.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let imageStatus:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let ImageExists:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let createdBy:Data = ((dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as AnyObject).value(forKey: "created_by")! as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let Deleted:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            
            Utils.svprogressHudShow(title: "Loading...", view: self)
        
//            indicator1.hidesWhenStopped = true
//            indicator1.startAnimating()
//
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
                multipartFormData.append(discss_id, withName: "discss_id")
                multipartFormData.append(Event_id, withName: "event_id")
                multipartFormData.append(DiscussType, withName: "discuss_type")
                multipartFormData.append(discussDesc, withName: "dis_description")
                multipartFormData.append(imageStatus, withName: "img_status")
                multipartFormData.append(Deleted, withName: "deleted")
                multipartFormData.append(ImageExists, withName: "image_exists")
                multipartFormData.append(createdBy, withName: "created_by")
               
                
                
        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_POST)",
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
                         
                            Utils.svprogressHudDismiss(view: self)
                           // self.indicator1.stopAnimating()
                            let alert = UIAlertController(title: "Message!", message: "Posted successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                                let next = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                                self.present(next, animated: false, completion: nil)
                            })
                            self.present(alert, animated: true)
                        }
                        else
                        {
                       
                            Utils.svprogressHudDismiss(view: self)
                           // self.indicator1.stopAnimating()
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
            
            
            let discss_id = ((postArray[pageCUR] as AnyObject).value(forKey: "dis_evt_id") as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            let Event_id:Data = ((postArray[pageCUR] as AnyObject).value(forKey: "event_id") as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            let DiscussType:Data = discuss_type.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            let discussDesc:Data = textView1.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            let imageStatus:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
            let ImageExists:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
            let createdBy:Data = ((postArray[pageCUR] as AnyObject).value(forKey: "created_by") as! String).data(using: String.Encoding.utf8, allowLossyConversion: false)!
            let Deleted:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            Utils.svprogressHudShow(title: "Loading...", view: self)
            
//            indicator1.startAnimating()
//            indicator1.hidesWhenStopped = true
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
                    multipartFormData.append(discss_id, withName: "discss_id")
                    multipartFormData.append(Event_id, withName: "event_id")
                    multipartFormData.append(DiscussType, withName: "discuss_type")
                    multipartFormData.append(discussDesc, withName: "dis_description")
                    multipartFormData.append(imageStatus, withName: "img_status")
                    multipartFormData.append(Deleted, withName: "deleted")
                    multipartFormData.append(ImageExists, withName: "image_exists")
                    multipartFormData.append(createdBy, withName: "created_by")
                    
                    
                    
            },
                to: "\(Constant.BASEURL)\(Constant.CREATE_POST)",
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
                                // self.loadSpinner(option:"1",Message: "")
                                
                        
                                Utils.svprogressHudDismiss(view: self)
                               // self.indicator1.stopAnimating()
                                let alert = UIAlertController(title: "Message!", message: "Posted successfully", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                                    let next = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                                    self.present(next, animated: false, completion: nil)
                                })
                                self.present(alert, animated: true)
                            }
                            else
                            {
                                
                                Utils.svprogressHudDismiss(view: self)
                               // self.indicator1.stopAnimating()
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
    func setParallaxHeader()
    {
        
        
    
    preImage.frame = CGRect(x : 0 ,y : 15 ,width : UIScreen.main.bounds.width ,height : 400)
    preImage.image = UIImage(named: "img1")
    preImage.contentMode = .scaleAspectFill
    
    //  topicView.isHidden = true
    
    
    headerImageView = preImage
    
    newTable.parallaxHeader.view = preImage
    newTable.parallaxHeader.height = 300
    // tableView.parallaxHeader.height = 400
    newTable.parallaxHeader.minimumHeight = 55
    
    topicView.isHidden = false
    topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 55)
    //topicView.layer.backgroundColor = UIColor.red.cgColor
    topicView.layer.backgroundColor = UIColor(red: 255/255, green: 222/255, blue: 141/255, alpha: 1.0).cgColor
    topicView.textAlignment = .center
    topicView.text = "Event Title"
    topicView.textColor = UIColor.black
   
    topicView.isUserInteractionEnabled = true
   // topicView.addGestureRecognizer(tap1)
    headerImageView?.addSubview(topicView)
        
        
        
    }
    
    @IBAction func uploadPic(_ sender: UIButton) {
        
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
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Got a Image")
        if let imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
            let seleImg_Data = UIImageJPEGRepresentation(reduced_sizeImg , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            print("the img str : \(base64_str?.characters.count)")
            
            imgStr = base64_str!
            uploadImage.image = imag
            //imgAddButton.isHidden = true
        }
        else{
            
            
            //            self.videoFilePath = (info[UIImagePickerControllerMediaURL] as? NSURL)! as URL!
            //            videoImage.image = UIImage(named: "att_video.png")
        }
        
        
        picker.dismiss(animated: true, completion: nil)
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
    
    @IBAction func backAct(_ sender: UIButton) {
        
      postView.isHidden = true
      newTable.isHidden = false
        
        
    }
    
    
    @IBAction func goingAction(_ sender: UIButton) {
        
        //var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag , section: 0) as IndexPath) as! EventsDetailedViewCell
        
        
        var going : Int = 0
        
        if cell.goinImage.image == UIImage(named :"circular-check-button-2")
        {
            
            
            cell.goinImage.image = UIImage(named :"accept")
            
            going = 1
        }
        else
        {
            
            cell.goinImage.image = UIImage(named :"circular-check-button-2")
            going = 0
        }
        let params: [String:String] = ["eventid" : ((dataArr[sender.tag] as AnyObject).value(forKey: "event_id")! as! String),"going" : "\(going)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GOING)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
//                    let alert = UIAlertController(title: "", message: "Going status changed", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
                    
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
        
        
    }
    @IBAction func likeAction(_ sender: UIButton) {
        
        var like : Int = 0
        var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        
       
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! EventsDetailedViewCell
        
        if cell.likeIMage.image == UIImage(named :"star-1")
        {
            
            
            cell.likeIMage.image = UIImage(named :"bookmark-star")
            
            like = 1
        }
        else
        {
            
            cell.likeIMage.image = UIImage(named :"star-1")
            like = 0
        }
        let params: [String:String] = ["eventid" : (dataArr[sender.tag] as! AnyObject).value(forKey: "event_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_LIKE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
//                    let alert = UIAlertController(title: "", message: "In", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
                    
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
        
        
    }
    
    
    // just testing
    
    
    @IBAction func expandButt(_ sender: UIButton) {
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! EventsDetailedViewCell
        myValueInt = 1
       // self.newTable.reloadData()
        
        if  cell.expandImage.image == #imageLiteral(resourceName: "downArrow")
        {
        cell.textViewLabel.numberOfLines = 0
            cell.textViewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textViewLabel.sizeToFit()
        
        cell.expandImage.frame =  CGRect(x : newTable.frame.size.width - 20,y : cell.textViewLabel.frame.maxY + 10,width : 15 ,height : 15)
        cell.expandButton.frame =  CGRect(x : cell.textViewLabel.frame.maxX - 30 ,y : cell.textViewLabel.frame.maxY + 5,width : 40 ,height : 30)
        cell.expandImage.image =  #imageLiteral(resourceName: "up-arrow")
            extendHeight = cell.textViewLabel.frame.maxY + 30
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.newTable.reloadRows(at: [indexPath], with: .none)
            //newTable.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],  with: .none)
            
        }

        else
        {
           cell.textViewLabel.numberOfLines = 2
            cell.textViewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textViewLabel.sizeToFit()
            cell.expandImage.frame =  CGRect(x : newTable.frame.size.width - 20 ,y : cell.textViewLabel.frame.maxY + 10,width : 15 ,height : 15)
            cell.expandButton.frame =  CGRect(x : newTable.frame.size.width - 30
                ,y : cell.textViewLabel.frame.maxY + 5,width : 40 ,height : 30)
            cell.expandImage.image =  #imageLiteral(resourceName: "downArrow")
            extendHeight = cell.textViewLabel.frame.maxY + 30
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.newTable.reloadRows(at: [indexPath], with: .none)
           // newTable.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
        }
      // self.newTable.reloadData()
        
        print("working")
    }
    
    
    
    //
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if indexPath.section == 0
            
        {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! EventsDetailedViewCell
            if myValueInt == 0
            {
               
               // var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
             
            
            
            if (dataArr[indexPath.row] as! AnyObject).value(forKey: "evt_likes") as! String == "1"
            {
                
                cell.likeIMage.image = UIImage(named :"bookmark-star")
                
                
                
            }
                
            else
                
            {
                
                cell.likeIMage.image =  UIImage(named :"star-1")
            }
            
            if (dataArr[indexPath.row] as! AnyObject).value(forKey: "gng_likes") as! String == "1"
            {
                cell.goView.isHidden = false


            }

            else

            {
                cell.goinImage.image =  UIImage(named :"circular-check-button-2")

            }
                cell.goingBtn.tag = indexPath.row + 3000
                cell.goingBtn.addTarget(self, action: #selector(goingBtnAct(_:)), for: .touchUpInside)
                cell.acceptBtn.addTarget(self, action: #selector(pressButton2(_:)), for: .touchUpInside)
                cell.acceptBtn.tag = indexPath.row + 5000
          
            let now = Date()
            
            
            let currentDateFormat = DateFormatter()
            currentDateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            let currentDate = currentDateFormat.string(from: now)
            
            currentDateFormat.dateFormat = "dd"
            
            let todayDate = currentDateFormat.string(from: now)
            
            
            
            let startDate = (dataArr[indexPath.row] as! AnyObject).value(forKey: "start_date") as! String
            // let createdOn = (dict["start_date"] as? String)!
            
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: startDate)!
            
            myDate.getElapsedInterval()
            
            dateFormatterr.dateFormat = "LLLL"
            let  month = dateFormatterr.string(from: myDate)
            
            dateFormatterr.dateFormat = "dd"
            let  startDATE = dateFormatterr.string(from: myDate)
            
            dateFormatterr.dateFormat = "MMM"
            let  startMonth = dateFormatterr.string(from: myDate)
       
            //let dateFormatter1 = DateFormatter()
            dateFormatterr.dateFormat  = "EEEE"//"EE" to get short style
            let dayInWeek = dateFormatterr.string(from: myDate)
            
            // let dateFormatter3 = DateFormatter()
            dateFormatterr.dateFormat  = "hh :mm"//"EE" to get short style
            let time = dateFormatterr.string(from: myDate)
            
            // let dateFormatter2 = DateFormatter()
            dateFormatterr.dateFormat  = "dd"//"EE" to get short style
            let dates = dateFormatterr.string(from: myDate)
            
            let endDate = (dataArr[indexPath.row] as! AnyObject).value(forKey: "end_date") as! String
           
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate1 = dateFormatter1.date(from: endDate)!
            
            dateFormatter1.dateFormat = "LLLL"
            let  month1 = dateFormatter1.string(from: myDate1)
   
            
            // let dateFormatter5 = DateFormatter()
            dateFormatter1.dateFormat  = "EEEE"//"EE" to get short style
            let dayInWeek1 = dateFormatter1.string(from: myDate1)
            
            //  let dateFormatter6 = DateFormatter()
            dateFormatter1.dateFormat  = "hh :mm"//"EE" to get short style
            let time1 = dateFormatter1.string(from: myDate1)
            
            //  let dateFormatter7 = DateFormatter()
            dateFormatter1.dateFormat  = "dd"//"EE" to get short style
            let date1 = dateFormatter1.string(from: myDate1)
            
            
            var eventDaysleft : Int = 0
            
            
            
            if Int(todayDate)! > Int(startDATE)!
                
            {
                
                
                
                cell.eventDateandTIme.text = "\(String(describing: dayInWeek)),\(String(describing: month)) \(String(describing: dates)) at \(String(describing: time)) to \(String(describing: dayInWeek1)),\(String(describing: month1)) \(String(describing: date1)) at \(String(describing: time1)) - Event was over"
                cell.eventDateandTIme.numberOfLines = 0
                cell.eventDateandTIme.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.eventDateandTIme.sizeToFit()
                
                
            }
                
                
           else if  Int(todayDate)! ==  Int(startDATE)!
                
            {
                
               cell.eventDateandTIme.text = "\(String(describing: dayInWeek)),\(String(describing: month)) \(String(describing: dates)) at \(String(describing: time)) to \(String(describing: dayInWeek1)),\(String(describing: month1)) \(String(describing: date1)) at \(String(describing: time1)) - Today"
                cell.eventDateandTIme.numberOfLines = 0
                cell.eventDateandTIme.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.eventDateandTIme.sizeToFit()
                
                
            }
                
                
            else
                
            {
                
                eventDaysleft = Int(startDATE)! - Int(todayDate)!
                cell.eventDateandTIme.text = "\(String(describing: dayInWeek)),\(String(describing: month)) \(String(describing: dates)) at \(String(describing: time)) to \(String(describing: dayInWeek1)),\(String(describing: month1)) \(String(describing: date1)) at \(String(describing: time1)) - \(eventDaysleft) days left"
                cell.eventDateandTIme.numberOfLines = 0
                cell.eventDateandTIme.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.eventDateandTIme.sizeToFit()
                
                
            }
            
         
            
       cell.eventTitle.text! = (dataArr[indexPath.row] as! AnyObject).value(forKey: "event_name") as! String
            //        profPicture.sd_setImage(with: URL(string: (dict["picture"] as! String)), placeholderImage: UIImage(named: "img1.png"))
            
            cell.eventLocation.text! = (dataArr[indexPath.row] as! AnyObject).value(forKey: "location") as! String
            
//            cell.aboutEvent.text! = (dict["event_description"] as? String)!
            
            
      
        if (dataArr[indexPath.row] as! AnyObject).value(forKey: "ticket_url") as! String == "0"
                    {
                        cell.ticketUrl.text! = "No Ticket Url"
            
                    }
        
        else
            
                    {
                        cell.ticketUrl.text! = (dataArr[indexPath.row] as! AnyObject).value(forKey: "ticket_url") as! String
            
                    }
            
     
            cell.eventMainStartDate.text! = startDATE
            cell.eventMainStartMonth.text! = startMonth
            //dict["ticket_url"] as? String)!
           
            
            
            cell.interestedPplCount.text = "\((dataArr[indexPath.row] as! AnyObject).value(forKey: "total_likes") as! String)  People Interested & \((dataArr[indexPath.row] as! AnyObject).value(forKey: "total_going") as! String)  People Going"
                cell.interestedPplCount.numberOfLines = 0
                cell.interestedPplCount.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.interestedPplCount.sizeToFit()
            preImage.sd_setImage(with: URL(string: (dataArr[indexPath.row] as! AnyObject).value(forKey: "event_image") as! String), placeholderImage: UIImage(named: "ProfileImg4.png"))
            
            
          //  eventDetailCall()
       
            
            
            cell.backBUTTON.frame = CGRect(x : 0 ,y : 0,width : 60 ,height : 60)
           
            
            view.addSubview(cell.backBUTTON)
            cell.backBUTTON.isHidden = false
                
            cell.backBUTTON.tag = indexPath.row + 5000
            cell.backBUTTON.addTarget(self, action: #selector(EventsDetailedController.BackAction(_:)), for: .touchUpInside)
                
            
            cell.textViewLabel.text = (dataArr[indexPath.row] as! AnyObject).value(forKey: "event_description") as! String
            cell.textViewLabel.numberOfLines = 2
            cell.textViewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.textViewLabel.sizeToFit()
            cell.expandButton.addTarget(self, action: #selector(EventsDetailedController.expandButt(_:)), for: .touchUpInside)
               
            }
            else
            {
               if extendHeight != 550.0
               {
                cell.textViewLabel.text = (dataArr[indexPath.row] as! AnyObject).value(forKey: "event_description") as! String
                //"Hi can you advice me I am creating a PayPal store app. I built with jquery mobile and used phonegap to build the iOS and apk file. My problem is I got apk store buttons working but the iOS buttons are not functioning. Can you please tell me what I am doing wrong and how to fix this. Thank you﻿"
                cell.textViewLabel.numberOfLines = 0
                cell.textViewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.textViewLabel.sizeToFit()
                
                cell.expandImage.frame =  CGRect(x : newTable.frame.size.width - 20,y : cell.textViewLabel.frame.maxY + 15,width : 15 ,height : 15)
                cell.expandButton.frame =  CGRect(x : newTable.frame.size.width - 20 ,y : cell.textViewLabel.frame.maxY + 10,width : 40 ,height : 30)
                cell.expandImage.image =  #imageLiteral(resourceName: "up-arrow")
                }
                else
               {
                cell.textViewLabel.numberOfLines = 2
                cell.textViewLabel.sizeToFit()
                cell.expandImage.frame =  CGRect(x : newTable.frame.size.width - 20 ,y : cell.textViewLabel.frame.maxY + 15,width : 15 ,height : 15)
                cell.expandButton.frame =  CGRect(x : newTable.frame.size.width - 20,y : cell.textViewLabel.frame.maxY + 10,width : 40 ,height : 30)
                cell.expandImage.image =  #imageLiteral(resourceName: "downArrow")
                
                }
                
            }
            return cell
        }
            
            
        else
            
        {
           
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! EventsDetailedViewCell1
            
          // var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
//            cell.postBtn.tag = indexPath.row + 8000
//            cell.postBtn.addTarget(self, action: #selector(EventsDetailedController.postActt(_:)), for: .touchUpInside)
//            cell.postBtn.applyGradientButtongreen()
            cell.postBtn.layer.cornerRadius = 12.0
            cell.postBtn.clipsToBounds = true
            
//            cell.addComments.tag = 0
//            cell.addComments.delegate = self
//            cell.addComments.text = "Add a comment"
//            cell.addComments.textColor = UIColor.lightGray
            cell.writePOst.tag = indexPath.row + 9000
            cell.writePOst.addTarget(self, action: #selector(EventsDetailedController.postActt(_:)), for: .touchUpInside)
            cell.viewAlldiscussionBtn.tag = indexPath.row + 8000
            cell.viewAlldiscussionBtn.addTarget(self, action: #selector(EventsDetailedController.viewAct(_:)), for: .touchUpInside)
            
            if (dataArr[indexPath.row] as! AnyObject).value(forKey: "total_discussion") as! String == "0"
            {
             cell.viewallDiscussLabel.text = "No post"
             cell.viewAlldiscussionBtn.isUserInteractionEnabled = false
            }
            
            else
            {
            cell.viewallDiscussLabel.text = "View all discussion"
            cell.viewAlldiscussionBtn.isUserInteractionEnabled = true
            }
        
            
            cell.userProfImage.sd_setImage(with: URL(string: (dataArr[indexPath.row] as! AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "img1"))
           
            
            cell.createdBy.text! = "Balaji R"
                //(dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as AnyObject).value(forKey: "first_name") as! String + " " + (dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as! AnyObject).value(forKey: "last_name") as! String
            return cell
        }
    
    }
    
    @objc func pressButton2(_ sender: UIButton!){
        
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 5000, section:0) as IndexPath) as! EventsDetailedViewCell
  
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Interested", style: .default, handler: { _ in
            //self.openCamera()
            
            var like : Int = 0
            cell.goView.isHidden = true
            cell.goinImage.image = #imageLiteral(resourceName: "circular-check-button-2")
            
            if cell.likeIMage.image == UIImage(named :"star-1")
            {
               
                cell.likeIMage.image = UIImage(named :"bookmark-star")
                
                
                like = 1
            }
            else
            {
                
                cell.likeIMage.image = UIImage(named :"star-1")
                like = 0
            }
            
            
            
            let params: [String:String] = ["eventid" : (self.dataArr[sender.tag - 5000] as AnyObject).value(forKey: "event_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_LIKE)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                if result != nil{
                    if   json["ResponseCode"] ==  1
                    {
                        
                        let alert = UIAlertController(title: "", message: "Interest shown", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
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
        
        alert.addAction(UIAlertAction(title: "Not Going", style: .default, handler: { _ in
            
            let going : Int = 0
            cell.goView.isHidden = true
            cell.goinImage.image = #imageLiteral(resourceName: "circular-check-button-2")
            if cell.likeIMage.image == UIImage(named :"star-1")
            {
                cell.likeIMage.image = UIImage(named :"bookmark-star")
            }
            else
            {
                cell.likeIMage.image = UIImage(named :"star-1")
                
            }
            
            
            let params: [String:String] = ["eventid" : (self.dataArr[sender.tag - 5000] as AnyObject).value(forKey: "event_id") as! String,"going" : "\(going)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GOING)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                
                let result = response.result
                
                let json = JSON(data: response.data!)
                
                if result != nil{
                    if   json["ResponseCode"] ==  1
                    {
                        
                        let alert = UIAlertController(title: "", message: "Going status changed", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
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
    
    
    @objc func goingBtnAct(_ sender: UIButton!){
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section:0) as IndexPath) as! EventsDetailedViewCell
        
        let going : Int = 1
        
        cell.goView.isHidden = false
        
        
        let params: [String:String] = ["eventid" : (self.dataArr[sender.tag - 3000] as AnyObject).value(forKey: "event_id") as! String,"going" : "\(going)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GOING)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    let alert = UIAlertController(title: "", message: "Going shown", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
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
   
    }
    
    func UTCToLocal(UTCDateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Input Format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let UTCDate = dateFormatter.date(from: UTCDateString)
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss" // Output Format
        dateFormatter.timeZone = TimeZone.current
        let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
        return UTCToCurrentFormat
    }
    
    
    
    @objc func BackAction(_ sender: UIButton) {
        
      self.dismiss(animated: false, completion: nil)
        
    }
    @objc func viewAct(_ sender: UIButton) {
        
     
         let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 8000, section: 1) as IndexPath) as! EventsDetailedViewCell1
        let cell1 = newTable.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! EventsDetailedViewCell
        view.willRemoveSubview(cell1.backBUTTON)
        cell1.backBUTTON.isHidden = true
         var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        let page:FoodStreetController = self.storyboard?.instantiateViewController(withIdentifier: "foodStreet") as! FoodStreetController
        page.eventId = (dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as! AnyObject).value(forKey: "event_id") as! String
    
        self.present(page, animated: false, completion: nil)
      
    }
    
    
    func getCohosts()
    {
        if ab == 0
        {
           
            
            let params: [String:String] = ["eventid" : (postArray[pageCUR] as AnyObject).value(forKey: "event_id") as! String]
            userImage.sd_setImage(with: URL(string: (postArray[pageCUR] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
            
            
            let urlString = "\(Constant.BASEURL)\(Constant.GET_COHOSTS)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                
                if let resData = json["Data"].arrayObject {
                    self.cohostArray = resData as! [[String:AnyObject]]
                    
                    if(self.cohostArray.count != 0){
                        
                        
                        print(self.cohostArray)
                        for i in 0..<self.cohostArray.count
                        {
                            
                            if (Utils.getPreferenceValue(ForKey: Constant.USER_ID) == (self.cohostArray[i] as AnyObject) as! String)
                            {
                                
                                self.discuss_type = "1"
                            }
                            
                            
                        }
                        
                    }
                        
                    else
                        
                    {
                        self.discuss_type = "0"
                        
                    }
                }
                
                
            }
        }
        else
        {
            
            var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
            
            
            let params: [String:String] = ["eventid" : (dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as! AnyObject).value(forKey: "event_id") as! String]
            userImage.sd_setImage(with: URL(string: (dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!] as! AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
            
            
            let urlString = "\(Constant.BASEURL)\(Constant.GET_COHOSTS)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                
                if let resData = json["Data"].arrayObject {
                    self.cohostArray = resData as! [[String:AnyObject]]
                    
                    if(self.cohostArray.count != 0){
                        
                        
                        print(self.cohostArray)
                        for i in 0..<self.cohostArray.count
                        {
                            
                            if (Utils.getPreferenceValue(ForKey: Constant.USER_ID) == (self.cohostArray[i] as AnyObject).value(forKey: "cohost_id") as! String)
                            {
                                
                                self.discuss_type = "1"
                            }
                            
                            
                        }
                        
                    }
                        
                    else
                        
                    {
                        self.discuss_type = "0"
                        
                    }
                }
                
                
            }
        }
       
        
    }
    
    
    @objc func postActt(_ sender: UIButton!)
        
    {
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 9000, section: 1) as IndexPath) as! EventsDetailedViewCell1
        let cell1 = newTable.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! EventsDetailedViewCell
        view.willRemoveSubview(cell1.backBUTTON)
        cell1.backBUTTON.isHidden = true
        
        
        
        newTable.isHidden = true
        postView.isHidden = false
        
    }
    
    
    
    @objc func pressButton(_ sender: UIButton!)
        
    {
         let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! EventsDetailedViewCell
        
      
        

        
        cell.expandButton.isHidden = true
        cell.expandImage.isHidden = true
        
//        cell.CompressImage.frame = CGRect(x: 300 , y:  480 + newSize.height - 110, width: 15, height: 15)
//
//         cell.compressButton.frame = CGRect(x: 285 , y:  465 + newSize.height - 90, width: 46, height: 40)
//
//        cell.CompressImage.image = #imageLiteral(resourceName: "up-arrow")

        
        
     //  newTable.reloadData()
        
     
    
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
//        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 2) as IndexPath) as! EventsDetailedViewCell2
//
//        cell.editView.isHidden = true
        
        self.view.endEditing(true)
    }
    
    
    @objc func editAction(_ sender: UIButton!)
    {
        
        
//        let indexPath =  NSIndexPath(row: sender.tag, section: 0)
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 5000 , section: 2) as IndexPath) as! EventsDetailedViewCell2
        
        cell.editView.isHidden = false
        
        
       // newTable.reloadData()
        
        
    }
    
    
    func eventDetailCall()
    {
        let params: [String:String] = ["eventid" : eventID,"userid" : userid]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENT_COMMENT_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            //if json["ResponseMessage"]
            
            if let resData = json["Data"].arrayObject {
                self.dataArray = resData as! [[String:AnyObject]]
                
                if(self.dataArray.count != 0){
                    
                    
                    print(self.dataArray)
                    if self.action1 == "1"
                    {
                        let indexPath = IndexPath(item: self.rowNumber, section: 2)
                        self.newTable.deleteRows(at: [indexPath], with: .none)
                        self.action1 = ""
                    }
                        
                    else
                    {
                        self.newTable.reloadData()
                    }
                    
                    
                }
                    
                else
                    
                {
                    
                 print("Nothing")
        
                }
                
                
            }
            
            
            
            
        }
        
        
    }
    
    
    @objc func deleteRowAction(_ sender: UIButton!)
    {
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section: 2) as IndexPath) as! EventsDetailedViewCell2
        
        
        
        
        let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to delete this comment?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: " Yes,Delete it!", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            
            let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID),"comment_id" :
                "\((self.dataArray[sender.tag - 3000] as AnyObject).value(forKey: "cmmt_evt_id")!)" ,"comments": cell.rowComments.text!,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_EVENT_COMMENTS)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json != nil
                {
                    if json["ResponseMessage"] == "success"
                        
                    {
                        print("Success")
                        //self.commentField.text = ""
//                        self.dataArray.remove(at: sender.tag - 3000)
                        cell.editView.isHidden = true
                       // self.newTable.reloadData()
                        self.rowNumber = sender.tag - 3000
                        self.action1 = "1"
                        self.eventDetailCall()
                        
                    }
                    
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
        
    }
    
    
    @objc func editRowAction(_ sender: UIButton!)
    {
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 4000, section: 2) as IndexPath) as! EventsDetailedViewCell2
         cell.rowComments.isScrollEnabled = true
     
        
        //        cell.commentsTextField.isUserInteractionEnabled = true
        //        cell.commentsTextField.delegate = self
        cell.rowComments.frame = CGRect(x: 10 , y: 80, width: 220, height: 55)
        cell.editView.isHidden = true
        cell.rowComments.isUserInteractionEnabled = true
        
        // cell.editCommentView.isHidden = false
        cell.postButton.isHidden = false
        cell.cancelBUtton.isHidden = false
        cell.postButton.addTarget(self, action: #selector(postEditedComment(_:)), for: .touchUpInside)
        cell.postButton.applyGradientButtongreen()
        cell.postButton.layer.cornerRadius = 10.0
        cell.postButton.clipsToBounds = true
        cell.cancelBUtton.layer.cornerRadius = 5.0
        cell.cancelBUtton.clipsToBounds = true
        cell.cancelBUtton.layer.borderColor = UIColor.black.cgColor
        cell.cancelBUtton.layer.borderWidth = 1.0
        
        
        
        cell.cancelBUtton.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        commentID =  "\((self.dataArray[sender.tag - 4000] as AnyObject).value(forKey: "cmmt_evt_id")!)"
        
        
        
        
      
        
        
    }
    
    @objc func cancelAction(_ sender: UIButton!)
    {
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section: 2) as IndexPath) as! EventsDetailedViewCell2
        cell.editView.isHidden = true
        cell.postButton.isHidden = true
        cell.cancelBUtton.isHidden = true
        cell.rowComments.frame = CGRect(x: 10 , y: 80, width: 310 , height: 55)
        // cell.editCommentView.isHidden = true
        self.view.endEditing(true)
    }
    
    
    @objc func postEditedComment(_ sender: UIButton!)
        
    {
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section: 2) as IndexPath) as! EventsDetailedViewCell2
         cell.rowComments.isScrollEnabled = false
       
        editedComment = cell.rowComments.text!
        cell.editView.isHidden = true
        cell.postButton.isHidden = true
        cell.cancelBUtton.isHidden = true
        cell.rowComments.frame = CGRect(x: 10 , y: 80, width: 300 , height: 55)
       
        
        let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID),"comment_id" :
            commentID,"comments": editedComment,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EVENT_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    print("Success")
                    
                    self.rowNumber = sender.tag - 2000
                    self.action1 = "1"
                    self.eventDetailCall()
                    // self.newTable.reloadData()
                    
                }
                
            }
            
        }
      
    }
    
   @objc func pressButton1(_ sender: UIButton!)
       {
        
         let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! EventsDetailedViewCell
        
        cell.expandImage.image = #imageLiteral(resourceName: "downArrow")
        
         cell.expandButton.frame = CGRect(x: 275 , y:  480 , width: 15, height: 15)
        
        cell.expandImage.frame = CGRect(x: 260 , y:  465 , width: 46, height: 40)
        
    }
    
    
//     func viewDidLayoutSubviews(_ sender : UITextView) {
//
//        super.viewDidLayoutSubviews()
//
//
//
//        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! EventsDetailedViewCell2
//
//
//
//        let contentSize = cell.rowComments.sizeThatFits(cell.rowComments.bounds.size)
//        var frame = cell.rowComments.frame
//        frame.size.height = contentSize.height
//        cell.rowComments.frame = frame
//
//
//        var aspectRatioTextViewConstraint = NSLayoutConstraint()
//        aspectRatioTextViewConstraint = NSLayoutConstraint(item: cell.rowComments, attribute: .height, relatedBy: .equal, toItem: cell.rowComments, attribute: .width, multiplier: cell.rowComments.bounds.height/cell.rowComments.bounds.width, constant: 1)
//        cell.rowComments.addConstraint(aspectRatioTextViewConstraint)
//
//    }
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataArr.count == 0
        {
            return 0
        }
        
       if section == 0
       {
         return 1
        
        }
        
        else
        {
            
           return 1
        }
        
//       else
//        {
//
//          return dataArray.count
//
//        }

        
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if dataArr.count == 0
        {
            return 0
        }
      if indexPath.section == 0
      {
        
      return extendHeight
        
        
    }
        
        
       else
        {
            
            
            return 300.0
        }
        
//       else
//        {
//
//
//            return UITableViewAutomaticDimension
//        }
        
        
    }
    
    
//     func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 2
//        {
//        return 55 + extendHeightto1
//        }
//        if indexPath.section == 0
//        {
//            return 500.0
//        }
//        else
//        {
//            return 220.0
//        }
//    }
//
    
    func textViewDidChange(_ sender: UITextView) {
        
        if textView1.tag == 1
        {
        
        let fixedWidth = textView1.frame.size.width
        textView1.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView1.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView1.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView1.frame = newFrame
        //textView1.sizeToFit()
        
        
        if newSize.height > 60
        {
            uploadImage.frame  = CGRect( x : 10,y:textView1.frame.maxY + 20, width : self.view.frame.size.width ,height : uploadImage.frame.size.height)
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
                
                textView.text = "Write Something"
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
                textView.text = "Write something"
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
    
    
    func heightOfTextView(height: CGFloat) {
        
        textViewHeight = height
        self.newTable.beginUpdates()
        self.newTable.endUpdates()
        
    }
    
    func localToUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss"
        
        return dateFormatter.string(from: dt!)
    }
    
    
    
//
//    func findHeightForText(text: String, havingWidth widthValue: CGFloat, andFont font: UIFont) -> CGSize {
//
//        var size = .zero
//        if text.isEmpty == false {
//            let frame = text.boundingRect(with: CGSize(widthValue, CGFloat.max), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//            size = CGSize(frame.size.width, ceil(frame.size.height))
//        }
//        return size
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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






extension UITextView {
    
    
   
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }

}

extension Date {
    func timeAgoDisplay1() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "Just Now"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) days ago"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff) weeks ago"
    }
}

extension Date {
    
    
//    func localToUTC(date:String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.calendar = NSCalendar.current
//        dateFormatter.timeZone = TimeZone.current
//
//        let dt = dateFormatter.date(from: date)
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ss"
//
//        return dateFormatter.string(from: dt!)
//    }

    func getElapsedInterval() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour" :
                "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute" :
                "\(minute)" + " " + "minutes ago"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second" :
                "\(second)" + " " + "seconds ago"
        } else {
            return "Just Now"
        }

    }
}


