//
//  CreateReviewController.swift
//  mapsLearn
//
//  Created by Ramesh Ponnuvel on 16/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TagListView
import IQKeyboardManagerSwift

var labelArray : NSMutableArray = []
var topDishesArray : [UIImage] = []
var labelArray1 : NSMutableArray = []
var dishesToAvoidArray : [UIImage] = []
var ambianceArray : [UIImage] = []
var deliveryArray : [UIImage] = []
var tagArray : [String] = []
var tagArray1 : [String] = []


class CreateReviewController: UIViewController,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TagListViewDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var underlineLabel1: UILabel!
    var dishes : [String] = ["Chapati/Roti","Naan","Butter Naan","Paratha","Aloo Paratha","Chapathi","Puri","Papadam","Aloo tikki","Butter chicken","Coconut Rice","Lemon Rice","Jeera Rice","Coconut Rice","Veg Biryani","Chicken Hariyali","Tandoori Chicken","Chicken MalaiKabab","SheekhKabab","Chili Chicken","Grilled Chicken","Keema Samosa","Chicken 65","Jumbo Bagari Spiced Shrimp","Vegetable Formaishi Kabab","Tandoori Mix Grill","Tandoori Lobster","Lamb BotiKabab","Tandoori Fish Tikka","Tandoori Jumbo Shrimp","Chicken Biryani","Mutton Biryani","Fish Biryani","Gobi Biryani","Beef Biryani","Mushroom Biryani","Shrimp Biryani","Goose Biryani","Chana masala ","Chicken Tikka masala","Dosa","Masala dosa","Momos","Mutton korma","Pakora","Paneer","Pulao","Chicken Roll","Mutton Roll","Samosa","Shahi paneer","Thali","Vadas","Halwa","Rasgulla/Roshogulla","Kulfi","Kheer"]
    var ambiance : String = ""
     var taste : String = ""
     var service : String = ""
     var ValueMoney : String = ""
     var FoodExperience : String = ""
    var CategoryType : String = "1"
    var vegNonVeg : String = "1"
    var originalDishesList:[String] = Array()
    @IBOutlet weak var serviceBtn: UIButton!
    @IBOutlet weak var ambianceBtn: UIButton!
    @IBOutlet weak var nonVegBTn: UIImageView!
    @IBOutlet weak var vegBtn: UIImageView!
    @IBOutlet weak var delivery: UIImageView!
    @IBOutlet weak var searchLocation: UITextField!
    var dataArray1 = [[String:AnyObject]]()
    var tag1 : Int = 0
    var pageTag : String = ""
    
    @IBOutlet weak var valueRatingLabel: UILabel!
    @IBOutlet weak var packageRatingLabel: UILabel!
    @IBOutlet weak var tasteRatingLabel: UILabel!
    @IBOutlet weak var ambianceRatinglabel: UILabel!
    @IBOutlet weak var overAllRatingLabel: UILabel!
    @IBOutlet weak var selectDishField: UITextField!
    @IBOutlet weak var preVImage1: UIImageView!
    @IBOutlet weak var hotelAddress: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var tagLisst1: TagListView!
    @IBOutlet weak var tagLisst: TagListView!
    var pageCur : Int = 0
    
    @IBOutlet weak var selectDishTable: UITableView!
    //  @IBOutlet weak var okayBtn: UIButton!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var badBtn: UIButton!
  //  @IBOutlet weak var terribleGrayBtn: UIButton!
    @IBOutlet weak var packageView: UIView!
    @IBOutlet weak var terribleButton: UIButton!
   
    @IBOutlet weak var hotelsView: UIView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var okayBtn: UIButton!
    
    @IBOutlet weak var terribleButton1: UIButton!
    
    
    @IBOutlet weak var badButton1: UIButton!
    @IBOutlet weak var badBtn1: UIButton!
    
    @IBOutlet weak var terribleGrayBtn1: UIButton!
    
    @IBOutlet weak var okayButton1: UIButton!
    @IBOutlet weak var okayBtn1: UIButton!
    
    @IBOutlet weak var greatbtn: UIButton!
    @IBOutlet weak var greatButton1: UIButton!
    @IBOutlet weak var goodBtn1: UIButton!
    @IBOutlet weak var goodButton1: UIButton!
    
    @IBOutlet weak var greatBtn1: UIButton!
    
    
    @IBOutlet weak var terribleButton2: UIButton!
    
    
    @IBOutlet weak var badButton2: UIButton!
    @IBOutlet weak var badBtn2: UIButton!
    
    @IBOutlet weak var terribleGrayBtn2: UIButton!
    
    @IBOutlet weak var okayButton2: UIButton!
    @IBOutlet weak var okayBtn2: UIButton!
    
    @IBOutlet weak var greatBtn2: UIButton!
    @IBOutlet weak var greatButton2: UIButton!
    @IBOutlet weak var goodBtn2: UIButton!
    @IBOutlet weak var goodButton2: UIButton!
    
    
    
    @IBOutlet weak var terribleButton4: UIButton!
    
    var selectedTextField : String = "0"
    @IBOutlet weak var badButton4: UIButton!
    @IBOutlet weak var badBtn4: UIButton!
    
    @IBOutlet weak var terribleGrayBtn4: UIButton!
    
    @IBOutlet weak var okayButton4: UIButton!
    @IBOutlet weak var okayBtn4: UIButton!
    
    @IBOutlet weak var greatBtn4: UIButton!
    @IBOutlet weak var greatButton4: UIButton!
    @IBOutlet weak var goodBtn4: UIButton!
    @IBOutlet weak var goodButton4: UIButton!
    
    
    
    @IBOutlet weak var terribleButton3: UIButton!
    
    
    @IBOutlet weak var badButton3: UIButton!
    @IBOutlet weak var badBtn3: UIButton!
    
    @IBOutlet weak var terribleGrayBtn3: UIButton!
    
    @IBOutlet weak var okayButton3: UIButton!
    @IBOutlet weak var okayBtn3: UIButton!
    
    @IBOutlet weak var dishetoAvoidField: UITextField!
    @IBOutlet weak var greatBtn3: UIButton!
    @IBOutlet weak var greatButton3: UIButton!
    @IBOutlet weak var goodBtn3: UIButton!
    @IBOutlet weak var goodButton3: UIButton!
    
   // @IBOutlet weak var greatBtn1: UIButton!
    
    
    @IBOutlet weak var terribleGrayBtn: UIButton!
    
    
    
    
    
    
    
    @IBOutlet weak var collectView3: UICollectionView!
    @IBOutlet weak var collectView2: UICollectionView!
    @IBOutlet weak var searchView: UIButton!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var ambianceView: UIView!
    @IBOutlet weak var overallView: UIView!
    @IBOutlet weak var dishesToAvoid: UIView!
    @IBOutlet weak var scrollNEw: UIScrollView!
   
    @IBOutlet weak var aMbDeliveryLabel: UILabel!
    var newImag = UIImage(named : "")
    var a : String = ""
     var b : String = ""
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var collectView4: UICollectionView!
    @IBOutlet weak var greatBtn: UIButton!
    @IBOutlet weak var greatButton: UIButton!
    @IBOutlet weak var goodBtn: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    var scrollHeight : CGFloat =  1500.0
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var underlineLabel: UILabel!
    
    var restaurantsArray : NSArray = []
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var collectTable: UICollectionView!
    
    var previewImage : UIImage?
    @IBOutlet weak var servicePackageLabel: UILabel!
    @IBOutlet weak var dineIn: UIImageView!
    
    
    var hotelNames : String = ""
    var hotelAddressess : String = ""
    
    
    @IBOutlet weak var collectionView1: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reviewText.text = "Type your review here"
        reviewText.textColor = UIColor.lightGray
       
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        hotelAddress.numberOfLines = 0
        hotelAddress.lineBreakMode = NSLineBreakMode.byWordWrapping
        selectDishTable.addDropShadowToView(targetView: selectDishTable)
        selectDishTable.delegate = self
        selectDishTable.dataSource = self
        createBtn.layer.cornerRadius = 15.0
        createBtn.clipsToBounds = true
        createBtn.applyGradient()
        selectDishField.delegate = self
        selectDishField.tag = 0
        dishetoAvoidField.delegate = self
        dishetoAvoidField.tag = 1
        tagLisst.delegate = self
        tagLisst1.delegate = self
        topDishesArray.removeAll()
        dishesToAvoidArray.removeAll()
        Utils.setPreferenceValue(setValue: "", ForKey: Constant.NEWVALUE)
        print(topDishesArray.count)
        scrollNEw.delegate = self
        scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
        dishesToAvoid.frame = CGRect(x:10,y:self.underlineLabel.frame.maxY + 20,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
        underlineLabel.frame = CGRect(x:15,y:self.selectDishField.frame.maxY + 10,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
        collectionView1.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 20,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
        collectView2.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 20,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
        tagLisst.frame = CGRect(x:5,y:self.underlineLabel1.frame.maxY + 30,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height)
         overallView.frame = CGRect(x:0,y:self.underlineLabel1.frame.maxY + 20,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
//        tag
        collectView2.isHidden = true
        collectView3.isHidden = true
        ambianceView.frame = CGRect(x:0,y:140.0,width:self.ambianceView.frame.size.width,height:self.ambianceView.frame.size.height)
        
        categoryView.frame = CGRect(x:0,y:45,width:self.categoryView.frame.size.width,height:self.categoryView.frame.size.height)
        packageView.frame = CGRect(x:0,y:260.0,width:self.packageView.frame.size.width,height:self.packageView.frame.size.height)
        
        for dish in dishes {
            originalDishesList.append(dish)
        }
        collectTable.delegate = self
        collectTable.dataSource = self
        searchLocation.delegate = self
        imagePicker.delegate = self
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectTable.tag = 0
        collectionView1.tag = 1
        collectView2.delegate = self
        collectView2.dataSource = self
        collectView2.tag = 2
        collectView4.delegate = self
        collectView4.dataSource = self
        collectView4.tag = 4
        collectView3.delegate = self
        collectView3.dataSource = self
        collectView3.tag = 3
        reviewText.delegate = self
        eventNoreValue = ""
        selectDishField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        dishetoAvoidField.addTarget(self, action: #selector(searchRecords(_ :)), for: .editingChanged)
        tagLisst.tag = 1
        tagLisst1.tag = 2
        
        if pageTag == "1"
        {
            detailView.isHidden = false
            //            searchPhotoFromGoogle(photo_Ref: ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String ,imageView : preVImage1)
            searchLocation.text = hotelNames
            hotelsView.isHidden = true
            categoryView.frame = CGRect(x:0,y:self.detailView.frame.maxY + 20,width:self.categoryView.frame.size.width,height:self.categoryView.frame.size.height)
            preVImage1.image = previewImage
            hotelAddress.text = hotelAddressess
            hotelName.text = hotelNames
        }
        
//        if newImag == UIImage(named:"")
//        {}
//        else
//
//        {
//            dishesToAvoid.frame = CGRect(x:10,y:370.0,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
//            scrollHeight = scrollHeight + 150.0
//            scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
//        topDishesArray.append(newImag!)
//        collectionView1.reloadData()
//        }
        // Do any additional setup after loading the view.
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        txtSearchBar.resignFirstResponder()
//        return true
//    }
    //MARK:- searchRecords
    @objc func searchRecords(_ textField: UITextField) {
        self.dishes.removeAll()
        if textField.text?.count != 0 {
            for dish in originalDishesList {
                if let countryToSearch = textField.text{
                    let range = dish.lowercased().range(of: countryToSearch, options: .caseInsensitive, range: nil, locale: nil)
                    if range != nil {
                        self.dishes.append(dish)
                    }
                }
            }
        } else {
            for dish in originalDishesList {
                dishes.append(dish)
            }
        }
        
        
        
        selectDishTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "1"
        {
            collectionView1.reloadData()
        }
        else if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "2"
        {
            collectView2.reloadData()
        }
        else if Utils.getPreferenceValue(ForKey: Constant.NEWVALUE) == "3"
        {
            collectView3.reloadData()
        }
        else
        {
            collectView4.reloadData()
        }
        
        
        if eventNoreValue == "hotel"
        {
            detailView.isHidden = false
            hotelsView.isHidden = true
            searchLocation.text = (self.restaurantsArray[pageCur] as AnyObject).value(forKey: "name") as! String
           categoryView.frame = CGRect(x:0,y:310.0,width:self.categoryView.frame.size.width,height:self.categoryView.frame.size.height)
        }
            
        else
        {
            
            if pageTag == "1"
            {
                detailView.isHidden = false
                hotelsView.isHidden = true
            }
            
            else
            {
            detailView.isHidden = true
            hotelsView.isHidden = false
            }
            
        }
    }
    
    
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//    }
//

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == selectDishField
        {
            tag1 = 1
            selectDishField.resignFirstResponder()
            selectDishTable.isHidden = false
            selectDishTable.frame = CGRect(x:20,y:self.selectDishField.frame.maxY + 50,width: self.selectDishTable.frame.size.width,height:self.selectDishTable.frame.size.height)
            if dishes.count == 0
            {
                
                self.tagLisst1.addTag(selectDishField.text!)
                tagArray.append(selectDishField.text!)
                self.selectDishTable.isHidden = true
                selectDishField.text = ""
                scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 20)
                
               
                
                
            }
            
            if a == "1"
            {
                tagLisst1.frame = CGRect(x:10,y:self.selectDishField.frame.maxY + 20,width:self.tagLisst1.frame.size.width,height:self.tagLisst1.frame.size.height + 20)
                dishesToAvoid.frame = CGRect(x:self.collectionView1.frame.minX,y:self.collectionView1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
                collectionView1.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 30,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
                underlineLabel.frame = CGRect(x:15,y:self.tagLisst1.frame.maxY + 10  ,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
                
                
            }
            else
            {
                if tagArray.count%3 != 0
                {
                    tagLisst1.frame = CGRect(x:10,y:self.selectDishField.frame.maxY + 20,width:self.tagLisst1.frame.size.width,height:self.tagLisst1.frame.size.height + 20)
                    dishesToAvoid.frame = CGRect(x:self.tagLisst1.frame.minX,y:self.tagLisst1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
                    collectionView1.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 20,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
                    underlineLabel.frame = CGRect(x:15,y:self.tagLisst1.frame.maxY + 10  ,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
                    if topDishesArray.count == 0
                    {
                        collectionView1.isHidden = true
                    }
                    else
                    {
                        collectionView1.isHidden = false
                    }
                }
            }
            selectDishField.becomeFirstResponder()
            selectedTextField = "1"
            
        }
        else if textField == dishetoAvoidField
        {
            tag1 = 2
            dishetoAvoidField.resignFirstResponder()
            selectDishTable.isHidden = false
            selectDishTable.frame = CGRect(x:20,y:self.selectDishField.frame.maxY + 50,width: self.selectDishTable.frame.size.width,height:self.selectDishTable.frame.size.height)
            if dishes.count == 0
            {
                
                self.tagLisst.addTag(dishetoAvoidField.text!)
                tagArray1.append(dishetoAvoidField.text!)
                self.selectDishTable.isHidden = true
                dishetoAvoidField.text = ""
                // selectDishField.text = ""
                scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 20)
                
                
                
                
            }
            
            if a == "2"
            {
                tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height + 20)
                overallView.frame = CGRect(x:self.collectView2.frame.minX,y:self.collectView2.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                collectView2.frame = CGRect(x:10,y:self.underlineLabel1.frame.maxY + 30,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
                underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10 ,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
                
                
            }
            else
            {
                if tagArray1.count%3 != 0
                {
                    tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height + 20)
                    overallView.frame = CGRect(x:self.tagLisst.frame.minX,y:self.tagLisst.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                    collectView2.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 30,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
                    underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10 ,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
                    if   dishesToAvoidArray.count == 0
                    {
                        collectView2.isHidden = true
                    }
                    else
                    {
                        collectView2.isHidden = false
                    }
                }
            }
            dishetoAvoidField.becomeFirstResponder()
            selectedTextField = "2"
            
            
            
            
//            tag1 = 2
//            dishetoAvoidField.resignFirstResponder()
//            selectDishTable.isHidden = false
//            selectDishTable.frame = CGRect(x:20,y:self.dishetoAvoidField.frame.maxY + 50,width: self.selectDishTable.frame.size.width,height:self.selectDishTable.frame.size.height)
//            scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 30)
//            if dishes.count == 0
//            {
//
//                self.tagLisst.addTag(dishetoAvoidField.text!)
//                tagArray1.append(dishetoAvoidField.text!)
//                self.selectDishTable.isHidden = true
//                dishetoAvoidField.text = ""
//
//
//                dishetoAvoidField.becomeFirstResponder()
//
//
//            }
//
//
//            if a == "2"
//            {
//                tagLisst.frame = CGRect(x:5,y:self.underlineLabel1.frame.maxY,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height + 20)
//                overallView.frame = CGRect(x:self.collectView2.frame.minX,y:self.collectView2.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
//                collectView2.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 30,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
//                underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10  ,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
//
//
//            }
//            else
//            {
//                if tagArray1.count%3 != 0
//                {
//                    tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height)
//                    overallView.frame = CGRect(x:self.tagLisst.frame.minX,y:self.tagLisst.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
//                    collectView2.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 30,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
//                    underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
//                    if dishesToAvoidArray.count == 0
//                    {
//                        collectView2.isHidden = true
//                    }
//                    else
//                    {
//                        collectView2.isHidden = false
//                    }
//                }
//            }
//            selectedTextField = "2"
        }
        
        
        if textField == searchLocation
        {
        searchPlaceFromGoogle(place: searchLocation.text!)
        }
       // }
//        }
       // placeName = textField.text!
        return true
    }
    
    @IBAction func searchAct(_ sender: UIButton) {
        
        collectTable.isHidden = false
        
        detailView.isHidden = true
        searchPlaceFromGoogle(place: searchLocation.text!)
        categoryView.frame = CGRect(x:0,y:self.collectTable.frame.maxY + 20,width:self.categoryView.frame.size.width,height:self.categoryView.frame.size.height)
        scrollHeight = scrollHeight + 150.0
        scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
        
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
            
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        
        
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dishes.count == 0
        {
            return 0
            
            
        }
        else
        {
        return dishes.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! selectDishCell
//        cell.label1.text = dishes[indexPath.row] as! String
//        return cell
        
//        var cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "cell1")
//        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! selectDishCell
        cell.label1?.text = dishes[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if selectedTextField == "1"
        {
            
            selectedTextField = ""

            self.tagLisst1.addTag(dishes[indexPath.row])
            tagArray.append(selectDishField.text!)
            selectDishField.text = ""
            scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 20)
            if tagArray.count%3 != 0
            {
                tagLisst1.frame = CGRect(x:10,y:self.selectDishField.frame.maxY + 20,width:self.tagLisst1.frame.size.width,height:self.tagLisst1.frame.size.height + 20)
                dishesToAvoid.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
                collectionView1.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 20,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
                underlineLabel.frame = CGRect(x:15,y:self.tagLisst1.frame.maxY + 10  ,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
                collectionView1.isHidden = true
                
            }
            
            print(tagLisst1)
            selectDishField.becomeFirstResponder()

           
        }
        else
        {
            //self.dishetoAvoidField.text = dishes[indexPath.row]
            selectedTextField = ""
            scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 20)
            
            self.tagLisst.addTag(dishes[indexPath.row])
            tagArray1.append(dishetoAvoidField.text!)
            selectDishField.text = ""
            if tagArray1.count%3 != 0
            {
                tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height + 20)
                if a == "2"
                {
                    overallView.frame = CGRect(x:10,y:self.collectView2.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                     collectView2.isHidden = false
                }
                else
                {
                    overallView.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                     collectView2.isHidden = true
                }
                collectView2.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 20,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
                underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10  ,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
               
                
            }
            dishetoAvoidField.text = ""
            print(tagLisst)
            dishetoAvoidField.becomeFirstResponder()
            
        }
        
       
       selectDishTable.isHidden = true
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
       // sender.removeTagView(tagView)
        if tag1 == 1
        {
          sender.removeTagView(tagView)
            scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 20)
            if tagLisst1.frame.size.height > 40
            {
                
            tagLisst1.frame = CGRect(x:10,y:self.selectDishField.frame.maxY + 20,width:self.tagLisst1.frame.size.width,height:self.tagLisst1.frame.size.height - 10)
            }
            
           if a == "1"
           {
            
            dishesToAvoid.frame = CGRect(x:10,y:self.collectionView1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
            collectionView1.frame = CGRect(x:15,y:self.tagLisst1.frame.maxY + 30,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
            underlineLabel.frame = CGRect(x:15,y:self.tagLisst1.frame.maxY + 10,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
            
           
            }
            else if tagLisst1.tag == 2
           {
            dishesToAvoid.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
            collectionView1.frame = CGRect(x:10,y:self.tagLisst1.frame.maxY + 20,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
           underlineLabel.frame = CGRect(x:15,y:self.tagLisst1.frame.maxY + 10,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
         
           
            print("tagArray : \(tagArray)")

           
            }
            
           
            
           tagArray.removeLast()
            if tagArray.count == 0
            {
                if a == "1"
                {
                dishesToAvoid.frame = CGRect(x:10,y:self.collectionView1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
                    
                underlineLabel.frame = CGRect(x:15,y:self.selectDishField.frame.maxY + 20,width:self.underlineLabel.frame.size.width,height:self.underlineLabel.frame.size.height)
                collectionView1.frame = CGRect(x:15,y:self.underlineLabel.frame.maxY + 20,width:self.collectionView1.frame.size.width,height:self.collectionView1.frame.size.height)
                tagLisst1.frame = CGRect(x:10,y:self.selectDishField.frame.maxY + 20,width:self.tagLisst1.frame.size.width,height:40.0)
                }
                
                // tagLisst1.frame.size.height
                
            }
            
           if topDishesArray.count == 0
           {
             collectionView1.isHidden = true
           }
            else
           {
            collectionView1.isHidden = false
           }
        }
        else if tag1 == 2
        {
            sender.removeTagView(tagView)
            scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight + 20)
            
            if tagLisst.frame.size.height > 40
            {
                
                tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:self.tagLisst.frame.size.height - 10)
            }
            
            if a == "2"
            {
                
                overallView.frame = CGRect(x:10,y:self.collectView2.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                collectView2.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 30,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
                underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
                
                
            }
            else
            {
                overallView.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                collectView2.frame = CGRect(x:10,y:self.tagLisst.frame.maxY + 20,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
                underlineLabel1.frame = CGRect(x:15,y:self.tagLisst.frame.maxY + 10,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
                
                
                print("tagArray : \(tagArray1)")
                
                
            }
            
            
            
            tagArray1.removeLast()
            if tagArray1.count == 0
            {
//                tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:0.0)
                
                if a == "2"
                {
                overallView.frame = CGRect(x:10,y:self.collectView2.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
                underlineLabel1.frame = CGRect(x:15,y:self.dishetoAvoidField.frame.maxY + 20,width:self.underlineLabel1.frame.size.width,height:self.underlineLabel1.frame.size.height)
                collectView2.frame = CGRect(x:15,y:self.underlineLabel1.frame.maxY + 20,width:self.collectView2.frame.size.width,height:self.collectView2.frame.size.height)
                tagLisst.frame = CGRect(x:10,y:self.dishetoAvoidField.frame.maxY + 20,width:self.tagLisst.frame.size.width,height:40.0)
                }
                // tagLisst1.frame.size.height
                
            }
            
            if dishesToAvoidArray.count == 0
            {
                collectView2.isHidden = true
            }
            else
            {
                collectView2.isHidden = false
            }
        }
        
        else
        {
            
        }
//        if TagListView == tagLisst
//        {
//            
//        }
        
        
//        tagOuterView.frame = CGRect(x:addCohostsLabel.frame.minX,y:addCohostsLabel.frame.maxY + 20,width : tagOuterView.frame.size.width,height : tagOuterView.frame.size.height - 15)
//        tagListView.frame = CGRect(x:tagOuterView.frame.minX + 5,y:5,width : tagOuterView.frame.size.width - 4,height : tagListView.frame.size.height - 15)
        
    }
    @IBAction func badAct(_ sender: UIButton) {
        
        badButton.isHidden = false
        badBtn.isHidden = true
        //if terribleButton
        terribleButton.isHidden = true
        greatButton.isHidden = true
        // badButton.isHidden = true
        goodButton.isHidden = true
        okayButton.isHidden = true
        greatbtn.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn.isHidden = false
        terribleGrayBtn.isHidden = false
        goodBtn.isHidden = false
        overAllRatingLabel.text = "Rating : 2/5"
        FoodExperience = "2"
        //badBtn.isHidden = false
    }
    @IBAction func terribleAct(_ sender: UIButton) {
        
        
        self.badButton.isHidden = true
        greatButton.isHidden = true
        // badButton.isHidden = true
        goodButton.isHidden = true
        okayButton.isHidden = true
        // self.terribleGrayBtn.isHidden = true
        self.terribleButton.isHidden = false
        terribleGrayBtn.isHidden = true
        greatbtn.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn.isHidden = false
        //  terribleGrayBtn.isHidden = false
        goodBtn.isHidden = false
        badBtn.isHidden = false
        overAllRatingLabel.text = "Rating : 1/5"
        FoodExperience = "1"
        
        
        
        //        }
        //
    }
    
    @IBAction func okAct(_ sender: UIButton) {
        
        badButton.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton.isHidden = true
        greatButton.isHidden = true
        // badButton.isHidden = true
        goodButton.isHidden = true
        okayButton.isHidden = false
        okayBtn.isHidden = true
        greatbtn.isHidden =  false
        // greatBtn.isHidden = true
        // okayBtn.isHidden = false
        terribleGrayBtn.isHidden = false
        goodBtn.isHidden = false
        badBtn.isHidden = false
        overAllRatingLabel.text = "Rating : 3/5"
        FoodExperience = "3"
        
    }
    
    
    @IBAction func goodAct(_ sender: UIButton) {
        badButton.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton.isHidden = true
        greatButton.isHidden = true
        // badButton.isHidden = true
        goodButton.isHidden = false
        okayButton.isHidden = true
        greatbtn.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn.isHidden = false
        terribleGrayBtn.isHidden = false
        goodBtn.isHidden = true
        badBtn.isHidden = false
         overAllRatingLabel.text = "Rating : 4/5"
        FoodExperience = "4"
        
    }
    
    @IBAction func greatact(_ sender: UIButton) {
        
        badButton.isHidden = true
        
        terribleButton.isHidden = true
        greatButton.isHidden = false
        // badButton.isHidden = true
        goodButton.isHidden = true
        okayButton.isHidden = true
        greatbtn.isHidden = true
        okayBtn.isHidden = false
        terribleGrayBtn.isHidden = false
        goodBtn.isHidden = false
        badBtn.isHidden = false
         overAllRatingLabel.text = "Rating : 5/5"
        FoodExperience = "5"
        
    }
    
    
    @IBAction func badAct1(_ sender: Any) {
        badButton1.isHidden = false
        badBtn1.isHidden = true
        //if terribleButton
        terribleButton1.isHidden = true
        greatButton1.isHidden = true
        // badButton.isHidden = true
        goodButton1.isHidden = true
        okayButton1.isHidden = true
        greatBtn1.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn1.isHidden = false
        terribleGrayBtn1.isHidden = false
        goodBtn1.isHidden = false
        //badBtn.isHidden = false
        ambianceRatinglabel.text = "Rating : 2/5"
        ambiance = "2"
        
        
        
    }
    @IBAction func okayAct1(_ sender: UIButton) {
        
        badButton1.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton1.isHidden = true
        greatButton1.isHidden = true
        // badButton.isHidden = true
        goodButton1.isHidden = true
        okayButton1.isHidden = false
        okayBtn1.isHidden = true
        greatBtn1.isHidden =  false
        // greatBtn.isHidden = true
        // okayBtn.isHidden = false
        terribleGrayBtn1.isHidden = false
        goodBtn1.isHidden = false
        badBtn1.isHidden = false
         ambianceRatinglabel.text = "Rating : 3/5"
          ambiance = "3"
    }
    
    @IBAction func terribleAct1(_ sender: UIButton) {
        
        
        self.badButton1.isHidden = true
        greatButton1.isHidden = true
        // badButton.isHidden = true
        goodButton1.isHidden = true
        okayButton1.isHidden = true
        // self.terribleGrayBtn.isHidden = true
        self.terribleButton1.isHidden = false
        terribleGrayBtn1.isHidden = true
        greatBtn1.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn1.isHidden = false
        //  terribleGrayBtn.isHidden = false
        goodBtn1.isHidden = false
        badBtn1.isHidden = false
         ambianceRatinglabel.text = "Rating : 1/5"
          ambiance = "1"
    }
    @IBAction func goodAct1(_ sender: UIButton) {
        badButton1.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton1.isHidden = true
        greatButton1.isHidden = true
        // badButton.isHidden = true
        goodButton1.isHidden = false
        okayButton1.isHidden = true
        greatBtn1.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn1.isHidden = false
        terribleGrayBtn1.isHidden = false
        goodBtn1.isHidden = true
        badBtn1.isHidden = false
        ambianceRatinglabel.text = "Rating : 4/5"
          ambiance = "4"
    }
    
    @IBAction func greatAct1(_ sender: UIButton) {
        badButton1.isHidden = true
        
        terribleButton1.isHidden = true
        greatButton1.isHidden = false
        // badButton.isHidden = true
        goodButton1.isHidden = true
        okayButton1.isHidden = true
        greatBtn1.isHidden = true
        okayBtn1.isHidden = false
        terribleGrayBtn1.isHidden = false
        goodBtn1.isHidden = false
        badBtn1.isHidden = false
        ambianceRatinglabel.text = "Rating : 5/5"
          ambiance = "5"
    }
    
    
    @IBAction func badAct2(_ sender: Any) {
        badButton2.isHidden = false
        badBtn2.isHidden = true
        //if terribleButton
        terribleButton2.isHidden = true
        greatButton2.isHidden = true
        // badButton.isHidden = true
        goodButton2.isHidden = true
        okayButton2.isHidden = true
        greatBtn2.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn2.isHidden = false
        terribleGrayBtn2.isHidden = false
        goodBtn2.isHidden = false
        //badBtn.isHidden = false
         tasteRatingLabel.text = "Rating : 2/5"
        taste = "2"
        
        
    }
    @IBAction func okayAct2(_ sender: UIButton) {
        
        badButton2.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton2.isHidden = true
        greatButton2.isHidden = true
        // badButton.isHidden = true
        goodButton2.isHidden = true
        okayButton2.isHidden = false
        okayBtn2.isHidden = true
        greatBtn2.isHidden =  false
        // greatBtn.isHidden = true
        // okayBtn.isHidden = false
        terribleGrayBtn2.isHidden = false
        goodBtn2.isHidden = false
        badBtn2.isHidden = false
        tasteRatingLabel.text = "Rating : 3/5"
        taste = "3"
    }
    
    @IBAction func terribleAct2(_ sender: UIButton) {
        
        
        self.badButton2.isHidden = true
        greatButton2.isHidden = true
        // badButton.isHidden = true
        goodButton2.isHidden = true
        okayButton2.isHidden = true
        // self.terribleGrayBtn.isHidden = true
        self.terribleButton2.isHidden = false
        terribleGrayBtn2.isHidden = true
        greatBtn2.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn2.isHidden = false
        //  terribleGrayBtn.isHidden = false
        goodBtn2.isHidden = false
        badBtn2.isHidden = false
        tasteRatingLabel.text = "Rating : 1/5"
        taste = "1"
    }
    @IBAction func goodAct2(_ sender: UIButton) {
        badButton2.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton2.isHidden = true
        greatButton2.isHidden = true
        // badButton.isHidden = true
        goodButton2.isHidden = false
        okayButton2.isHidden = true
        greatBtn2.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn2.isHidden = false
        terribleGrayBtn2.isHidden = false
        goodBtn2.isHidden = true
        badBtn2.isHidden = false
        tasteRatingLabel.text = "Rating : 4/5"
        taste = "4"
    }
    
    @IBAction func greatAct2(_ sender: UIButton) {
        badButton2.isHidden = true
        
        terribleButton2.isHidden = true
        greatButton2.isHidden = false
        // badButton.isHidden = true
        goodButton2.isHidden = true
        okayButton2.isHidden = true
        greatBtn2.isHidden = true
        okayBtn2.isHidden = false
        terribleGrayBtn2.isHidden = false
        goodBtn2.isHidden = false
        badBtn2.isHidden = false
        tasteRatingLabel.text = "Rating : 5/5"
        taste = "5"
    }
    
    
    @IBAction func badAct3(_ sender: Any) {
        badButton3.isHidden = false
        badBtn3.isHidden = true
        //if terribleButton
        terribleButton3.isHidden = true
        greatButton3.isHidden = true
        // badButton.isHidden = true
        goodButton3.isHidden = true
        okayButton3.isHidden = true
        greatBtn3.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn3.isHidden = false
        terribleGrayBtn3.isHidden = false
        goodBtn3.isHidden = false
        //badBtn.isHidden = false
        packageRatingLabel.text = "Rating : 2/5"
        service = "2"
        
        
        
    }
    @IBAction func okayAct3(_ sender: UIButton) {
        
        badButton3.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton3.isHidden = true
        greatButton3.isHidden = true
        // badButton.isHidden = true
        goodButton3.isHidden = true
        okayButton3.isHidden = false
        okayBtn3.isHidden = true
        greatBtn3.isHidden =  false
        // greatBtn.isHidden = true
        // okayBtn.isHidden = false
        terribleGrayBtn2.isHidden = false
        goodBtn3.isHidden = false
        badBtn3.isHidden = false
        packageRatingLabel.text = "Rating : 3/5"
          service = "3"
    }
    
    @IBAction func backAct(_ sender: UIButton) {
        
        self.dismiss(animated : false,completion: nil)
    }
    @IBAction func terribleAct3(_ sender: UIButton) {
        
        
        self.badButton3.isHidden = true
        greatButton3.isHidden = true
        // badButton.isHidden = true
        goodButton3.isHidden = true
        okayButton3.isHidden = true
        // self.terribleGrayBtn.isHidden = true
        self.terribleButton3.isHidden = false
        terribleGrayBtn3.isHidden = true
        greatBtn3.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn3.isHidden = false
        //  terribleGrayBtn.isHidden = false
        goodBtn3.isHidden = false
        badBtn3.isHidden = false
        packageRatingLabel.text = "Rating : 1/5"
          service = "1"
    }
    @IBAction func goodAct3(_ sender: UIButton) {
        badButton3.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton3.isHidden = true
        greatButton3.isHidden = true
        // badButton.isHidden = true
        goodButton3.isHidden = false
        okayButton3.isHidden = true
        greatBtn3.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn3.isHidden = false
        terribleGrayBtn3.isHidden = false
        goodBtn3.isHidden = true
        badBtn3.isHidden = false
        packageRatingLabel.text = "Rating : 4/5"
          service = "4"
    }
    
    @IBAction func greatAct3(_ sender: UIButton) {
        badButton3.isHidden = true
        
        terribleButton3.isHidden = true
        greatButton3.isHidden = false
        // badButton.isHidden = true
        goodButton3.isHidden = true
        okayButton3.isHidden = true
        greatBtn3.isHidden = true
        okayBtn3.isHidden = false
        terribleGrayBtn3.isHidden = false
        goodBtn3.isHidden = false
        badBtn3.isHidden = false
        packageRatingLabel.text = "Rating : 5/5"
          service = "5"
    }
    
    
    
    
    
    @IBAction func badAct4(_ sender: Any) {
        badButton4.isHidden = false
        badBtn4.isHidden = true
        //if terribleButton
        terribleButton4.isHidden = true
        greatButton4.isHidden = true
        // badButton.isHidden = true
        goodButton4.isHidden = true
        okayButton4.isHidden = true
        greatBtn4.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn4.isHidden = false
        terribleGrayBtn4.isHidden = false
        goodBtn4.isHidden = false
        //badBtn.isHidden = false
        valueRatingLabel.text = "Rating : 2/5"
        ValueMoney = "2"
        
        
        
    }
    @IBAction func okayAct4(_ sender: UIButton) {
        
        badButton4.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton4.isHidden = true
        greatButton4.isHidden = true
        // badButton.isHidden = true
        goodButton4.isHidden = true
        okayButton4.isHidden = false
        okayBtn4.isHidden = true
        greatBtn4.isHidden =  false
        // greatBtn.isHidden = true
        // okayBtn.isHidden = false
        terribleGrayBtn4.isHidden = false
        goodBtn4.isHidden = false
        badBtn4.isHidden = false
        valueRatingLabel.text = "Rating : 3/5"
        ValueMoney = "3"
    }
    
    @IBAction func terribleAct4(_ sender: UIButton) {
        
        
        self.badButton4.isHidden = true
        greatButton4.isHidden = true
        // badButton.isHidden = true
        goodButton4.isHidden = true
        okayButton4.isHidden = true
        // self.terribleGrayBtn.isHidden = true
        self.terribleButton4.isHidden = false
        terribleGrayBtn4.isHidden = true
        greatBtn4.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn4.isHidden = false
        //  terribleGrayBtn.isHidden = false
        goodBtn4.isHidden = false
        badBtn4.isHidden = false
        valueRatingLabel.text = "Rating : 1/5"
        ValueMoney = "1"
    }
    @IBAction func goodAct4(_ sender: UIButton) {
        badButton4.isHidden = true
        // badBtn.isHidden = true
        //if terribleButton
        terribleButton4.isHidden = true
        greatButton4.isHidden = true
        // badButton.isHidden = true
        goodButton4.isHidden = false
        okayButton4.isHidden = true
        greatBtn4.isHidden =  false
        // greatBtn.isHidden = true
        okayBtn4.isHidden = false
        terribleGrayBtn4.isHidden = false
        goodBtn4.isHidden = true
        badBtn4.isHidden = false
        valueRatingLabel.text = "Rating : 4/5"
        ValueMoney = "4"
    }
    
    @IBAction func greatAct4(_ sender: UIButton) {
        badButton4.isHidden = true
        
        terribleButton4.isHidden = true
        greatButton4.isHidden = false
        // badButton.isHidden = true
        goodButton4.isHidden = true
        okayButton4.isHidden = true
        greatBtn4.isHidden = true
        okayBtn4.isHidden = false
        terribleGrayBtn4.isHidden = false
        goodBtn4.isHidden = false
        badBtn4.isHidden = false
        valueRatingLabel.text = "Rating : 5/5"
        ValueMoney = "5"
    }
    

    
    //    @IBAction func okayAct5(_ sender: UIButton) {
//
//        badButton5.isHidden = true
//        // badBtn.isHidden = true
//        //if terribleButton
//        terribleButton5.isHidden = true
//        greatButton5.isHidden = true
//        // badButton.isHidden = true
//        goodButton5.isHidden = true
//        okayButton5.isHidden = false
//        okayBtn5.isHidden = true
//        greatBtn5.isHidden =  false
//        // greatBtn.isHidden = true
//        // okayBtn.isHidden = false
//        terribleGrayBtn5.isHidden = false
//        goodBtn5.isHidden = false
//        badBtn5.isHidden = false
//    }
//
//    @IBAction func terribleAct5(_ sender: UIButton) {
//
//
//        self.badButton5.isHidden = true
//        greatButton5.isHidden = true
//        // badButton.isHidden = true
//        goodButton5.isHidden = true
//        okayButton5.isHidden = true
//        // self.terribleGrayBtn.isHidden = true
//        self.terribleButton5.isHidden = false
//        terribleGrayBtn5.isHidden = true
//        greatBtn5.isHidden =  false
//        // greatBtn.isHidden = true
//        okayBtn5.isHidden = false
//        //  terribleGrayBtn.isHidden = false
//        goodBtn5.isHidden = false
//        badBtn5.isHidden = false
//    }
//    @IBAction func goodAct5(_ sender: UIButton) {
//        badButton5.isHidden = true
//        // badBtn.isHidden = true
//        //if terribleButton
//        terribleButton5.isHidden = true
//        greatButton5.isHidden = true
        // badButton.isHidden = true
//        goodButton5.isHidden = false
//        okayButton5.isHidden = true
//        greatBtn5.isHidden =  false
//        // greatBtn.isHidden = true
//        okayBtn5.isHidden = false
//        terribleGrayBtn5.isHidden = false
//        goodBtn5.isHidden = true
//        badBtn5.isHidden = false
//    }
//
//    @IBAction func greatAct5(_ sender: UIButton) {
//        badButton5.isHidden = true
//
//        terribleButton5.isHidden = true
//        greatButton5.isHidden = false
//        // badButton.isHidden = true
//        goodButton5.isHidden = true
//        okayButton5.isHidden = true
//        greatBtn5.isHidden = true
//        okayBtn5.isHidden = false
//        terribleGrayBtn5.isHidden = false
//        goodBtn5.isHidden = false
//        badBtn5.isHidden = false
//    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//
//
//
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0
        {
        return self.restaurantsArray.count
        }
        else if collectionView.tag == 1
        {
            return topDishesArray.count
        }
        else if collectionView.tag == 2
        {
            return dishesToAvoidArray.count
        }
        
        else if collectionView.tag == 3
        {
           return  ambianceArray.count
        }
        
        else
        {
            return deliveryArray.count
        }
    }
    
    func searchPlaceFromGoogle(place:String) {
        
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+\(place)&key=AIzaSyDTV3YxP-zWn4ss-UD4dTXB4dbzwiNxJqk"
        //AIzaSyBCmiAi-SgtYNvYzuwwCNjR2rFDtdoOKlo
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil {
                let jsonDict = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                // let json = JSON(data: response.data!)
                if var dict = jsonDict as? Dictionary<String,AnyObject>{
                    if  let innerDict = dict["results"]{
                        if  (dict["status"] as! String)  == "OK"
                        {
                            self.restaurantsArray = (innerDict as! NSArray)
                            print(self.restaurantsArray.count)
                           
                            
                        }
                        
                    }
                    else{
                        
                    }
                }
                else
                {
                    
                }
            } else {
                //we have error connection google api
            }
        }
        
        self.collectTable.reloadData()
        task.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //thisWidth = CGFloat(self.frame.width)
        if collectionView.tag == 0
        {
        return CGSize(width : 146.0,height :152.0)
        }
        else if collectionView.tag == 1
        {
            return CGSize(width : 140.0,height :140.0)
        }
        else if collectionView.tag == 2
        {
            return CGSize(width : 140.0,height :140.0)
        }
        else if collectionView.tag == 3
        {
             return CGSize(width : 135.0,height :105.0)
        }
        else
        {
            return CGSize(width : 135.0,height :105.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView.tag == 0
        {
        
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
            cell.view1.addShadowViewProfile()
            cell.view1.layer.cornerRadius = 5.0
            cell.view1.clipsToBounds = true
            cell.hotelAddress.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "formatted_address") as! String
            cell.hotelName.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
            
            
            searchPhotoFromGoogle(photo_Ref: ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String ,imageView : cell.hotelPic)
            return cell
        }
        
        else if collectionView.tag == 1
        {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
            cell.view1.addShadowViewProfile()
            cell.view1.layer.cornerRadius = 5.0
            cell.view1.clipsToBounds = true
            cell.hotelPic.image = topDishesArray[indexPath.row]
            cell.hotelName.text = labelArray[indexPath.row] as? String
            return cell
            
            
            
        }
        
        else if collectionView.tag == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
            cell.view1.addShadowViewProfile()
            cell.view1.layer.cornerRadius = 5.0
            cell.view1.clipsToBounds = true
            cell.hotelPic.image = dishesToAvoidArray[indexPath.row]
//            let imageView = UIImageView()
//            imageView.image = dishesToAvoidArray[indexPath.row]
            cell.hotelName.text = labelArray1[indexPath.row] as? String
            return cell
        }
        else if collectionView.tag == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
            cell.view1.addShadowViewProfile()
            cell.view1.layer.cornerRadius = 5.0
            cell.view1.clipsToBounds = true
            cell.hotelPic.image = ambianceArray[indexPath.row]
            //            let imageView = UIImageView()
            //            imageView.image = dishesToAvoidArray[indexPath.row]
            //cell.hotelName.text = labelArray1[indexPath.row] as? String
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            
            cell.view1.addShadowViewProfile()
            cell.view1.layer.cornerRadius = 5.0
            cell.view1.clipsToBounds = true
            cell.hotelPic.image = deliveryArray[indexPath.row]
            //            let imageView = UIImageView()
            //            imageView.image = dishesToAvoidArray[indexPath.row]
            //cell.hotelName.text = labelArray1[indexPath.row] as? String
            return cell
        }
       
            
        
    }
    
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        
        pageCur = indexPath.row
        let page:hotelDetailController = self.storyboard?.instantiateViewController(withIdentifier: "hotelDetail") as! hotelDetailController
        page.hotelname = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        page.hoteladdress = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "formatted_address") as! String
        page.imgString = ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String
      // page.pageVal = pageCur
        detailView.isHidden = false
        page.pageIden = "1"
//        place_ID = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "place_id") as! String
       searchPhotoFromGoogle(photo_Ref: ((((self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String ,imageView : preVImage1)
        
        hotelAddress.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "formatted_address") as! String
        hotelName.text = (self.restaurantsArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
        
        self.present(page, animated: false, completion: nil)
        
    }
    
    @IBAction func dineInAct(_ sender: UIButton) {
        
        
//        dineIn.setImage(#imageLiteral(resourceName: "radiobutton"), for: .normal)
//        delivery.setImage(#imageLiteral(resourceName: "radiobtn"), for: .normal)
        dineIn.image = #imageLiteral(resourceName: "radiobutton")
        delivery.image = #imageLiteral(resourceName: "radiobtn")
        servicePackageLabel.text = "Service"
        serviceBtn.isHidden = true
        aMbDeliveryLabel.text = "Ambiance"
        ambianceBtn.isHidden = false
        CategoryType = "1"
       
       
        
       
    }
    
    @IBAction func deliveryAct(_ sender: UIButton) {
        dineIn.image = #imageLiteral(resourceName: "radiobtn")
        delivery.image = #imageLiteral(resourceName: "radiobutton")
         ambianceBtn.isHidden = true
         aMbDeliveryLabel.text = "Delivery on time"
        serviceBtn.isHidden = false
         servicePackageLabel.text = "Package"
         CategoryType = "2"
        
    }
    func searchPhotoFromGoogle(photo_Ref:String,imageView : UIImageView) {
        // AIzaSyBntvQCBdlpx4Jcppk2yXsN_19M7R4km28
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=500&photoreference=\(photo_Ref)&key=AIzaSyDTV3YxP-zWn4ss-UD4dTXB4dbzwiNxJqk"
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = URL(string: strGoogleApi)!
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async { // Make sure you're on the main thread here
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    @IBAction func imagePIc2(_ sender: UIButton) {
//         overallView.frame = CGRect(x:0,y:260,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
         b = "1"
         a = "2"
        collectView2.isHidden = false
        scrollHeight = scrollHeight + 200
        scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
        
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
    
    @IBAction func searchBtn(_ sender: UIButton) {
        
      
        
        
        
    }
    @IBAction func imgPic3(_ sender: UIButton) {
        
        collectView3.isHidden = false
         a = "3"
        ambianceView.frame = CGRect(x:0,y:250.0,width:self.ambianceView.frame.size.width,height:self.ambianceView.frame.size.height)
        scrollHeight = scrollHeight + 200.0
        scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
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
    
    
    @IBAction func imagepic1(_ sender: UIButton) {
          a = "1"
          b = "2"
//        collectView2.isHidden = true
        
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
    
    
    @IBAction func vegAct(_ sender: UIButton) {
        
        vegBtn.image = #imageLiteral(resourceName: "radiobutton")
        nonVegBTn.image = #imageLiteral(resourceName: "radiobtn")
    }
    
    
    @IBAction func nonVegAct(_ sender: UIButton) {
        
        vegBtn.image = #imageLiteral(resourceName: "radiobtn")
        nonVegBTn.image = #imageLiteral(resourceName: "radiobutton")
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
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = "Type your review here"
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
            textView.text = "Type your review here"
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
    
    
    
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        print("Got a Image")
        if let imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
            let seleImg_Data = UIImageJPEGRepresentation(reduced_sizeImg , 1)
            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            print("the img str : \(base64_str?.characters.count)")
//            topDishesArray.append(reduced_sizeImg)
//            collectionView1.reloadData()
            collectionView1.isHidden = false
            if a == "1" && b == "2"
            {

           
               dishesToAvoid.frame = CGRect(x:10,y:collectionView1.frame.maxY + 30,width:self.dishesToAvoid.frame.size.width,height:self.dishesToAvoid.frame.size.height)
                
                scrollHeight = scrollHeight + 200.0
                scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
            }
            
            else if a == "2" && b == "1"
            {

                overallView.frame = CGRect(x:10,y:self.collectView2.frame.maxY + 30,width:self.overallView.frame.size.width,height:self.overallView.frame.size.height)
            }
            picker.dismiss(animated: true, completion: nil)
            let page:NotificationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "notifications") as! NotificationsViewController
            page.newImage = a
            page.getImage = imag
            self.present(page, animated: false, completion: nil)
           
        }
        else{
            
           
        }
        
        
        picker.dismiss(animated: true, completion: nil)
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
    @IBAction func package(_ sender: UIButton) {
        
      packageView.frame = CGRect(x:0,y:360.0,width:self.packageView.frame.size.width,height:self.packageView.frame.size.height)
        a = "4"
        scrollHeight = scrollHeight + 200.0
        scrollNEw.contentSize = CGSize(width : self.scrollNEw.frame.size.width,height : scrollHeight)
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
    
    
    
    @IBAction func createReview(_ sender: UIButton) {
      
        
 let params: [String:String] = ["google_id" : (self.restaurantsArray[pageCur] as AnyObject).value(forKey: "id") as! String,"hotel_name":searchLocation.text!,"hotel_review":reviewText.text!,"category_type":CategoryType,"veg_nonveg":vegNonVeg,"place_id":(self.restaurantsArray[pageCur] as AnyObject).value(forKey: "place_id") as! String,"open_times": "","address":(self.restaurantsArray[pageCur] as AnyObject).value(forKey: "formatted_address") as! String,"latitude":Utils.getPreferenceValue(ForKey: Constant.LATITUDE),"longitude":Utils.getPreferenceValue(ForKey: Constant.LONGITUDE),"phone":"","upload_photo": "0","image": ((((self.restaurantsArray[pageCur] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String,"google_photo": ((((self.restaurantsArray[pageCur] as AnyObject).value(forKey: "photos")) as! NSArray)[0] as! AnyObject).value(forKey: "photo_reference") as! String,"food_exprience": FoodExperience,"ambiance":ambiance,"taste":taste,"service":service,"value_money": ValueMoney,"created_by": Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_REVIEW)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count == 0){
                    
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                    print(self.dataArray1)
                   
                    self.showToast(message: "Created SuccessFully")
                    self.sendimages()
//                    let indexPath = IndexPath(item: self.rowNumber, section: 2)
//                    self.tableView.reloadRows(at: [indexPath], with: .none)
                    
                    
                }
            }
            
            
        }
        
    }
    
    func sendimages()
    {
        let params: [String:String] = ["hotel_id" :(dataArray1[0] as AnyObject).value(forKey: "hotelid") as! String ,"review_id" : (dataArray1[1] as AnyObject).value(forKey: "reviewid") as! String,"dishname":"","dishtype" :"0","created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"image" :""]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_HOTEL_DISH_IMAGE)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataArray1 = resData as! [[String:AnyObject]]
                
                if(self.dataArray1.count == 0){
                    
                    
                    print("Empty")
                    
                }
                    
                else
                    
                {
                    
                    print(self.dataArray1)
//                    let indexPath = IndexPath(item: self.rowNumber, section: 2)
//                    self.tableView.reloadRows(at: [indexPath], with: .none)
                    
                    
                }
            }
            
            
        }
        
    }
    
    
    
 
    
}
