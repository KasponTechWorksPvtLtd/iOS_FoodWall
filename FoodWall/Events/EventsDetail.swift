//
//  EventsDetail.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 11/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import MXParallaxHeader
import Alamofire
import SwiftyJSON
//import ParallaxHeader


class EventsDetail: UIViewController, UITableViewDelegate, UITableViewDataSource ,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate{
    
    @IBOutlet var backBUTTON: UIButton!
    @IBOutlet var goinImage: UIImageView!
    @IBOutlet var likeIMage: UIImageView!
    @IBOutlet var starView: UIView!
    @IBOutlet var eventTitle: UILabel!
    
    @IBOutlet var addCommentLabel: UILabel!
    @IBOutlet var eventDateTime: UILabel!
   // @IBOutlet var commentField: UITextField!
    
    @IBOutlet var commentField: UITextView!
    var index : Int = 0
    
    @IBOutlet var view2: UIView!
    @IBOutlet var expandButton: UIButton!
    var commentsData : String = ""
    var timeAgoText : String = ""
    
    @IBOutlet var view1: UIView!
    @IBOutlet var ticketURL: UILabel!
    @IBOutlet var interestedPplCount: UILabel!
    
    @IBOutlet var profPicture: UIImageView!
    @IBOutlet var eventMainStartMonth: UILabel!
    
    @IBOutlet var eventMainStartDate: UILabel!
    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var eventDescription: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var eventLocation: UILabel!
    weak var headerImageView: UIView?
    let topicView = UILabel()
    @IBOutlet var newTable: UITableView!
    let preImage = UIImageView()
   // let topicLabel
    
    var a : Int = 1
     var b : Int = 1
    var  commentID : String = ""
    var editedComment : String = ""
    
    @IBOutlet var postButton: UIButton!
    @IBOutlet var createdBy: UILabel!
    var dataArr = [[String:AnyObject]]()
    var dataArray = [[String:AnyObject]]()
   var commentIDs : [String] = []
    @IBOutlet var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        newTable.delegate = self
        newTable.dataSource = self
        
        self.newTable.estimatedRowHeight = 170.0
        self.newTable.rowHeight = UITableViewAutomaticDimension
        
    
        
       // newTable.estimatedRowHeight = 150
        
        
//        newTable.frame = CGRect(x: 0 , y: 711, width: UIScreen.main.bounds.size.width, height: newTable.contentSize.height)
        
        newTable.estimatedRowHeight = 160.0
        newTable.rowHeight = UITableViewAutomaticDimension
        
        
//        let date = Date(timeIntervalSinceNow: -180)
//        print("Time ago :", date.getElapsedInterval())
        eventDescription.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EventsDetail.tapFunction))
        addCommentLabel.isUserInteractionEnabled = true
        addCommentLabel.addGestureRecognizer(tap)
        scroll.delegate = self
        imageIcon.layer.cornerRadius = imageIcon.frame.size.width/2
        imageIcon.clipsToBounds = true
        
        expandButton.frame = CGRect(x : UIScreen.main.bounds.size.width - 30 ,y : 480 ,width : 15 ,height : 15)
        starView.frame = CGRect(x : 300 ,y : -25 ,width : 60 ,height : 60)
        
        backBUTTON.frame = CGRect(x : 0 ,y : 0,width : 60 ,height : 60)
       // backBUTTON.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        
        view.addSubview(backBUTTON)
        starView.layer.cornerRadius = starView.frame.size.width/2
        starView.clipsToBounds = true
//        starView.dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true)
        postButton.layer.cornerRadius = 10.0
        postButton.clipsToBounds = true
        scroll.addSubview(starView)
      //  print(dataArr)
        postButton.applyGradientButtongreen()
//        let otherVC = EventsViewController()
//        dataArray1 = otherVC.newArray
//        print(dataArray1)
        newTable.isScrollEnabled = false
        
    print(self.newTable.frame.size.height)
        
          setupParallaxHeader()
          getEventDetails()
    }
    
    
    
    @IBAction func backAct(_ sender: UIButton) {
        
        
        let page:EventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventsview") as! EventsViewController
        self.present(page, animated: false, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLayoutSubviews() {
       eventDescription.setContentOffset(.zero, animated: false)
//        newTable.frame = CGRect(x: 0 , y: 711, width: newTable.frame.size.width, height: newTable.contentSize.height)
        newTable.reloadData()
    }
    
//
//    func viewDidLayoutSubviews(){
//
//    }
    
    
    
    @IBAction func viewFullDesc(_ sender: UIButton) {
        
        
        if a == 1
        
        {
        
        let fixedWidth = eventDescription.frame.size.width
        
        eventDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let newSize = eventDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        var newFrame = eventDescription.frame
        
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        
        eventDescription.frame = newFrame
            
            let view1height = 500 + (newSize.height - 70)
            
        view2.frame = CGRect(x : 0, y : 0 , width :  UIScreen.main.bounds.size.width, height : view1height )
        
        view1.frame =  CGRect(x : 0, y : view1height , width : UIScreen.main.bounds.size.width, height : 211 )
            
            let tableY = view1height + 211
              newTable.frame = CGRect(x : 0, y : tableY , width : UIScreen.main.bounds.size.width, height : newTable.frame.size.height )
            
        self.scroll?.contentSize =  CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height + newTable.frame.size.height + (newSize.height - 70) + 200 )
        
        expandButton.frame = CGRect(x :  UIScreen.main.bounds.size.width - 30, y : 480 + newSize.height - 70 , width : 15, height : 15 )
        expandButton.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
         a = 0
        }
        
        else
        
        {
            view2.frame = CGRect(x : 0, y : 0 , width :  UIScreen.main.bounds.size.width, height : 500 )
            
            view1.frame =  CGRect(x : 0, y : 500 , width : UIScreen.main.bounds.size.width, height : 211 )
            newTable.frame = CGRect(x : 0, y : 711 , width : UIScreen.main.bounds.size.width, height : newTable.frame.size.height  )
            
            eventDescription.frame = CGRect(x : 68, y : 395 , width : 290, height : 70 )
            expandButton.frame = CGRect(x : UIScreen.main.bounds.size.width - 30, y : 480 , width : 15, height : 15 )
            expandButton.setImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
            self.scroll?.contentSize =  CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height + newTable.frame.size.height + 200)
            a = 1
        }
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        newTable.isScrollEnabled = true
        let cell = newTable.cellForRow(at: NSIndexPath(row: index , section: 0) as IndexPath) as! eventsDetailsTableViewCell
        
        
        
        
        cell.commentsTextField.becomeFirstResponder()
       

    }
    

    func textViewDidBeginEditing(_ textView: UITextView) {



       // }
    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//
//
//        let cell = newTable.cellForRow(at: NSIndexPath(row: index , section: 0) as IndexPath) as! eventsDetailsTableViewCell
//        if cell.CommentsTextView.text.isEmpty {
//            cell.CommentsTextView.text = "Placeholder"
//            cell.CommentsTextView.textColor = UIColor.lightGray
//        }
//    }
    
    
    @IBAction func goingAction(_ sender: UIButton) {
        
  var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        
        var going : Int = 0
        
        if goinImage.image == UIImage(named :"circular-check-button")
        {
            
            
            goinImage.image = UIImage(named :"accept")
            
            going = 1
        }
        else
        {
            
           goinImage.image = UIImage(named :"circular-check-button")
            going = 0
        }
        let params: [String:String] = ["eventid" : (dict["event_id"] as? String)!,"going" : "\(going)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
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
        
        
    }
    @IBAction func likeAction(_ sender: UIButton) {
        
        var like : Int = 0
         var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        
        if likeIMage.image == UIImage(named :"circular-check-button")
        {
            
            
            likeIMage.image = UIImage(named :"accept")
            
            like = 1
        }
        else
        {
            
            likeIMage.image = UIImage(named :"circular-check-button")
            like = 0
        }
        let params: [String:String] = ["eventid" : (dict["event_id"] as? String)!,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_LIKE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    let alert = UIAlertController(title: "", message: "Status changed to going", preferredStyle: UIAlertControllerStyle.alert)
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
    //MARK: private
    
    private func setupParallaxHeader() {
        
        //        newTable.delegate = self
        //        newTable.dataSource = self
        
        
        
        preImage.frame = CGRect(x : 0 ,y : 15 ,width : UIScreen.main.bounds.width ,height : 400)
       // imageView.image = UIImage(named: "img1")
        preImage.contentMode = .scaleAspectFill
        
      //  topicView.isHidden = true
        
        
        headerImageView = preImage
        
         scroll.parallaxHeader.view = preImage
        scroll.parallaxHeader.height = 300
        // tableView.parallaxHeader.height = 400
        scroll.parallaxHeader.minimumHeight = 55
        
        topicView.isHidden = false
        topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 55)
        //topicView.layer.backgroundColor = UIColor.red.cgColor
        topicView.layer.backgroundColor = UIColor(red: 255/255, green: 222/255, blue: 141/255, alpha: 1.0).cgColor
        topicView.textAlignment = .center
        topicView.text = "Event Title"
        topicView.textColor = UIColor.black
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(EventsDetail.pressButton))
        topicView.isUserInteractionEnabled = true
        topicView.addGestureRecognizer(tap1)
        headerImageView?.addSubview(topicView)
        
      
        
        let backButton = UIButton(frame: CGRect(x: 15, y: 20, width: 20, height: 20))
        backButton.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        
       // backBUTTON.addSubview(backButton)
      //  backButton.addTarget(self, action: #selector(EventsDetail.pressButton(_:)), for: .touchUpInside)
       // view.addSubview(backButton)
        //headerImageView?.addSubview(starView)
        
        //                scroll.parallaxHeader.parallaxHeaderDidScrollHandler = { parallaxHeader in
        //                    print(parallaxHeader.progress)
        //        }
        //
        scroll.parallaxHeader.mode = .topFill
        
        scroll.addSubview(starView)
        
        
       newTable.tableFooterView = UIView()
        
//       self.scroll?.contentSize =  CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height + newTable.frame.size.height + 200)
        
        
        
    }
    
    @objc func pressButton() // @objc func tapFunction()
    
    {
        
        
        self.dismiss(animated: false, completion: nil)
        
        
        
    }
    
    
    func getEventDetails()
    
    {
        
    var dict = dataArr[Int(Utils.getPreferenceValue(ForKey: Constant.PAGECUR))!]
        
        
        
        if (dict["evt_likes"] as? String) == "1"
        {
            
            likeIMage.image = UIImage(named :"bookmark-star")
            
            
            
        }
            
        else
            
        {
            
            likeIMage.image =  UIImage(named :"star-1")
        }
        
        if (dict["gng_likes"] as? String) == "1"
        {
            goinImage.image =  UIImage(named :"accept")
            
            
        }
            
        else
            
        {
            goinImage.image =  UIImage(named :"circular-check-button-2")
            
        }
        let now = Date()
        
       
        let currentDateFormat = DateFormatter()
         currentDateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let currentDate = currentDateFormat.string(from: now)
        
        currentDateFormat.dateFormat = "dd"
        
        let todayDate = currentDateFormat.string(from: now)
        
       
        
        let startDate = (dict["start_date"] as? String)!
       // let createdOn = (dict["start_date"] as? String)!
        
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatterr.date(from: startDate)!
       
        myDate.timeAgoDisplay()
        
        dateFormatterr.dateFormat = "LLLL"
        let  month = dateFormatterr.string(from: myDate)
        
        dateFormatterr.dateFormat = "dd"
        let  startDATE = dateFormatterr.string(from: myDate)
        
        dateFormatterr.dateFormat = "MMM"
        let  startMonth = dateFormatterr.string(from: myDate)
      
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "LLLL"
//        let nameOfMonth = dateFormatter.date(from: startDate)
        
        
        
        //let dateFormatter1 = DateFormatter()
        dateFormatterr.dateFormat  = "EEEE"//"EE" to get short style
        let dayInWeek = dateFormatterr.string(from: myDate)
        
       // let dateFormatter3 = DateFormatter()
        dateFormatterr.dateFormat  = "hh :mm"//"EE" to get short style
        let time = dateFormatterr.string(from: myDate)
        
       // let dateFormatter2 = DateFormatter()
        dateFormatterr.dateFormat  = "dd"//"EE" to get short style
        let dates = dateFormatterr.string(from: myDate)
        
        
        let endDate = (dict["end_date"] as? String)!
        
        
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
                
                
                
                eventDateTime.text = "\(String(describing: dayInWeek)),\(String(describing: month)) \(String(describing: dates)) at \(String(describing: time)) to \(String(describing: dayInWeek1)),\(String(describing: month1)) \(String(describing: date1)) at \(String(describing: time1)) - Event was over"
              

            }
        
            
    else
        
         {
            
            eventDaysleft = Int(startDATE)! - Int(todayDate)!
            eventDateTime.text = "\(String(describing: dayInWeek)),\(String(describing: month)) \(String(describing: dates)) at \(String(describing: time)) to \(String(describing: dayInWeek1)),\(String(describing: month1)) \(String(describing: date1)) at \(String(describing: time1)) - \(eventDaysleft) days left"
            
            
        }
        
        
//        var d : AnyObject = 0 as AnyObject
        
        
        
        
        
        
      
   
        
        eventTitle.text! = (dict["event_name"] as? String)!
//        profPicture.sd_setImage(with: URL(string: (dict["picture"] as! String)), placeholderImage: UIImage(named: "img1.png"))
        
        eventLocation.text! = (dict["location"] as? String)!
        
        eventDescription.text! = (dict["event_description"] as? String)!
        
      //  eventDateTiprintme = "
        
//        
//        if Int((dict["picture"] as! String)) == 0
//        {
//            print("Nithya")
//            
//        }
//        
//        else
//        
//        {
//                  profPicture.sd_setImage(with: URL(string: (dict["picture"] as! String)), placeholderImage: UIImage(named: "img1.png"))
//            
//        }
//        
//        if Int((dict["ticket_url"] as? String)!) == 0
//        {
//            print("Nithya")
//            
//        }
//            
//        else
//            
//        {
//            ticketURL.text! = (dict["ticket_url"] as? String)!
//            
//        }
        
       // ticketURL.text! = (dict["ticket_url"] as? String)!
        eventMainStartDate.text! = startDATE
        eventMainStartMonth.text! = startMonth
            //dict["ticket_url"] as? String)!
        createdBy.text! = (dict["first_name"] as? String)! + " " + (dict["last_name"] as? String)!
       
        
        interestedPplCount.text = "\((dict["created_by"] as? String)!)  People Interested"
        preImage.sd_setImage(with: URL(string: (dict["event_image"] as? String)!), placeholderImage: UIImage(named: "ProfileImg4.png"))
        
          eventDetailCall()
        
//
//        let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID)]
//
//
//        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENT_COMMENT_ALL)"
//        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
//            let result = response.result
//            let json = JSON(data: response.data!)
//
//            if let resData = json["Data"].arrayObject {
//                self.dataArray = resData as! [[String:AnyObject]]
//
//                if(self.dataArray.count == 0){
//
//
//                    print("Empty")
//
//                }
//
//                else
//
//                {
//
//                    print(self.dataArray)
//
//                    for i in 0..<self.dataArray.count
//                    {
//                        self.newTable.frame.size.height = self.newTable.frame.size.height + 140
//                    }
//                    self.scroll?.contentSize =  CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height + self.newTable.frame.size.height)
//                    self.newTable.reloadData()
//                }
//
//
//            }
//
//
//
//
//        }
    
    }
    
    
    
    
    
    
    
    
    
//    func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
//
//        let calendar = NSCalendar.current
//        let unitFlags = NSCalendar.Unit.CalendarUnitMinute | NSCalendar.Unit.CalendarUnitHour | NSCalendar.UnitNSCalendar.Unit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekOfYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitSecond
//        let now = NSDate()
//        let earliest = now.earlierDate(date as Date)
//        let latest = (earliest == now as Date) ? date : now
//        let components:NSDateComponents = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: nil)
//
//        if (components.year >= 2) {
//            return "\(components.year) years ago"
//        } else if (components.year >= 1){
//            if (numericDates){
//                return "1 year ago"
//            } else {
//                return "Last year"
//            }
//        } else if (components.month >= 2) {
//            return "\(components.month) months ago"
//        } else if (components.month >= 1){
//            if (numericDates){
//                return "1 month ago"
//            } else {
//                return "Last month"
//            }
//        } else if (components.weekOfYear >= 2) {
//            return "\(components.weekOfYear) weeks ago"
//        } else if (components.weekOfYear >= 1){
//            if (numericDates){
//                return "1 week ago"
//            } else {
//                return "Last week"
//            }
//        } else if (components.day >= 2) {
//            return "\(components.day) days ago"
//        } else if (components.day >= 1){
//            if (numericDates){
//                return "1 day ago"
//            } else {
//                return "Yesterday"
//            }
//        } else if (components.hour >= 2) {
//            return "\(components.hour) hours ago"
//        } else if (components.hour >= 1){
//            if (numericDates){
//                return "1 hour ago"
//            } else {
//                return "An hour ago"
//            }
//        } else if (components.minute >= 2) {
//            return "\(components.minute) minutes ago"
//        } else if (components.minute >= 1){
//            if (numericDates){
//                return "1 minute ago"
//            } else {
//                return "A minute ago"
//            }
//        } else if (components.second >= 3) {
//            return "\(components.second) seconds ago"
//        } else {
//            return "Just now"
//        }
//
//    }
    
    
    
    
    
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //
    //        if scroll.parallaxHeader.minimumHeight == 50
    //        {
    //            topicView.isHidden = true
    //            topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 60)
    //            topicView.layer.backgroundColor = UIColor.red.cgColor
    //            topicView.textAlignment = .center
    //            topicView.text = "Event Title"
    //            topicView.textColor = UIColor.black
    //            imageView.addSubview(topicView)
    //
    //            let backButton = UIButton(frame: CGRect(x: 25, y: 15, width: 20, height: 20))
    //            backButton.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
    //            topicView.addSubview(backButton)
    //
    //              }
    //    }
    
    //
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //        let backButton = UIButton(frame: CGRect(x: 15, y: 20, width: 20, height: 20))
    //        backButton.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
    //        topicView.addSubview(backButton)
    //       // topicView.isHidden = scrollView.contentOffset.y + scrollView.bounds.height < scrollView.contentSize.height
    //    }
    
    
    //    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
    //
    //        if scroll.parallaxHeader.minimumHeight == 50
    //        {
    //            topicView.isHidden = false
    //            topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 50)
    //            topicView.layer.backgroundColor = UIColor.red.cgColor
    //            imageView.addSubview(topicView)
    //            scroll.parallaxHeader.minimumHeight = 55
    //            // topicView.image = UIImage(named: "beauty-bloom-blue-67636")
    //            //imageView.contentMode = .scaleAspectFill
    //        }
    //
    //
    //    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.commentField {
        self.addCommentLabel.isHidden = commentField.text.isEmpty
        }
    }

//
//    func textView(_ textView: UITextView, range: NSRange, replacementText text: String) -> Bool
//    {
//        if (!commentField.text.isEmpty{
//            addCommentLabel.isHidden = true
//        } else {
//           addCommentLabel.isHidden = false
//        }
//        return true
//    }
    
    
    
    
    @objc func tapFunction()
    
    {
        if commentField.text.isEmpty
        {
        
            addCommentLabel.isHidden = true
            
            
            
        }
        
   
       else  {
            
            addCommentLabel.isHidden = false
            
            
            
        }
        
        
        
        
    }
    
    @objc func tapFunction1(_ sender: UIButton!)
        
    {
        
        
        
       let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! eventsDetailsTableViewCell
        cell.editBigButton.isHidden = true
        
      //  cell.commentsTextField.isEditable = true
        if (cell.commentsTextField.text?.isEmpty)!
                {
                    
        
                    cell.addCommentEdit.isHidden = true
                    cell.editBigButton.isHidden = true
                    //commentID = ""
        
        
                }
        
        
                else  {
        
                    cell.addCommentEdit.isHidden = true
                    cell.editBigButton.isHidden = true
                    cell.commentsTextField.becomeFirstResponder()
        
        
        
                }
        
        
        
        
        
    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        if scroll.parallaxHeader.minimumHeight == 55
//        {
//            topicView.isHidden = false
//            topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 55)
//            topicView.layer.backgroundColor = UIColor.red.cgColor
//            topicView.textAlignment = .center
//            topicView.text = "Event Title"
//            topicView.textColor = UIColor.black
//            headerImageView?.addSubview(topicView)
//
//            let backButton = UIButton(frame: CGRect(x: 15, y: 20, width: 20, height: 20))
//            backButton.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
//            topicView.addSubview(backButton)
//            scroll.parallaxHeader.minimumHeight = 50
//        }
//
//
//        if  scrollView.contentOffset.y + scrollView.bounds.height < 450
//        {
//
//            topicView.isHidden = false
//
//        }
//        else
//        {
//
//            UIView.animate(withDuration: 1.0, animations: {
//
//
//                self.topicView.isHidden = true
//
//            })
//
//
//
//        }
//
//    }
//
    
    
//
//    private func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
    
    
    @IBAction func postAction(_ sender: UIButton) {
        
        
        
       
        
        let now = Date()
        timeAgoText = now.timeAgoDisplay()
        commentsData = commentField.text!
        
        
        
        let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID),"comment_id" : "0","comments":commentField.text!,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EVENT_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
         
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                
                {
                    print("Success")
                    
                    self.commentField.text = ""
                   // self.newTable.reloadData()
                    self.eventDetailCall()
                    
                    
                }
                
            }
            
            
            
            
        }
       // print(dataArray)
        
       
       // newTable.reloadData()
        
        
    }
    
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //        if scroll.parallaxHeader.minimumHeight == 300
    //        {
    //            topicView.isHidden = true
    //            topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 50)
    //            topicView.layer.backgroundColor = UIColor.red.cgColor
    //            imageView.addSubview(topicView)
    //            // topicView.image = UIImage(named: "beauty-bloom-blue-67636")
    //            //imageView.contentMode = .scaleAspectFill
    //        }
    //    }
    
    
    
    
    //MARK: table view data source/delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if commentsData != ""
        {
            
            return dataArray.count + 1
            
        }
        
        else
        {
        return dataArray.count
       
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! eventsDetailsTableViewCell
        
        index = indexPath.row
        cell.commentsTextField.tag = indexPath.row
//        cell.commentsTextField.delegate = self
       

        cell.addCommentEdit.tag = indexPath.row
        
      //  cell.CommentsTextView.delegate = self as! UITextViewDelegate
        cell.deleteRow.tag = indexPath.row
        cell.editRow.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.editBigButton.tag = indexPath.row
        //cell.editCommentView.isHidden = true
        if indexPath.row == 0
        {
            if commentsData != ""
            
            {
                cell.commentsTextField.text! = commentsData
                cell.daysText.text! = timeAgoText
                cell.userName.text! = Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME) + " " + Utils.getPreferenceValue(ForKey: Constant.LAST_NAME)
                
                b = 0
                commentsData = ""
                cell.editButton.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
            }
            
            else
            {
                cell.commentsTextField.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "evt_comments")!)"
                
                let createdTime = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate = dateFormatterr.date(from: createdTime)!
                cell.daysText.text! =  myDate.timeAgoDisplay()
                cell.userName.text! = Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME) + " " + Utils.getPreferenceValue(ForKey: Constant.LAST_NAME)
             //   commentIDs.append("\((dataArray[indexPath.row] as AnyObject).value(forKey: "cmmt_evt_id")!)")
               
                 cell.editButton.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
            }
            
        }
        
        else
        
        {
            
            
            if b == 0
            {
           
        
                cell.commentsTextField.text! = "\((dataArray[indexPath.row - 1] as AnyObject).value(forKey: "evt_comments")!)"
                let createdTime = "\((dataArray[indexPath.row - 1] as AnyObject).value(forKey: "created_on")!)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate = dateFormatterr.date(from: createdTime)!
                cell.daysText.text! =  myDate.timeAgoDisplay()
                cell.userName.text! = Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME) + " " + Utils.getPreferenceValue(ForKey: Constant.LAST_NAME)
                 cell.editButton.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
              //  commentIDs.append("\((dataArray[indexPath.row] as AnyObject).value(forKey: "cmmt_evt_id")!)")
            
            }
            
            else
            {
                
                cell.commentsTextField.text! = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "evt_comments")!)"
                let createdTime = "\((dataArray[indexPath.row] as AnyObject).value(forKey: "created_on")!)"
                let dateFormatterr = DateFormatter()
                dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let myDate = dateFormatterr.date(from: createdTime)!
                cell.daysText.text! =  myDate.timeAgoDisplay()
                cell.userName.text! = Utils.getPreferenceValue(ForKey: Constant.FIRST_NAME) + " " + Utils.getPreferenceValue(ForKey: Constant.LAST_NAME)
                cell.editButton.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
              //  commentIDs.append("\((dataArray[indexPath.row] as AnyObject).value(forKey: "cmmt_evt_id")!)")
               
                
            }
            
        }

       
        
        

//        commentIds.insert("\((dataArray[indexPath.row] as AnyObject).value(forKey: "cmmt_evt_id")!)", at: indexPath.row)
        
        return cell
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    @objc func editAction(_ sender: UIButton!)
    {
        
        
        let indexPath =  NSIndexPath(row: sender.tag, section: 0)
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! eventsDetailsTableViewCell
        
        cell.editView.isHidden = false
        
         // dataSource being your dataSource array
        cell.deleteRow.addTarget(self, action: #selector(deleteRowAction(_:)), for: .touchUpInside)
        cell.editRow.addTarget(self, action: #selector(editRowAction(_:)), for: .touchUpInside)
       
      // cell.CommentsTextView.isUserInteractionEnabled = true
        
        newTable.reloadData()
        
        
    }
    
    @objc func deleteRowAction(_ sender: UIButton!)
    {
        
     

        
//        dataArray.remove(at: sender.tag)
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! eventsDetailsTableViewCell
        
        
        
        
        let alertController = UIAlertController(title: "FoodWall", message: "Are you sure to delete this comment?", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: " Yes,Delete it!", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            
            let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID),"comment_id" :
                "\((self.dataArray[sender.tag] as AnyObject).value(forKey: "cmmt_evt_id")!)" ,"comments": cell.CommentsTextView.text!,"created_by" :"119"]
            
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
                        self.dataArray.remove(at: sender.tag)
                        cell.editView.isHidden = true
                        self.newTable.reloadData()
                        
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
        
//        for i in 0..<self.dataArray.count
//        {
//            self.newTable.frame.size.height = self.newTable.frame.size.height + 140
//        }
        self.scroll?.contentSize =  CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height + self.newTable.frame.size.height + 200)
       
        
       // newTable.reloadData()
        
        
    }
    
    @objc func editRowAction(_ sender: UIButton!)
    {
        
        
        
        
        //        dataArray.remove(at: sender.tag)
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! eventsDetailsTableViewCell
        
//        cell.commentsTextField.isUserInteractionEnabled = true
//        cell.commentsTextField.delegate = self
        cell.commentsTextField.frame = CGRect(x: 10 , y: 90, width: 200, height: 60)
        cell.editView.isHidden = true
        
       // cell.editCommentView.isHidden = false
        cell.postEditButton.isHidden = false
        cell.cancelEditButton.isHidden = false
        cell.postEditButton.addTarget(self, action: #selector(postEditedComment(_:)), for: .touchUpInside)
        cell.postEditButton.applyGradientButtongreen()
        cell.postEditButton.layer.cornerRadius = 10.0
        cell.postEditButton.clipsToBounds = true
        cell.cancelEditButton.layer.cornerRadius = 5.0
        cell.cancelEditButton.clipsToBounds = true
        cell.cancelEditButton.layer.borderColor = UIColor.black.cgColor
        cell.cancelEditButton.layer.borderWidth = 1.0
        
        
    cell.cancelEditButton.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        commentID =  "\((self.dataArray[sender.tag] as AnyObject).value(forKey: "cmmt_evt_id")!)"
        
        

        
         cell.editBigButton.addTarget(self, action: #selector(textViewDidBeginEditing(_:)), for: .touchUpInside)
        
      
        

    }
    
     @objc func cancelAction(_ sender: UIButton!)
     {
        
        let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! eventsDetailsTableViewCell
        cell.editView.isHidden = true
        cell.postEditButton.isHidden = true
        cell.cancelEditButton.isHidden = true
        cell.commentsTextField.frame = CGRect(x: 20 , y: 85, width: 340 , height: 85)
       // cell.editCommentView.isHidden = true
        self.view.endEditing(true)
    }
    
    
   @objc func postEditedComment(_ sender: UIButton!)
    
    {
        
         let cell = newTable.cellForRow(at: NSIndexPath(row: sender.tag, section: 0) as IndexPath) as! eventsDetailsTableViewCell
        editedComment = cell.posteditedComment.text!
        cell.editView.isHidden = true
        cell.postEditButton.isHidden = true
        cell.cancelEditButton.isHidden = true
        
        let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID),"comment_id" :
            commentID,"comments": editedComment,"created_by" :"119"]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EVENT_COMMENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    print("Success")
                   
                    
                    self.eventDetailCall()
                   // self.newTable.reloadData()
                    
                }
                
            }
            
        }
        
        
        
        
        
    }
    
    
    func eventDetailCall()
    {
        let params: [String:String] = ["eventid" : Utils.getPreferenceValue(ForKey: Constant.EVENT_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENT_COMMENT_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                self.dataArray = resData as! [[String:AnyObject]]
                
                if(self.dataArray.count == 0){
                    
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                    print(self.dataArray)
                    
//                    for i in 0..<self.dataArray.count
//                    {
//                        self.newTable.frame.size.height = self.newTable.frame.size.height + 140
//                    }
                   
                    self.newTable.reloadData()
                    self.newTable.frame.size.height = self.newTable.contentSize.height + 100

                     self.scroll?.contentSize =  CGSize(width: self.view.frame.size.width, height: UIScreen.main.bounds.size.height + self.newTable.frame.size.height + 200)
                }
                
                
            }
            
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    
    
}








extension UIView {
    
    
    func addShadowViewEventsDetail() {
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
    func applyGradientButtongreen() {
        let gradient = CAGradientLayer()
        
      //  let greenColor  = UIColor.green.cgColor
             let yellow  = UIColor(red: 153/255, green: 255/255, blue:94/255, alpha: 1.0).cgColor
        
        
        
        
        gradient.colors = [yellow,yellow,yellow]   // your colors go here
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
}
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        
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
    
    func timeAgoDisplay2() -> String {
        
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
            return "\(diff) m"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) h"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) d"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff) w"
    }
    
    func timeAgoDisply() -> String {
        
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
            return "\(diff) m"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) h"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) d"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff) w"
    }
    
    
   
    
}

//extension Date {
//
//    func getElapsedInterval() -> String {
//
//        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
//
//        if let year = interval.year, year > 0 {
//            return year == 1 ? "\(year)" + " " + "year" :
//                "\(year)" + " " + "years"
//        } else if let month = interval.month, month > 0 {
//            return month == 1 ? "\(month)" + " " + "month" :
//                "\(month)" + " " + "months"
//        } else if let day = interval.day, day > 0 {
//            return day == 1 ? "\(day)" + " " + "day" :
//                "\(day)" + " " + "days"
//        } else if let hour = interval.hour, hour > 0 {
//            return hour == 1 ? "\(hour)" + " " + "hour" :
//                "\(hour)" + " " + "hours"
//        } else if let minute = interval.minute, minute > 0 {
//            return minute == 1 ? "\(minute)" + " " + "minute" :
//                "\(minute)" + " " + "minutes"
//        } else if let second = interval.second, second > 0 {
//            return second == 1 ? "\(second)" + " " + "second" :
//                "\(second)" + " " + "seconds"
//        } else {
//            return "a moment ago"
//        }
//
//    }
//}
//
