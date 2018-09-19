//
//  ProfileViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 30/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate {

    @IBOutlet weak var addFollowImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
   
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var editView: UIView!
    //@IBOutlet weak var totalPosts: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet var editProfileButton: UIButton!
   // @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var headerView: ShadowView!
    @IBOutlet weak var followButton: UIButton!
    var followText : String = ""
    var a : String = ""
    var imgStr : String = ""
    
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var bucketListView: UIView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var tapLabel3: UILabel!
    @IBOutlet weak var tapLabel2: UILabel!
    @IBOutlet weak var tapLabel1: UILabel!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var mapView: UIView!
    let imagePicker = UIImagePickerController()
  
    
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var totalPosts: UILabel!
    @IBOutlet weak var FollowLabel: UILabel!
   
    @IBOutlet weak var totalFollowing: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var totalFollowers: UILabel!
    // @IBOutlet weak var totalFollowing: UILabel!
    @IBOutlet weak var profImgView: UIImageView!
    var dataProfArray : NSArray = []
    var getfollowArray : NSArray = []
    var create_followArray : NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
         mapView.isHidden = false
        photoView.isHidden = true
        bucketListView.isHidden = true
        tapLabel1?.translatesAutoresizingMaskIntoConstraints = false
        headerView.addDropShadowToView(targetView: headerView)
        editProfileButton.layer.cornerRadius = 10.0
        editProfileButton.clipsToBounds = true
        profImgView.layer.cornerRadius = profImgView.frame.size.width/2
        profImgView.clipsToBounds = true
        imagePicker.delegate = self
         scrollview.isScrollEnabled = true
       
       // editProfileButton.frame = CGRect( x: 100 , y: 157 ,width : 90 ,height :25 )
        
       if  Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID) == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
       {
        editProfileButton.setTitle("Edit Profile", for: .normal)
        
        messageView.isHidden = true
        editView.isHidden = false
//        editProfileButton.frame = CGRect( x: self.view.frame.size.width/2 - 20, y: 157 ,width : 170 ,height :25 )
        addFollowImageView.isHidden = true
        //FollowLabel.isHidden = true
        followButton.isHidden = true
        }
        else
       {
        messageView.isHidden = false
        editView.isHidden = true
        editProfileButton.setTitle("Message", for: .normal)
//        editProfileButton.frame = CGRect( x: self.view.frame.size.width/2 - 50 , y: 157 ,width : 90 ,height :25)
        addFollowImageView.isHidden = false
      //  FollowLabel.isHidden = false
        }
     //   profileViewDetails()
         editProfileButton.applyGradient1()
         messageBtn.applyGradient1()
        stack1.addDropShadowToView(targetView: stack1)
       // editProfileButton =
//     Utils.addGradientBackgroundLayer(editProfileButton)

        // Do any additional setup after loading the view.
    }

    @IBAction func backActt(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileViewDetails()
    }
    @IBAction func FollowAction(_ sender: UIButton) {
        
        if FollowLabel.text == "Follow"
        {
            
           // FollowLabel.text = "Following"
            followText = "1"
            addFollowImageView.image =  #imageLiteral(resourceName: "followers")
            self.followfunction()
        }
        
        else
        {
            let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to want to UnFollow?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                //self.FollowLabel.text = "Follow"
                self.followText = "0"
                self.addFollowImageView.image =  #imageLiteral(resourceName: "add-user-2")
               
                self.followfunction()
            }
            let cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            
            
       }
        
       
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookLogout(_ sender: UIButton) {
        
        let manager = FBSDKLoginManager()
        manager.logOut()
    }
    
    @IBAction func backAciton(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
  
     @IBAction func editProfileAction(_ sender: UIButton) {
        
      
        let page:EditProfileController = self.storyboard?.instantiateViewController(withIdentifier: "editprofile") as! EditProfileController
        
        page.userid = (self.dataProfArray[0] as AnyObject).value(forKey: "user_id") as! String
        page.firstName = (self.dataProfArray[0] as AnyObject).value(forKey: "first_name") as! String
        page.lastName = (self.dataProfArray[0] as AnyObject).value(forKey: "last_name") as! String
        page.genderR = (self.dataProfArray[0] as AnyObject).value(forKey: "gender") as! String
        page.emailid = (self.dataProfArray[0] as AnyObject).value(forKey: "email") as! String
        page.DOB = (self.dataProfArray[0] as AnyObject).value(forKey: "dob") as! String
        page.biodesc = (self.dataProfArray[0] as AnyObject).value(forKey: "bio_description") as! String
        page.imageString = (self.dataProfArray[0] as AnyObject).value(forKey: "picture") as! String
        
        self.present(page, animated: true, completion: nil)
        
        
     } 
    
    @IBAction func ViewFollwers(_ sender: UIButton) {
        
        a = "1"
        let page:FollowersTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "followers") as! FollowersTableViewController
        page.pro = a
        page.userFollowingsArray = getfollowArray
        self.present(page, animated: true, completion: nil)
        
        
    }
    
    @IBAction func viewFollwings(_ sender: UIButton) {
        
        
        a = "2"
        
        let page:FollowersTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "followers") as! FollowersTableViewController
        page.pro = a
        self.present(page, animated: true, completion: nil)
        
        
    }
    
    
    func getfollowings()
    {
        
//        var userid :String = ""
//
//        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) != Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)
//        {
//
//            userid = Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)
//
//        }
//        else
//        {
//
//            userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
//
//        }
        
        
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWINGS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.getfollowArray = resData as! [[String:AnyObject]] as NSArray
                
                if(self.getfollowArray.count != 0){
                    
                    for i in 0..<self.getfollowArray.count
                    {
                        
                        if "\((self.getfollowArray[i] as AnyObject).value(forKey: "following_id") as! String)" == Utils.getPreferenceValue(ForKey: Constant.FOLLOW_ID)
                        {
                            
                          //  self.FollowLabel.text = "Following"
                            self.addFollowImageView.image = #imageLiteral(resourceName: "followers")
                            
                            
                        }
                        
                        
                        
                    }

                    
                    
                }
                    
                else
                    
                {
                    
                    print("EMpty")
                    
                    
                }
            }
            
        }
        
        
        
    }
    
   
    func followfunction()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"followerid" : Utils.getPreferenceValue(ForKey: Constant.CREATED_BY_USERID) , "follow" : followText]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_FOLLOWER)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if let resData = json["Data"].arrayObject {
                
                self.create_followArray = resData as! [[String:AnyObject]] as NSArray
                
                if(self.create_followArray.count != 0){
                    
                    print(self.create_followArray)
                    
                    Utils.setPreferenceValue(setValue: "\((self.create_followArray[0] as AnyObject).value(forKey: "following_id")!)", ForKey: Constant.FOLLOW_ID)
                    
                    
                    
                    
                }
                    
                else
                    
                {
                    
                   print("Nodata")
                    
                    
                   
                    
                    
                    
                }
            }
            
        }
        
        
        
        
        
    }
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
    
    
    func profileViewDetails()
        
    {
        
        
        if Utils.getPreferenceValue(ForKey: Constant.FOLLOWERID) != "0"
        {
           
           // self.FollowLabel.text = "Following"
            self.addFollowImageView.image = #imageLiteral(resourceName: "followers")
            
        }
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID),"yourid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
       //
        let urlString = "\(Constant.BASEURL)\(Constant.GET_PROFILE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if let resData = json["Data"].arrayObject {
                
                self.dataProfArray = resData as! [[String:AnyObject]] as NSArray
                
                if(self.dataProfArray.count != 0){
                    
                    
                    print(self.dataProfArray)
                    
                    self.userName.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "first_name") as! String)   \((self.dataProfArray[0] as AnyObject).value(forKey: "last_name") as! String)"
                    self.totalFollowing.text! = ((self.dataProfArray[0] as AnyObject).value(forKey: "total_followings") as? String)!
                    self.totalFollowers.text! = (self.dataProfArray[0] as AnyObject).value(forKey: "total_followers") as! String
                    self.totalPosts.text! = (self.dataProfArray[0] as AnyObject).value(forKey: "total_posts") as! String
                  self.headingLabel.text! = "\((self.dataProfArray[0] as AnyObject).value(forKey: "first_name") as! String)   \((self.dataProfArray[0] as AnyObject).value(forKey: "last_name") as! String)"
                    self.profImgView.sd_setImage(with: URL(string:(self.dataProfArray[0] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
                    Utils.setPreferenceValue(setValue: (self.dataProfArray[0] as AnyObject).value(forKey: "picture") as! String, ForKey: Constant.PROFILE_URL)
                    
                }
                    
                else
                    
                {
                    
                   print("Empty")
                    
                    
                    
                }
            }
            
            
        }
        
        
        
        
        
    }
    
    
    
    @IBAction func changePicture(_ sender: UIButton) {
        
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
            
            //  let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
            let seleImg_Data = UIImageJPEGRepresentation(imag , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            print("the img str : \(base64_str?.characters.count)")
            
            imgStr = base64_str!
            profImgView.image = imag
            
            
            let userID :Data = Utils.getPreferenceValue(ForKey: Constant.USER_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!
            
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
                                
                            let alert = UIAlertController(title: "Message!", message: "Uploaded Successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
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
    
    
    
    
    @IBAction func historicalMapAct(_ sender: UIButton) {
        mapView.isHidden = false
        bucketListView.isHidden = true
        photoView.isHidden = true
        tapLabel1.isHidden = false
        tapLabel3.isHidden = true
        tapLabel2.isHidden = true
        
        
        // view.addConstraints([horConstraint])
    }
    
    @IBAction func photosAct(_ sender: UIButton) {
        
        mapView.isHidden = true
        bucketListView.isHidden = true
        photoView.isHidden = false
        tapLabel1.isHidden = true
        tapLabel3.isHidden = true
        tapLabel2.isHidden = false
        
        
    }
    
    @IBAction func bucketLisACT(_ sender: UIButton) {
        
        bucketListView.isHidden = false
        mapView.isHidden = true
        photoView.isHidden = true
        tapLabel1.isHidden = true
        tapLabel3.isHidden = false
        tapLabel2.isHidden = true
        
        
        
    }


}
extension UIView {
    
    func addShadowViewProfile() {
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
    
}

