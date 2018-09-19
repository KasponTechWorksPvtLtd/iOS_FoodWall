//
//  EventsViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 30/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class EventsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate ,KYButtonDelegate{
    
    
    @IBOutlet weak var tableview2: UITableView!
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
    @IBOutlet var backButton: UIButton!
    var arrRes = [[String:AnyObject]]()
    var cohostsArray = [[String:AnyObject]]()
    var newArray = [[String:AnyObject]]()
    var eventType : String = ""
  //  var dataArray1 :NSArray = []
    @IBOutlet var eventsNore: KYButton!
    

    let cellSpacingHeight: CGFloat = 260
    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView1: UITableView!
    
    //search
    var searchingdetailarray = [[String:AnyObject]]()
    var eventsarray : NSArray = []
    
    @IBOutlet weak var segmentview: UIView!
    @IBOutlet weak var tablegroupview: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // headerView.addShadowViewEvents()
       // indicator.isHidden = true
        tableView1.delegate = self
        tableView1.dataSource = self
        tableview2.delegate = self
        tableview2.dataSource = self
        eventsNore.kyDelegate = self
        tableView1.estimatedRowHeight = 160.0
        tableView1.rowHeight = UITableViewAutomaticDimension
        
        
        
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            headerView.isHidden = true
            segmentview.isHidden = true
            
            tablegroupview.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            tablegroupview?.translatesAutoresizingMaskIntoConstraints = true
            tableview2.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            tableview2?.translatesAutoresizingMaskIntoConstraints = true
            tableView1.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            tableView1?.translatesAutoresizingMaskIntoConstraints = true
            
            //            segmentCtrl?.translatesAutoresizingMaskIntoConstraints = true
            headerView.addDropShadowToView(targetView: headerView)
            segmentview.addDropShadowToView(targetView: segmentview)
            eventType = "2"
            tableView1.isHidden = false
            tableview2.isHidden = true
            getAllEventsforcommonsearch()
            tableview2.reloadData()
        }
        else {
            headerView.isHidden = false
            tablegroupview.frame.size.width = self.view.frame.size.width
            tablegroupview.frame.size.height = self.view.frame.size.height
            eventType = "1"
            getAllEvents()
        }
        
        
        
      //  getUserLike()
      //  getAllEvents()
       // eventsNore.kyDelegate = self
        eventsNore.openType = .popUp
        eventsNore.plusColor = UIColor.white
        //eventsNore.plusColor = 
        
        eventsNore.fabTitleColor = UIColor.black
        eventsNore.add(color:UIColor.white, title: "Private Events(Visible to only your followers)", image: UIImage(named: "globeLock")!){_ in
           
            
            let page:PrivateEventController = self.storyboard?.instantiateViewController(withIdentifier: "privateevent") as! PrivateEventController
            self.present(page, animated: false, completion: nil)
            
            
            
        }
        eventsNore.add(color:UIColor.white, title: "Public Events(Visible to everyone)", image: UIImage(named: "world")!){_ in
            
            let page:PublicEventController = self.storyboard?.instantiateViewController(withIdentifier: "publicevent") as! PublicEventController
            self.present(page, animated: false, completion: nil)
            
        }
       
         // eventsNore.closeButton()
        
//            self.progress = 0.0
//            self.progress = (self.progress + 0.14 <= 1.0) ? self.progress + 0.14 : 1.0
//            self.selectImage2 = UIImage.init(named: "no_image.jpg")!
//            //  self.btnImgMain.uploadImage(image:self.selectImage2, progress: self.progress)
//            if(self.progress <= 1.0) {
//                self.perform(#selector(PhotosEditVC.reset1), with: nil, afterDelay: 0.2)
//            }
//            self.progress += 0.1
//
//            self.btnImgMain.autoCompleted = true
//
//            self.imgByteConversion = ""
        
        
//        
//        if progress == 1.0 {
//            progress = 0.0
//        }
//        
//        progress = (progress + 0.14 <= 1.0) ? progress + 0.14 : 1.0
//        self.reset()
//        self.btnImgMain.autoCompleted = true

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    @IBAction func backAct(_ sender: UIButton) {
        
          self.dismiss(animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
        //        view.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 0.1)
        //        view.layer.shadowOpacity = 0.1
        
         view.backgroundColor = UIColor(red: 239/255, green: 238/255, blue: 239/255, alpha: 0.1)
        
       // view.backgroundColor = UIColor.white
        return view
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return arrRes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "evencell", for: indexPath) as! EventsViewCell
        let startDate = (arrRes[indexPath.section] as AnyObject).value(forKey: "start_date") as! String
        // let createdOn = (dict["start_date"] as? String)!
        
        
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatterr.date(from: startDate)!
        dateFormatterr.dateFormat = "LLLL"
        let  month = dateFormatterr.string(from: myDate)
        dateFormatterr.dateFormat = "dd"
        let  day = dateFormatterr.string(from: myDate)
         cell.startDate.text! = month + " " + day
        
    //   cell.startDate.text = month
        
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 30.0
        cell.layer.masksToBounds = true
        cell.contentView.isUserInteractionEnabled = true

        cell.eventLocation.text = (arrRes[indexPath.section] as AnyObject).value(forKey: "location") as! String
        //if (arrRes[indexPath.section] as AnyObject).value(forKey: "event_id") as! String
        // var EventID = (arrRes[indexPath.section] as AnyObject).value(forKey: "event_id") as! String
        
        
        
        
        
        cell.eventTitle.text = (arrRes[indexPath.section] as AnyObject).value(forKey: "event_name") as! String
         cell.eventsPrevImage.sd_setImage(with: URL(string: (arrRes[indexPath.section] as AnyObject).value(forKey: "event_image") as! String), placeholderImage: UIImage(named: "ProfileImg3.png"))
        
       
        cell.interestedButton.tag = indexPath.section + 2000
        cell.interestedButton.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        
      if "\((arrRes[indexPath.section] as AnyObject).value(forKey: "evt_likes")!)" ==  "1"
      {
        cell.interestImage.image =   UIImage(named :"bookmark-star")
        
      }
        else
        {
        
        cell.interestImage.image =  UIImage(named :"star-1")
        
        }
        
        if "\((arrRes[indexPath.section] as AnyObject).value(forKey: "gng_likes")!)" ==  "1"
        {
             cell.goView.isHidden = false
            
        }
        else
        {
            
           
            cell.goinImage.image =  #imageLiteral(resourceName: "circular-check-button-2")
            
        }
        
        cell.goinButton.tag = indexPath.section + 3000
        cell.goinButton.addTarget(self, action: #selector(goingBtn(_:)), for: .touchUpInside)
        cell.acceptBtn.addTarget(self, action: #selector(pressButton1(_:)), for: .touchUpInside)
        cell.acceptBtn.tag = indexPath.section + 1000
        
        
        
     Utils.setPreferenceValue(setValue: "\((arrRes[indexPath.section] as AnyObject).value(forKey: "event_id")!)", ForKey: Constant.EVENT_ID)
        

      cell.view1.addShadowViewEvents()
        cell.view1.layer.cornerRadius = 20.0
        cell.view1.clipsToBounds = true
        
//        cell.view2.addShadowViewEvents()
        return cell
            
        }
        
        else
        {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! myEventsTableViewCell
            
            let startDate = (arrRes[indexPath.section] as AnyObject).value(forKey: "start_date") as! String
            // let createdOn = (dict["start_date"] as? String)!
            
            
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: startDate)!
            dateFormatterr.dateFormat = "LLLL"
            let  month = dateFormatterr.string(from: myDate)
            dateFormatterr.dateFormat = "dd"
            let  day = dateFormatterr.string(from: myDate)
            cell.startDate.text! = month + " " + day
            
            //   cell.startDate.text = month
            
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 30.0
            cell.layer.masksToBounds = true
            cell.contentView.isUserInteractionEnabled = true
            
            cell.eventLocation.text = (arrRes[indexPath.section] as AnyObject).value(forKey: "location") as! String
            //if (arrRes[indexPath.section] as AnyObject).value(forKey: "event_id") as! String
            // var EventID = (arrRes[indexPath.section] as AnyObject).value(forKey: "event_id") as! String
            
            
            
            
            
            cell.eventTitle.text = (arrRes[indexPath.section] as AnyObject).value(forKey: "event_name") as! String
            cell.prevImage.sd_setImage(with: URL(string: (arrRes[indexPath.section] as AnyObject).value(forKey: "event_image") as! String), placeholderImage: UIImage(named: "ProfileImg3.png"))
            
            
            cell.editBtn.tag = indexPath.section + 1000
            cell.editBtn.addTarget(self, action: #selector(editAction(_:)), for: .touchUpInside)
            
            
            
            cell.deleteBtn.tag = indexPath.section + 2000
            cell.deleteBtn.addTarget(self, action: #selector(deleteAction(_:)), for: .touchUpInside)
            
            
            
            
            Utils.setPreferenceValue(setValue: "\((arrRes[indexPath.section] as AnyObject).value(forKey: "event_id")!)", ForKey: Constant.EVENT_ID)
            
            
            cell.view1.addShadowViewEvents()
            cell.view1.layer.cornerRadius = 20.0
            cell.view1.clipsToBounds = true
            
            //        cell.view2.addShadowViewEvents()
            return cell
            
            
        }
    }
    
    
    @objc func goingBtn(_ sender: UIButton!){
        
        let cell = tableView1.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 3000) as IndexPath) as! EventsViewCell
        
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
    
    @objc func editAction(_ sender: UIButton!){
        
        let cell = tableview2.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 1000) as IndexPath) as! myEventsTableViewCell

        var eventType = (arrRes[sender.tag] as AnyObject).value(forKey: "event_type") as! String
        
        if eventType == "1"
        {
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "privateevent") as! PrivateEventController
        var pageCur = sender.tag

        page.dataArr = arrRes as! NSMutableArray
        page.pageCursor = pageCur
       // page.userid = (arrRes[pageCur] as AnyObject).value(forKey: "user_id") as! String

        self.present(page, animated: false, completion: nil)
        
        }
        
        else
        {
            let page = self.storyboard?.instantiateViewController(withIdentifier: "publicevent") as! PublicEventController
            
            var pageCur = sender.tag
            
           // page.dataArr = (arrRes as! NSMutableArray) as! [[String : AnyObject]]
            page.dataArr = arrRes as! [[String : AnyObject]]
            page.pageCursor = pageCur
            // page.userid = (arrRes[pageCur] as AnyObject).value(forKey: "user_id") as! String
            
            self.present(page, animated: false, completion: nil)
            
        }
        
        
        
        
        
    }
    
    @objc func deleteAction(_ sender: UIButton!){
        
        let cell = tableview2.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 2000 ) as IndexPath) as! myEventsTableViewCell
        
        
        
        let params: [String:String] = ["eventid" : (arrRes[sender.tag - 2000] as AnyObject).value(forKey: "event_id") as! String,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_EVENTS)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    self.tableview2.reloadData()
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
        
        let cell = tableView1.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 2000) as IndexPath) as! EventsViewCell
        
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
    
    @IBAction func segmentAct(_ sender: Any) {
        
        switch segmentCtrl.selectedSegmentIndex
        {
        case 0:
           eventType = "1"
           getAllEvents()
            
           
        case 1:
            eventType = "2"
            tableView1.isHidden = false
            tableview2.isHidden = true
            getAllEvents()
        
        case 2:
            tableview2.isHidden = false
            tableView1.isHidden = true
           // getAllEvents()
            getEventsUser()
            
            
            
        default:
            break
        }
        
        
    }
    @IBOutlet weak var segmentAct: UISegmentedControl!
   
    @objc func pressButton1(_ sender: UIButton!){
        
        
        let cell = tableView1.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 1000) as IndexPath) as! EventsViewCell
        
       
        
        
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        let pageCur = indexPath.section
        
        Utils.setPreferenceValue(setValue: "\(pageCur)", ForKey: Constant.PAGECUR)
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
        
        
       // page.dataArr = arrRes as NSArray
        page.userid = (arrRes[pageCur] as AnyObject).value(forKey: "user_id") as! String
        page.eventID = (arrRes[pageCur] as AnyObject).value(forKey: "event_id") as! String
        self.present(page, animated: false, completion: nil)
        
        
        
    }
    
    
//
//    @IBAction func backAct(_ sender: UIButton) {
//
//        let page:MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuview") as! MenuViewController
//
//        self.present(page, animated: true, completion: nil)
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    func getAllEvents()
    {
        
        let params: [String:String] = ["userid" : "21","event_type" :eventType]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENTS_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)

            if let resData = json["Data"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
                
                if(self.arrRes.count != 0){
                    
                    
                    print(self.arrRes)
                    self.tableView1.reloadData()

                }
                
                else
                
                {
                    print("No Action")
                    
                }
            
                
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
                                self.tableView1.reloadData()
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
    
    
    
    func getEventsUser()
    {
        
        let params: [String:String] = ["userid" : "21","deleted":"0"]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENTS_USER)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
                
                if(self.arrRes.count != 0){
                    
                    
                    print(self.arrRes)
                    self.tableview2.reloadData()
                    
                }
                    
                else
                    
                {
                    print("No Action")
                    
                }
                
                
            }
            
        }
        
        
        
    }

    
    func getUserLike()
    
    
    {
        
        var dict = arrRes
        
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"eventid" : ""]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_EVENT_USER_LIKED)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
                
                if(self.arrRes.count == 0){
                    
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                    print(self.arrRes)
                    self.tableView1.reloadData()
                }
                
                
            }
            
        }
        
        
       
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    func applyGradientButton() {
        let gradient = CAGradientLayer()
        
        let greenColor  = UIColor.green.cgColor
//        let orangeColor  = UIColor(red: 255/255, green: 128/255, blue:8/255, alpha: 1.5).cgColor
        
        gradient.colors = [greenColor,greenColor,UIColor.white.cgColor]   // your colors go here
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
   
        
        func addShadowViewEvents() {
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
//    
//    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowRadius = 1
//        
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
    
    // OUTPUT 2
//    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = color.cgColor
//        layer.shadowOpacity = opacity
//        layer.shadowOffset = offSet
//        layer.shadowRadius = radius
//
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
    
}



