//
//  FoodStreetController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 20/06/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FoodStreetController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var headerView: UIView!
    // @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var foodTable: UITableView!
    
    var eventId : String = ""
    var discussArray : NSArray = []
    var act : String = ""
    
    var rowNumber :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addDropShadowToView(targetView: headerView)
        getDiscussionAll()
        foodTable.estimatedRowHeight = 55.0
        foodTable.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return discussArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_image") as! String)" != "0"
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! foodStreetCell
            cell.userName.text = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "first_name") as! String)" + "\((discussArray[indexPath.section] as AnyObject).value(forKey: "last_name") as! String)"
            
            //"\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_creator_firstname") as! String)" + "\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_creator_lastname") as! String)"
            cell.profImage.sd_setImage(with: URL(string: "\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_creator_picture") as! String)"), placeholderImage: UIImage(named: "img1"))
            cell.descText.text = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_description") as! String)"
            cell.descText.numberOfLines = 0
            cell.descText.lineBreakMode = NSLineBreakMode.byWordWrapping
            // cell.descText.sizeToFit()
            cell.PrevImahe.sd_setImage(with: URL(string: "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_image") as! String)"), placeholderImage: UIImage(named: "default"))
            
            let createdTime = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.commentsLabel.text = "View all \((discussArray[indexPath.section] as AnyObject).value(forKey: "total_comments")!) Comments"
            
            cell.timeAgoLabel.text! =  myDate.timeAgoDisplay()
            
            if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_likes") as! String)" == "0"
            {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            }
                
            else
            {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
                
            }
            
            
            
            if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_created") as! String)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                cell.optionMenu.isHidden = false
            }
                
            else
            {
                cell.optionMenu.isHidden = true
                
            }
            
            
            
            
            if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String)" == "0"
            {
                cell.likesLabel.isHidden = true
            }
            else if  "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String)" == "1"
            {
                cell.likesLabel.isHidden = false
                
                cell.likesLabel.text! = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String) like"
                
            }
            else
            {
                cell.likesLabel.isHidden = false
                cell.likesLabel.text! = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String) likes"
                
                
            }
            cell.commentbtn.tag = indexPath.section + 9000
            cell.likeAllBtn.tag = indexPath.section + 7000
            cell.viewAllBtn.tag = indexPath.section + 6000
            cell.likeBtn.tag = indexPath.section + 2000
            cell.likeBtn.addTarget(self, action: #selector(likeBTN), for: .touchUpInside)
            cell.optionMenu.tag = indexPath.section + 3000
            cell.optionMenu.addTarget(self, action: #selector(EDITDELETEACT), for: .touchUpInside)
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! foodStreetCell1
            cell.userName.text = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_creator_firstname") as! String)" + "\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_creator_lastname") as! String)"
            
            cell.commentsLabel.text = "View all \((discussArray[indexPath.section] as AnyObject).value(forKey: "total_comments")!) Comments"
            cell.likeallbtn.tag = indexPath.section + 7000
            cell.profImage.sd_setImage(with: URL(string: "\((discussArray[indexPath.section] as AnyObject).value(forKey: "picture") as! String)"), placeholderImage: UIImage(named: "img1"))
            cell.descText.text = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_description") as! String)"
            cell.descText.numberOfLines = 0
            cell.descText.lineBreakMode = NSLineBreakMode.byWordWrapping
            // cell.descText.sizeToFit()
            let createdTime = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            cell.timeAgoLabel.text! =  myDate.timeAgoDisplay()
            
            if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_likes") as! String)" == "0"
            {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            }
                
            else
            {
                cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
                
            }
            
            if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "event_created") as! String)" == Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            {
                cell.optionMenu.isHidden = false
            }
                
            else
            {
                cell.optionMenu.isHidden = true
                
            }
            
            
            cell.commentbtn.tag = indexPath.section + 9000
            cell.viewAllbtn.tag = indexPath.section + 6000
            if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String)" == "0"
            {
                cell.likesLabel.isHidden = true
            }
            else if  "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String)" == "1"
            {
                cell.likesLabel.isHidden = false
                
                cell.likesLabel.text! = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String) like"
                
            }
            else
            {
                cell.likesLabel.isHidden = false
                cell.likesLabel.text! = "\((discussArray[indexPath.section] as AnyObject).value(forKey: "total_likes") as! String) likes"
                
            }
            
            cell.likeBtn.tag = indexPath.section + 2000
            cell.likeBtn.addTarget(self, action: #selector(likeBUTTON), for: .touchUpInside)
            cell.optionMenu.tag = indexPath.section + 3000
            cell.optionMenu.addTarget(self, action: #selector(EDITDELETEACT), for: .touchUpInside)
            return cell
            
        }
    }
    
    
    
    @IBAction func viewAllLike(_ sender: UIButton) {
        
        
        
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        page.c = "5"
        page.eventID = (discussArray[sender.tag - 6000] as AnyObject).value(forKey: "dis_evt_id") as! String
        // page.hotelID = (self.discussArray[sender.tag - 6000] as AnyObject).value(forKey: "hotel_id") as! String
        //        page.d = "123"
        
        self.present(page, animated: false, completion: nil)
    }
    
    
    @IBAction func viewAllLikes(_ sender: UIButton) {
        
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        page.c = "5"
        page.eventID = (discussArray[sender.tag - 6000] as AnyObject).value(forKey: "dis_evt_id") as! String
        // page.hotelID = (self.discussArray[sender.tag - 6000] as AnyObject).value(forKey: "hotel_id") as! String
        //        page.d = "123"
        
        self.present(page, animated: false, completion: nil)
        
        
    }
    
    
    @IBAction func commentAct(_ sender: UIButton) {
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        page.c = "5"
        page.eventID = (discussArray[sender.tag - 9000] as AnyObject).value(forKey: "dis_evt_id") as! String
        self.present(page, animated: false, completion: nil)
        
    }
    
    @IBAction func commentAct2(_ sender: UIButton) {
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        page.c = "5"
        page.eventID = (discussArray[sender.tag - 9000] as AnyObject).value(forKey: "dis_evt_id") as! String
        self.present(page, animated: false, completion: nil)
    }
    
    
    @IBAction func viewAll1(_ sender: UIButton) {
        
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        page.c = "5"
        page.eventID = (discussArray[sender.tag - 6000] as AnyObject).value(forKey: "dis_evt_id") as! String
        // page.hotelID = (self.discussArray[sender.tag - 6000] as AnyObject).value(forKey: "hotel_id") as! String
        //        page.d = "123"
        
        self.present(page, animated: false, completion: nil)
    }
    
    
    @IBAction func viewAll2(_ sender: UIButton) {
        
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid = Utils.getPreferenceValue(ForKey: Constant.USER_ID)
        page.c = "5"
        page.eventID = (discussArray[sender.tag - 6000] as AnyObject).value(forKey: "dis_evt_id") as! String
        // page.hotelID = (self.discussArray[sender.tag - 6000] as AnyObject).value(forKey: "hotel_id") as! String
        //        page.d = "123"
        
        self.present(page, animated: false, completion: nil)
    }
    
    
    
    @IBAction func likesAllBtn(_ sender: UIButton) {
        
        
        
    }
    
    
    
    
    
    
    
    
    @objc func likeBTN(sender: UIButton!){
        
        let cell = foodTable.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 2000) as IndexPath) as! foodStreetCell
        
        
        self.rowNumber = sender.tag - 2000
        var like : Int = 0
        
        if cell.likeBtn.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.likesLabel.isHidden = false
            let cont = ((discussArray[sender.tag - 2000] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                cell.likesLabel.text! = "\(cont1) like"
            }
            else if cont1 == 0
            {
                cell.likesLabel.isHidden = true
                
            }
                
            else
            {
                cell.likesLabel.text! = "\(cont1) likes"
                
            }
            like = 1
        }
        else
        {
            
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((discussArray[sender.tag - 2000] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.likeBtn.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    cell.likesLabel.text! = "\(cont1) like"
                }
                    
                else if cont1 == 0
                {
                    cell.likesLabel.isHidden = true
                    
                }
                else
                {
                    cell.likesLabel.text! = "\(cont1) likes"
                }
            }
            
            like = 0
        }
        let params: [String:String] = ["dis_evt_id" : (discussArray[sender.tag - 2000] as AnyObject).value(forKey: "dis_evt_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DISCUSSION_LIKES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    self.act = "1"
                    self.getDiscussionAll()
                    
                    
                    
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
    
    
    @objc func likeBUTTON(sender: UIButton!){
        
        let cell = foodTable.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 2000) as IndexPath) as! foodStreetCell1
        
        
        self.rowNumber = sender.tag - 2000
        var like : Int = 0
        
        if cell.likeBtn.currentImage == UIImage(named :"like_symbol")
        {
            
            
            //            cell.likeButton.sd_setImage(with:  #imageLiteral(resourceName: "Heart") , for: UIImage(named: "ProfileImg3.png"))
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like-2"), for: .normal)
            
            cell.likesLabel.isHidden = false
            let cont = ((discussArray[sender.tag - 2000] as AnyObject).value(forKey :"total_likes") as! String)
            let cont1 = Int(cont)! + 1
            
            if cont1 == 1
            {
                cell.likesLabel.text! = "\(cont1) like"
            }
            else if cont1 == 0
            {
                cell.likesLabel.isHidden = true
                
            }
                
            else
            {
                cell.likesLabel.text! = "\(cont1) likes"
                
            }
            like = 1
        }
        else
        {
            
            cell.likeBtn.setImage(#imageLiteral(resourceName: "like_symbol"), for: .normal)
            let cont = ((discussArray[sender.tag - 2000] as AnyObject).value(forKey :"total_likes") as! String)
            if cont == "0"
            {
                
                cell.likeBtn.isHidden = true
            }
                
            else
            {
                let cont1 = Int(cont)! - 1
                if cont1 == 1
                {
                    cell.likesLabel.text! = "\(cont1) like"
                }
                    
                else if cont1 == 0
                {
                    cell.likesLabel.isHidden = true
                    
                }
                else
                {
                    cell.likesLabel.text! = "\(cont1) likes"
                }
            }
            
            like = 0
        }
        let params: [String:String] = ["dis_evt_id" : (discussArray[sender.tag - 2000] as AnyObject).value(forKey: "dis_evt_id") as! String,"likes" : "\(like)","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_DISCUSSION_LIKES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    self.act = "1"
                    self.getDiscussionAll()
                    
                    
                    
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
    @objc func EDITDELETEACT(sender: UIButton!){
        
        if  (self.discussArray[sender.tag - 3000] as AnyObject).value(forKey: "dis_image") as! String != "0"
        {
            let cell = foodTable.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 3000) as IndexPath) as! foodStreetCell
            let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                
                
                let page = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
                
                page.postArray = self.discussArray
                page.ab = 0
                page.pageCUR = sender.tag - 3000
                
                self.present(page, animated: false, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                let params: [String:String] = ["discss_id" : (self.discussArray[sender.tag - 3000] as AnyObject).value(forKey: "dis_evt_id") as! String,"eventid" : self.eventId,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted" : "1"]
                
                
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_POST)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    if result != nil{
                        if   json["ResponseCode"] ==  1
                        {
                            print("Event Deleted")
                            
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
            
        else
        {
            
            let cell = foodTable.cellForRow(at: NSIndexPath(row: 0, section:sender.tag - 3000) as IndexPath) as! foodStreetCell1
            let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
                
                let page = self.storyboard?.instantiateViewController(withIdentifier: "EventsDetais") as! EventsDetailedController
                page.postArray = self.discussArray
                page.ab = 0
                page.pageCUR = sender.tag - 3000
                self.present(page, animated: false, completion: nil)
                
                
                
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                let params: [String:String] = ["discss_id" : (self.discussArray[sender.tag - 3000] as AnyObject).value(forKey: "dis_evt_id") as! String,"eventid" : self.eventId,"created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"deleted" : "1"]
                
                
                let urlString = "\(Constant.BASEURL)\(Constant.CREATE_POST)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    if result != nil{
                        if   json["ResponseCode"] ==  1
                        {
                            print("Event Deleted")
                            
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
            
            self.present(alert, animated: true, completion: nil)}
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    
    
    
    
    @IBAction func backact(_ sender: UIButton) {
        
        
        self.dismiss(animated: false, completion: nil)
    }
    func getDiscussionAll()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"eventid" : eventId]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_DISCUSSION_ALL)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if let resData = json["Data"].arrayObject {
                
                self.discussArray = resData as NSArray
                
                if(self.discussArray.count != 0){
                    
                    print(self.discussArray)
                    self.foodTable.reloadData()
                    if self.act == "1"
                    {
                        let indexPath = IndexPath(item: 0, section: self.rowNumber)
                        self.foodTable.reloadRows(at: [indexPath], with: .none)
                    }
                    
                }
                    
                else
                    
                {
                    print("Nodata")
                    
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if "\((discussArray[indexPath.section] as AnyObject).value(forKey: "dis_image") as! String)" == "0"
        {
            return 180.0
        }
            
            
        else
        {
            return 385.0
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        
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

