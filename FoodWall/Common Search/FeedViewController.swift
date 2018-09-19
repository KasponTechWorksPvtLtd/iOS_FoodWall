//
//  FeedViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 04/09/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var window: UIWindow?
    
    var imgStr : String = ""
    
    //var SelectedAssets = [PHAsset]()
    var PhotoArray = [UIImage]()
    var pic : UIImage = UIImage(named : "img1")!
    var imageArray = [URL]()

    var imagePost1 :UIImage = UIImage(named : "img1")!
    var dataArray : NSArray = []
    // let image1 :UIImage = []
    let imageUrl = "\(Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL))"
    var ImageArray = [String]()
    var dateArray = [String]()
    var profImageArray = [String]()
    var ImageFilter: NSMutableArray = []
    var ImageFilter1: NSMutableArray = []
    var testArray = [String]()
    var nameArray = [String]()
    @IBOutlet var scrollBgView: UIScrollView!
    var created_by : String = ""
    var commentsText : String = ""
    var like : Int = 0
    var myIndexPath : Int = 0
    let imagView = UIImageView()
    //    @IBOutlet var collectionView: UICollectionView!
   
    @IBOutlet weak var tableview: UITableView!
    var a :Int = 1
    var k :Int = 0
    var action1 : String = ""
    var myIndex : Int = 0
    var dataArray1 = [[String:AnyObject]]()
    var commentsNew : String = ""
//    var action1 : String = ""
    var rowNumber : Int = 0
    var rowIndex : Int = 0
    
    var storiesArray : NSArray = []
    
    let imagePicker = UIImagePickerController()
    //var imgStr : String = ""
    var imageFilePath:URL! = nil
    var searchingdetailarray = [[String:AnyObject]]()
     //var dataArray = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
   timelineFunctionCommonSearch()
        // Do any additional setup after loading the view.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myIndexPath)
        
                return dataArray.count
           
       
        
        
        }
        
        
        
    
    

        

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
    }
    
    
func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
    
    
}


    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
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
                           // self.ImageArray = ((self.dataArray.value(forKey: "image") as? NSArray as! [String]))
                            
                            self.tableview.reloadData()
                            
                            
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
    
    
    @objc func commentBUTTON(sender: UIButton!){
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag - 1000, section:0) as IndexPath) as! homeTableViewCell
        
        cell.postCommentButton.isHidden = false
        cell.commentTextView.becomeFirstResponder()
        
        
    }
    
    
    @objc func ViewAction(sender: UIButton!){
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag, section:0) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        
        let page:CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "comments") as! CommentsViewController
        page.userid =  "\((dataArray[sender.tag] as AnyObject).value(forKey: "created_by") as! String)"
        page.c = "1"
        
        self.present(page, animated: false, completion: nil)
        
      
        
    }
    @objc func postCommentBUTTON(sender: UIButton!){
        
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag - 3000, section: 0) as IndexPath) as! homeTableViewCell
        rowIndex = sender.tag - 3000
        commentsText = cell.commentTextView.text!
        cell.postCommentButton.isHidden = true
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "timeline_id") as! String)", ForKey: Constant.TIMELINE_ID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 3000] as AnyObject).value(forKey: "created_by") as! String)", ForKey: Constant.COMMENTS_USER_ID)
        postAct()
        
    }
    @objc func profilePageDisplay(sender: UIButton!){
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag - 4000, section: 0) as IndexPath) as! homeTableViewCell
        
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "user_id") as! String)", ForKey: Constant.SELECTED_USER_ID)
        created_by =  "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "created_by") as! String)"
        Utils.setPreferenceValue(setValue: created_by, ForKey: Constant.CREATED_BY_USERID)
        Utils.setPreferenceValue(setValue: "\((dataArray[sender.tag - 4000] as AnyObject).value(forKey: "following_id") as! String)", ForKey: Constant.FOLLOWERID)
        
        let page:ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "profileview") as! ProfileViewController
        self.present(page, animated: true, completion: nil)
        
        
        
    }
    
    @objc func ViewLikes(sender: UIButton!){
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag - 11000, section:0) as IndexPath) as! homeTableViewCell
        
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
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag , section:0) as IndexPath) as! homeTableViewCell
        
        
        
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
        
        let cell = tableview.cellForRow(at: NSIndexPath(row: sender.tag - 2000, section:0) as IndexPath) as! homeTableViewCell
        
        
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
