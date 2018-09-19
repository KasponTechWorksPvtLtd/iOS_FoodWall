//
//  AllsearchViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 17/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


//var myIndexPath : Int!
//var index1 : Int!
//var a :Int = 1

//var revieWPicID : String = ""
//var hotelName : String = ""

class AllsearchViewController: UIViewController,UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,CategoryRowDelegate{
    
    
   
    

 
    var eventType : String = ""
    
    @IBOutlet var tableView: UITableView!
    
    var arrRes = [[String:AnyObject]]()
    
    var searchingdetailarray = [[String:AnyObject]]()
    var quesAnsArray : NSArray = []
    var dataArray1 = [[String:AnyObject]]()
    var peoplearray : NSArray = []
    var dataArray : NSArray = []
    let cellSpacingHeight: CGFloat = 485
    var myIndexPath = -1
    var totalposts : String = ""
    var totalFollowers : String = ""
    var eventsarray : NSArray = []
    var action1 : String = ""
    var rowNumber : Int = 0
     var testArray = [String]()
    
    
    
    //Eventcellaction1
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet var backButton: UIButton!
    //var arrRes = [[String:AnyObject]]()
    var cohostsArray = [[String:AnyObject]]()
    var newArray = [[String:AnyObject]]()
    //var eventType : String = ""
    //  var dataArray1 :NSArray = []
    @IBOutlet var eventsNore: KYButton!
    
    //let cellSpacingHeight: CGFloat = 260
   // @IBOutlet var headerView: UIView!
    @IBOutlet var tableView1: UITableView!
    
    //search
    //var searchingdetailarray = [[String:AnyObject]]()
   // var eventsarray : NSArray = []
    
    @IBOutlet weak var segmentview: UIView!
    @IBOutlet weak var tablegroupview: UIView!
    
    
    
    
    
    //reviewIBOutletvar myIndexPath : Int!
    var like : Int = 0
    var rowIndex : Int = 0
    var rowNumber1 : Int = 0
    var k : Int = 0
    
    var action11 : String = ""
    
    var totalposts1 : String = ""
    var totalFollowers1 : String = ""
    var cellSpacingHeight1 = 670.0
    
    var categoryType : String = "0"
  //  tableView.estimatedRowHeight = 100.0
    //tableView.rowHeight = UITableViewAutomaticDimension
    
    
    
    
    
    //foodhelp(Q&A)
   // let cellSpacingHeight: CGFloat = 200
   // var quesAnsArray : NSArray = []
    var ansArray : NSArray = []
    var total_poll : Double = 0.0
    var total_poll_user : Double = 0.0
    //    var a : Double = 0.0
    //    var b : Double = 0.0
    var poll_percentage : Float = 0.0
    var cellPath :Int = 0
    var quesID = [String]()
    var celltag : Int = 0
    var optionValue : Int = 0
    var optnLoad : Int = 0
    var actn : String = ""
    var Questionarray = [[String:AnyObject]]()
    
    
    
    
    //Timeline
    var imgCount : Int = 0
   // var dataArr : NSArray = []
    var ImageArray : NSArray = []
    var myIndex : Int = 0
    var ImageFilter : NSMutableArray = []
    var looPValue : Int = 10
    var imgString : String = ""
    var timeLine_id : String = ""
    var user_id : String = ""
    var time = 0
    var timer = Timer()
    var imgStr :String = ""
    var storyImage : UIImage = UIImage(named : "default")!
    var progressView: UIProgressView?
    
     let imageUrl = "\(Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL))"
   // var testArray : NSArray = []
    var created_by : String = ""
    var commentsText : String = ""
    var testArray1 : NSArray = []
    var progressValue : CGFloat = 0.1
    var countValue : Int = 0
    var a : Int = 0
    var b : Int = 0
    var storyId : String = ""
    var edit : Int = 0
    var searchLocation : String = ""
    @IBOutlet weak var uploadStoryView: UIView!
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var profname: UILabel!
    @IBOutlet weak var profImage: UIImageView!
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var statusView: UIView!
//    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var optionMenu: UIButton!
    @IBOutlet weak var proGRssView: UIProgressView!
    @IBOutlet weak var progrssView: UIProgressView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var uploadImage: UIImageView!
    @IBOutlet weak var postText: UITextView!
     let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        ///Eventcellfunc
       // indicator.isHidden = true
       // tableView1.delegate = self
        //tableView1.dataSource = self
      //  tableview2.delegate = self
       // tableview2.dataSource = self
       // eventsNore.kyDelegate = self
       // tableView1.estimatedRowHeight = 160.0
        //tableView1.rowHeight = UITableViewAutomaticDimension
        //headerView.isHidden = false
       // tablegroupview.frame.size.width = self.view.frame.size.width
       // tablegroupview.frame.size.height = self.view.frame.size.height
       // eventType = "1"
        //getAllEvents()
       // eventsNore.openType = .popUp
       // eventsNore.plusColor = UIColor.white
        //eventsNore.plusColor =
        
//        eventsNore.fabTitleColor = UIColor.black
//        eventsNore.add(color:UIColor.white, title: "Private Events(Visible to only your followers)", image: UIImage(named: "globeLock")!){_ in
//
//
//            let page:PrivateEventController = self.storyboard?.instantiateViewController(withIdentifier: "privateevent") as! PrivateEventController
//            self.present(page, animated: false, completion: nil)
//
//
//
//        }
//        eventsNore.add(color:UIColor.white, title: "Public Events(Visible to everyone)", image: UIImage(named: "world")!){_ in
//
//            let page:PublicEventController = self.storyboard?.instantiateViewController(withIdentifier: "publicevent") as! PublicEventController
//            self.present(page, animated: false, completion: nil)
//
//        }
//
      
        var restaurantsArray : NSArray = []
        
       
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        CommonSearchFunction()
        getReviewsCommonAll()
        eventType = "2"
        getAllEventsforcommonsearch()
        getQAAllFORCOMMONSEARCH()
        timelineFunctionCommonSearch()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cellTapped() {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketList") as! BucketListController
        
        page.a = "1"
        page.reviewId = revieWPicID
        page.hotelNAME = hotelName
        self.present(page, animated: false, completion: nil)
    }
    
   
    func colour1(_ sender: AnyObject)
    {
        
       
        sender.layer.shadowRadius = 1
        sender.layer.shadowOpacity = 2.0
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2
        {
        
        let pageCur = indexPath.row
        
        Utils.setPreferenceValue(setValue: "\(pageCur)", ForKey: Constant.PAGECUR)
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
            if arrRes.count >= 1
            {
                if  ((self.arrRes[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                    
                {
        
        // page.dataArr = arrRes as NSArray
        page.userid = (arrRes[pageCur] as AnyObject).value(forKey: "user_id") as! String
        page.eventID = (arrRes[pageCur] as AnyObject).value(forKey: "event_id") as! String
                }
            }
            
        self.present(page, animated: false, completion: nil)
        
        }
        else if indexPath.section == 1 {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "hotelDetail") as! hotelDetailController
            if dataArray1.count >= 1
            {
                if  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                    
                {
            page.hotelname = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_name") as? String)!
            page.reviewID = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "revrat_id") as? String)!
            page.category_type = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "category_type") as? String)!
            page.ambienceRate = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)!
            page.valueMoney = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)!
            page.tasteRate = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)!
            page.serviceRate = "\(((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)!)"
            page.mainRate = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)!
            page.photoRef = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "photo_reference") as? String)!
            page.pageIden = "2"
                }
            }
            
            self.present(page, animated: false, completion: nil)
            
        }
        else if indexPath.section == 4{
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController

            if quesAnsArray.count >= 1
            {
                if  ((self.quesAnsArray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                    
                {
            
            Utils.setPreferenceValue(setValue: (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_by") as! String, ForKey:Constant.QA_CREATEDBY)
            page.question_id = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "quest_id") as! String
            page.followid = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ques_follow") as! String
                }}
            self.present(page, animated: false, completion: nil)
            
        }
        else if indexPath.section == 5{
            let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
            if quesAnsArray.count >= 1
            {
                if  ((self.quesAnsArray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                    
                {
            Utils.setPreferenceValue(setValue: (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_by") as! String, ForKey:Constant.QA_CREATEDBY)
            
            page.question_id = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "quest_id") as! String
            page.followid = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ques_follow") as! String
                }
            }
            self.present(page, animated: false, completion: nil)
            
        }
        else {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch section {
        case 0:
            
            
            if peoplearray.count >= 1
            {
                if  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    return peoplearray.count
                    
                }
            }
            else {
                return  0
            }
        case 1:
            
            
            if dataArray1.count >= 1
            {
                if  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    return dataArray1.count
                    
                }
            }
            else {
                return  0
            }
        case 2 :
            
            
            if arrRes.count >= 1
            {
                if  ((self.arrRes[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    return arrRes.count
                    
                }
            }
            else {
                return  0
            }
        case 3 :
            if dataArray.count >= 1
            {
                if  ((self.dataArray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    return dataArray.count
                    
                }
            }
            else {
                return  0
            }
        case 4 :
            
            
            if quesAnsArray.count >= 1
            {
                if  ((self.quesAnsArray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    return quesAnsArray.count
                    
                }
            }
            else {
                return  0
            }
            
        default:
            return 0
        }
        // return 1
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 6
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section ==  0
            
        {
            
            
            if peoplearray.count >= 1
            {
                if  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    
                    return 30
                    
                }
            }
            else {
                return  0
            }
            
            
            
            
        }
        else if section ==  1 {
            if dataArray1.count >= 1
            {
                if  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    
                    return 30
                    
                }
            }
            else {
                return  0
            }
            
            
        }
        else if section ==  2 {
            if arrRes.count >= 1
            {
                if  ((self.arrRes[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    
                    return 30
                    
                }
            }
            else {
                return  0
            }
            
            
            
        }
        else if section ==  3 {
            
            if dataArray.count >= 1
            {
                if  ((self.dataArray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    
                    return 30
                    
                }
            }
            else {
                return  0
            }
            
        }
        else if section ==  4 {
            
            if quesAnsArray.count >= 1
            {
                if  ((self.quesAnsArray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                {
                    return 0
                }
                else {
                    
                    return 30
                    
                }
            }
            else {
                return  0
            }
        }
            
            
        else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section ==  0
        {
            return "people"
        }
        else if section ==  1 {
            
            return "Review"
        }
        else if section ==  2 {
            
            return "Event"
        }
        else if section ==  3 {
            
            return "Timeline"
        }
        else if section ==  4 {
            
            return "Q&A"
        }
        else {
            
            return ""
        }
        
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if indexPath.section ==  0 {
            
            return 92
            
        }
        else if indexPath.section ==  1 {
            return UITableViewAutomaticDimension
        }
        else if indexPath.section == 2 {
            return 270
        }
        else if indexPath.section == 3{
            return  450
        }
        else if indexPath.section == 4{
            
            if (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "ques_type") as? String != ""
            {
                
                if (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "ques_type") as? String == "0"
                {
                    
                    return  200
                }
                else
                {
                    return  450
                }
                
                
            }
                
            else
            {
                return 0
                
            }
        }
            
        else {
            return  0
        }
        
        
        
        
        
    }
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        
        if indexPath.section == 0 {
             self.myIndexPath = indexPath.row
            let cell = tableView.dequeueReusableCell(withIdentifier: "commonpeople", for: indexPath) as! AllpeoplecommonTableViewCell
            self.myIndexPath = indexPath.row
            
          
            
            if peoplearray.count >= 1
            {
                if  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
                    
                {
                    
                }
                else {
                    
                    cell.peoplelabel.text = ""
                    print(self.peoplearray)
                    cell.peoplelabel.text = "\( ((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))"+"\( ((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
                    if "\(((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "picture") as? String)!)" != "0"
                    {
                        
                        
                        
                        
                        cell.peopleimage.sd_setImage(with: URL(string: "\(((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"), placeholderImage: UIImage(named: "default"))
                        
                    }
                    
                    
                }
                
            }
            
            
            return cell
        }
        else if indexPath.section == 1{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "review", for: indexPath) as! reviewCell
            cell.selectionStyle = .none
            cell.delegate = self
            
            myIndexPath = indexPath.row
            
            print("\(dataArray1)")
            
            
           if dataArray1.count >= 1
           {
                if  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"

                {

                }
                else {
            
            
            
            cell.reviewText.text = (dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_review") as? String
            cell.hotelNameLabel.text = (dataArray1[indexPath.row] as AnyObject).value(forKey: "hotel_name") as? String
            cell.progImage.sd_setImage(with: URL(string:((dataArray1[indexPath.row] as AnyObject).value(forKey: "picture") as? String)!), placeholderImage: UIImage(named: "default"))
            
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "1"
            {
                cell.rating1.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "2"
            {
                cell.rating1.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "3"
            {
                cell.rating1.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! == "4"
            {
                cell.rating1.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
            }
            else
            {
                
                cell.rating1.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
            }
            
            
            if a == 2 && indexPath.row == index1
            {
                cell.hotelAmbianceView.isHidden = false
                myIndexPath = index1
                cell.moreLessBtn.isHidden = true
                
                index1 = -1
            }
            else
            {
                cell.hotelAmbianceView.isHidden = true
                myIndexPath = indexPath.row
                cell.moreLessBtn.isHidden = false
                //           cell.setData1(data1: dataArray1)
            }
            
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "category_type") as? String)! == "1"
            {
                cell.servicePackageLabel.text = "Service"
            }
            else{
                cell.servicePackageLabel.text = "Package"
            }
            
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "1"
            {
                cell.rating2.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "2"
            {
                cell.rating2.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "3"
            {
                cell.rating2.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! == "4"
            {
                cell.rating2.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
            }
            else
            {
                
                cell.rating2.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
                
            }
            
            
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "1"
            {
                cell.rating3.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "2"
            {
                cell.rating3.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "3"
            {
                cell.rating3.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! == "4"
            {
                cell.rating3.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
            }
            else
            {
                
                cell.rating3.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
                
            }
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "1"
            {
                cell.rating4.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "2"
            {
                cell.rating4.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "3"
            {
                cell.rating4.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)! == "4"
            {
                cell.rating4.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
            }
            else
            {
                
                cell.rating4.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
                
            }
            
            
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "1"
            {
                cell.mainRating.backgroundColor = UIColor(red: 242/255, green: 83/255, blue: 83/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "2"
            {
                cell.mainRating.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 8/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "3"
            {
                cell.mainRating.backgroundColor = UIColor(red: 255/255, green: 153/255, blue: 102/255, alpha: 1.0)
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! == "4"
            {
                cell.mainRating.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
            }
            else
            {
                
                cell.mainRating.backgroundColor = UIColor(red: 26/255, green: 147/255, blue: 111/255, alpha: 1.0)
                
            }
            
            
            cell.rating1.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "ambiance") as? String)! + "*"
            cell.rating2.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "value_money") as? String)! + "*"
            cell.rating3.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "taste") as? String)! + "*"
            cell.rating4.text = "\(((dataArray1[indexPath.row] as AnyObject).value(forKey: "service") as? String)!)*"
            cell.mainRating.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "food_exprience") as? String)! + "*"
            cell.commentImage.sd_setImage(with: URL(string:((dataArray1[indexPath.row] as AnyObject).value(forKey: "picture") as? String)!), placeholderImage: UIImage(named: "default"))
            cell.userName.text = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "first_name") as? String)! + (" ") + ((dataArray1[indexPath.row] as AnyObject).value(forKey: "last_name") as? String)!
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! == "0"
            {
                cell.likesLabel.isHidden = true
            }
            else if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! == "1"
            {
                cell.likesLabel.text! = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! + "Like"
            }
            else
            {
                cell.likesLabel.text! = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_likes") as? String)! + "Likes"
            }
            if ((dataArray1[indexPath.row] as AnyObject).value(forKey: "htl_rev_likes") as? String)!  == "0"
            {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol") , for: .normal)
            }
            else
            {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            }
            
            cell.editDeleteBtn.addTarget(self, action: #selector(deleteEVENT), for: .touchUpInside)
            cell.editDeleteBtn.tag = indexPath.row + 5000
            cell.commentsTextView.delegate = self
            cell.commentsTextView.text = "Add a comment"
            cell.commentsTextView.textColor = UIColor.lightGray
            if "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String)" == "1"
            {
                totalposts = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String) Review"
            }
            else if "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String)" == "0"
            {
                totalposts = ""
            }
            else
            {
                totalposts = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as! String) Reviews"
            }
            
            if (dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as? String == "1"
            {
                totalFollowers = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String) Follower"
            }
            else if (dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as? String == "0"
            {
                totalFollowers = ""
            }
            else
            {
                
                if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
                {
                    
                    
                }
                else {
                    totalFollowers = ((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_followers") as? String)! + "Followers"
                }
            }
            
            cell.reviewFollwersLabel.text = "\(totalposts)" + (" ") + (",") + (" ")
                + "\(totalFollowers)"
            
            //        cell.reviewFollwersLabel.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "total_review") as? String) review"
            let createdTime = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timeAgoLabel.text! =  myDate.timeAgoDisplay()
            
            
            
            
            cell.topDishesLabel.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "topdish")!)"
            cell.dishesToAvoidLabel.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "avoiddish")!)"
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "top_count") as! Int) == 0
            {
                cell.topDishesView.isHidden = true
            }
                
            else
            {
                cell.topDishesView.isHidden = false
            }
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoid_count") as! Int) == 0
            {
                cell.dishesToAvoidView.isHidden = true
            }
                
            else
            {
                cell.dishesToAvoidView.isHidden = false
            }
            
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "topdish") as! String) == ""
            {
                cell.TopdishNameView.isHidden = true
            }
                
            else
            {
                cell.TopdishNameView.isHidden = false
            }
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoiddish") as! String) == ""
            {
                cell.dishtoAvoidNameView.isHidden = true
            }
                
            else
            {
                cell.dishtoAvoidNameView.isHidden = false
            }
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoiddish") as! String) == "" && ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "avoid_count") as! Int) == 0
            {
                
                cell.topView.isHidden = true
            }
                
            else
            {
                cell.topView.isHidden = false
            }
            
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "topdish") as! String) == "" && ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "top_count") as! Int) == 0
            {
                
                cell.dishView.isHidden = true
            }
                
            else
            {
                cell.dishView.isHidden = false
            }
            
            if ((dataArray1[indexPath.row] as! AnyObject).value(forKey : "ambi_image_count") as! Int) == 0
            {
                cell.moreLessBtn.isHidden = true
            }
                
            else
            {
                cell.moreLessBtn.isHidden = false
            }
            
            
            if dataArray1.count != 0
            {
            let  searchvalue =  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as! String)
            
            if searchvalue != "0"
                
            {
            cell.setData1(data1: dataArray1)
            }
            }
            cell.bucketListBtn.tag = indexPath.row + 3000
            cell.bucketListBtn.addTarget(self, action: #selector(bucketListAct), for: .touchUpInside)
            cell.likeBtn.tag = indexPath.row + 2000
            
            cell.likeBtn.addTarget(self, action: #selector(likeEVENT), for: .touchUpInside)
            cell.moreLessBtn.addTarget(self, action: #selector(performAction), for: .touchUpInside)
            cell.moreLessBtn.tag = indexPath.row
                    
            }
            }
            return cell
            
           
        }else if indexPath.section == 2{

            
            let cell = tableView.dequeueReusableCell(withIdentifier: "evencell", for: indexPath) as! EventsViewCell
            
            print(arrRes)
            if arrRes.count >= 1

            {
            let  searchvalue =  ((self.arrRes[0] as AnyObject).value(forKey: "search_val") as! String)
                
                if searchvalue != "0"
                    
                {
                    print(indexPath.row)
                    let startDate = (arrRes[indexPath.row] as AnyObject).value(forKey: "start_date") as! String
                    // let createdOn = (dict["start_date"] as? String)!
                    
                    
                    let dateFormatterr = DateFormatter()
                    dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let myDate = dateFormatterr.date(from: startDate)!
                    dateFormatterr.dateFormat = "LLLL"
                    let  month = dateFormatterr.string(from: myDate)
                    dateFormatterr.dateFormat = "dd"
                    let  day = dateFormatterr.string(from: myDate)
                    cell.startDate.text! = month + " " + day
                    
                    cell.startDate.text = month
                    
                    cell.selectionStyle = .none
                    cell.layer.cornerRadius = 30.0
                    cell.layer.masksToBounds = true
                    cell.contentView.isUserInteractionEnabled = true
                    
                    cell.eventLocation.text = (arrRes[indexPath.row] as AnyObject).value(forKey: "location") as! String
                    
                    
                    cell.eventTitle.text = (arrRes[indexPath.row] as AnyObject).value(forKey: "event_name") as! String
                    cell.eventsPrevImage.sd_setImage(with: URL(string: (arrRes[indexPath.row] as AnyObject).value(forKey: "event_image") as! String), placeholderImage: UIImage(named: "ProfileImg3.png"))
                    
                    
                    cell.interestedButton.tag = indexPath.row + 2000
                    cell.interestedButton.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
                    
                    if "\((arrRes[indexPath.row] as AnyObject).value(forKey: "evt_likes")!)" ==  "1"
                    {
                        cell.interestImage.image =   UIImage(named :"bookmark-star")
                        
                    }
                    else
                    {
                        
                        cell.interestImage.image =  UIImage(named :"star-1")
                        
                    }
                    
                    if "\((arrRes[indexPath.row] as AnyObject).value(forKey: "gng_likes")!)" ==  "1"
                    {
                        cell.goView.isHidden = false
                        
                    }
                    else
                    {
                        
                        
                        cell.goinImage.image =  #imageLiteral(resourceName: "circular-check-button-2")
                        
                    }
                    
                    cell.goinButton.tag = indexPath.row + 3000
                    cell.goinButton.addTarget(self, action: #selector(goingBtn(_:)), for: .touchUpInside)
                    cell.acceptBtn.addTarget(self, action: #selector(pressButton1(_:)), for: .touchUpInside)
                    cell.acceptBtn.tag = indexPath.row + 1000
                    
                    
                    
                    Utils.setPreferenceValue(setValue: "\((arrRes[indexPath.row] as AnyObject).value(forKey: "event_id")!)", ForKey: Constant.EVENT_ID)
                    
                    
                    cell.view1.addShadowViewEvents()
                    cell.view1.layer.cornerRadius = 20.0
                    cell.view1.clipsToBounds = true
                }
                //        cell.view2.addShado
            }
            
//
//            if arrRes.count >= 1
//            {
//             let  searchvalue =  ((self.arrRes[0] as AnyObject).value(forKey: "search_val") as! String)
//
//            if searchvalue != "0"
//
//            {
//
//            let startDate = (arrRes[indexPath.row] as AnyObject).value(forKey: "start_date") as! String
//            // let createdOn = (dict["start_date"] as? String)!
//
//
//            let dateFormatterr = DateFormatter()
//            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let myDate = dateFormatterr.date(from: startDate)!
//            dateFormatterr.dateFormat = "LLLL"
//            let  month = dateFormatterr.string(from: myDate)
//            dateFormatterr.dateFormat = "dd"
//            let  day = dateFormatterr.string(from: myDate)
//            cell.startDate.text! = month + " " + day
//
//               cell.startDate.text = month
//
//            cell.selectionStyle = .none
//            cell.layer.cornerRadius = 30.0
//            cell.layer.masksToBounds = true
//            cell.contentView.isUserInteractionEnabled = true
//
//            cell.eventLocation.text = (arrRes[indexPath.row] as AnyObject).value(forKey: "location") as! String
//
//
//            cell.eventTitle.text = (arrRes[indexPath.row] as AnyObject).value(forKey: "event_name") as! String
//            cell.eventsPrevImage.sd_setImage(with: URL(string: (arrRes[indexPath.row] as AnyObject).value(forKey: "event_image") as! String), placeholderImage: UIImage(named: "ProfileImg3.png"))
//
//
//            cell.interestedButton.tag = indexPath.row + 2000
//           cell.interestedButton.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
//
//            if "\((arrRes[indexPath.row] as AnyObject).value(forKey: "evt_likes")!)" ==  "1"
//            {
//                cell.interestImage.image =   UIImage(named :"bookmark-star")
//
//            }
//            else
//            {
//
//                cell.interestImage.image =  UIImage(named :"star-1")
//
//            }
//
//            if "\((arrRes[indexPath.row] as AnyObject).value(forKey: "gng_likes")!)" ==  "1"
//            {
//                cell.goView.isHidden = false
//
//            }
//            else
//            {
//
//
//                cell.goinImage.image =  #imageLiteral(resourceName: "circular-check-button-2")
//
//            }
//
//            cell.goinButton.tag = indexPath.row + 3000
//           cell.goinButton.addTarget(self, action: #selector(goingBtn(_:)), for: .touchUpInside)
//        cell.acceptBtn.addTarget(self, action: #selector(pressButton1(_:)), for: .touchUpInside)
//            cell.acceptBtn.tag = indexPath.row + 1000
//
//
//
//            Utils.setPreferenceValue(setValue: "\((arrRes[indexPath.row] as AnyObject).value(forKey: "event_id")!)", ForKey: Constant.EVENT_ID)
//
//
//            cell.view1.addShadowViewEvents()
//            cell.view1.layer.cornerRadius = 20.0
//            cell.view1.clipsToBounds = true
//            }
//            //        cell.view2.addShadowViewEvents()
//            }
//
            
          return cell
            
            
          
            
           
        }
        
        else if indexPath.section == 3{
            print("Checking")
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! homeTableViewCell
            if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "0" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "6" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "7" || "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "5"
                
            {
                
                
                
                cell.selectionStyle = .none
                cell.profName.numberOfLines = 0
                cell.profName.lineBreakMode = NSLineBreakMode.byWordWrapping
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "6"
                {
                    if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
                    {
                        
                        cell.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                        cell.translatesAutoresizingMaskIntoConstraints = true
                    }
                    
                    
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String) liked your review on \((dataArray[indexPath.row] as AnyObject).value(forKey: "hotel") as! String)"
                    
                    
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "review")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "7"
                {
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String) commented your review on \((dataArray[indexPath.row] as AnyObject).value(forKey: "hotel") as! String)"
                    
                    
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "review")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "post_type")!)" == "5"
                {
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String) created new review on \((dataArray[indexPath.row] as AnyObject).value(forKey: "hotel") as! String)"
                    
                    
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "review")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                    
                else
                {
                    cell.profName.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String) \((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String)"
                    
                    let string = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "timeline_description")!)" as NSString
                    
                    let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15.0)])
                    
                    let boldFontAttribute = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15.0)]
                    
                    // Part of string to be bold
                    attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\((dataArray[indexPath.row] as AnyObject).value(forKey: "first_name")!)" + (" ") + "\((dataArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"))
                    cell.descText.attributedText = attributedString
                }
                
                
                //test.removeAllObjects()
                
                
                let dict = dataArray[indexPath.row] as! NSDictionary
                cell.selectionStyle = .none
                
                let createdTime = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate = dateFormatterr.date(from: createdTime)!
                cell.daysAgoLabel.text! =  myDate.timeAgoDisplay()
                
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" == "0" && "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String)" == "0"
                {
                    
                    cell.postFollowersLabel.text = ""
                    
                }
                    
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" == "0" && "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" != "0"
                {
                    cell.postFollowersLabel.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_followers") as! String) Followers"
                    
                }
                else if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" != "0" && "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String)" == "0"
                {
                    cell.postFollowersLabel.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String) Posts"
                    
                }
                else
                {
                    cell.postFollowersLabel.text = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String) Posts \((dataArray[indexPath.row] as AnyObject).value(forKey: "total_posts") as! String) Followers   "
                    
                }
                
                
                if "\(dict.value(forKey: "total_likes") as! String)" == "0"
                {
                    cell.totalLikes.isHidden = true
                }
                else if  "\(dict.value(forKey: "total_likes") as! String)" == "1"
                {
                    cell.totalLikes.isHidden = false
                    
                    cell.totalLikes.text! = "\(dict.value(forKey: "total_likes") as! String) like"
                    
                }
                else
                {
                    cell.totalLikes.isHidden = false
                    cell.totalLikes.text! = "\(dict.value(forKey: "total_likes") as! String) likes"
                    
                }
                
                
                
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "tl_likes")!)" == "0"
                {
                    
                    cell.likeButton.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
                    
                    
                }
                    
                    
                    
                    
                else
                {
                    
                    cell.likeButton.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
                    
                    
                    
                }
                
                
                
                
                
                if  "\(dict.value(forKey: "total_comments") as! String)" == "0"
                    
                {
                    
                    cell.viewallButton.isHidden = true
                    
                }
                    
                    
                else if  "\(dict.value(forKey: "total_comments") as! String)" == "1"
                    
                {
                    
                    cell.viewallButton.isHidden = false
                    //cell.view.text! = "\(dict.value(forKey: "total_likes") as! String) like"
                    cell.viewallButton.setTitle("\(dict.value(forKey: "total_comments") as! String) Comment", for: .normal)
                    cell.viewallButton.contentHorizontalAlignment = .left
                }
                    
                    
                else
                {
                    cell.viewallButton.isHidden = false
                    cell.viewallButton.setTitle("\(dict.value(forKey: "total_comments") as! String) Comments", for: .normal)
                    cell.viewallButton.contentHorizontalAlignment = .left
                }
                
                
                
                
                cell.commentTextView.delegate = self
                cell.commentTextView.text = "Add a comment"
                cell.commentTextView.textColor = UIColor.lightGray
                
                // cell.commentTextView.delegate = self
                
                cell.postCommentButton.tag = indexPath.row + 3000
                cell.postCommentButton.addTarget(self, action: #selector(postCommentBUTTON), for: .touchUpInside)
                cell.postCommentButton.applyGradient()
                
                cell.likeButton.tag = indexPath.row + 2000
                cell.likeButton.addTarget(self, action: #selector(likeBUTTON), for: .touchUpInside)
                
                cell.likesClick.tag = indexPath.row + 11000
                cell.likesClick.addTarget(self, action: #selector(ViewLikes), for: .touchUpInside)
                
                cell.commentButton.tag = indexPath.row + 1000
                cell.commentButton.addTarget(self, action: #selector(commentBUTTON), for: .touchUpInside)
                cell.viewallButton.tag = indexPath.row
                cell.viewallButton.addTarget(self, action: #selector(ViewAction), for: .touchUpInside)
                cell.optionsMenu.tag = indexPath.row
                cell.optionsMenu.addTarget(self, action: #selector(optionMenuAction), for: .touchUpInside)
                cell.profilePageBUtton.tag = indexPath.row + 4000
                cell.profilePageBUtton.addTarget(self, action: #selector(profilePageDisplay), for: .touchUpInside)
                
                
                if "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_by") as! String)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
                {
                    cell.commentsNewText.isHidden = false
                    // cell.commentsNewText.text = "\((dataArray1[indexPath.row] as AnyObject).value(forKey: "tl_comments") as! String)"
                    
                }
                    
                else
                {
                    
                    cell.commentsNewText.isHidden = true
                }
                
                
                cell.commentimage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "default"))
                
                cell.profileImage.sd_setImage(with: URL(string: "\(dict.value(forKey:"picture") as! String)"), placeholderImage: UIImage(named: "default"))
                testArray.removeAll()
                
                if   "\(dict.value(forKey:"post_type") as! String)" == "1" || "\(dict.value(forKey:"post_type") as! String)" == "2" || "\(dict.value(forKey:"post_type") as! String)" == "6" || "\(dict.value(forKey:"post_type") as! String)" == "7" || "\(dict.value(forKey:"post_type") as! String)" == "7"
                {
                    if ((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi_count") as! Int) != 0
                    {
                        
                        for i in 0..<((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi") as! NSArray).count
                        {
                            
                            testArray.append((((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi") as! NSArray)[i] as AnyObject).value(forKey : "picture") as! String)
                            print("testArray:\((((dataArray[indexPath.row] as! AnyObject).value(forKey : "multi") as! NSArray)[i] as AnyObject).value(forKey : "picture") as! String)")
                            cell.setData(data: testArray)
                            
                            
                        }
                    }
                    else
                    {
                        
                        
                    }
                }
                else if "\(dict.value(forKey:"post_type") as! String)" == "5" || "\(dict.value(forKey:"post_type") as! String)" == "4"
                {
                    if ((dataArray[indexPath.row] as! AnyObject).value(forKey : "image_count") as! Int) != 0
                    {
                        for i in 0..<((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray).count
                        {
                            
                            testArray.append((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)
                            print("testArray:\((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)")
                            cell.setData(data: testArray)
                            
                            
                        }
                    }
                    
                }
                else
                {
                    if ((dataArray[indexPath.row] as! AnyObject).value(forKey : "image_count") as! Int) != 0
                    {
                        for i in 0..<((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray).count
                        {
                            
                            testArray.append((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)
                            print("testArray:\((((dataArray[indexPath.row] as! AnyObject).value(forKey : "image") as! NSArray)[i] as AnyObject).value(forKey : "img") as! String)")
                            cell.setData(data: testArray)
                            
                        }
                    }
                    
                }
                
                
                
            }
            return cell
           
           
        }
        else if indexPath.section == 4{
            
            
            print("\(quesAnsArray)")
            print("\(indexPath.row)")
            
            
            
            if (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "ques_type") as? String == "0"
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FoodHelpViewCell
                
                
                cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2
                cell.userImage.clipsToBounds = true
                cell.selectionStyle = .none
                cell.view1.addShadowView()
                
                
                
                let imageUrl1 = (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "picture") as! String
                
                
                cell.userImage.sd_setImage(with: URL(string: imageUrl1 ), placeholderImage: UIImage(named: "img1"))
                
                cell.question1.text = "\((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "ask_question") as! String)"
                
                cell.username.text = "\((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String)" + ("  ") + "\((quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "last_name") as! String)"
                
                let endDate = (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "created_on") as! String
                
                // cell.selectionStyle = .none
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate1 = dateFormatter1.date(from: endDate)!
                
                dateFormatter1.dateFormat = "LLLL"
                let  month1 = dateFormatter1.string(from: myDate1)
                
                //  let dateFormatter7 = DateFormatter()
                dateFormatter1.dateFormat  = "dd"//"EE" to get short style
                let date1 = dateFormatter1.string(from: myDate1)
                
                dateFormatter1.dateFormat  = "yyyy"//"EE" to get short style
                let year1 = dateFormatter1.string(from: myDate1)
                
                
                if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "created_by") as! String)
                {
                    cell.editDeleteBtn.isHidden = false
                    
                }
                
                
                
                cell.editDeleteBtn.tag = indexPath.row
                cell.editDeleteBtn.addTarget(self, action: #selector(editDelteAction), for: .touchUpInside)
                
                
                cell.quesAskedLabel.text  = " Asked \(String(describing: month1)),\(String(describing: date1)) \(String(describing: year1))"
                if  ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "total_answers") as! String) == "0"
                {
                    if  (((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "answer") as! NSArray)[0] as AnyObject).value(forKey: "ans_id") as? String == "0"
                    {
                        cell.answerLabel.text = "No answers yet"
                    }
                    
                }
                else
                {
                    
                    
                    cell.answerLabel.text = (((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "answer") as! NSArray)[0] as AnyObject).value(forKey: "ask_answer") as? String
                    
                }
                
                return cell
                
            }
            else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! pollTableViewcell
                
                
                
                
                //                if quesAnsArray.count >= 1
                //                {
                //                    var  searchvalue =  ((self.quesAnsArray[0] as AnyObject).value(forKey: "search_val") as! String)
                //
                //
                //
                //                    if searchvalue != "0"
                //                    {
                cell.selectionStyle = .none
                cell.userImage1.layer.cornerRadius = cell.userImage1.frame.size.width/2
                cell.userImage1.clipsToBounds = true
                cell.pollView.addShadowView()
                
                cell.editDeleteBtn1.tag = indexPath.row
                cell.editDeleteBtn1.addTarget(self, action: #selector(editDelteAction), for: .touchUpInside)
                
                cell.question2.text = "\((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "ask_question") as! String)"
                
                if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "created_by") as! String)
                {
                    cell.editDeleteBtn1.isHidden = false
                    
                }
                
                let imageUrl1 = (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "picture") as! String
                
                
                cell.userImage1.sd_setImage(with: URL(string: imageUrl1 ), placeholderImage: UIImage(named: "img1"))
                cell.userName1.text = "\((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String)" + ("  ") + "\((quesAnsArray[indexPath.row] as! AnyObject).value(forKey: "last_name") as! String)"
                
                
                cell.optn1.tag = indexPath.section
                cell.optn1.addTarget(self, action: #selector(btn1), for: .touchUpInside)
                cell.optn2.tag = indexPath.section
                cell.optn2.addTarget(self, action: #selector(btn2), for: .touchUpInside)
                cell.optn3.tag = indexPath.section
                cell.optn3.addTarget(self, action: #selector(btn3), for: .touchUpInside)
                cell.optn4.tag = indexPath.section
                cell.optn4.addTarget(self, action: #selector(btn4), for: .touchUpInside)
                
                let endDate = (quesAnsArray[indexPath.row] as AnyObject).value(forKey: "created_on") as! String
                
                
                let dateFormatter1 = DateFormatter()
                dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate1 = dateFormatter1.date(from: endDate)!
                
                dateFormatter1.dateFormat = "LLLL"
                let  month1 = dateFormatter1.string(from: myDate1)
                
                //  let dateFormatter7 = DateFormatter()
                dateFormatter1.dateFormat  = "dd"//"EE" to get short style
                let date1 = dateFormatter1.string(from: myDate1)
                
                dateFormatter1.dateFormat  = "yyyy"//"EE" to get short style
                let year1 = dateFormatter1.string(from: myDate1)
                
                cell.quesAskedLabel1.text  = "Asked  \(String(describing: month1)),\(String(describing: date1)) \(String(describing: year1))"
                
                if  ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll_reg_id") as! String) != "0"
                {
                    
                    
                    cell.optionView.isHidden = true
                    cell.progressView.isHidden = false
                    cell.segment1.isHidden = false
                    cell.segment2.isHidden = false
                    cell.segment3.isHidden = false
                    cell.segment4.isHidden = false
                    cell.undoBtn.tag = indexPath.row + 1000
                    cell.undoBtn.addTarget(self, action: #selector(undoAct), for: .touchUpInside)
                    if ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count == 2
                    {
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll/total_poll_user)*100)
                        cell.progress1.progress = Float(poll_percentage)/100
                        cell.percentDisplay1.text = "\(Int(poll_percentage))" + "%"
                        
                        
                        cell.optnName1.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll/total_poll_user)*100)
                        cell.progress2.progress = Float(poll_percentage)/100
                        cell.percentDisplay2.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName2.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        cell.segment3.isHidden = true
                        cell.segment4.isHidden = true
                        
                        for i in 0..<((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count
                        {
                            if (((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "poll_id") as! String == ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll_id") as! String)
                            {
                                if i == 0
                                {
                                    cell.tick1.isHidden = false
                                    cell.tick2.isHidden = true
                                    
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                                else
                                {
                                    cell.tick2.isHidden = false
                                    cell.tick1.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"                            }
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    else if ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count == 3
                    {
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll/total_poll_user)*100)
                        cell.progress1.progress = Float(poll_percentage)/100
                        cell.percentDisplay1.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName1.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll / total_poll_user) * 100)
                        cell.progress2.progress = Float(poll_percentage)/100
                        cell.percentDisplay2.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName2.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll / total_poll_user) * 100)
                        cell.progress3.progress = Float(poll_percentage)/100
                        cell.percentDisplay3.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName3.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        cell.segment4.isHidden = true
                        
                        for i in 0..<((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count
                        {
                            if (((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "poll_id") as! String == ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll_id") as! String)
                            {
                                if i == 0
                                {
                                    cell.tick1.isHidden = false
                                    cell.tick2.isHidden = true
                                    cell.tick3.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                                else if i == 1
                                {
                                    cell.tick2.isHidden = false
                                    cell.tick1.isHidden = true
                                    cell.tick3.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                                    
                                else
                                {
                                    cell.tick3.isHidden = false
                                    cell.tick1.isHidden = true
                                    cell.tick2.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                            }
                            
                        }
                        
                        
                        
                    }
                    else{
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll / total_poll_user) * 100)
                        cell.progress1.progress = Float(poll_percentage)/100
                        cell.percentDisplay1.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName1.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll / total_poll_user) * 100)
                        cell.progress2.progress = Float(poll_percentage)/100
                        cell.percentDisplay2.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName2.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll / total_poll_user) * 100)
                        cell.progress3.progress = Float(poll_percentage)/100
                        cell.percentDisplay3.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName3.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        total_poll = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "total_poll") as? String)!)!
                        total_poll_user = Double(((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                        poll_percentage = Float((total_poll / total_poll_user) * 100)
                        cell.progress4.progress = Float(poll_percentage)/100
                        cell.percentDisplay4.text = "\(Int(poll_percentage))" + "%"
                        cell.optnName4.text! = ((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "poll_list") as? String)!
                        
                        for i in 0..<((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count
                        {
                            if (((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "poll_id") as! String == ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll_id") as! String)
                            {
                                if i == 0
                                {
                                    cell.tick1.isHidden = false
                                    cell.tick3.isHidden = true
                                    cell.tick2.isHidden = true
                                    cell.tick4.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                                else if i == 1
                                {
                                    cell.tick2.isHidden = false
                                    cell.tick1.isHidden = true
                                    cell.tick3.isHidden = true
                                    cell.tick4.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                                    
                                else if i == 2
                                {
                                    cell.tick3.isHidden = false
                                    cell.tick1.isHidden = true
                                    cell.tick2.isHidden = true
                                    cell.tick4.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                                else
                                {
                                    cell.tick4.isHidden = false
                                    cell.tick1.isHidden = true
                                    cell.tick2.isHidden = true
                                    cell.tick3.isHidden = true
                                    cell.votes.text = "\((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                    
                else
                {
                    
                    cell.optionView.isHidden = false
                    cell.progressView.isHidden = true
                    cell.progressSegment1.isHidden = false
                    cell.progressSegment3.isHidden = false
                    cell.progressSegment4.isHidden = false
                    cell.progressSegment2.isHidden = false
                    
                    
                    if ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count == 2
                    {
                        cell.optn1.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.optn2.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.progressSegment3.isHidden = true
                        cell.progressSegment4.isHidden = true
                    }
                    else if ((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray).count == 3
                    {
                        cell.optn1.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.optn2.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.optn3.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.progressSegment4.isHidden = true
                        
                        
                        
                        
                    }
                    else{
                        cell.optn1.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.optn2.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.optn3.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        cell.optn4.setTitle((((quesAnsArray[indexPath.row] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                        
                    }
                    
                    
                    
                }
                
                
                //                    }
                //                }
                //
                
                
                return cell
                
            }
            
            
            
            
        }
            
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "qacell", for: indexPath) as! qaTimelineCell
            return cell
        }
        
        
        
        
    }
    
    @objc func undoAct(sender :UIButton!)
    {
        let cell  = tableView.cellForRow(at: IndexPath(row:0,section:sender.tag - 1000)) as! pollTableViewcell
    //    indicator.hidesWhenStopped = true
      //  indicator.startAnimating()
        let params: [String:Any] = ["created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID) ,"quesid" :"\((self.quesAnsArray[sender.tag - 1000] as AnyObject).value(forKey: "quest_id")!)" ]
        cellPath = sender.tag - 1000
        let urlString = "\(Constant.BASEURL)\(Constant.UNDO_POLL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseCode"] == 1
                    
                {
                   // self.indicator.stopAnimating()
                    self.optnLoad = 1
                    //                                let votes = Int(cell.votes.text!)
                    //                                cell.votes.text = String(votes! - 1)
                    self.getQAAllFORCOMMONSEARCH()
                    
                    //  self.timelineFunction()
                    
                }
                
            }
        }
        
        
    }
    
    func changeColorSelectedCell(view:[UIView],label:[UILabel],bgcolor:UIColor,LblTxtColor:UIColor) -> Void {
        
        for allviews in view {
            allviews.backgroundColor = bgcolor
        }
        for allLbl in label {
            
            allLbl.backgroundColor = bgcolor
            allLbl.textColor = LblTxtColor
            //            allLbl.font = UIFont.init(name: "Montserrat-Bold ", size: 12.0)
        }
    }
    
    
    @objc func editDelteAction(sender: UIButton!)
    {
        let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            
            
            //           let params: [String:Any] = ["created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID) ,"latitude" :Utils.getPreferenceValue(ForKey: Constant.LATITUDE) ,"longitude" : Utils.getPreferenceValue(ForKey: Constant.LONGITUDE),"questid" : "0","ask_question" :quesTextView.text!,"ques_type" :ques_type,"poll" : answerArr]
            //            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_QUESTION)"
            //            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            //                let result = response.result
            //                let json = JSON(data: response.data!)
            //
            //                if json != nil
            //                {
            //                    if json["ResponseCode"] == 1
            //
            //                    {
            //
            //                        self.timelineFunction()
            //
            //                    }
            //
            //                }
            //            }
            
            
            if  "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "ques_type")!)" == "0"
            {
                
                self.actn = "0"
                let page:AskQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "askques") as! AskQuestionController
                page.question = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "ask_question")!)"
                page.questionID = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "quest_id")!)"
                page.act = self.actn
                //            page.  = (((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "answer") as! NSArray)[0] as AnyObject).value(forKey: "ask_answer") as? String
                self.present(page, animated: false, completion: nil)
            }
                
            else
            {
                
                let page:AskQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "askques") as! AskQuestionController
                
                if ((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray).count == 2
                {
                    
                    self.actn = "1"
                    page.question = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "ask_question")!)"
                    page.ans1  = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.ans2 = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.questionID = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "quest_id")!)"
                    page.act = self.actn
                }
                else if ((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray).count == 3
                {
                    self.actn = "2"
                    page.question = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "ask_question")!)"
                    page.questionID = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "quest_id")!)"
                    page.ans1  = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.ans2 = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.ans3 = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.act = self.actn
                }
                    
                else
                {
                    self.actn = "3"
                    page.question = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "ask_question")!)"
                    page.questionID = "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "quest_id")!)"
                    page.ans1  = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.ans2 = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.ans3 = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.ans4 = ((((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "poll_list") as? String)!
                    page.act = self.actn
                }
                
                self.present(page, animated: false, completion: nil)
                
                
                
            }
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            
            
            let params: [String:String] = ["pollid" : "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll_id")!)","created_by" : "\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "created_by")!)","quesid":"\((self.quesAnsArray[sender.tag] as AnyObject).value(forKey: "quest_id")!)"]
            
           // self.indicator.hidesWhenStopped = true
            //self.indicator.startAnimating()
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_QUESTION)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json != nil
                {
                    if json["ResponseCode"] == 1
                        
                    {
                        
                       // self.indicator.stopAnimating()
                        self.getQAAllFORCOMMONSEARCH()
                        // self.optnLoad = 5
                        
                        
                    }
                    
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
    
    
    
    
    
    
    
    
    
    @objc func deleteEVENT(sender : UIButton)
    {
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 5000, section:1) as IndexPath) as! reviewCell
        
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Bucket List Options", style: .default, handler: { _ in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
            
            let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to delete this comment?", preferredStyle: .alert)
            
            // Create the actions
            let okAction = UIAlertAction(title: " Yes,Delete it!", style: UIAlertActionStyle.default) {
                UIAlertAction in
                
                let params: [String:String] = ["reviewid" :(self.dataArray1[sender.tag - 5000] as AnyObject).value(forKey: "hotel_id") as! String ,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
                
                
                let urlString = "\(Constant.BASEURL)\(Constant.DELETE_HOTEL_REVIEW)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    if result != nil{
                        if   json["ResponseCode"] ==  1
                        {
                            
                            self.action1 = "1"
                            self.rowNumber1 = self.rowIndex
                            
                                self.getReviewsCommonAll()
                            
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
    
    
    
    
    
    
    
    
    @objc func bucketListAct(sender : UIButton)
    {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "bucketGrp") as! BucketGrpFollowerController
        page.userID = "\((dataArray1[sender.tag - 3000] as AnyObject).value(forKey: "user_id")!)"
        page.REviewID = "\((dataArray1[sender.tag - 3000] as AnyObject).value(forKey: "revrat_id")!)"
        page.userName = "\((dataArray1[sender.tag - 3000] as AnyObject).value(forKey: "first_name")!)"
        self.present(page, animated: false, completion: nil)
        
    }
    @objc func likeEVENT(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:1) as IndexPath) as! reviewCell
        
        
        rowIndex = sender.tag - 2000
        
        
        if cell.likeBtn.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.likesLabel.isHidden = false
            let cont = ((dataArray1[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                //  cell.likesLabel.setTitle("\(cont1) like", for: .normal)
                cell.likesLabel.text = "\(cont1) like"
            }
            else if cont1 == 0
            {
                cell.likesLabel.isHidden = true
                
            }
                
            else
            {
                // cell.likesLabel.setTitle("\(cont1) likes", for: .normal)
                cell.likesLabel.text = "\(cont1) likes"
                
            }
            like = 1
        }
        else
        {
            
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((dataArray1[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.likesLabel.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    //cell.likesLabel.setTitle("\(cont1) like", for: .normal)
                    cell.likesLabel.text = "\(cont1) like"
                }
                    
                else if cont1 == 0
                {
                    cell.likesLabel.isHidden = true
                    
                }
                else
                {
                    //cell.likesLabel.setTitle("\(cont1) likes", for: .normal)
                    cell.likesLabel.text = "\(cont1) likes"
                }
            }
            
            like = 0
        }
        
        likeFuncCall()
        
        
        
    }
    
    
    
    
    
  
    
    @objc func performAction(sender:UIButton!)
    {
        let cell = tableView.cellForRow(at: IndexPath(row : sender.tag,section : 1)) as! reviewCell
        
        
        // myIndexPath = sender.tag
        index1 = sender.tag
        a = 2
        
        cell.hotelAmbianceView.isHidden = false
        cell.moreLessBtn.isHidden = true
        let indexPath = IndexPath(item: sender.tag, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
        
    }
    
    
    @objc func pressButton1(_ sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section: 2) as IndexPath) as! EventsViewCell
        
        
        
        
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Interested", style: .default, handler: { _ in
            //self.openCamera()
            
            var like : Int = 0
            cell.goView.isHidden = true
            cell.goinImage.image = #imageLiteral(resourceName: "circular-check-button-2")
            
            if cell.interestImage.image == UIImage(named :"star-1")
            {
                
                
                cell.interestImage.image = UIImage(named :"bookmark-star")
                
                
                like = 1
            }
            else
            {
                
                cell.interestImage.image = UIImage(named :"star-1")
                like = 0
            }
            
            
            
            let params: [String:String] = ["eventid" : (self.arrRes[sender.tag - 1000] as AnyObject).value(forKey: "event_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            
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
            if cell.interestImage.image == UIImage(named :"star-1")
            {
                cell.interestImage.image = UIImage(named :"bookmark-star")
            }
            else
            {
                cell.interestImage.image = UIImage(named :"star-1")
                
            }
            
            
            let params: [String:String] = ["eventid" : (self.arrRes[sender.tag - 1000] as AnyObject).value(forKey: "event_id") as! String,"going" : "\(going)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
            
            
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
    
    
    @objc func goingBtn(_ sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section: 2) as IndexPath) as! EventsViewCell
        
        let going : Int = 1
        
        cell.goView.isHidden = false
        
        
        let params: [String:String] = ["eventid" : (self.arrRes[sender.tag - 3000] as AnyObject).value(forKey: "event_id") as! String,"going" : "\(going)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
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
    @objc func pressButton(_ sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section: 2) as IndexPath) as! EventsViewCell
        
        var like : Int = 0
        
        if cell.interestImage.image == UIImage(named :"star-1")
        {
            
            
            cell.interestImage.image = UIImage(named :"bookmark-star")
            
            like = 1
        }
        else
        {
            
            cell.interestImage.image = UIImage(named :"star-1")
            like = 0
        }
        let params: [String:String] = ["eventid" : (arrRes[sender.tag - 2000] as AnyObject).value(forKey: "event_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_LIKE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    self.showToast(message: "Interest Shown")
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
    
    @objc func btn1(sender: UIButton!)
    {
        let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: sender.tag) as IndexPath) as! pollTableViewcell
        cellPath = sender.tag
        optionValue = 0
        optnLoad = 1
        progressAPI()
        
    }
    @objc func btn2(sender: UIButton!)
    {
        let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: sender.tag) as IndexPath) as! pollTableViewcell
        cellPath = sender.tag
        optionValue = 1
        optnLoad = 2
        progressAPI()
        
    }
    @objc func btn3(sender: UIButton!)
    {
        let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: sender.tag) as IndexPath) as! pollTableViewcell
        cellPath = sender.tag
        optionValue = 2
        optnLoad = 3
        progressAPI()
        
    }
    @objc func btn4(sender: UIButton!)
    {
        let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: sender.tag) as IndexPath) as! pollTableViewcell
        cellPath = sender.tag
        optionValue = 3
        optnLoad = 4
        progressAPI()
    }
    
    
    
    func progressAPI(){
        
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: cellPath) as IndexPath) as! pollTableViewcell
        
        let params: [String:String] = ["question_id" :(quesAnsArray[cellPath] as AnyObject).value(forKey: "quest_id") as! String, "created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID),"latitude" : "12.78861","longitude" : "80.54645","ask_answer" :"","poll_id":((((quesAnsArray[cellPath] as AnyObject).value(forKey: "poll") as! NSArray)[optionValue] as AnyObject).value(forKey: "poll_id") as? String)!,"ques_type":"1","ansid":"0"]
       // indicator.hidesWhenStopped = true
       // indicator.startAnimating()
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if  json["status"] == 200 {
                
                
                
                
              //  self.indicator.stopAnimating()
                
                print(self.ansArray)
                
                //self.tableView.reloadData()
                // self.tableView.reloadData()
                //   cell.answerLabel.text = "\((self.ansArray[self.celltag] as AnyObject).value(forKey: "ask_answer") as! String)"
                //                let indexPath = IndexPath(item: 0, section: self.cellPath)
                //                self.tableView.reloadRows(at: [indexPath], with: .none)
                self.getQAAllFORCOMMONSEARCH()
                
                
                
                // self.tableView.reloadSections(NSIndexSet(index: self.cellPath) as IndexSet, with: .none)
                
                
            }
                
            else
                
            {
                
                print("Nothing")
                
                
            }
            
            
            
        }
        
    }
    
    @objc func progressAction(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: sender.tag) as IndexPath) as! pollTableViewcell
        
        cellPath = sender.tag
        progressAPI()
        
        
        //        cell.progress1.isHidden = false
        //        cell.progress2.isHidden = false
        //        cell.progress3.isHidden = false
        //        cell.progress4.isHidden = false
        //        cell.optn1.isHidden = true
        //        cell.optn2.isHidden = true
        //        cell.optn3.isHidden = true
        //        cell.optn4.isHidden = true
        
        cell.optionView.isHidden = true
        
        
        
        if ((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray).count == 2
        {
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress1.progress = Float(poll_percentage)/100
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress2.progress = Float(poll_percentage)/100
            
        }
        else if ((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray).count == 3
        {
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress1.progress = Float(poll_percentage)/100
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress2.progress = Float(poll_percentage)/100
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress3.progress = Float(poll_percentage)/100
            
            
            
            
        }
        else{
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress1.progress = Float(poll_percentage)/100
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress2.progress = Float(poll_percentage)/100
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress3.progress = Float(poll_percentage)/100
            
            total_poll = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "total_poll") as? String)!)!
            total_poll_user = Double(((((quesAnsArray[sender.tag] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
            poll_percentage = Float((total_poll / total_poll_user) * 100)
            cell.progress4.progress = Float(poll_percentage)/100
            
            
            
        }
        
       
        
        
        
    }
    
    
    @IBAction func createQuestion(_ sender: UIButton) {
        
        let page:AskQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "askques") as! AskQuestionController
        self.present(page, animated: false, completion: nil)
        
    }
    
    
    
    
    
    
    func getReviewsCommonAll()
    {
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let username = "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"
        let parameters = ["userid": username,"search_text" : searchtext]
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)", method: .post, parameters: parameters)
            
            .responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
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
                        print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        
                        self.dataArray1 = (((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray) as! [[String : AnyObject]])
                        
                        print("\((((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                        print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        print("\((((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                        print("\((((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                        
                        if(self.dataArray1.count != 0){
                            var  searchvalue =  ((self.dataArray1[0] as AnyObject).value(forKey: "search_val") as! String)
                            if self.action1 == "1"
                            {
                                
                                
                                if searchvalue != "0"
                                {
//                                    let indexPath = IndexPath(item: self.rowNumber1, section: 1)
//                                    self.tableView.reloadRows(at: [indexPath], with: .none)
                                         self.tableView.reloadSections([1], with: .none)
                                  //  self.indicator1.stopAnimating()
                                }
                                else {
                                    
                                  //  self.indicator1.stopAnimating()
                                    
                                }
                            }
                            else
                            {
                                
                                if searchvalue != "0"
                                {
                                    //self.tableView.reloadData()
                                         self.tableView.reloadSections([1], with: .none)
                                    //self.indicator1.stopAnimating()
                                }
                                else {
                                    //self.indicator1.stopAnimating()
                                }
                                
                            }
                            
                            
                            //  self.nochatlable.isHidden = false
                            
                            // self.Mytable.isHidden = false
                            
                        }
                        else {
                            //self.indicator1.stopAnimating()
                            self.showToast(message: "Server Error")
                        }
                    }
                    else {
                        
                      //  self.indicator1.stopAnimating()
                        self.showToast(message: "Server Error")
                    }
                    
                    
                }
                else {
                    
                }
                
                
                
        }
        
        
    }
    
    
    
   
    func getAllEventsforcommonsearch()
    {
        
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let username = "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"
        let parameters = ["userid": username,"search_text" : searchtext]
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)", method: .post, parameters: parameters)
            
            .responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
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
                        
                        
                        
                        
                        self.eventsarray = (((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray))
                         self.arrRes = self.eventsarray as! [[String:AnyObject]]
                        print("\((((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                        print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        print("\((((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                        print("\((((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                        
                        if self.eventsarray.count != 0
                        {
                            let  searchvalue =  ((self.eventsarray[0] as AnyObject).value(forKey: "search_val") as! String)
                            
                            if searchvalue != "0"
                                
                            {
                                self.arrRes = self.eventsarray as! [[String:AnyObject]]
                               // self.tableView.reloadData()
                                     self.tableView.reloadSections([4,2], with: .none)
                            }
                            else {
                                
                            }
                        }
                        else {
                            
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
            
            textView.text = "Add a Comment"
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
    
    
    
  
    func CommonSearchFunction()
    {
        if self.action1 != "1"
        {
          //  indicator.hidesWhenStopped = true
            //indicator.startAnimating()
        }
        
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let username = "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"
        
        
        let parameters = ["userid": username,"search_text" : searchtext]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)"
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        
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
                               
                               // self.dataArray = (((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray))
                                //self.dataArray1 = (((self.searchingdetailarray[2] as AnyObject).value(forKey: "review")as! NSArray) as! [[String : AnyObject]])
                                self.peoplearray = (((self.searchingdetailarray[0] as AnyObject).value(forKey: "people") as! NSArray))
                               // self.quesAnsArray = (((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray))
                              //  self.arrRes = (((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray) as! [[String : AnyObject]])
                                
                                
                                print("\((((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                                print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                                
                                print("\((((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                                print("\((((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                                
                                let  searchvalue =  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as! String)
                                
                                if searchvalue != "0"
                                    
                                {
                                   // let indexPath = IndexPath(item: self.rowNumber, section: 0)
                                   // self.tableView.reloadSections([0], with: .none)
                                    self.tableView.reloadData()
                                }
                                
                            }
                            else {
                                
                            }
                            
                            
                            //  self.dataArray = innerDict as! NSArray
                           
                        }
                            
                        else
                        {
                          //  self.indicator.stopAnimating()
                            self.showToast(message: "No posts yet")
                        }
                        
                        
                        
                    }
                }
                
                
            }
        }
        
    }
    
    func getQAAllFORCOMMONSEARCH()
    {
        
       // indicator.hidesWhenStopped = true
       // indicator.startAnimating()
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let params: [String:String] = [ "userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"search_text":searchtext]
        
        // let params: [String:String] = [ "userid" : "3" ]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)"
        
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)", method: .post, parameters: params)
            
            .responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if let resData = json["Data"].arrayObject {
                    
                    if json["Data"] != "Novalue"
                    {
                        self.Questionarray = (((resData as! NSArray) as! [[String : AnyObject]] ))
                        //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                        // "\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"
                        
                        
                    }
                    else {
                        self.showToast(message: "No search found!!!")
                    }
                    if(self.Questionarray.count != 0)
                    {
                        print("\((((self.Questionarray[0] as AnyObject).value(forKey: "people") as! NSArray)))")
                        
                        
                        
                        
                        self.quesAnsArray = (((self.Questionarray[3] as AnyObject).value(forKey: "question") as! NSArray))
                        
                        print("\((((self.Questionarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                        print("\((((self.Questionarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        print("\((((self.Questionarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                        print("\((((self.Questionarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                        
                        var  searchvalue =  ((self.quesAnsArray[0] as AnyObject).value(forKey: "search_val") as! String)
                        
                        if searchvalue != "0"
                        {
                            
                            
                            
                            // self.tableView.reloadSections([4,5], with: .none)
                            
                          self.tableView.reloadData()
                            
                        }
                        else {
                            
                        }
                        
                        
                        
                        if self.optnLoad == 0
                        {
                            
                           // self.indicator.stopAnimating()
                            if searchvalue != "0"
                                
                            {
                                self.tableView.reloadData()
                                     //self.tableView.reloadSections([4,5], with: .none)
                            }
                            
                        }
                        else
                            
                        {
                           
                            
                            //self.indicator.stopAnimating()
                            if searchvalue != "0"
                                
                            {
//                                self.tableView.reloadData()
//                                let indexPath = IndexPath(item: 0, section: self.cellPath)
//                                self.tableView.reloadRows(at: [indexPath], with: .none)
                                     self.tableView.reloadSections([4,5], with: .none)
                            }
                            self.optnLoad = 0
                            
                        }
                        
                        //  self.nochatlable.isHidden = false
                        
                        // self.Mytable.isHidden = false
                        
                    }
                    else {
                        //self.indicator.stopAnimating()
                        //  self.Mytable.isHidden = true
                        // self.showToast(message: "No search found!!!")
                        // self.indicator.stopAnimating()
                    }
                }
                else {
                    //self.indicator.stopAnimating()
                    //   self.indicator.stopAnimating()
                    // self.showToast(message: "No search found!!!")
                    //  self.nochatlable.isHidden = true
                    print("No data")
                }
                
                
        }
        
        
        
    }
    
    
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
                        
                             self.tableView.reloadSections([3], with: .none)
                            
                            
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
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return  CGSize(width: self.view.frame.width, height: 250)
        
        
        
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
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
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
    @IBAction func searchAct(_ sender: UIButton) {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "searchView") as! SearchViewController
        
        self.present(page, animated: false, completion: nil)
        
    }
    
  
    
    @IBAction func postComment(_ sender: UIButton) {
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 9000, section:1) as IndexPath) as! reviewCell
        
        let params: [String:String] = ["comment_id" :"0" ,"hotelid" : (self.dataArray1[sender.tag - 9000] as AnyObject).value(forKey: "revrat_id") as! String,"reviewid" :(self.dataArray1[sender.tag - 9000] as AnyObject).value(forKey: "hotel_id") as! String,
                                       "comments": cell.commentsTextView.text! ,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_HOTEL_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    
                    self.rowNumber = self.rowIndex
                    self.action1 = "1"
                    cell.commentsTextView.text = ""
                    // self.getCommentsAll()ha
                   
                        self.getReviewsCommonAll()
                    
                    
                    
                }
                
            }
            
        }
        
        
        
        
        
        
        
        
        
    }
    
    
    
    //feed
    
    @objc func commentBUTTON(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section:3) as IndexPath) as! homeTableViewCell
        
        cell.postCommentButton.isHidden = false
        cell.commentTextView.becomeFirstResponder()
        
        
    }
    
    
    @objc func ViewAction(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag, section:3) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "1"
        
        self.present(page, animated: false, completion: nil)
        
        
        
    }
    @objc func postCommentBUTTON(sender: UIButton!){
        
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section: 3) as IndexPath) as! homeTableViewCell
        rowIndex = sender.tag - 3000
        commentsText = cell.commentTextView.text!
        cell.postCommentButton.isHidden = true
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        postAct()
        
    }
    @objc func profilePageDisplay(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 4000, section: 0) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
        created_by =  "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "created_by") as! String)"
        Utils.setPreferenceValue(setValue: created_by, ForKey: Constant.CREATED_BY_USERID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "following_id") as! String)", ForKey: Constant.FOLLOWERID)
        
        let page:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! ProfileViewController
        self.present(page, animated: true, completion: nil)
        
        
        
    }
    
    @objc func ViewLikes(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 11000, section:3) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag - 11000] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "2"
        self.present(page, animated: false, completion: nil)
        
        
    }
    
    
    func postAct()
    {
        
        let params: [String:String] = ["comment_id" :"0" ,"timelineid" : (Utils.getPreferenceValue(ForKey: Constant.TIMELINE_ID))
            ,"comments": commentsText ,"created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EDIT_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    
                    self.rowNumber = self.rowIndex
                    self.action1 = "1"
                    // self.getCommentsAll()
                    self.timelineFunctionCommonSearch()
                    
                    
                }
                
            }
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    @objc func optionMenuAction(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag , section:3) as IndexPath) as! homeTableViewCell
        
        
        
        if Utils.getPreferenceValue(ForKey: Constant.USER_ID) != "\((dataArray[sender.tag] as AnyObject).value(forKey: "user_id") as! String)"
        {
            
            let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { _ in
                //self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Copy Link", style: .default, handler: { _ in
                // self.openGallary()
            }))
            
            alert.addAction(UIAlertAction(title: "Turn On Post Notifications", style: .default, handler: { _ in
                // self.openGallary()
            }))
            alert.addAction(UIAlertAction(title: "Share Via", style: .default, handler: { _ in
                // self.openGallary()
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
            
        else
        {
            
            let alert = UIAlertController(title: "Choose Action", message: nil, preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                
                let page = self.storyboard?.instantiateViewController(withIdentifier: "post") as! PostTimelineController
                
                self.k = 1
                //page.imagePost = imag
                
                //   var stringURl =
                if ((self.ImageArray[sender.tag] as AnyObject).value(forKey: "img") as! NSArray).count == 1
                {
                    page.imgArray1 = ((self.ImageArray[sender.tag] as AnyObject).value(forKey: "img") as! NSArray)
                    page.a = self.k
                }
                    
                else
                {
                    page.imgArray1 = (((self.ImageArray[sender.tag] as AnyObject).value(forKey: "img") as! NSArray)[0] as! NSArray) as NSArray
                    page.a = self.k
                    
                    
                }
                self.present(page, animated: false, completion: nil)
                
                
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                
                
                let params: [String:String] = ["timelineid" : "\((self.dataArray[sender.tag] as AnyObject).value(forKey: "timeline_id")!)","created_by" : "\((self.dataArray[sender.tag] as AnyObject).value(forKey: "user_id")!)"]
                
                
                let urlString = "\(Constant.BASEURL)\(Constant.DELETE_POST)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json != nil
                    {
                        if json["ResponseCode"] == 1
                            
                        {
                            
                            self.timelineFunctionCommonSearch()
                            
                        }
                        
                    }
                }
                
            }))
            alert.addAction(UIAlertAction(title: "Report", style: .default, handler: { _ in
                // self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Copy Link", style: .default, handler: { _ in
                // self.openGallary()
            }))
            
            alert.addAction(UIAlertAction(title: "Turn On Post Notifications", style: .default, handler: { _ in
                // self.openGallary()
            }))
            alert.addAction(UIAlertAction(title: "Share Via", style: .default, handler: { _ in
                // self.openGallary()
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
        
        
        // cell.commentTextField.becomeFirstResponder()
        
        
    }
    
    
    
    @objc func likeBUTTON(sender: UIButton!){
        
        let cell = tableView.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:3) as IndexPath) as! homeTableViewCell
        
        
        rowIndex = sender.tag - 2000
        
        
        if cell.likeButton.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeButton.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.totalLikes.isHidden = false
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                cell.totalLikes.text! = "\(cont1) like"
            }
            else if cont1 == 0
            {
                cell.totalLikes.isHidden = true
                
            }
                
            else
            {
                cell.totalLikes.text! = "\(cont1) likes"
                
            }
            like = 1
        }
        else
        {
            
            cell.likeButton.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((dataArray[rowIndex] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.totalLikes.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    cell.totalLikes.text! = "\(cont1) like"
                }
                    
                else if cont1 == 0
                {
                    cell.totalLikes.isHidden = true
                    
                }
                else
                {
                    cell.totalLikes.text! = "\(cont1) likes"
                }
            }
            
            like = 0
        }
        
        likeFuncCall()
        
        
        
    }
    
    
    
    func likeFuncCall()
    {
        
        let params: [String:String] = ["timelineid" : (dataArray[rowIndex] as AnyObject).value(forKey: "timeline_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_TIMELINE_LIKES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    //                    let alert = UIAlertController(title: "", message: "Interest shown", preferredStyle: UIAlertControllerStyle.alert)
                    //                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    //                    self.present(alert, animated: true, completion: nil)
                    self.action1 = "1"
                    self.rowNumber = self.rowIndex
                    self.timelineFunctionCommonSearch()
                    
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
    }
    
   
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.textAlignment = .left
            textView.text = "Add a Comment"
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    
    
    
    
   
}



