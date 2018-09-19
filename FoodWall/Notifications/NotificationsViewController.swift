//
//  NotificationsViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//
//1,4,5,7
import UIKit
import Alamofire
import SwiftyJSON

class NotificationsViewController: UIViewController,UITabBarDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var captionView: UITextView!
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var followerslabel: UILabel!
    
    
    @IBOutlet weak var followersview: UIView!
    
    @IBOutlet weak var notification: UILabel!
    
    @IBOutlet weak var Nonotificationview: UIView!
     @IBOutlet weak var Mytable: UITableView!
    
  //  @IBOutlet weak var selectedImage: ScaledHeightImageView!
    // @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var selectedImage: ScaledHeightImageView!
    @IBOutlet var bottomBar: UITabBar!
    @IBOutlet var menuBarItem: UITabBarItem!
    @IBOutlet var notificationsButton: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!
    let imagePicker = UIImagePickerController()
    var newImage : String = ""
    var getImage = UIImage(named : "")
    
    var followerArray : NSArray = []
    var followcount : NSArray = []
    var NotificationArray : NSArray = []
    var NotificationsetArray : NSArray = []
    var Notificationcount : NSArray = []
    var ALLNotificationArray : NSArray = []
    
    
    var dataArray1 = [[String:AnyObject]]()
    var Notificationcountforrow = -1
    var followrow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Nonotificationview.isHidden = true
        self.followersview.isHidden = false
        findnumberoffollowers()
        // getnotificationcount()
        getnotificationallAPI()
        Mytable.frame = CGRect(x: 0, y: 149 , width: 375, height: 500)
        notification.frame = CGRect(x: 8, y: 125 , width: 367, height: 21)
        bottomBar.selectedItem = notificationsButton
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        bottomBar.selectedItem?.title = "Notifications"
        bottomBar.isHidden = false
        captionView.delegate = self
        captionView.text = "Add a Caption"
        captionView.textColor = UIColor.lightGray
        imagePicker.delegate = self
        selectedImage.image = getImage
     
        doneBtn.layer.cornerRadius = 10.0
        doneBtn.clipsToBounds = true
        doneBtn.applyGradient()
        
        Mytable.delegate = self
        Mytable.dataSource = self
        
        Mytable.separatorStyle = .none
        self.Mytable.isHidden = false
        
        
        
          headerView.addShadowView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("clicked")
        NotificationsetArray = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray))
 
        // print("\(((self.NotificationsetArray[indexPath.row] as! AnyObject).value(forKey: "user_id") as! NSString) )")
        if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "1"
            
            
        {
            
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
            // print("\(((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray))")
            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
            
            page.question_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "2"
            
            
        {
           
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
           
            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
            
            page.question_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "3"
            
            
        {
            
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
            
            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
            
            page.question_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "10"
            
            
        {
          
            let page:FoodStreetController = self.storyboard?.instantiateViewController(withIdentifier: "foodStreet") as! FoodStreetController
           
             page.eventId = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "11"
            
            
        {
            
            let page:FoodStreetController = self.storyboard?.instantiateViewController(withIdentifier: "foodStreet") as! FoodStreetController
            
            //dis_evt_id
               page.eventId = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "12"
            
            
        {
           
            let page:FoodStreetController = self.storyboard?.instantiateViewController(withIdentifier: "foodStreet") as! FoodStreetController
            
             page.eventId = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "13"
            
            
        {
   
            
            let page:FoodStreetController = self.storyboard?.instantiateViewController(withIdentifier: "foodStreet") as! FoodStreetController
             page.eventId = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "14"
            
            
        {
       
            
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
            // print("\(((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray))")
            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
            
            page.question_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "15"
            
            
        {
           
            
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
           
            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
            
            page.question_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
//        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "16"
//
//
//        {
//
//            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
//
//            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
//
//            page.question_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
//
//            self.present(page, animated: false, completion: nil)
//        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "4"
            
            
        {
            let page:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! ProfileViewController
            // print("\(((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray))")
            Utils.setPreferenceValue(setValue: "\((((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
            // page.userid = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
            
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "5"
            
            
        {
           // let page:TimelineDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
            // print("\(((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray))")
//            page.timeLine_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "timeline_id") as! String
          //  page.user_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String
//            page.user_id = ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "userid") as! String)
//            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "6"
            
            
        {
           // let page:TimelineDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
            // print("\(((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray))")
//            page.timeLine_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "timeline_id") as! String
//            //page.user_id = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String
//                 page.user_id = ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "userid") as! String)
//            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "16"
            
            
        {
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            //category_type
                 page.categoryType = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "category_type") as! String
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "17"
            
            
        {
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            page.categoryType = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "category_type") as! String
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "18"
            
            
        {
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            page.categoryType = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "category_type") as! String
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "7"
            
            
        {
            let page:EventsDetailedController = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
           
            page.eventID = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            page.userid = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "8"
            
            
        {
            let page:EventsDetailedController = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
           
            page.eventID = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            page.userid = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "9"
            
            
        {
            let page:EventsDetailedController = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
         
            
            page.eventID = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "event_id") as! String
            page.userid = (((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi") as! NSArray)[0] as AnyObject).value(forKey: "user_id") as! String
            
            self.present(page, animated: false, completion: nil)
        }
        else {
            print("Notification")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! NotificationTableViewCell
        cell.selectionStyle = .none
//       cell.notificationlabel.numberOfLines = 0
//        cell.notificationlabel.lineBreakMode = NSLineBreakMode.byWordWrapping
//         cell.notificationlabel.sizeToFit()
        
        
        
        if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "7"
        {
           
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )" + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "liked the event"
            //  cell.foodimage.
          
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("liked the event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
            }
            else {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("liked the event ") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "4"
        {
            
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            // cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "Started following you"
            print( cell.notificationlabel.text!)
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("Started following you") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
            }
            else {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("Started following you") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
                
            }
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "5"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "likes the timeline"
        
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("likes the timeline") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
            }
            else {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("likes the timeline") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
                
            }
            
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "16"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "liked the review"
          
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)"  + (" ") + ("liked the review") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
            }
            else {
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("liked the review") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
                
            }
            
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "3"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "following your question"
           
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("following your question") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("following your question") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
                
            }
            
            
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "1"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            //   cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "requested you to answer a question"
        
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("requested you to answer a question") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
            }
            else {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("requested you to answer a question") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "2"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "answered your question"
           
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)"  + ("answered your question") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("answered your question") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
                
            }
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "6"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "commented on your post"
         
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
           
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("commented on your post") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
            
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("commented on your post") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
         
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "9"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "shared your event"
           
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("shared your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("shared your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "8"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "going to your event"
         
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("going to your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("going to your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "10"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "commented on your event"
         
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("commented on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" ) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("commented on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "11"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "started a discussion on your event"
          
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("started a discussion on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" ) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("started a discussion on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "12"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )" + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "liked a discussion on your event"
          
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("liked a discussion on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" ) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("liked a discussion on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "13"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "commented in a discussion on your event"
           
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("commented in a discussion on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("commented in a discussion on your event") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "14"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "upvoted your answer"
            
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("upvoted your answer") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" ) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
            }
            else {
                
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("upvoted your answer") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "15"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "commented on your answer"
           
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ")  + ("commented on your answer") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" ) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
            }
            else {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("commented on your answer") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "17"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "shared your review"
          
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ")  + ("shared your review") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)") )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
            }
            else {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("shared your review") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
        }
        else if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "post_type") as! String) == "18"
        {
            
            
            NotificationsetArray = (((self.dataArray1[0] as AnyObject).value(forKey: "multi") as! NSArray))
            
            cell.notificationlabel.text! = "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "first_name") as! NSString)) \(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "last_name") as! NSString) )"  + " " + "and" + " " + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + " " + "Others" + " " + "commented on your review"
           
            
            cell.foodimage.sd_setImage(with: URL(string: "\(((self.NotificationsetArray[0] as! AnyObject).value(forKey: "picture") as! NSString) )"), placeholderImage: UIImage(named: "default"))
            let createdTime = "\((NotificationsetArray[0] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timelabel.text! =  myDate.timeAgoDisplay()
            
            if ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber)  == 1
                
            {
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("commented on your review") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" ) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
            }
            else {
                
                
                
                let string = "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") + "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others") + (" ") + ("commented on your review") as? NSString
                
                let attributedString = NSMutableAttributedString(string: (string as! NSString) as String  , attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                
                let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                // Part of string to be bold
                
                attributedString.addAttributes(boldFontAttribute, range: (string?.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((NotificationsetArray[0] as AnyObject).value(forKey: "last_name")!)" + (" ") + ("and") + (" ") +  "\( ((self.dataArray1[indexPath.row] as AnyObject).value(forKey: "multi_count") as! NSNumber) )" + (" ") + ("Others")) )!)
                //  attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((NotificationsetArray[0] as AnyObject).value(forKey: "first_name")!)"))
                
                cell.notificationlabel.attributedText = attributedString
                
                
                
            }
            
            
            
            
            
            
            
        }
        else {
            cell.notificationlabel.text! = "super"
        }
        
        
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110    }
    
    
    func findnumberoffollowers()
    {
        
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWE_COUNT)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.followerArray = innerDict as! NSArray
                        if self.followerArray != nil{
                            
                            self.followcount =  (self.followerArray.value(forKey: "total_count") as? Any!)! as! NSArray
                            
                      
                            
                            
                            self.followrow = ("\(self.followcount[0])"as AnyObject).integerValue
                            if  self.followrow == 0 {
                            
                                
                                self.notification.frame = CGRect(x: 8, y: 100, width: 367, height: 21)
                                self.Mytable.frame = CGRect(x: 0, y: self.notification.frame.maxY + 10 , width: 375, height: 500)
                                
                                self.followersview.isHidden = true
                                self.showToast(message: "No followers yet")
                                
                            }
                            else {
                                self.followersview.isHidden = false
                                self.followerslabel.text! = "Followers (\(self.followcount [0]))"
                                self.Mytable.reloadData()
                            }
                            
                            
                            
                        }
                        
                        
                    }
                        
                    else
                    {
                        self.notification.frame = CGRect(x: 8, y: 100, width: 367, height: 21)
                        
                        self.Mytable.frame = CGRect(x: 0, y: self.notification.frame.maxY + 10 , width: 375, height: 358)
                        
                        self.followersview.isHidden = true
                        self.showToast(message: "No followers yet")
                        self.Mytable.reloadData()
                    }
                    
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    
    func getnotificationcount()
    {
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        //    print("\(params)")
        // let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_NOTIFICATION_COUNT)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.NotificationArray = innerDict as! NSArray
                        if self.NotificationArray != nil{
                           
                            
                            self.Notificationcount =  (self.NotificationArray.value(forKey: "total_count") as? Any!)! as! NSArray
                            
                            // print(self.followerArray)
                            self.Notificationcountforrow = ("\(self.Notificationcount[0])"as AnyObject).integerValue
                            
                            if self.Notificationcountforrow != 0
                            {
                                
                                self.Mytable.reloadData()
                              
                                
                                self.Mytable.isHidden = false
                            }
                            else {
                                self.Mytable.isHidden = true
                                self.Nonotificationview.isHidden = false
                                self.Mytable.reloadData()
                                self.showToast(message: "No Notification yet")
                            }
                        }
                            
                        else
                        {
                            
                            
                        }
                        
                        
                        
                    }
                }
                
                
            }
            
        }
        
        
    }
    
    
    func getnotificationallAPI()
    {
        // let params: [String:String] = ["userid" : "4"]
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
    
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_ALL_NOTIFICATION)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count == 0){
                    self.Mytable.reloadData()
                    
                    self.Mytable.isHidden = true
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                    self.Mytable.isHidden = false
                    
                    self.Mytable.reloadData()
                    self.showToast(message: "No Notification yet")
                    
                }
            }
            
            
        }
    }
    
    
        
        
    
    
    
    
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
//        @IBAction func FollowButton(_ sender: Any) {
//            
//            print("followers")
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            
//            let ViewController = storyBoard.instantiateViewController(withIdentifier: "followview") as! FollowchoiceViewController
//            self.present(ViewController, animated:true, completion:nil)
//            
//            
//            
//        }
    
    @IBAction func FollowButton(_ sender: UIButton) {
        
        
                    print("followers")
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
                    let ViewController = storyBoard.instantiateViewController(withIdentifier: "followview") as! FollowchoiceViewController
                    self.present(ViewController, animated:true, completion:nil)
        
        
        
    }
    
    @IBOutlet weak var FollowButton: UIButton!
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Got a Image")
        if let imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
            let seleImg_Data = UIImageJPEGRepresentation(imag , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            print("the img str : \(base64_str?.characters.count)")
            selectedImage.image = imag
//            let page:CreateReviewController = self.storyboard?.instantiateViewController(withIdentifier: "createreview") as! CreateReviewController
//            page.newImag = selectedImage.image
//            self.present(page, animated: true, completion: nil)
            
            UserDefaults.standard.register(defaults: ["key":UIImageJPEGRepresentation(selectedImage.image!, 100)!])
            UserDefaults.standard.set(UIImageJPEGRepresentation(selectedImage.image!, 100), forKey: "key")
            if newImage == "1"
            {
            Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
            Utils.setPreferenceValue(setValue: "1", ForKey: Constant.NEWVALUE)
            }
            else if newImage == "2"
            {
                Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
                Utils.setPreferenceValue(setValue: "2", ForKey: Constant.NEWVALUE)
                
            }
            else if newImage == "3"
            {
               // Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
                Utils.setPreferenceValue(setValue: "4", ForKey: Constant.NEWVALUE)
                
            }
            else if newImage == "4"
            {
               //Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
                Utils.setPreferenceValue(setValue: "4", ForKey: Constant.NEWVALUE)
                
            }
           
        }
        else{
            
            
            //            self.videoFilePath = (info[UIImagePickerControllerMediaURL] as? NSURL)! as URL!
            //            videoImage.image = UIImage(named: "att_video.png")
        }
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
//
//    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / image.size.width
//        let heightRatio = targetSize.height / image.size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio,height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
//        }
//
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRect(x:0,y:0, width:newSize.width, height: newSize.height)
//
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Add a Caption"
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
            textView.text = "Add a Caption"
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
        
        if(bottomBar.selectedItem == menuBarItem){
            
            
            let page:MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuview") as! MenuViewController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == reviewButton){
            
            
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            self.present(page, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func backAct(_ sender: UIButton) {
        openGallary()
        
    }
    
    @IBAction func doneAct(_ sender: UIButton) {
        
//        let page:CreateReviewController = self.storyboard?.instantiateViewController(withIdentifier: "createreview") as! CreateReviewController
//        self.present(page, animated: true, completion: nil)
        UserDefaults.standard.register(defaults: ["key":UIImageJPEGRepresentation(selectedImage.image!, 100)!])
        UserDefaults.standard.set(UIImageJPEGRepresentation(selectedImage.image!, 100), forKey: "key")
        if newImage == "1"
        {
            Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
            Utils.setPreferenceValue(setValue: "1", ForKey: Constant.NEWVALUE)
        }
        else if newImage == "2"
        {
            Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
            Utils.setPreferenceValue(setValue: "2", ForKey: Constant.NEWVALUE)
            
        }
        else if newImage == "3"
        {
            //Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
            Utils.setPreferenceValue(setValue: "3", ForKey: Constant.NEWVALUE)
            
        }
        
        else if newImage == "4"
        {
            //Utils.setPreferenceValue(setValue: captionView.text!, ForKey: Constant.CAPTION)
            Utils.setPreferenceValue(setValue: "4", ForKey: Constant.NEWVALUE)
           
        }
        
        if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == ""
        {
            
        }
        else if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "1"
        {
            
            if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
                let imageFromData = UIImage(data: imageData)
                //mLogoImageView.image = imageFromData!
                
                
                topDishesArray.append(imageFromData!)
                labelArray.add(Utils.getPreferenceValue(ForKey: Constant.CAPTION))
               // collectionView1.reloadData()
                // let imageView1 = UIImage(named : "")
                //           UserDefaults.standard.set(UIImageJPEGRepresentation(imageView1!, 100), forKey: "key")
                
                
            }
        }
            
        else if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "2"
        {
            if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
                let imageFromData = UIImage(data: imageData)
                //mLogoImageView.image = imageFromData!
                dishesToAvoidArray.append(imageFromData!)
                labelArray1.add(Utils.getPreferenceValue(ForKey: Constant.CAPTION))
              //  collectView2.reloadData()
                // UserDefaults.removeObjectForKey("key")
                UserDefaults.standard.set(nil, forKey: "key")
                
                
            }
        }
        else if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "3"
        {
            if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
                let imageFromData = UIImage(data: imageData)
                //mLogoImageView.image = imageFromData!
                ambianceArray.append(imageFromData!)
                
               // collectView3.reloadData()
                
            }
        }
            
        else if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "4"
        {
            if let imageData = UserDefaults.standard.value(forKey: "key") as? Data{
                let imageFromData = UIImage(data: imageData)
                //mLogoImageView.image = imageFromData!
                deliveryArray.append(imageFromData!)
                
              //  collectView4.reloadData()
                
            }
        }
        
        self.dismiss(animated: false, completion: nil)
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

//extension UIView {
//
//    func addShadowView2() {
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
//    }}

