



//
//  SignUpViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MobileCoreServices
import AVKit
import GoogleMaps


var signs = ""
class SignUpViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate,UIScrollViewDelegate{
 var coordinatelocation = LoginController()
    
    @IBOutlet var signUpLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var femaleRadioBtn: UIButton!
    @IBOutlet var maleRadioBtn: UIButton!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var confirmPwd: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var dateOfBirth: UITextField!
    @IBOutlet var firstName: UITextField!
    @IBOutlet var emailid: UITextField!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var bioDesp: UITextField!
    var gender :String = ""
    var dataArray : NSArray = []
     let datePicker = UIDatePicker()
    let imagePicker = UIImagePickerController()
    var imgStr : String = ""
    var imageFilePath:URL! = nil
    var profileStatus : String = ""
    //var imagestatus : String = ""
    @IBOutlet weak var switch1: UISwitch!
    
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var plusImage: UIImageView!
    @IBOutlet var profileImage: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let emailAttriburedString = NSMutableAttributedString(string: "Enter your E-mail id")
        let passAttriburedString =  NSMutableAttributedString(string: "Password")
        let ConfirmAttriburedString = NSMutableAttributedString(string: "Confirm Password")
        let firstnameAttriburedString = NSMutableAttributedString(string: "First Name")
         let lastnameAttriburedString = NSMutableAttributedString(string: "Last Name")
         let dateofbirthAttriburedString = NSMutableAttributedString(string: "Date of Birth")
         let BiodescriptionAttriburedString = NSMutableAttributedString(string: "Bio Description")
        
        
        let asterix = NSAttributedString(string: "*", attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        emailAttriburedString.append(asterix)
        passAttriburedString.append(asterix)
        ConfirmAttriburedString.append(asterix)
        firstnameAttriburedString.append(asterix)
        lastnameAttriburedString.append(asterix)
        dateofbirthAttriburedString.append(asterix)
        BiodescriptionAttriburedString.append(asterix)
        self.emailid.attributedPlaceholder = emailAttriburedString
        self.firstName.attributedPlaceholder = firstnameAttriburedString
        self.lastName.attributedPlaceholder = lastnameAttriburedString
        self.bioDesp.attributedPlaceholder = BiodescriptionAttriburedString
        self.confirmPwd.attributedPlaceholder = ConfirmAttriburedString
        self.password.attributedPlaceholder = passAttriburedString
        self.dateOfBirth.attributedPlaceholder = dateofbirthAttriburedString
        
        
        scrollView.delegate = self
        
        
        password.isSecureTextEntry = true
        confirmPwd.isSecureTextEntry = true
        
//        signUpLabel.layer.shadowOpacity = 1.0
//        signUpLabel.layer.shadowColor = UIColor.lightGray.cgColor
        
//        headerView.layer.shadowOpacity = 0.1
//        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        signupButton.layer.shadowOpacity = 0.5
        signupButton.layer.shadowColor = UIColor.lightGray.cgColor
        signupButton.layer.cornerRadius = 10.0
        signupButton.layer.masksToBounds = true
    signupButton.frame = CGRect(x : 55.0,y :confirmPwd.frame.maxY + 130,width : signupButton.frame
            .size.width,height: signupButton.frame.size.height)
        profileImage.layer.cornerRadius = 45.0
        profileImage.clipsToBounds = true
        dateOfBirth.delegate = self
        dateOfBirth.tag = 1
        headerView.addShadowViewSignup()
        imagePicker.delegate = self
    
       
        lastName.delegate = self
        confirmPwd.delegate = self
        password.delegate = self
        dateOfBirth.delegate = self
        firstName.delegate = self
        emailid.delegate = self
        
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2
        profileImageView.layer.masksToBounds = false
       // profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1.0
        profileImageView.clipsToBounds = true
        let scrollHei: CGFloat? =  scrollView.frame.size.height + 100
        self.scrollView?.contentSize =  CGSize(width: self.view.frame.size.width, height: scrollHei!)
        
        scrollView.isScrollEnabled = true
        
         self.signupButton.applyGradient1()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swichAct(_ sender: UISwitch) {
        
        if switch1.isOn
        {
            profileStatus = "1"
        }
        else
        {
             profileStatus = "0"
        }
    }
    func getLocation()
    
    {
        let longitude :CLLocationDegrees = Double(Utils.getPreferenceValue(ForKey: Constant.LONGITUDE))!
        let latitude :CLLocationDegrees = Double(Utils.getPreferenceValue(ForKey: Constant.LATITUDE))!
        
        let location = CLLocation(latitude: latitude, longitude: longitude) //changed!!!
        // println(location)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            if let err = error {
                print(err.localizedDescription)
            } else if let placemarkArray = placemarks {
                if let placemark = placemarkArray.first {
                    print(placemark)
                    print(self.formAddressFromPlaceMark(sender: placemark))
                    // self.sourceLab.text = self.formAddressFromPlaceMark(sender: placemark)
                } else {
                    print("Placemark was nil")
                }
            } else {
                print("Unknown error")
            }
        })
        
        
        
    }
    
    
    
    func formAddressFromPlaceMark(sender:CLPlacemark) -> String
    {
        let pm = sender
        var st1:String="nil"
        var st2:String="nil"
        var st3:String="nil"
        var st4:String="nil"
        var st5:String="nil"
        var st6:String="nil"
        
        if((pm.thoroughfare) != nil)
        {
            st1 = "\(pm.thoroughfare!)"
        }
        
        if((pm.locality) != nil)
        {
            st2 = "\(pm.locality!)"
        }
        if((pm.subLocality) != nil)
        {
            st3 = "\(pm.subLocality!)"
            Utils.setPreferenceValue(setValue:st3 , ForKey: Constant.CURRENTLOCATION)
        }
        if((pm.administrativeArea) != nil)
        {
            st4 = "\(pm.administrativeArea!)"
        }
        if((pm.postalCode) != nil)
        {
            st5 = "\(pm.postalCode!)"
        }
        if((pm.country) != nil)
        {
            st6 = "\(pm.country!)"
            Utils.setPreferenceValue(setValue: st6, ForKey: Constant.COUNTRY)
        }
        
        let astring: NSString = "\(st1), \(st2), \(st3), \(st4), \(st5), \(st6)" as NSString
        let newString:NSString = astring.replacingOccurrences(of: "nil,", with: "") as NSString
        let newString1:NSString = newString.replacingOccurrences(of: "nil", with: "") as NSString
       
        return "\(newString1)"
    }

    @IBAction func ChooseImage(_ sender: UIButton) {
        
//        self.btnEdit.setTitleColor(UIColor.white, for: .normal)
//        self.btnEdit.isUserInteractionEnabled = true
        
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
        
        
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .photoLibrary
//
//        self.present(imagePicker, animated: true, completion: nil)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
      self.dismiss(animated: false, completion: nil)
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1
        {
            resignFirstResponder()
            fromDatePicker()
        }
       
        
    }
    
    func  fromDatePicker()
    {
        
  
        
         datePicker.maximumDate = Date()

         datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
        toolbar.setItems([doneButton,cancelButton], animated: false)


        dateOfBirth.inputAccessoryView=toolbar



        dateOfBirth.inputView=datePicker

        
    
        
        
       
        
        
    }
    
    
    
    
    @objc func donePressed()
        
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-mm-YYYY"
        
        dateFormatter.dateStyle = .medium
        
        dateOfBirth.text = dateFormatter.string(from: datePicker.date)
        
       
        
        
       //  datePicker.maximumDate = Date()
        
     //   let strDate = "\(dateFormatter.string(from: datePicker.date))"
        
       
        
      //  let birthFromStr = dateFormatter.date(from: strDate)! as Date

     //   datePicker.minimumDate = birthFromStr
        
         //5 -  get the current date
        //6- set the current date/time as a minimum
       // datePicker.date = currentDate as Date
   
       // datePicker.minimumDate = Date()
        
        print("Date Stamp: \(dateFormatter.string(from: datePicker.date))")
        
        self.view.endEditing(true)
        
        
        
        
        
        
        
    }
    @objc func cancel()
    {
        self.view.endEditing(true)
        
    }
    
    @IBAction func maleRadioAction(_ sender: UIButton) {
        
       
            
             maleRadioBtn.setImage(#imageLiteral(resourceName: "radiobutton"), for: .normal)
             femaleRadioBtn.setImage(#imageLiteral(resourceName: "radiobtn"), for: .normal)
            
            gender = "male"
        
        
        
    }
    
    @IBAction func femaleRadioAction(_ sender: UIButton) {
    
       
        
        maleRadioBtn.setImage(#imageLiteral(resourceName: "radiobtn"), for: .normal)
        femaleRadioBtn.setImage(#imageLiteral(resourceName: "radiobutton"), for: .normal)
        
       
            gender = "female"
       
        
        
    
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
            profileImageView.image = imag
            UserDefaults.standard.register(defaults: ["key2":UIImageJPEGRepresentation(imag, 100)!])
            UserDefaults.standard.set(UIImageJPEGRepresentation(imag, 100), forKey: "key2")
            plusImage.isHidden = true
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
    
    
    
    @IBAction func signUp(_ sender: UIButton) {

        

       
        
        if emailid.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter first name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
        else if firstName.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter last Name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
               
            })
            self.present(alert, animated: true)
            
        }
       else if lastName.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter Email Id", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
              
            })
            self.present(alert, animated: true)
            
        }
        else if password.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
            
        else if confirmPwd.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please confirm password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
            
        else if dateOfBirth.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please confirm password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
        else if bioDesp.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please confirm password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
        
       
        else
        {
            self.uploadImageAndData()
        }

        
        
    }
    
    
    func uploadImageAndData(){
        
        
        
        //coordinatelocation.findCoordinates()
        
        //parameters
         
        
        
//        let URL = "http://yourserviceurl/"
//        let image = UIImage(named: "image.png")
        let generateUUID = UIDevice.current.identifierForVendor?.uuidString
        Utils.setPreferenceValue(setValue: firstName.text!, ForKey: Constant.FIRST_NAME)
        Utils.setPreferenceValue(setValue: lastName.text!, ForKey: Constant.LAST_NAME)
        
        
        print(generateUUID!)
        Utils.setPreferenceValue(setValue:generateUUID! , ForKey: Constant.UDID)
       // self.loadSpinner(option:"0",Message: "Uploading please wait...")
        let imei_id:Data = Utils.getPreferenceValue(ForKey: Constant.UDID).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let gcmKey:Data = Utils.getPreferenceValue(ForKey: Constant.GCM_KEY).data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let loginType:Data = "3".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let oauthProvider:Data = "self".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let oauthUid:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        let firstNAME:Data = firstName.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let lastNAME:Data = lastName.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let Email:Data = emailid.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let Password:Data = password.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
         let Gender:Data = gender.data(using: String.Encoding.utf8, allowLossyConversion: false)!
         let DateofBirth:Data = dateOfBirth.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
         let Locale:Data = "en_IN".data(using: String.Encoding.utf8, allowLossyConversion: false)!
         let Link:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
         let bioDescription:Data = bioDesp.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!
         let Ip:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
         let Picture:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let Country:Data = Utils.getPreferenceValue(ForKey: Constant.COUNTRY).data(using: String.Encoding.utf8, allowLossyConversion: false)!
         let Countrycode:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let City:Data = "".data(using: String.Encoding.utf8, allowLossyConversion: false)!

//        let Latitude:Data = Utils.getPreferenceValue(ForKey: Constant.LATITUDE).data(using: String.Encoding.utf8, allowLossyConversion: false)!
//
//        let Longitude:Data = Utils.getPreferenceValue(ForKey: Constant.LONGITUDE).data(using: String.Encoding.utf8, allowLossyConversion: false)!
//
        
        print(Utils.getPreferenceValue(ForKey: Constant.LATITUDE))
        print(Utils.getPreferenceValue(ForKey: Constant.LONGITUDE))
        let Latitude:Data = "0.0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        let Longitude:Data = "0.0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        
        
        

        let Registertype:Data = "2".data(using: String.Encoding.utf8, allowLossyConversion: false)!

         let Mobileos:Data = "2".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
       
             let imagestatus = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
       
        
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
                    
                   // Utils.setPreferenceValue(setValue: self.imgStr, ForKey: Constant.PROFILE_URL)
                    
                }
                else {
                    
                }
                multipartFormData.append(imei_id, withName: "imei")
                multipartFormData.append(gcmKey, withName: "gcmkey")
                multipartFormData.append(loginType, withName: "logintype")
                multipartFormData.append(oauthProvider, withName: "oauthprovider")
                multipartFormData.append(oauthUid, withName: "oauth_uid")
                multipartFormData.append(firstNAME, withName: "first_name")
                multipartFormData.append(lastNAME, withName: "last_name")
                multipartFormData.append(Email, withName: "email")
                multipartFormData.append(Password, withName: "password")
                multipartFormData.append(Gender, withName: "gender")
                multipartFormData.append(DateofBirth, withName: "dob")
                multipartFormData.append(Locale, withName: "locale")
                multipartFormData.append(Link, withName: "link")
                multipartFormData.append(Ip, withName: "ip")
                multipartFormData.append(Picture, withName: "picture")
                multipartFormData.append(Country, withName: "country")
                multipartFormData.append(Countrycode, withName: "countrycode")
                multipartFormData.append(City, withName: "city")
                multipartFormData.append(Latitude, withName: "latitude")
                multipartFormData.append(Longitude, withName: "longitude")
                multipartFormData.append(Registertype, withName: "register_type")
                multipartFormData.append(Mobileos, withName: "mobile_os")
                multipartFormData.append(bioDescription, withName: "bio_descrip")
                 multipartFormData.append(imagestatus, withName: "img_status")
                
        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_USER_LOGIN)",
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
                            let alert = UIAlertController(title: "FoodWall!", message: "Sign up Successfull", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                              //  let next = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                                
                                
                                
                               let next = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginController
                                
                              
                                
                                self.present(next, animated: false, completion: nil)
                                signs = "1"
                                
                                //SELECTED_USER_ID //POST_IMAGE  //USER_ID  //EMAIL_ID //FIRST_NAME //LAST_NAME //PICTURE //GENDER //DOB
                                //IMAGE_VALUE //UDID //LATITUDE //LONGITUDE //COUNTRY
                                //CURRENTLOCATION //GCM_KEY //TOKENID //TRAINING_DATA_MODEL
                                //PROFILE_URL //EVENT_ID //PAGECUR //TIMELINE_ID //FOLLOWERID
                                //FOLLOW_ID //CREATED_BY_USERID //EMAIL_FOR_PWD //COMMENTS_USER_ID //QA_CREATEDBY // QUESTION_ID //MONTH
                                //STORY_IMAGE //CAPTION //NEWVALUE
                                
                               
                              
                                
                            })
                            self.present(alert, animated: true)
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


    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        
        textField.resignFirstResponder()
        return true;
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

extension UIView {
    func applyGradient1() {
        let gradient = CAGradientLayer()
        
        let yellowColor  = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.5).cgColor
        let orangeColor  = UIColor(red: 255/255, green: 128/255, blue:8/255, alpha: 1.5).cgColor
        
        
        
        
        gradient.colors = [orangeColor,yellowColor,yellowColor]   // your colors go here
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addShadowViewSignup() {
        //Remove previous shadow views
        superview?.viewWithTag(119900)?.removeFromSuperview()
        
        //Create new shadow view with frame
        let shadowView = UIView(frame: frame)
        shadowView.tag = 119900
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 3)
        shadowView.layer.masksToBounds = false
        let shadowSize : CGFloat = 5.0
//        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
//                                                   y: -shadowSize / 2,
//                                                   width: self.view.frame.size.width + shadowSize,
//                                                   height: self.view.frame.size.height + shadowSize))
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 3
        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true
        
        superview?.insertSubview(shadowView, belowSubview: self)
    }
}

