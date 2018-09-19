//
//  LoginController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import SwiftyJSON
import LocalAuthentication
import MapKit
//import CoreLocation
import CoreData


var login_type = ""

let locManager = CLLocationManager()
class LoginController: UIViewController,UITextFieldDelegate,GIDSignInUIDelegate,GIDSignInDelegate,MKMapViewDelegate {
    //CLLocationManagerDelegate
    
    var dict : [String : AnyObject]!
    var dataArray :NSArray = []
    // let locManager = CLLocationManager()
    var currentLocation = CLLocation()
    // var loginButtons = LoginButton(readPermissions: [ .publicProfile ])
    @IBOutlet var arrowView: UIView!
    @IBOutlet var arrowButton: UIButton!
    
    @IBOutlet var faceBookLogin: UIButton!
    //      let myColor : UIColor = UIColor(red: 255/255, green: 200/255, blue:55/255, alpha: 1.5)
    @IBOutlet var googleView: UIView!
    @IBOutlet var facebookVIew: UIView!
    @IBOutlet var signGoogleLabel: UILabel!
    @IBOutlet var authenticationView: UIView!
    @IBOutlet var password: UITextField!
    @IBOutlet var userName: UITextField!
    

    @IBOutlet weak var forGotPasswordLabel: UILabel!
    @IBOutlet var createAccntLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    var authProvider = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
      //  locManager.delegate = self
        //        var loginButtonview = LoginButton(readPermissions: [ .publicProfile ])
        //        loginButtonview.center = view.center
        //
        //        view.addSubview(loginButtonview)
        
//        locManager.requestWhenInUseAuthorization()
//        locManager.requestAlwaysAuthorization()
//        locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locManager.requestAlwaysAuthorization()
//        locManager.startUpdatingLocation()
       // indicator.hidesWhenStopped = true
      //  indicator.isHidden = true
        
        Utils.setPreferenceValue(setValue: "0.0", ForKey: Constant.LATITUDE)
        Utils.setPreferenceValue(setValue: "0.0", ForKey: Constant.LONGITUDE)
        
      //  findCoordinates()
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(LoginController.pwdFunction))
        forGotPasswordLabel.isUserInteractionEnabled = true
        forGotPasswordLabel.addGestureRecognizer(tap3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginController.tapFunction))
        createAccntLabel.isUserInteractionEnabled = true
        createAccntLabel.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(LoginController.GoogleSignIN))
        signGoogleLabel.isUserInteractionEnabled = true
        signGoogleLabel.addGestureRecognizer(tap2)
        
        userName.delegate = self
        password.delegate = self
        
        //creating button
        //        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        //        loginButton.center = view.center
        
        //adding it to view
        // view.addSubview(loginButton)
        
        //if the user is already logged in
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
        }
        // loginButtonview = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.layer.cornerRadius = 20.0
        loginButton.layer.masksToBounds = true
        
        userName.layer.cornerRadius = 5.0
        userName.layer.masksToBounds = true
        
        password.layer.cornerRadius = 5.0
        password.layer.masksToBounds = true
        password.isSecureTextEntry = true
        //googleView.layer.borderWidth = 1.0
        googleView.layer.shadowOpacity = 1.0
        googleView.layer.shadowColor = UIColor.lightGray.cgColor
        
        self.authenticationView.applyGradient()
        self.loginButton.applyGradient()
        
        arrowButton.layer.cornerRadius = 25.0
        arrowButton.clipsToBounds = true
        arrowView.layer.cornerRadius = 30.0
        arrowView.clipsToBounds = true
        arrowView.layer.shadowOpacity = 30.0
        arrowView.layer.shadowColor = UIColor.lightGray.cgColor
        
        // Do any additional setup after loading the view.
        
        //         loginButton.addTarget(self, action: #selector(LoginController.GoogleSignIN), forControlEvents: .TouchUpInside)
        
        
        
        
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        let string = "\(testStr)"
        var output = ""
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        var result = emailTest.evaluate(with: testStr)
        if result == true
        {
            for chr in string {
                var str = String(chr)
                if str.lowercased() != str {
                    output += str
                    result = false
                    
                }
            }
            
            
        }
        
        print(output)
        
        
        
        return result
        
    }
    
    
    
    @objc func pwdFunction()
    {
        
        let page:resetPasswordController = self.storyboard?.instantiateViewController(withIdentifier: "reset") as! resetPasswordController
        self.present(page, animated: true, completion: nil)
        
        
    }
    
    
    func findCoordinates()
    {
        
        if(CLLocationManager.locationServicesEnabled())
        {
            print("3")
            // let location = CLLocation()
            //            location.delegate = self
            //            location.requestLocation()
            
            //            location.desiredAccuracy = kCLLocationAccuracyBest
            //            location.startUpdatingLocation()
            //            map.showsUserLocation = true
            //            map.delegate = self
            
            
            if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                
                CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorized){
                
                print("2")
                if locManager.location != nil{
                    print("1")
                    currentLocation = locManager.location!
                    print(currentLocation.coordinate)
                    print(currentLocation.coordinate.latitude)
                    print(currentLocation.coordinate.longitude)
                    Utils.setPreferenceValue(setValue: "\(currentLocation.coordinate.latitude)", ForKey: Constant.LATITUDE)
                    Utils.setPreferenceValue(setValue: "\(currentLocation.coordinate.longitude)", ForKey: Constant.LONGITUDE)
                    
                }
                
                
                
            }
            
        }
        
        
    }
    
    
    
    
    @objc func tapFunction()
    {
        
        let page:SignUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        
        self.present(page, animated: true, completion: nil)
        
        
    }
    
    
    
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        
        //        let page:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
        //        self.present(page, animated: false, completion: nil)
        login_type = "3"
        
        if isValidEmail(testStr: userName.text!) == false
        {
            
            let alertController = UIAlertController(title: "FoodWall", message: "Please enter valid Email-id", preferredStyle: .alert)
            
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        
        
        else if self.userName.text == ""
        {
            let alertController = UIAlertController(title: "FoodWall", message: "Please enter Email-id", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
            }
            
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        else if self.password.text == ""
        {
            
            let alertController = UIAlertController(title: "FoodWall", message: "Please enter Password", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
            
        else if isValidEmail(testStr: userName.text!) == false
        {
            
            let alertController = UIAlertController(title: "FoodWall", message: "Please enter valid Email-id", preferredStyle: .alert)
            
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
        }
            
        else
        {
            
            self.loginFunction()
            
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loginFunction()
    {
//        indicator.isHidden = false
//        indicator.hidesWhenStopped = true
      Utils.svprogressHudShow(title: "Loading", view: self)
        
       // indicator.startAnimating()
        let generateUUID = UIDevice.current.identifierForVendor?.uuidString
        
        
        print(generateUUID!)
        Utils.setPreferenceValue(setValue:generateUUID! , ForKey: Constant.UDID)
       
        
        let params: [String:String] = ["username" : userName.text!,"password" : password.text!,"latitude":"\(currentLocation.coordinate.latitude)","longitude" :"\(currentLocation.coordinate.longitude)","imei" : generateUUID!,"gcmkey" : Utils.getPreferenceValue(ForKey: Constant.GCM_KEY)]
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.LOGIN_URL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data:response.data!)
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    self.dataArray = innerDict as! NSArray
                    
                   // self.indicator.stopAnimating()
                    Utils.svprogressHudDismiss(view: self)
                    self.showToast(message: "Login Successfull")
                    Utils.setPreferenceValue(setValue: "1", ForKey: Constant.isLoggedIn)
                    let page:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                    
                    self.present(page, animated: false, completion: nil)
                    
                    
                    
                    //                    let dict = self.dataArray
                    
                    let imageValue = json["Data"][0]["picture"]
                    let userid = json["Data"][0]["user_id"]
                    let firstName = json["Data"][0]["first_name"]
                    let lastName = json["Data"][0]["last_name"]
                    
                    Utils.setPreferenceValue(setValue: "\(imageValue)", ForKey: Constant.PROFILE_URL)
                    Utils.setPreferenceValue(setValue: "\(userid)", ForKey: Constant.USER_ID)
                    Utils.setPreferenceValue(setValue: "\(firstName)", ForKey: Constant.FIRST_NAME)
                    Utils.setPreferenceValue(setValue: "\(lastName)", ForKey: Constant.LAST_NAME)
                    print(self.dataArray)
                    signs = "2"
                    
                }
                    
                else
                {
                      Utils.svprogressHudDismiss(view: self)
                    let alertController = UIAlertController(title: "FoodWall", message: "Please enter Valid Credentials", preferredStyle: .alert)
                    
                    
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                        UIAlertAction in
                       Utils.svprogressHudDismiss(view: self)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
                
            else
            {
                  Utils.svprogressHudDismiss(view: self)
                let alertController = UIAlertController(title: "FoodWall", message: "Check your internet connection..", preferredStyle: .alert)
                
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                      Utils.svprogressHudDismiss(view: self)
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
                presentViewController viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
                dismissViewController viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func loginFunction1()
        
    {
           Utils.svprogressHudShow(title:"Loading..", view:self)
        
//        indicator.startAnimating()
//        indicator.hidesWhenStopped = true
        let generateUUID = UIDevice.current.identifierForVendor?.uuidString
        
        
        print(generateUUID!)
        Utils.setPreferenceValue(setValue:generateUUID! , ForKey: Constant.UDID)
        
        let params: [String:String] = ["imei" :Utils.getPreferenceValue(ForKey: Constant.UDID) ,"gcmkey" :Utils.getPreferenceValue(ForKey: Constant.GCM_KEY) ,"logintype":login_type,"oauthprovider" :authProvider,"oauth_uid" :"11009988445566774","first_name" :Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME),"last_name" :Utils.getPreferenceValue(ForKey: Constant.LAST_NAME),"email":Utils.getPreferenceValue(ForKey: Constant.EMAIL_ID),"password":"","gender":Utils.getPreferenceValue(ForKey:     Constant.GENDER),"dob":"","locale":"en_IN","link":"","ip":"","picture":Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL),"latitude":Utils.getPreferenceValue(ForKey: Constant.LATITUDE),"longitude":Utils.getPreferenceValue(ForKey: Constant.LONGITUDE),"register_type":"2","image":"","country":"","countrycode":"","mobile_os":"2","bio_descrip": "New User"]
        
        
        print(params)
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_USER_LOGIN)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            print(result)
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    self.dataArray = innerDict as! NSArray
                          Utils.svprogressHudDismiss(view: self)
                    //self.indicator.stopAnimating()
                    let userId = "\((self.dataArray[0] as AnyObject).value(forKey: "user_id") as! String)"
                    
                    (Utils.setPreferenceValue(setValue: "\(userId)", ForKey: Constant.USER_ID))
                    Utils.setPreferenceValue(setValue: "1", ForKey: Constant.isLoggedIn)
                    
                    let page:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
                    self.present(page, animated: false, completion: nil)
                    
                    
                    
                    print(self.dataArray)
                    
                }
                    
                else
                {
                       Utils.svprogressHudDismiss(view: self)
                    //self.indicator.stopAnimating()
                    self.showToast(message: "Server Error")
                }
            }
                
            else
            {
                
                   Utils.svprogressHudDismiss(view: self)
                //self.indicator.stopAnimating()
                self.showToast(message: "Server Error")
                
                
            }
            
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            
            
            
            //            let userId = user.userID
            //            let idToken = user.authentication.idToken
            //            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            let token = user.authentication.idToken
            // let imageValue = user.profile.hasImage
            // let imgValue = Bool(imageValue)
            let pic = user.profile.imageURL(withDimension: 100)!
            print(pic)
            // let gender = user.profile.gender
            
            
            
            
            
            login_type = "2"
            authProvider = "google"
            
            (Utils.setPreferenceValue(setValue: email!, ForKey: Constant.EMAIL_ID))
            (Utils.setPreferenceValue(setValue: givenName!, ForKey: Constant.FIRST_NAME))
            (Utils.setPreferenceValue(setValue: familyName!, ForKey: Constant.LAST_NAME))
            Utils.setPreferenceValue(setValue: "\(pic)", ForKey: Constant.PROFILE_URL)
            //
            //            emailClick = "2"
            //            gmailVar = "1"
            
            
            self.loginFunction1()
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //
            //            let mainViewController = storyboard.instantiateViewController(withIdentifier: "home") as! ViewController
            //            self.window?.rootViewController = mainViewController
            //
            //            self.window?.makeKeyAndVisible()
            
            
        }
            
            
        else {
            
            
            
            
            print("\(error.localizedDescription)")
        }
    }
    
    
    
    //
    //    func signIn(_signIn: GIDSignIn!,
    //                presentViewController viewController: UIViewController!) {
    //
    //
    //       // emailClick = "2"
    //
    //
    //        self.present(viewController, animated: true, completion: nil)
    //    }
    //
    //
    //    func sign(_ signIn: GIDSignIn!,
    //              dismiss viewController: UIViewController!) {
    //
    //
    //
    //
    //        self.dismiss(animated: true, completion: nil)
    //    }
    //
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    //    {
    //        textField.resignFirstResponder()
    //        return true;
    //    }
    
    @IBAction func facebookAction(_ sender: UIButton) {
        
        
        
        login_type = "1"
        
        AccessToken.refreshCurrentToken(AccessTokenRefreshed)
        
        if AccessToken.current != nil {
            print(AccessToken.current)
        }
        else
        {
            //            let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
            //            loginButton.delegate=self
            //            //loginButton.loginBehavior = LoginBehavior.systemAccount
            //            loginButton.center = view.center
            //            view.addSubview(loginButton)
        }
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                }
            }
        }
        
        
        
    }
    func AccessTokenRefreshed(accessToken:AccessToken?, error: Error?)
    {
        if (AccessToken.current != nil)
        {
            print("ok")
            // getFBUserData()
            
            // Utils.setPreferenceValue(setValue: AccessToken, ForKey: <#T##String#>)
        }
        else
        {
            
            print("not ok")
        }
    }
    
    
    
    
    @objc func GoogleSignIN() {
        GIDSignIn.sharedInstance().signIn()
        login_type = "2"
        
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getFBUserData(){
        
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, gender"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    self.dict = result as! [String : AnyObject]
                    //everything works print the user data
                    //                     print(result)
                    
                    
                    self.dict = result as! [String : AnyObject]
                    // let dataArr : NSArray = dict as NSArray
                    login_type = "1"
                    self.authProvider = "facebook"
                    (Utils.setPreferenceValue(setValue: (self.dict as AnyObject).value(forKey: "email") as! String, ForKey: Constant.EMAIL_ID))
                    (Utils.setPreferenceValue(setValue: (self.dict as AnyObject).value(forKey: "first_name") as! String, ForKey: Constant.FIRST_NAME))
                    (Utils.setPreferenceValue(setValue:  (self.dict as AnyObject).value(forKey: "last_name") as! String, ForKey: Constant.LAST_NAME))
                    (Utils.setPreferenceValue(setValue:  (self.dict as AnyObject).value(forKey: "gender") as! String, ForKey: Constant.GENDER))
                    //  (Utils.setPreferenceValue(setValue:  (self.dict as AnyObject).value(forKey: "url") as! String, ForKey: Constant.PROFILE_URL))
                    //  print(json)
                    
                    self.loginFunction1()
                    
                }
                    
                    
                else
                    
                {
                    
                    
                }
            })
        }
    }
    
}

extension UIView {
    func applyGradient() {
        let gradient = CAGradientLayer()
        
        let yellowColor  = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.5).cgColor
        let orangeColor  = UIColor(red: 255/255, green: 128/255, blue:8/255, alpha: 1.5).cgColor
        
        gradient.colors = [orangeColor,yellowColor,yellowColor]   // your colors go here
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    
    func applyGradientblue() {
        let gradient = CAGradientLayer()
        
        let blueColor  = UIColor(red: 0.2, green: 0.4, blue: 0.7, alpha: 1.0).cgColor
        let darkBlueColor  = UIColor(red: 0.4, green: 0.6, blue:0.9, alpha: 1.0).cgColor
        
        gradient.colors = [blueColor,darkBlueColor,darkBlueColor]   // your colors go here
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradientYellow() {
        let gradient = CAGradientLayer()
        
        //  let yellowColor  = UIColor(red: 248/255, green: 223/255, blue: 143/255, alpha:1.0 ).cgColor
        //        let white  = UIColor(red: 255/255, green: 128/255, blue:8/255, alpha: 1.5).cgColor
        let yellowColor  = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.5).cgColor
        
        let orangeColor  = UIColor(red: 255/255, green: 128/255, blue:8/255, alpha: 1.5).cgColor
        
        gradient.colors = [yellowColor,yellowColor,orangeColor]   // your colors go here
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.5, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}


