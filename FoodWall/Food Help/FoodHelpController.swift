//
//  FoodHelpController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FoodHelpController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate {
    
    @IBOutlet weak var askQuesView: UIView!
    
  
    // @IBOutlet weak var indicator: UIView!
    @IBOutlet var bottomBar: UITabBar!
    @IBOutlet var menuBarItem: UITabBarItem!
    @IBOutlet var notificationsButton: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!
    
   
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    let cellSpacingHeight: CGFloat = 200
    var quesAnsArray : NSArray = []
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
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
        
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            headerView.isHidden = true
            
            tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            tableView?.translatesAutoresizingMaskIntoConstraints = true
            headerView.addDropShadowToView(targetView: headerView)
            tableView.reloadData()
        }
        else {
            headerView.isHidden = false
            tableView.frame.size.width = self.tableView.frame.size.width
            tableView.frame.size.height = self.tableView.frame.size.height
            tableView.isHidden = false
            tableView?.translatesAutoresizingMaskIntoConstraints = false
            tableView.reloadData()
            headerView.addShadowView()
        }
        
        
        
        headerView.addShadowView()
        //askQuesView.isHidden = true
        
        bottomBar.selectedItem = foodHelpButton
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        bottomBar.selectedItem?.title = "Food Help"
        bottomBar.isHidden = false
        
        tableView.estimatedRowHeight = 55.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        if   UserDefaults.standard.string(forKey: "Controller") == "MainsearchViewController"
        {
            
            getQAAllFORCOMMONSEARCH()
            //  getQAAll()
        }
        else {
            
            //  getQAAllFORCOMMONSEARCH()
            getQAAll()
            
        }
        
        //  getAnsAll()
        //  getAnsAll()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // getQAAll()
    }
    
    override func viewDidLayoutSubviews() {
        headerView.layer.masksToBounds =  false
        headerView.layer.shadowColor = UIColor.lightGray.cgColor
        headerView.layer.shadowOffset =  CGSize(width: 2, height: 3)
        headerView.layer.shadowOpacity = 1.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quesAnsArray.count
    }
    
    
    func getQAAll()
    {
        
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
        Utils.svprogressHudShow(title: "Loading...", view: self)
      
        let params: [String:String] = [ "userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID) ]
        
        // let params: [String:String] = [ "userid" : "3" ]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_QUESTION_ANSWER_ALL)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.quesAnsArray = resData as! [[String:AnyObject]] as NSArray
                
                if(self.quesAnsArray.count != 0){
                    
                    
                    print(self.quesAnsArray)
                    self.tableView.reloadData()
                    
                    if self.optnLoad == 0
                    {
                        self.tableView.reloadData()
                       
                        Utils.svprogressHudDismiss(view: self)
//                        self.indicator.stopAnimating()
                    }
                    else
                        
                    {
                       
                        Utils.svprogressHudDismiss(view: self)
//                        self.indicator.stopAnimating()
                        let indexPath = IndexPath(item: 0, section: self.cellPath)
                        self.tableView.reloadRows(at: [indexPath], with: .none)
                        self.optnLoad = 0
                        
                    }
                    
                }
                    
                else
                    
                {
           
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator.stopAnimating()
                    print("Nothing")
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    
    
    func getQAAllFORCOMMONSEARCH()
    {
        
        Utils.svprogressHudShow(title: "Loading...", view: self)
       
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
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
                            self.tableView.reloadData()
                            
                        }
                        else {
                            
                        }
                        
                        
                        
                        if self.optnLoad == 0
                        {
                           
                            Utils.svprogressHudDismiss(view: self)
                          //  self.indicator.stopAnimating()
                            if searchvalue != "0"
                                
                            {
                                self.tableView.reloadData()
                            }
                            
                        }
                        else
                            
                        {
                            Utils.svprogressHudDismiss(view: self)
                           // self.indicator.stopAnimating()
                            if searchvalue != "0"
                                
                            {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(item: 0, section: self.cellPath)
                                self.tableView.reloadRows(at: [indexPath], with: .none)
                            }
                            self.optnLoad = 0
                            
                        }
                        
                        //  self.nochatlable.isHidden = false
                        
                        // self.Mytable.isHidden = false
                        
                    }
                    else {
                      
                        Utils.svprogressHudDismiss(view: self)
                       // self.indicator.stopAnimating()
                        //  self.Mytable.isHidden = true
                        // self.showToast(message: "No search found!!!")
                        // self.indicator.stopAnimating()
                    }
                }
                else {
                  
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator.stopAnimating()
                    //   self.indicator.stopAnimating()
                    // self.showToast(message: "No search found!!!")
                    //  self.nochatlable.isHidden = true
                    print("No data")
                }
                
                
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
        //        view.backgroundColor = UIColor(red: 118/255, green: 118/255, blue: 118/255, alpha: 0.1)
        //        view.layer.shadowOpacity = 0.1
        
        view.backgroundColor = UIColor(red: 239/255, green: 238/255, blue: 239/255, alpha: 0.1)
        
        // view.backgroundColor = UIColor.white
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ques_type") as? String != ""
        {
            
            
            if (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ques_type") as? String == "0"
            {
                
                return UITableViewAutomaticDimension
            }
            else
            {
                return UITableViewAutomaticDimension
            }
            
            
        }
            
        else
        {
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ques_type") as? String == "0"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! FoodHelpViewCell
            
            
            cell.userImage.layer.cornerRadius = cell.userImage.frame.size.width/2
            cell.userImage.clipsToBounds = true
            cell.selectionStyle = .none
            cell.view1.addShadowView()
            
            //  cell.reviewFollowers.text =
            
            //            cell.userImage.sd_setImage(with: <#T##URL?#>, placeholderImage: <#T##UIImage?#>, options: <#T##SDWebImageOptions#>, completed: <#T##SDExternalCompletionBlock?##SDExternalCompletionBlock?##(UIImage?, Error?, SDImageCacheType, URL?) -> Void#>)
            
            
            let imageUrl1 = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "picture") as! String
            
            
            cell.userImage.sd_setImage(with: URL(string: imageUrl1 ), placeholderImage: UIImage(named: "img1"))
            
            cell.question1.text = "\((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ask_question") as! String)"
            // cell.answerLabel.text =
            cell.username.text = "\((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "first_name") as! String)" + ("  ") + "\((quesAnsArray[indexPath.section] as! AnyObject).value(forKey: "last_name") as! String)"
            
            // cell.view1.layer.cornerRadius = 10.0
            //  cell.view1.clipsToBounds = true
            // cell.view1.addShadowView()
            
            
            //            
            //            let viewArr =  [cell.view1]
            //            
            //            let labelArr = [cell.question1,cell.quesAskedLabel,cell.answerLabel,cell.username]
            //            
            //            
            //            self.changeColorSelectedCell(view: viewArr as! [UIView],label: labelArr as! [UILabel],bgcolor:UIColor.white,LblTxtColor: UIColor.black)
            let endDate = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_on") as! String
            
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
            
            
            if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_by") as! String)
            {
                cell.editDeleteBtn.isHidden = false
                
            }
            
            
            
            cell.editDeleteBtn.tag = indexPath.section
            cell.editDeleteBtn.addTarget(self, action: #selector(editDelteAction), for: .touchUpInside)
            
            
            cell.quesAskedLabel.text  = " Asked \(String(describing: month1)),\(String(describing: date1)) \(String(describing: year1))"
            if  ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "total_answers") as! String) == "0"
            {
                if  (((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "answer") as! NSArray)[0] as AnyObject).value(forKey: "ans_id") as? String == "0"
                {
                    cell.answerLabel.text = "No answers yet"
                }
                
            }
            else
            {
                
                
                cell.answerLabel.text = (((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "answer") as! NSArray)[0] as AnyObject).value(forKey: "ask_answer") as? String
                
            }
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! pollTableViewcell
            cell.selectionStyle = .none
            cell.userImage1.layer.cornerRadius = cell.userImage1.frame.size.width/2
            cell.userImage1.clipsToBounds = true
            cell.pollView.addShadowView()
            
            cell.editDeleteBtn1.tag = indexPath.section
            cell.editDeleteBtn1.addTarget(self, action: #selector(editDelteAction), for: .touchUpInside)
            cell.question2.text = "\((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ask_question") as! String)"
            if Utils.getPreferenceValue(ForKey: Constant.USER_ID) == ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_by") as! String)
            {
                cell.editDeleteBtn1.isHidden = false
                
            }
            
            let imageUrl1 = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "picture") as! String
            
            
            cell.userImage1.sd_setImage(with: URL(string: imageUrl1 ), placeholderImage: UIImage(named: "img1"))
            cell.userName1.text = "\((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "first_name") as! String)" + ("  ") + "\((quesAnsArray[indexPath.section] as! AnyObject).value(forKey: "last_name") as! String)"
            // cell.pollView.addShadowView()
            //            cell.pollView.layer.cornerRadius = 10.0
            //            cell.pollView.clipsToBounds = true
            
            //cell.progress1.sizeThatFits(CGSize(width:0.0 , height:0.0 ))
            //  et progressBar = CustomProgressView(progressViewStyle: .bar)
            // cell.progress1 = customView(progressViewStyle: .bar)
            
            // cell.progress1 = customProgressView()
            
            //  cell.progress1.sizeThatFits(CGSize(width : 300,height : 10))
            // cell.progress1.frame = CGRect(x : 0,y:10,width:cell.progress1.frame.width,height:10)
            
            cell.optn1.tag = indexPath.section
            cell.optn1.addTarget(self, action: #selector(btn1), for: .touchUpInside)
            cell.optn2.tag = indexPath.section
            cell.optn2.addTarget(self, action: #selector(btn2), for: .touchUpInside)
            cell.optn3.tag = indexPath.section
            cell.optn3.addTarget(self, action: #selector(btn3), for: .touchUpInside)
            cell.optn4.tag = indexPath.section
            cell.optn4.addTarget(self, action: #selector(btn4), for: .touchUpInside)
            
            let endDate = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_on") as! String
            
            
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
            
            //            cell.progress1.isHidden = true
            //            cell.progress2.isHidden = true
            //            cell.progress3.isHidden = true
            //            cell.progress4.isHidden = true
            
            
            
            cell.quesAskedLabel1.text  = "Asked  \(String(describing: month1)),\(String(describing: date1)) \(String(describing: year1))"
            
            if  ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll_reg_id") as! String) != "0"
            {
                
                //                cell.progress1.isHidden = false
                //                cell.progress2.isHidden = false
                //
                //                cell.percentDisplay1.isHidden = false
                //                cell.percentDisplay2.isHidden = false
                //                cell.optnName1.isHidden = false
                //                cell.optnName2.isHidden = false
                //
                //
                //                cell.optn1.isHidden = true
                //                cell.optn2.isHidden = true
                //                cell.optn3.isHidden = true
                //                cell.optn4.isHidden = true
                //                cell.undoView.isHidden = false
                
                cell.optionView.isHidden = true
                cell.progressView.isHidden = false
                cell.segment1.isHidden = false
                cell.segment2.isHidden = false
                cell.segment3.isHidden = false
                cell.segment4.isHidden = false
                cell.undoBtn.tag = indexPath.section + 1000
                cell.undoBtn.addTarget(self, action: #selector(undoAct), for: .touchUpInside)
                if ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count == 2
                {
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll/total_poll_user)*100)
                    cell.progress1.progress = Float(poll_percentage)/100
                    cell.percentDisplay1.text = "\(Int(poll_percentage))" + "%"
                    
                    
                    cell.optnName1.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll/total_poll_user)*100)
                    cell.progress2.progress = Float(poll_percentage)/100
                    cell.percentDisplay2.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName2.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    cell.segment3.isHidden = true
                    cell.segment4.isHidden = true
                    
                    for i in 0..<((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count
                    {
                        if (((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "poll_id") as! String == ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll_id") as! String)
                        {
                            if i == 0
                            {
                                cell.tick1.isHidden = false
                                cell.tick2.isHidden = true
                                
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                            else
                            {
                                cell.tick2.isHidden = false
                                cell.tick1.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"                            }
                            
                            
                        }
                        
                    }
                    
                    
                }
                else if ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count == 3
                {
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll/total_poll_user)*100)
                    cell.progress1.progress = Float(poll_percentage)/100
                    cell.percentDisplay1.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName1.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll / total_poll_user) * 100)
                    cell.progress2.progress = Float(poll_percentage)/100
                    cell.percentDisplay2.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName2.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll / total_poll_user) * 100)
                    cell.progress3.progress = Float(poll_percentage)/100
                    cell.percentDisplay3.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName3.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    cell.segment4.isHidden = true
                    
                    for i in 0..<((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count
                    {
                        if (((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "poll_id") as! String == ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll_id") as! String)
                        {
                            if i == 0
                            {
                                cell.tick1.isHidden = false
                                cell.tick2.isHidden = true
                                cell.tick3.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                            else if i == 1
                            {
                                cell.tick2.isHidden = false
                                cell.tick1.isHidden = true
                                cell.tick3.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                                
                            else
                            {
                                cell.tick3.isHidden = false
                                cell.tick1.isHidden = true
                                cell.tick2.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                        }
                        
                    }
                    
                    
                    
                }
                else{
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll / total_poll_user) * 100)
                    cell.progress1.progress = Float(poll_percentage)/100
                    cell.percentDisplay1.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName1.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll / total_poll_user) * 100)
                    cell.progress2.progress = Float(poll_percentage)/100
                    cell.percentDisplay2.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName2.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll / total_poll_user) * 100)
                    cell.progress3.progress = Float(poll_percentage)/100
                    cell.percentDisplay3.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName3.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    total_poll = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "total_poll") as? String)!)!
                    total_poll_user = Double(((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "total_poll_user") as? String)!)!
                    poll_percentage = Float((total_poll / total_poll_user) * 100)
                    cell.progress4.progress = Float(poll_percentage)/100
                    cell.percentDisplay4.text = "\(Int(poll_percentage))" + "%"
                    cell.optnName4.text! = ((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "poll_list") as? String)!
                    
                    for i in 0..<((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count
                    {
                        if (((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "poll_id") as! String == ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll_id") as! String)
                        {
                            if i == 0
                            {
                                cell.tick1.isHidden = false
                                cell.tick3.isHidden = true
                                cell.tick2.isHidden = true
                                cell.tick4.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                            else if i == 1
                            {
                                cell.tick2.isHidden = false
                                cell.tick1.isHidden = true
                                cell.tick3.isHidden = true
                                cell.tick4.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                                
                            else if i == 2
                            {
                                cell.tick3.isHidden = false
                                cell.tick1.isHidden = true
                                cell.tick2.isHidden = true
                                cell.tick4.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
                            }
                            else
                            {
                                cell.tick4.isHidden = false
                                cell.tick1.isHidden = true
                                cell.tick2.isHidden = true
                                cell.tick3.isHidden = true
                                cell.votes.text = "\((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[i] as AnyObject).value(forKey: "total_poll_user") as! String) Votes"
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
                
                
                if ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count == 2
                {
                    cell.optn1.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.optn2.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.progressSegment3.isHidden = true
                    cell.progressSegment4.isHidden = true
                }
                else if ((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray).count == 3
                {
                    cell.optn1.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.optn2.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.optn3.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.progressSegment4.isHidden = true
                    
                    
                    
                    
                }
                else{
                    cell.optn1.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[0] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.optn2.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[1] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.optn3.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[2] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    cell.optn4.setTitle((((quesAnsArray[indexPath.section] as AnyObject).value(forKey: "poll") as! NSArray)[3] as AnyObject).value(forKey: "poll_list") as? String, for: .normal)
                    
                }
                
                
                
            }
            
            
            
            
            
            //  backgroundColor = UIColor.clear
            
            //            cell.pollView.layer.borderWidth = 1
            //             cell.pollView.layer.cornerRadius = 3
            //             cell.pollView.layer.borderColor = UIColor.clear.cgColor
            //             cell.pollView.layer.masksToBounds = true
            //            cell.pollView.layer.backgroundColor = UIColor.clear.cgColor
            //
            //           cell.pollView.layer.shadowOpacity = 0.18
            //            cell.pollView.layer.shadowOffset = CGSize(width: 0, height: 2)
            //            cell.pollView.layer.shadowRadius = 2
            //            cell.pollView.layer.shadowColor = UIColor.black.cgColor
            //            cell.pollView.layer.masksToBounds = false
            return cell
            
        }
        
        
    }
    
    
    @objc func undoAct(sender :UIButton!)
    {
        let cell  = tableView.cellForRow(at: IndexPath(row:0,section:sender.tag - 1000)) as! pollTableViewcell
        Utils.svprogressHudShow(title: "Loading...", view: self)
    
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
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
                   
                    Utils.svprogressHudDismiss(view: self)
//                    self.indicator.stopAnimating()
                    self.optnLoad = 1
                    //                                let votes = Int(cell.votes.text!)
                    //                                cell.votes.text = String(votes! - 1)
                    self.getQAAll()
                    
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
            
            Utils.svprogressHudShow(title: "Loading...", view: self)
           
//            self.indicator.hidesWhenStopped = true
//            self.indicator.startAnimating()
            let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DELETE_QUESTION)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json != nil
                {
                    if json["ResponseCode"] == 1
                        
                    {
                        
                        Utils.svprogressHudDismiss(view: self)
//                        self.indicator.stopAnimating()
                        self.getQAAll()
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
//        indicator.hidesWhenStopped = true
//        indicator.startAnimating()
        Utils.svprogressHudShow(title: "Loading...", view: self)
       
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_ANSWER)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if  json["status"] == 200 {
                
               
                Utils.svprogressHudDismiss(view: self)
//                self.indicator.stopAnimating()
//
                print(self.ansArray)
                
                //self.tableView.reloadData()
                // self.tableView.reloadData()
                //   cell.answerLabel.text = "\((self.ansArray[self.celltag] as AnyObject).value(forKey: "ask_answer") as! String)"
                //                let indexPath = IndexPath(item: 0, section: self.cellPath)
                //                self.tableView.reloadRows(at: [indexPath], with: .none)
                self.getQAAll()
                
                
                
                // self.tableView.reloadSections(NSIndexSet(index: self.cellPath) as IndexSet, with: .none)
                
                
            }
                
            else
                
            {
              
                Utils.svprogressHudDismiss(view: self)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Utils.setPreferenceValue(setValue: (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "created_by") as! String, ForKey:Constant.QA_CREATEDBY)
        let page:viewQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "viewQues") as! viewQuestionController
        page.question_id = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "quest_id") as! String
        page.followid = (quesAnsArray[indexPath.section] as AnyObject).value(forKey: "ques_follow") as! String
        self.present(page, animated: false, completion: nil)
       
        
        
        
        
    }
   
    
    @IBAction func createQuestion(_ sender: UIButton) {
        
        let page:AskQuestionController = self.storyboard?.instantiateViewController(withIdentifier: "askques") as! AskQuestionController
        self.present(page, animated: false, completion: nil)
        
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        if(bottomBar.selectedItem == homeButton){
            //            print("Segue Buzz")
            
            let page:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
            self.present(page, animated: true, completion: nil)
            
        }
        
        if(bottomBar.selectedItem == foodHelpButton){
            
            
            let page:MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuview") as! MenuViewController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == notificationsButton){
            
            
            let page:NotificationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "notifications") as! NotificationsViewController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == reviewButton){
            
            
            let page:ReviewViewController = self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewViewController
            self.present(page, animated: true, completion: nil)
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



extension UIProgressView {
    
    // var height:CGFloat = 1.0
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let size:CGSize = CGSize.init(width: self.frame.size.width, height: 1.0)
        
        return size
    }
    
    
    
    
}

