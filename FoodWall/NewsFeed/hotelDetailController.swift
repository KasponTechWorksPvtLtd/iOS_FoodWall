//
//  hotelDetailController.swift
//  FoodWall
//
//  Created by apple on 7/23/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import MXParallaxHeader
import Alamofire
import SwiftyJSON

var eventNoreValue : String = "0"
class hotelDetailController: UIViewController,UIScrollViewDelegate,KYButtonDelegate,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var newTable: UITableView!
    @IBOutlet weak var eventsNore: KYButton!
    @IBOutlet weak var hotelAddress: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var reviewScroll: UIScrollView!
    var reviewID : String = ""
   // var hotelName1 : String = ""
    var serviceRate : String = ""
    var tasteRate : String = ""
    var valueMoney : String = ""
    var ambienceRate : String = ""
    var hotelname : String = ""
    var hoteladdress : String = ""
    var imgString : String = ""
    var photoRef : String = ""
    var mainRate : String = ""
    var pageVal : Int = 0
    var statRate: Int = 3
    let preImage = UIImageView()
    let bigImage = UIImageView()
    var picArray : NSArray = []
    var dishesArray : NSArray = []
    var category_type : String = ""
    var picImageArray = [String]()
    var dishImageArray = [String]()
    var dishBadImageArray = [String]()
    var pageIden : String = "0"
    @IBOutlet weak var hotelNewScroll: UIScrollView!
    
    let topicView = UILabel()
    var backButton = UIButton()
    
    @IBOutlet weak var hotelReviewScroll: UIView!
    
     weak var headerImageView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTable.delegate = self
        newTable.dataSource = self
        hotelNewScroll.delegate = self

        reviewScroll.delegate = self
        setParallaxHeader()
       
        if pageIden == "1"
        {
            hotelNewScroll.isHidden = true
            reviewScroll.isHidden = false
        }
        else if pageIden == "2"
        {
            hotelNewScroll.isHidden = false
            reviewScroll.isHidden = true
            getAmbianceArray()
            getDishesImages()
            getBadDishesImages()
        }
        else if pageIden == "3"
        {
            hotelNewScroll.isHidden = true
            reviewScroll.isHidden = false
        }
        hotelName.text = hotelname
        hotelAddress.text = hoteladdress
       // hotelAddress.font = 15
       hotelAddress.numberOfLines = 0
       hotelAddress.lineBreakMode = NSLineBreakMode.byWordWrapping
       reviewScroll.contentSize = CGSize(width:375.0,height:670.0)
       hotelNewScroll.contentSize = CGSize(width:375.0,height:hotelNewScroll.frame.size.height + 400)
        searchPhotoFromGoogle(photo_Ref: imgString,imageView : preImage)
        searchPhotoFromGoogle(photo_Ref: photoRef,imageView : bigImage)
        backButton = UIButton(frame: CGRect(x: 15, y: 20, width: 30, height: 30))
        backButton.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        topicView.isHidden = false
        topicView.frame = CGRect(x : 0 ,y : 0 ,width : UIScreen.main.bounds.width ,height : 70.0)
        //topicView.layer.backgroundColor = UIColor.red.cgColor
        topicView.layer.backgroundColor = UIColor(red: 255/255, green: 222/255, blue: 141/255, alpha: 1.0).cgColor
        topicView.textAlignment = .center
        
        topicView.text = hotelname
        topicView.textColor = UIColor.black
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(EventsDetail.pressButton))
        topicView.isUserInteractionEnabled = true
        topicView.addGestureRecognizer(tap1)
        headerImageView?.addSubview(topicView)
        self.view.addSubview(topicView)
       // headerImageView?.addSubview(backButton)
        self.view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backAct), for: .touchUpInside)
        eventsNore.kyDelegate = self
        eventsNore.frame = CGRect(x : self.view.frame.size.width - 80,y : self.hotelAddress.frame.maxY + 70 , width : self.eventsNore.frame.size.width,height : self.eventsNore.frame.size.height
        )
        
        eventsNore.openType = .popUp
        eventsNore.plusColor = UIColor.white
        //eventsNore.plusColor =
        
        eventsNore.fabTitleColor = UIColor.black
        eventsNore.add(color:UIColor.white, title: "Write Review", image: UIImage(named: "pencil-edit-button-2")!){_ in
            
            eventNoreValue = "hotel"
            if self.pageIden == "3"
            {
                let page:CreateReviewController = self.storyboard?.instantiateViewController(withIdentifier: "createreview") as! CreateReviewController
            page.pageTag = "1"
            page.previewImage = self.preImage.image
                page.hotelNames = self.hotelName.text!
                page.hotelAddressess = self.hotelAddress.text!
            self.present(page, animated: true, completion: nil)
            }
            else
            {
            self.dismiss(animated: false, completion: nil)
            }
            
        }
       
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    
    func getDishesImages()
    {
        let params: [String:String] = ["reviewid" : reviewID,"dish_type":"1","userid": Utils.getPreferenceValue(ForKey: Constant.USER_ID)] //
        let urlString = "\(Constant.BASEURL)\(Constant.GET_DISHES_IMAGES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.dishesArray = ((innerDict as! NSArray))
                        
                        if self.dishesArray != nil{
                            
                           print(self.dishesArray)
                            
                            for i in 0..<self.dishesArray.count
                            {
                                
                                for j in 0..<((self.dishesArray[i] as! AnyObject).value(forKey: "image") as! NSArray).count
                                {
                                   print((((self.dishesArray[i] as! AnyObject).value(forKey: "image") as! NSArray)[j] as! NSDictionary).value(forKey: "img") as! String)
                            self.dishImageArray.append((((self.dishesArray[i] as! AnyObject).value(forKey: "image") as! NSArray)[j] as! NSDictionary).value(forKey: "img") as! String)
                                  
                                }

                                
                                print(self.dishImageArray)
                                print("1")
                            }
                           self.newTable.reloadData()
                        }
                        
                    }
                        
                    else
                    {
                        
                       // self.showToast(message: "")
                    }
                    
                    
                }
            }
            
            
        }
        
        
    }
    func getBadDishesImages()
    {
        let params: [String:String] = ["reviewid" : reviewID,"dish_type":"2","userid": Utils.getPreferenceValue(ForKey: Constant.USER_ID)] //
        let urlString = "\(Constant.BASEURL)\(Constant.GET_DISHES_IMAGES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.dishesArray = ((innerDict as! NSArray))
                        
                        if self.dishesArray != nil{
                            
                            print(self.dishesArray)
                            print("3")
                            for i in 0..<self.dishesArray.count
                            {
                                
                                for j in 0..<((self.dishesArray[i] as? AnyObject)?.value(forKey: "image") as! NSArray).count
                                {
                                    print((((self.dishesArray[i] as? AnyObject)?.value(forKey: "image") as! NSArray)[j] as! NSDictionary).value(forKey: "img") as! String)
                                    self.dishBadImageArray.append((((self.dishesArray[i] as! AnyObject).value(forKey: "image") as! NSArray)[j] as! NSDictionary).value(forKey: "img") as! String)
                                    
                                }
                                
                                
                                print(self.dishBadImageArray)
                                print("2")
                            }
                            self.newTable.reloadData()
                        }
                        
                    }
                        
                    else
                    {
                        
                        // self.showToast(message: "")
                    }
                    
                    
                }
            }
            
            
        }
        
        
    }
    func getAmbianceArray()
    {
        let params: [String:String] = ["reviewid" : reviewID] //
        let urlString = "\(Constant.BASEURL)\(Constant.GET_AMBIANCE_IMAGES)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if var dict = result.value as? Dictionary<String,AnyObject>{
                if  let innerDict = dict["Data"]{
                    if  (dict["ResponseMessage"] as! String)  != "nodata"
                    {
                        self.picArray = ((innerDict as! NSArray))
                        
                        if self.picArray != nil{
                            
                            for i in 0..<self.picArray.count
                            {
                                self.picImageArray.append((self.picArray[i] as AnyObject).value(forKey: "dishimage") as! String)
                                print(self.picImageArray)
                            }
                            
                            print(self.picArray)
                            self.newTable.reloadData()
                            
                        }
                    }
                        
                    else
                    {
                        
                        // self.showToast(message: "")
                    }
                    
                    
                }
            }
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! reviewDetailsCell1
            //        if let ourRating = object?["OurRating"] as? Double {
            
            cell.hotelNAME.text = hotelname
            if picArray.count == 0
            {
                cell.ambianceView.isHidden = false
                cell.newCollectTable.isHidden = true
            }
            else
            {
                cell.ambianceView.isHidden = true
                cell.newCollectTable.isHidden = false
                
                
            }
            if dishBadImageArray.count == 0
            {
                cell.dishesToAvoidView.isHidden = false
                cell.newCollectTable1.isHidden = true
            }
            else
            {
                cell.dishesToAvoidView.isHidden = true
                cell.newCollectTable1.isHidden = false
                
            }
            if dishImageArray.count == 0
            {
                cell.topDishesView.isHidden = false
                cell.newCollectTable2.isHidden = true
            }
            else
            {
                cell.topDishesView.isHidden = true
                cell.newCollectTable2.isHidden = false
            }
//            cell.setData(data: picArray)
            if mainRate == "0"
            {
                
            }
            else if mainRate == "1"{
                
                cell.star1.image = UIImage(named: "star-2")!
                cell.star2.image = UIImage(named: "star3")!
                cell.star3.image = UIImage(named: "star3")!
                cell.star4.image = UIImage(named: "star3")!
                cell.star5.image = UIImage(named: "star3")!
                
            }
            else if mainRate == "2"{
                
                cell.star1.image = UIImage(named: "star-2")!
                cell.star2.image = UIImage(named: "star-2")!
                cell.star3.image = UIImage(named: "star3")!
                cell.star4.image = UIImage(named: "star3")!
                cell.star5.image = UIImage(named: "star3")!
                
            }
            else if mainRate == "3"{
                
                cell.star1.image = UIImage(named: "star-2")!
                cell.star2.image = UIImage(named: "star-2")!
                cell.star3.image = UIImage(named: "star-2")!
                cell.star4.image = UIImage(named: "star3")!
                cell.star5.image = UIImage(named: "star3")!
                
            }
            else if mainRate == "4"{
                
                cell.star1.image = UIImage(named: "star-2")!
                cell.star2.image = UIImage(named: "star-2")!
                cell.star3.image = UIImage(named: "star-2")!
                cell.star4.image = UIImage(named: "star-2")!
                cell.star5.image = UIImage(named: "star3")!
                
            }
            else
            {
                cell.star1.image = UIImage(named: "star-2")!
                cell.star2.image = UIImage(named: "star-2")!
                cell.star3.image = UIImage(named: "star-2")!
                cell.star4.image = UIImage(named: "star-2")!
                cell.star5.image = UIImage(named: "star-2")!
                
                
            }
            if ambienceRate == "0"
            {
                
            }
            else if ambienceRate == "1"{
                
                cell.ambianceStar1.image = UIImage(named: "star-2")!
                cell.ambianceStar2.image = UIImage(named: "star3")!
                cell.ambianceStar3.image = UIImage(named: "star3")!
                cell.ambianceStar4.image = UIImage(named: "star3")!
                cell.ambianceStar5.image = UIImage(named: "star3")!
                
            }
            else if ambienceRate == "2"{
                
                cell.ambianceStar1.image = UIImage(named: "star-2")!
                cell.ambianceStar2.image = UIImage(named: "star-2")!
                cell.ambianceStar3.image = UIImage(named: "star3")!
                cell.ambianceStar4.image = UIImage(named: "star3")!
                cell.ambianceStar5.image = UIImage(named: "star3")!
                
            }
            else if ambienceRate == "3"{
                
                cell.ambianceStar1.image = UIImage(named: "star-2")!
                cell.ambianceStar2.image = UIImage(named: "star-2")!
                cell.ambianceStar3.image = UIImage(named: "star-2")!
                cell.ambianceStar4.image = UIImage(named: "star3")!
                cell.ambianceStar5.image = UIImage(named: "star3")!
                
            }
            else if ambienceRate == "4"{
                
                cell.ambianceStar1.image = UIImage(named: "star-2")!
                cell.ambianceStar2.image = UIImage(named: "star-2")!
                cell.ambianceStar3.image = UIImage(named: "star-2")!
                cell.ambianceStar4.image = UIImage(named: "star-2")!
                cell.ambianceStar5.image = UIImage(named: "star3")!
                
            }
            else
            {
                cell.ambianceStar1.image = UIImage(named: "star-2")!
                cell.ambianceStar2.image = UIImage(named: "star-2")!
                cell.ambianceStar3.image = UIImage(named: "star-2")!
                cell.ambianceStar4.image = UIImage(named: "star-2")!
                cell.ambianceStar5.image = UIImage(named: "star-2")!
                
                
            }
            if serviceRate == "0"
            {
                
            }
            else if serviceRate == "1"{
                
                cell.serviceStar1.image = UIImage(named: "star-2")!
                cell.serviceStar2.image = UIImage(named: "star3")!
                cell.serviceStar3.image = UIImage(named: "star3")!
                cell.serviceStar4.image = UIImage(named: "star3")!
                cell.serviceStar5.image = UIImage(named: "star3")!
                
            }
            else if serviceRate == "2"{
                
                cell.serviceStar1.image = UIImage(named: "star-2")!
                cell.serviceStar2.image = UIImage(named: "star-2")!
                cell.serviceStar3.image = UIImage(named: "star3")!
                cell.serviceStar4.image = UIImage(named: "star3")!
                cell.serviceStar5.image = UIImage(named: "star3")!
                
            }
            else if serviceRate == "3"{
                
                cell.serviceStar1.image = UIImage(named: "star-2")!
                cell.serviceStar2.image = UIImage(named: "star-2")!
                cell.serviceStar3.image = UIImage(named: "star-2")!
                cell.serviceStar4.image = UIImage(named: "star3")!
                cell.serviceStar5.image = UIImage(named: "star3")!
                
            }
            else if serviceRate == "4"{
                
                cell.serviceStar1.image = UIImage(named: "star-2")!
                cell.serviceStar2.image = UIImage(named: "star-2")!
                cell.serviceStar3.image = UIImage(named: "star-2")!
                cell.serviceStar4.image = UIImage(named: "star-2")!
                cell.serviceStar5.image = UIImage(named: "star3")!
                
            }
            else
            {
                cell.serviceStar1.image = UIImage(named: "star-2")!
                cell.serviceStar2.image = UIImage(named: "star-2")!
                cell.serviceStar3.image = UIImage(named: "star-2")!
                cell.serviceStar4.image = UIImage(named: "star-2")!
                cell.serviceStar5.image = UIImage(named: "star-2")!
                
                
            }
            if tasteRate == "0"
            {
                
            }
            else if tasteRate == "1"{
                
                cell.tasteStar1.image = UIImage(named: "star-2")!
                cell.tasteStar2.image = UIImage(named: "star3")!
                cell.tasteStar3.image = UIImage(named: "star3")!
                cell.tasteStar4.image = UIImage(named: "star3")!
                cell.tasteStar5.image = UIImage(named: "star3")!
                
            }
            else if tasteRate == "2"{
                
                cell.tasteStar1.image = UIImage(named: "star-2")!
                cell.tasteStar2.image = UIImage(named: "star-2")!
                cell.tasteStar3.image = UIImage(named: "star3")!
                cell.tasteStar4.image = UIImage(named: "star3")!
                cell.tasteStar5.image = UIImage(named: "star3")!
                
            }
            else if tasteRate == "3"{
                
                cell.tasteStar1.image = UIImage(named: "star-2")!
                cell.tasteStar2.image = UIImage(named: "star-2")!
                cell.tasteStar3.image = UIImage(named: "star-2")!
                cell.tasteStar4.image = UIImage(named: "star3")!
                cell.tasteStar5.image = UIImage(named: "star3")!
                
            }
            else if tasteRate == "4"{
                
                cell.tasteStar1.image = UIImage(named: "star-2")!
                cell.tasteStar2.image = UIImage(named: "star-2")!
                cell.tasteStar3.image = UIImage(named: "star-2")!
                cell.tasteStar4.image = UIImage(named: "star-2")!
                cell.tasteStar5.image = UIImage(named: "star3")!
                
            }
            else
            {
                cell.tasteStar1.image = UIImage(named: "star-2")!
                cell.tasteStar2.image = UIImage(named: "star-2")!
                cell.tasteStar3.image = UIImage(named: "star-2")!
                cell.tasteStar4.image = UIImage(named: "star-2")!
                cell.tasteStar5.image = UIImage(named: "star-2")!
                
                
            }
            
            
            if valueMoney == "0"
            {
                
            }
            else if valueMoney == "1"{
                
                cell.valueStar1.image = UIImage(named: "star-2")!
                cell.valueStar2.image = UIImage(named: "star3")!
                cell.valueStar3.image = UIImage(named: "star3")!
                cell.valueStar4.image = UIImage(named: "star3")!
                cell.valueStar5.image = UIImage(named: "star3")!
                
            }
            else if valueMoney == "2"{
                
                cell.valueStar1.image = UIImage(named: "star-2")!
                cell.valueStar2.image = UIImage(named: "star-2")!
                cell.valueStar3.image = UIImage(named: "star3")!
                cell.valueStar4.image = UIImage(named: "star3")!
                cell.valueStar5.image = UIImage(named: "star3")!
                
            }
            else if valueMoney == "3"{
                
                cell.valueStar1.image = UIImage(named: "star-2")!
                cell.valueStar2.image = UIImage(named: "star-2")!
                cell.valueStar3.image = UIImage(named: "star-2")!
                cell.valueStar4.image = UIImage(named: "star3")!
                cell.valueStar5.image = UIImage(named: "star3")!
                
            }
            else if valueMoney == "4"{
                
                cell.valueStar1.image = UIImage(named: "star-2")!
                cell.valueStar2.image = UIImage(named: "star-2")!
                cell.valueStar3.image = UIImage(named: "star-2")!
                cell.valueStar4.image = UIImage(named: "star-2")!
                cell.valueStar5.image = UIImage(named: "star3")!
                
            }
            else
            {
                cell.valueStar1.image = UIImage(named: "star-2")!
                cell.valueStar2.image = UIImage(named: "star-2")!
                cell.valueStar3.image = UIImage(named: "star-2")!
                cell.valueStar4.image = UIImage(named: "star-2")!
                cell.valueStar5.image = UIImage(named: "star-2")!
                
                
            }
            
            
            cell.setData(data: picImageArray)
            cell.setData1(data1: dishImageArray)
            cell.setData2(data2: dishBadImageArray)
         
            return cell
        }
            
        else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! writeTableViewCell
           
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 950.0
        }
        else
        {
            return 0
        }
    }
    
       
    
    
    @objc func backAct(_ sender : UIButton)
    {
        self.dismiss(animated: false, completion: nil)
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
    
    func setParallaxHeader()
    {
        preImage.frame = CGRect(x : 0 ,y : 15 ,width : UIScreen.main.bounds.width ,height : 300)
        preImage.image = UIImage(named: "img1")
        preImage.contentMode = .scaleAspectFill
        
        //  topicView.isHidden = true
        
        
        headerImageView = preImage
        
        reviewScroll.parallaxHeader.view = preImage
        reviewScroll.parallaxHeader.height = 300.0
        // tableView.parallaxHeader.height = 400
        reviewScroll.parallaxHeader.minimumHeight = 0.0
        
        bigImage.frame = CGRect(x : 0 ,y : 15 ,width : UIScreen.main.bounds.width ,height : 300.0)
        bigImage.image = UIImage(named: "img1")
        bigImage.contentMode = .scaleAspectFill
        
        //  topicView.isHidden = true
        
        
        headerImageView = bigImage
        
        hotelNewScroll.parallaxHeader.view = bigImage
        hotelNewScroll.parallaxHeader.height = 300.0
        // tableView.parallaxHeader.height = 400
        hotelNewScroll.parallaxHeader.minimumHeight = 0.0
        
        
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

extension reviewDetailsCell1:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0
        {
        return (data?.count)!
        }
        else if collectionView.tag == 1
        {
          return (data1?.count)!
        }
        else
        {
           return (data2?.count)!
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0
        {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! imageCollectionCell
             cell.imgeView.sd_setImage(with: URL(string: data![indexPath.row]), placeholderImage: UIImage(named: "default"))
            
       
        return cell
        }
        else if collectionView.tag == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            cell.hotelPic.sd_setImage(with: URL(string: data1![indexPath.row]), placeholderImage: UIImage(named: "default"))
            cell.view1.addDropShadowToView(targetView: cell.view1)
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Parts", for: indexPath) as! writePostCell
            cell.hotelPic.sd_setImage(with: URL(string: data2![indexPath.row]), placeholderImage: UIImage(named: "default"))
             cell.view1.addDropShadowToView(targetView: cell.view1)
            
            return cell
            
        }
    }
    
    //    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    //       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! timelineCollectionCell
    //        return cell.bgImage
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       // self.pageCtrl.currentPage = indexPath.row
        // self.pageCtrl.transform.cu = CGAffineTransform(scaleX: 2, y: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0
        {
          return CGSize(width: self.newCollectTable.frame.size.width, height: 180.0)
            
        }
        else if collectionView.tag == 1
        {
            return CGSize(width: 140.0, height: 140.0)
        }
        else
        {
             return CGSize(width: 140.0, height: 140.0)
        }
//        thisWidth = CGFloat(self.frame.width)
//        return CGSize(width: thisWidth, height: self.frame.height)
    }
    
    
    func initCollection()
    {
        self.newCollectTable.dataSource = self
        self.newCollectTable.delegate = self
        self.newCollectTable1.dataSource = self
        self.newCollectTable1.delegate = self
        self.newCollectTable2.dataSource = self
        self.newCollectTable2.delegate = self
        // self.collectionView2.register(UINib(nibName:"timelineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "parts")
    }
    
    
    func setData(data: [String])
    {
        self.data = data
        self.initCollection()
        self.newCollectTable.reloadData()
        
    }
    func setData1(data1: [String])
    {
        self.data1 = data1
        self.initCollection()
        self.newCollectTable1.reloadData()
        
    }
    func setData2(data2: [String])
    {
        self.data2 = data2
        self.initCollection()
        self.newCollectTable2.reloadData()
        
    }
    
   
}
