//
//  SampleCheck.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 24/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class SampleCheck: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var dataIMgArray: NSArray = []

    @IBOutlet weak var photosCollection: UICollectionView!
    @IBOutlet weak var blueView: UIView!
    
    
    
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollection.delegate = self
        photosCollection.dataSource = self
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3.1, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 4
        photosCollection!.collectionViewLayout = layout
        getPic()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
       // self.heightConstraint.constant = collectionView.contentSize.height
        self.view.layoutIfNeeded()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let itemSize = self.photosCollection.frame.size.width - (numberOfItemsPerRow - 1.0)
//
//        return CGSize(width: 110, height: 110)
//
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(0, 0, 0, 0)
//    }

    
    
    func getPic()
    
    {
        
        let params :[String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)]
            
           
        let urlString = "\(Constant.BASEURL)\(Constant.GET_IMAGES)"
     Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.dataIMgArray = resData as! [[String:AnyObject]] as NSArray
                
                if(self.dataIMgArray.count != 0){
                    
                    
                    print(self.dataIMgArray)
                    self.photosCollection.reloadData()
                    
                }
                    
                else
                    
                {
                    print("Empty")
              
                    
                    
                }
            }
            else
                
            {
                
                print("error")
            }
            
            
        }
        
        
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }
    
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    let screenwidth : CGFloat = UIScreen.main.bounds.width
//        let cellWidth = screenwidth/2
//    return CGSize(width : cellWidth,height : cellWidth)
//
////        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 7), height: CGFloat(127))
//
//
//    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 2
//    }

//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataIMgArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell :photosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! photosCollectionViewCell
        
        cell.imges.sd_setImage(with: URL(string:(self.dataIMgArray[indexPath.row] as AnyObject).value(forKey: "timelineimage") as! String), placeholderImage: UIImage(named: "img1"))
        
//        cell.imges.contentMode = UIViewContentMode.scaleAspectFill
//        cell.imges.layer.masksToBounds = false
//        cell.imges.clipsToBounds = true
        
        
//        let url = URL(string: (self.dataIMgArray[indexPath.row] as AnyObject).value(forKey: "timelineimage") as! String)
//        if let data = try? Data(contentsOf: url!)
//        {
//            let image1: UIImage = UIImage(data: data)!
//           // cell.imges.image = image1
////            let reduced_sizeImg:UIImage = RBResizeImage(image: image1,targetSize: CGSize(width: 300,height: 300))
//            let seleImg_Data = UIImageJPEGRepresentation(image1 , 1)
//            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
//            // imgStr = base64_str!
//            let dataDecoded : Data = Data(base64Encoded: base64_str!, options: .ignoreUnknownCharacters)!
//            let decodedimage = UIImage(data: dataDecoded)
//            cell.imges.image = decodedimage
//            cell.imges.backgroundColor = UIColor.red
//            cell.addSubview(cell.imges)
//        }
        
        
        return cell
    }
    
  
    
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
//
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dict = dataIMgArray[indexPath.row] as! NSDictionary
        
        let page:TimelineDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
        
        page.timeLine_id = dict.value(forKey: "timelineid") as! String
        page.user_id = dict.value(forKey: "userid") as! String
        self.present(page, animated: false, completion: nil)
        
        
        
        
    }
//    func apiCall()
//
//    {
//
//       // let params: NSDictionary = ["questid" : "1", "ask_question" :"1" ,"created_by" :"1","latitude":"1","longitude":"1","ques_type":"1",]
//
//        let params :[String:Any]? = [
//
//                "questid" : "0", "ask_question" : "just do it" ,"created_by" : "2","latitude":"0.0","longitude":"0.0","ques_type": "0",
//                                "poll": [
//                                            ["pollname": "True"],
//                                            ["pollname": "False"]
//                                ]
//
//                    ]
//
//
//
//
//        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_QUESTION)"
//         Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response:DataResponse<Any>) in
//            let result = response.result
//            let json = JSON(data: response.data!)
//            if result != nil{
//                if   json["ResponseCode"] ==  1
//                {
//
//                    let alert = UIAlertController(title: "", message: "Status changed to going", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//
//                    print("success")
//                    // self.dataArray1 = innerDict as! NSArray
//
//                    // self.tableView.reloadData()
//
//
//
//                }
//
//                else
//
//                {
//
//                    print("error")
//                }
//            }
//            else
//
//            {
//
//                print("error")
//            }
//
//
//        }
//
//
//
//    }
    
    
    
//    func myValues()
//
//    {
//
//        let myarray = ["pollname":"1","pollname1":"2","pollname2":"3","pollname3":"4"]
//
//        //        let params:[String : Any] = ["questid":"0", "ask_question":"question for poll","latitude":"0.0","longitude":"0.0","created_by":"7","ques_type":"1","poll":myarray]
//
//        let params:[String : Any] = ["questid":"0", "ask_question":"question for poll","latitude":"0.0","longitude":"0.0","created_by":"7","ques_type":"0"]
//
//        print(params)
//
//        let urlString = "http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_question"
//
//        Alamofire.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default)
//
//            .responseJSON { response in
//
//                if let json = response.result.value {
//
//                    print("JSON: \(json)")
//
//                } else {
//
//                    print("Did not receive json")
//
//                }
//
//        }
//
//    }

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
