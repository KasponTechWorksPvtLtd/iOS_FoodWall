//
//  MenuViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController ,UITabBarDelegate{

    @IBOutlet var ViewProfileLabel: UILabel!
    @IBOutlet var EventsLabel: UILabel!
    @IBOutlet var headerView: UIView!
    
   
    @IBOutlet weak var logout: UILabel!
    @IBOutlet weak var About: UILabel!
    @IBOutlet weak var headerView1: UIView!
    @IBOutlet weak var updatePassword: UILabel!
    @IBOutlet weak var editProfile: UILabel!
    @IBOutlet weak var ProfName: UILabel!
    @IBOutlet var profileIMAGE: UIImageView!
    @IBOutlet var bottomBar: UITabBar!
    @IBOutlet var menuBarItem: UITabBarItem!
    @IBOutlet var notificationsButton: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
       // headerView1.addShadowView()
        bottomBar.selectedItem = menuBarItem
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        bottomBar.selectedItem?.title = "Menu"
        bottomBar.isHidden = false
       
        
        ProfName.text = Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME) + (" ") + Utils.getPreferenceValue(ForKey: Constant.LAST_NAME)
        viewAction.layer.cornerRadius = viewAction.frame.size.width/2
        viewAction.clipsToBounds = true
        profileIMAGE.layer.cornerRadius = profileIMAGE.frame.size.width/2
        profileIMAGE.clipsToBounds = true
        
//        profileIMAGE.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)), placeholderImage: UIImage(named: "default"))
     
       // let imageFromData = UIImage(data: imageData)!
//        if UserDefaults.standard.value(forKey: "key2") as? Data == nil
//        {
        if signs == "2"
        {
          profileIMAGE.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)), placeholderImage: UIImage(named: "default"))
        }
        
        else if signs == "1"
        {
           // let imageData = UserDefaults.standard.value(forKey: "key2") as! Data
           // profileIMAGE.image = UIImage(data: imageData)!
        }
        else
        {
             profileIMAGE.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)), placeholderImage: UIImage(named: "default"))
        }
//        }

//        else
//        {
//            let imageData = UserDefaults.standard.value(forKey: "key2") as! Data
//              profileIMAGE.image = UIImage(data: imageData)!
//        }
      
        
       let superview = UIView(frame: CGRect(x:0, y:0, width:200,height:200))

        let shadowView = UIView(frame: CGRect(x:50, y:50, width:100,height:100))
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 5

       let view = MyView(frame: shadowView.bounds)
        
         // let view = UIView(frame: CGRect(x:50, y:50, width:100,height:100))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true

        shadowView.addSubview(view)
        superview.addSubview(shadowView)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.tapFunction))
       ViewProfileLabel.isUserInteractionEnabled = true
        ViewProfileLabel.addGestureRecognizer(tap)
//        let tap1 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.tapFunction))
//        ProfName.isUserInteractionEnabled = true
//        ProfName.addGestureRecognizer(tap1)
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.editProfileAction))
        editProfile.isUserInteractionEnabled = true
        editProfile.addGestureRecognizer(tap4)
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.updatePasswordAction))
        updatePassword.isUserInteractionEnabled = true
        updatePassword.addGestureRecognizer(tap5)
//        let tap6 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.aboutAction))
//        About.isUserInteractionEnabled = true
//        About.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.logOutAction))
        logout.isUserInteractionEnabled = true
        logout.addGestureRecognizer(tap7)
        
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.tapFunction1))
        EventsLabel.isUserInteractionEnabled = true
        EventsLabel.addGestureRecognizer(tap2)
        
        
        
        

        headerView.addShadowView()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if(bottomBar.selectedItem == reviewButton){
            
            
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            self.present(page, animated: true, completion: nil)
            
//            let page1:ReviewMainVC = self.storyboard?.instantiateViewController(withIdentifier: "reviewmain") as! ReviewMainVC
//            self.present(page1, animated: true, completion: nil)
        }
        
    }
    

    @IBOutlet var viewAction: UIButton!
  
    @objc func tapFunction()
    {

        let page:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! ProfileViewController
        Utils.setPreferenceValue(setValue: Utils.getPreferenceValue(ForKey: Constant.USER_ID) , ForKey: Constant.SELECTED_USER_ID)
        self.present(page, animated: true, completion: nil)


    }
    
    @objc func logOutAction()
    {
        let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to want to Logout?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            
            let page:LoginController = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginController
            self.present(page, animated: true, completion: nil)
            
            
            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.SELECTED_USER_ID)
                                 
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.USER_ID)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.EMAIL_ID)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.FIRST_NAME)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.LAST_NAME)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.PICTURE)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.GENDER)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.DOB)
//
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.UDID)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.LATITUDE)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.LONGITUDE)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.COUNTRY)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.CURRENTLOCATION)
//                                            Utils.setPreferenceValue(setValue:"" , ForKey: Constant.GCM_KEY)
            
          
            
                                            Utils.removePreferenceValue(ForKey: Constant.USER_ID)
                                            Utils.removePreferenceValue(ForKey: Constant.EMAIL_ID)
                                            Utils.removePreferenceValue(ForKey: Constant.FIRST_NAME)
                                             Utils.removePreferenceValue(ForKey: Constant.LAST_NAME)
                                            Utils.removePreferenceValue(ForKey: Constant.PICTURE)
                                            Utils.removePreferenceValue(ForKey: Constant.GENDER)
                                                Utils.removePreferenceValue(ForKey: Constant.DOB)
                                            Utils.removePreferenceValue(ForKey: Constant.LATITUDE)
                                            Utils.removePreferenceValue(ForKey: Constant.LONGITUDE)
                                             Utils.removePreferenceValue(ForKey: Constant.COUNTRY)
                                             Utils.removePreferenceValue(ForKey: Constant.CURRENTLOCATION)
                             
            
            
           Utils.setPreferenceValue(setValue: "0", ForKey: Constant.isLoggedIn)
            
            
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
//    @objc func aboutAction()
//    {
//
//        let page:ProfileHeadController = self.storyboard?.instantiateViewController(withIdentifier: "profilehead") as! ProfileHeadController
//        self.present(page, animated: true, completion: nil)
//
//
//    }
    @IBAction func backAct(_ sender: Any) {
        
       self.dismiss(animated: false, completion: nil)
        
        
        
    }
    @objc func updatePasswordAction()
    {
        
        
        let page:UpdatePasswordController = self.storyboard?.instantiateViewController(withIdentifier: "password") as! UpdatePasswordController
        self.present(page, animated: true, completion: nil)
        
        
    }
    @objc func editProfileAction()
    {

        let page:EditProfileController = self.storyboard?.instantiateViewController(withIdentifier: "editprofile") as! EditProfileController
        self.present(page, animated: true, completion: nil)


    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    @objc func tapFunction1()
    {
        
        let page:EventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventsview") as! EventsViewController
        self.present(page, animated: true, completion: nil)
        
        
    }

    @IBAction func ViewProfileAction(_ sender: UIButton) {
        
      
      print("viewprofielaction")
        
        
    }
    
    
}

extension UIView {
    
    func addShadowView() {
        //Remove previous shadow views
        superview?.viewWithTag(119900)?.removeFromSuperview()
        
        //Create new shadow view with frame
        let shadowView = UIView(frame: frame)
        shadowView.tag = 119900
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 3)
        shadowView.layer.masksToBounds = false
        
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shadowRadius = 2.0  // 3
        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true
        
        superview?.insertSubview(shadowView, belowSubview: self)
    }
    
}
