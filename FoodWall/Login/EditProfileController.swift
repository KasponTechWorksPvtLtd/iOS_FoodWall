//
//  EditProfileController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 15/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView1: UIScrollView!
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profImg: UIImageView!
    @IBOutlet weak var profilePicBtn: UIButton!
    @IBOutlet weak var femaleradioBtn: UIButton!
    @IBOutlet weak var maleradioBtn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var first_name: UITextField!
    var dataProfArray : NSArray = []
    @IBOutlet weak var last_name: UITextField!
    
    @IBOutlet weak var user_name: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var profDesc: UITextField!
    
   
    
    var lastName :String = ""
    var firstName : String = ""
    var genderR :String = ""
    var emailid :String = ""
    var DOB :String = ""
    var biodesc :String = ""
    var imageString :String = ""
    var userid :String = ""
    
    

    var dataArray : NSArray = []
    let datePicker = UIDatePicker()
    let imagePicker = UIImagePickerController()
    var imgStr : String = ""
    var profStatus : String = ""
    var imageFilePath:URL! = nil
    // @IBOutlet weak var description: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadowView()
        updateButton.layer.shadowOpacity = 0.5
        updateButton.layer.shadowColor = UIColor.lightGray.cgColor
        updateButton.layer.cornerRadius = 10.0
        updateButton.layer.masksToBounds = true
        dob.delegate = self
        dob.tag = 1
        profDesc.layer.cornerRadius = 5.0
        profDesc.layer.masksToBounds = true
        profDesc.layer.borderColor = UIColor.lightGray.cgColor
        profDesc.layer.borderWidth = 0.5
        imagePicker.delegate = self
        
        getProfile()
        first_name.delegate = self
        last_name.delegate = self
        
       
        email.delegate = self
        profDesc.delegate = self
        
        profImg.layer.cornerRadius = self.profImg.frame.size.height/2
        profImg.layer.masksToBounds = false
        // profileImageView.layer.borderColor = UIColor.white.cgColor
        self.profImg.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)), placeholderImage: UIImage(named: "img1"))
        profImg.clipsToBounds = true
//        let scrollHei: CGFloat? =  scrollView.frame.size.height + 100
//        self.scrollView?.contentSize =  CGSize(width: self.view.frame.size.width, height: scrollHei!)
        
        scrollView1.isScrollEnabled = true
        
        self.updateButton.applyGradient1()
      
        // Do any additional setup after loading the view.
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
     func getProfile()
     {
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"yourid":Utils.getPreferenceValue(ForKey: Constant.USER_ID) ]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_PROFILE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataProfArray = resData as! [[String:AnyObject]] as NSArray
                
                if(self.dataProfArray.count != 0){
                    
                    
                    print(self.dataProfArray)
                    
                    self.first_name.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "first_name") as! String)"
                  self.last_name.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "last_name") as! String)"
                    self.profDesc.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "bio_description") as! String)"
                    self.email.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "email") as! String)"
                    self.dob.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "dob") as! String)"
                    self.profDesc.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
                    
                    self.profImg.sd_setImage(with: URL(string: "\(String(describing: (self.dataProfArray[0] as AnyObject).value(forKey: "picture")!))"), placeholderImage: UIImage(named: "img1"))
                    if "\((self.dataProfArray[0] as AnyObject).value(forKey: "gender") as! String)" == "male"
                    {
                        self.maleradioBtn.setImage( #imageLiteral(resourceName: "radiobutton"), for: .normal)
                        self.femaleradioBtn.setImage( #imageLiteral(resourceName: "radiobtn"), for: .normal)
                        
                    }
                    
                    else
                    {
                       self.maleradioBtn.setImage( #imageLiteral(resourceName: "radiobtn"), for: .normal)
                       self.maleradioBtn.setImage( #imageLiteral(resourceName: "radiobutton"), for: .normal)
                    }
                    
                 self.user_name.text = "\((self.dataProfArray[0] as AnyObject).value(forKey: "username") as! String)"
                    
            if  "\((self.dataProfArray[0] as AnyObject).value(forKey: "profile_status") as! String)" == "0"
                {
                
               self.switch1.setOn(false, animated: false)
                
                    }
                    
                    
                    else
                  {
                    self.switch1.setOn(true, animated: false)
                    }
                    
                }
                    
                else
                    
                {
                    
                    print("Empty")
                    
                    
                    
                }
            }
            }
        }
        
        
        
        
 
    
    override func viewWillAppear(_ animated: Bool) {
        
        
       
       
     
        
        
    }
    
    @IBAction func switchAct(_ sender: UISwitch) {
        
        if switch1.isOn
        {
           switch1.setOn(false, animated: true)
            profStatus = "0"
        }
        
        else
        {
            switch1.setOn(true, animated: true)
            profStatus = "1"
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Got a Image")
        if let imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
          //  let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
            let seleImg_Data = UIImageJPEGRepresentation(imag , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            print("the img str : \(base64_str?.characters.count)")
            
            imgStr = base64_str!
            profImg.image = imag
            
            
            let userID :Data = userid.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    
                   
                    
                    if(self.imgStr != "")
                    {
                        let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
                        let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                        let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("newImage3.jpg")
                        dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                        
                        multipartFormData.append(fileDestinationUrl2, withName: "image")
                    }
                    
                    
                    multipartFormData.append(userID, withName: "userid")
                    
                    
                    
            },
                to: "\(Constant.BASEURL)\(Constant.UPDATE_USER_PROFILE_IMAGE)",
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
                                
//                                let alert = UIAlertController(title: "Message!", message: "Updated Successfully", preferredStyle: .alert)
//                                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
//                                })
//                                self.present(alert, animated: true)
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
        else{
            
            
            //            self.videoFilePath = (info[UIImagePickerControllerMediaURL] as? NSURL)! as URL!
            //            videoImage.image = UIImage(named: "att_video.png")
        }
        
        
        picker.dismiss(animated: true, completion: nil)
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
    
    @IBAction func updateAction(_ sender: UIButton) {
        
        
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) ,"first_name" : first_name.text!,"last_name":last_name.text!,"gender" :genderR,"dob": dob.text!,"bio_description":profDesc.text!,"profile_status" : profStatus,"username" :user_name.text!]
        
        let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_USER_PROFILE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    let alert = UIAlertController(title: "", message: "Updated Successfully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        
                        
                        
                    })
                    self.present(alert, animated: true, completion: nil)
                   
                    
                }
                
            }
        }
        
        
        
    }
    
    @IBAction func backAct(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func maleRadioAction(_ sender: UIButton) {
        
        maleradioBtn.setImage(#imageLiteral(resourceName: "radiobutton"), for: .normal)
        femaleradioBtn.setImage(#imageLiteral(resourceName: "radiobtn"), for: .normal)
        
        genderR = "male"
        
    }
    
    @IBAction func femaleRadioAction(_ sender: UIButton) {
        maleradioBtn.setImage(#imageLiteral(resourceName: "radiobtn"), for: .normal)
        femaleradioBtn.setImage(#imageLiteral(resourceName: "radiobutton"), for: .normal)
        
        
        genderR = "female"
        
    }
    
    @IBAction func choseePic(_ sender: UIButton) {
        
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
        
        
        
        
        
        
  
    
}
