//
//  CreategrouppageViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreategrouppageViewController: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

     var placeholderLabel : UILabel!
     @IBOutlet weak var textview: UITextView!
    let imagePicker = UIImagePickerController()
    var imgStr : String = ""
    var imageFilePath:URL! = nil
    var imagevalue = 0
     var grouparray = [[String:AnyObject]]()
  var idarr = [String]()
    var intArray = [Int]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.delegate = self
        
        imagePicker.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Your group name..."
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textview.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textview.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 20, y: (textview.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textview.text.isEmpty
        // Do any additional setup after loading the view.
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textview.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // headerView.frame.size =
        
    }
    
    @IBAction func imgUpload(_ sender: UIButton) {
        
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
     
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
            //eventImage.image = imag
           // imgAddButton.isHidden = true
        }
        else{
            
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Back(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func camera(_ sender: Any) {
        
        
    }
    
    @IBAction func create(_ sender: Any) {
       
        
        print(imgStr)
        if imgStr != ""{
           imagevalue = 1
        }
        else {
            imagevalue = 0
        }
        
  
         intArray = idarr.map { Int($0)!}
        print(intArray)

        if intArray.count <= 1 {
            let alert = UIAlertController(title: "FoodWall", message: "choose atleast two members to create a group", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        
       else if textview.text == nil{
            let alert = UIAlertController(title: "FoodWall", message: "Enter your group name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
             if (currentReachabilityStatus != .notReachable) == true {
          
            let params:[String:Any] = ["group_name" : "\(textview.text!)" as AnyObject,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) as AnyObject,"img_status" : 0,"friends" : intArray,"image" : " "]
        //  let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GROUP)"
            
            
            

        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)

            if let resData = json["Data"].arrayObject {
                       
                self.grouparray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
               
                if(self.grouparray.count != 0)
                {
                    let responsemessage = ((json ["ResponseMessage"].string)!)
                    if responsemessage == "success"
                    {
                    print(self.grouparray)
                        print("Created Successfully")
                        
                        let page = self.storyboard?.instantiateViewController(withIdentifier: "viewchat") as! ViewcreatedgroupViewController
                        
                        
                        page.intArray = self.intArray
                        page.grouparray = self.grouparray
                    
                        page.groupname = "\(((self.grouparray[0] as AnyObject).value(forKey: "groupname") as! String).decodeEmoji)"
                        
                        page.groupicon = "\(((self.grouparray[0] as AnyObject).value(forKey: "groupicon") as! String))"
                          page.groupid = "\(((self.grouparray[0] as AnyObject).value(forKey: "groupid") as! String))"
                        page.sessionid = "\(((self.grouparray[0] as AnyObject).value(forKey: "sessionid") as! NSString))"
                  // let    vlaue = "\(((self.grouparray[1] as AnyObject).value(forKey: "sessionid") as! NSArray))"
                        self.present(page, animated: false, completion: nil)
                     
                        
                    }
                    else{
                        
                      
                        
                        
                        
                    }
                    
                    
                   
                }

                else
                {
                    print("No data")
                }
         
            
            
            
            
            
            }
            else {
                let alert = UIAlertController(title: "Server Problem", message: "Please try again...", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
             }
                else {
                    let alert = UIAlertController(title: "No Internet Connection", message: "Check your internet..", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
                
           
//            let myarrey = [4,3] as NSArray
//            let params:[String:Any] = ["group_name" : "\(textview.text!)" as AnyObject,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) as AnyObject,"img_status" : 1,"friends" : intArray]
//
//            Alamofire.upload(
//                multipartFormData: { multipartFormData in
//
//
//
//                    if(self.imgStr != "")
//                    {
//                        let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
//                        let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                        let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("newImage1.jpg")
//                        dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
//
//                        multipartFormData.append(fileDestinationUrl2, withName: "image")
//                    }
//
//
//                    for (key,value) in params {
//                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//                    }
//
//            },
//                to: "\(Constant.BASEURL)\(Constant.CREATE_GROUP)",
//                encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .success(let upload, _, _):
//                        upload.responseJSON { response in
//                            debugPrint(response)
//
//
//
//                            let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
//                            print("JSON : \(datastring)")
//                            let json = JSON(data:response.data!)
//                            // print(json["status"])
//
//                            // print(data:response.data!)
//                            if("\(json["ResponseMessage"])" == "success")
//                            {
//                                // self.loadSpinner(option:"1",Message: "")
//
//                                let alert = UIAlertController(title: "Message!", message: "Created Successfully", preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
//                                    //let next = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
//                                  //  self.present(next, animated: false, completion: nil)
//                                })
//                                self.present(alert, animated: true)
//                            }
//                            else
//                            {
//                                // self.loadSpinner(option:"1",Message: "")
//                            }
//                        }
//
//                    case .failure(let encodingError):
//                        print(encodingError)
//                        // self.loadSpinner(option:"1",Message: "")
//                    }
//            }
//            )
//
//

//            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_GROUP)"
//
//            // newdestext.text = ""
//            // Newtitletext.text = Emp_id,news_title,news_detail,news_file(optional),news_image(optional)
//             let params:[String:Any] = ["group_name" : "\(textview.text!)" as AnyObject,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) as AnyObject,"img_status" : 1,"friends" : intArray]
//
//
//            Alamofire.upload(
//                multipartFormData: { multipartFormData in
//
//
//                    //                if(self.imageFilePath != nil)
//                    //                {
//                    //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
//                    //                }
//
//                    if(self.imgStr != "")
//                    {
//                        let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
//                        let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                        let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("newImage1.jpg")
//                        dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
//
//                        multipartFormData.append(fileDestinationUrl2, withName: "image")
//                    }
//                    for (key,value) in params {
//
//                       multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//
//                    }
//
//
//            },
//                to: urlString,
//                encodingCompletion: { encodingResult in
//                    switch encodingResult {
//                    case .success(let upload, _, _):
//                        upload.responseJSON { response in
//                            debugPrint(response)
//                            let result = response.result
//                                        let json = JSON(data: response.data!)
//
//
//
//                            let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
//                            print("JSON : \(datastring)")
//                            if let resData = json["Data"].arrayObject {
//
//                                                self.grouparray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
//                                                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
//
//
//                                                if(self.grouparray.count != 0)
//                                                {
//                                                    print(self.grouparray)
//
//                                                    // self.followTable.reloadData()
//
//                                                }
//
//                                                else
//                                                {
//                                                    print("No data")
//                                                }
//                                            }
//                        }
//
//                    case .failure(let encodingError):
//                        print(encodingError)
//                        // self.loadSpinner(option:"1",Message: "")
//                    }
//            }
//            )
            
            
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
