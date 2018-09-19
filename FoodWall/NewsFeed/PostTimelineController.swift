 //
//  PostTimelineController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 03/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class PostTimelineController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postIMage: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    var imgArray1 :NSArray = []
    var picArray = [UIImage]()
    var imgStr : String = ""

    
    var a : Int = 0
   //var b : Int = 0
    
    @IBOutlet weak var enlargeView: UIView!
    var imagePost :UIImage = UIImage(named : "img1")!
    var imgString :String = ""
    var imgString1 :String = ""
    var timeline_id : String = ""
    
    @IBOutlet weak var collectView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectView.delegate = self
        collectView.dataSource = self

        postButton.setTitle("Post", for: .normal)
        enlargeView.isHidden = true
        
        let imageValue = Utils.getPreferenceValue(ForKey: Constant.POST_IMAGE)
//        let longstring = imgString
//        let data = (longstring).data(using: String.Encoding.utf8)
//        let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
//
//        print(base64)
//        imgString = base64
       // print(imgString)
        
        if a == 0
        
        {
        
        enlargeView.isHidden = true
        
      //  postIMage.image = imagePost
        //let reduced_sizeImg:UIImage = RBResizeImage(image: imagePost,targetSize: CGSize(width:500,height:500))
//        let seleImg_Data = UIImageJPEGRepresentation(postIMage.image!, 1)
//        let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
//        imgString = base64_str!
        }
        
        else if a == 1
        {
            let imageUrl = imgArray1[0]
           // let numbers = [1, 2, 3, 4, 5]
            //numbers.a
            
            enlargeView.isHidden = true
            
//            postIMage.sd_setImage(with: URL(string: imageUrl as! String ), placeholderImage: UIImage(named: "default"))
//            postButton.setTitle("Repost", for: .normal)
//            //let reduced_sizeImg:UIImage = RBResizeImage(image: postIMage.image! ,targetSize: CGSize(width:500,height:500))
//            let seleImg_Data = UIImageJPEGRepresentation(postIMage.image! , 1)
//            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
//            imgString = base64_str!
            
         //   b = 1
            
            
        }
        
        else
        {
            
            enlargeView.isHidden = false
            postButton.setTitle("Next", for: .normal)
            postButton.setTitleColor(UIColor.black, for: .normal)
            collectView.reloadData()
            
            
        }
       // print(imgString)
//        if let string = imageValue {
//            let decodedData = NSData(base64Encoded: imageValue, options: [])
//            if let data = decodedData {
//                var decodedimage = UIImage(data: data as Data)
//                postIMage.image = decodedimage
//            } else {
//                print("error with decodedData")
//            }
//        } else {
//            print("error with base64String")
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func g()
    {
        
        let parameters: Parameters = [
            
            "timeline_id" : timeline_id,
            
            "created_by" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)
            
        ]
        
        // You can change your image name here, i use NSURL image and convert into string
        
        
        // Start Alamofire
        Alamofire.upload(multipartFormData: { multipartFormData in
            //    for (key,value) in parameters {
            //    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
            //    }
            //
            
            var a : Int = 0
            
            for imageData in self.picArray {
                
                //            if  let imageData = UIImageJPEGRepresentation(PhotoArray[i], 0.6)
                //            {
                // a = 0
                //            multipartFormData.append(imageData, withName: "image", fileName: "image\(a).jpeg", mimeType: "image/jpeg")
                //
                
                let seleImg_Data = UIImageJPEGRepresentation(self.picArray[a] , 1)
                let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
                self.imgStr = base64_str!
                let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
                let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("G\(a).jpg")
                dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
                // self.imageArray.append(fileDestinationUrl2 )
                
                multipartFormData.append(fileDestinationUrl2, withName: "image")
                
                a = a + 1
                //            }
            }
            
            
            for (key,value) in parameters {
//                if let value = value as? String {
//                    if value == "image" {
//
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//
//                    } else {
                    
                        
//                    }
//                }
            }
            
            
            //        var data = Data()
            //
            //        for i in 0..<self.PhotoArray.count
            //        {
            //
            //
            ////            let seleImg_Data = UIImageJPEGRepresentation(self.PhotoArray[i] , 1)
            ////            let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
            ////            self.imgStr = base64_str!
            ////            let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
            //////            let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            //////            let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("B1.jpg")
            //////            dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
            //////            self.imageArray.append(fileDestinationUrl2 )
            //                     multipartFormData.append(self.PhotoArray[i] , withName: "image", fileName: "image\(i).jpg", mimeType: "image/jpeg")
            //
            //        }
            
            
            
            
            
        },
                         to: "\(Constant.BASEURL)\(Constant.CREATE_TIMELINE_IMAGE)",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        
                        
                        
                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
                        print("JSON : \(datastring)")
                        let json = JSON(data:response.data!)
                        // print(json["status"])
                        
                        // print(data:response.data!)
                        if("\(json["ResponseMessage"])" == "success")
                        {
                            // self.loadSpinner(option:"1",Message: "")
                            
                            let alert = UIAlertController(title: "Message!", message: "Created Successfully", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                                
                            })
                            self.present(alert, animated: true)
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

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell :postCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "parts", for: indexPath) as! postCollectionViewCell
        cell.prevIMage.image = picArray[indexPath.row]
        return cell
    }
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func backAct(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    @IBAction func postAction(_ sender: UIButton) {
        
        
        
        
        let timeLineID:Data = "0".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let postTitle:Data = self.postTitle.text!.data(using: String.Encoding.utf8, allowLossyConversion: false)!

         let CREATEDBY:Data = Utils.getPreferenceValue(ForKey: Constant.USER_ID).data(using: String.Encoding.utf8, allowLossyConversion: false)!



        let laTITUDE:Data = "12.971815".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        let longTITUDE:Data = "80.24889".data(using: String.Encoding.utf8, allowLossyConversion: false)!



        Alamofire.upload(
            multipartFormData: { multipartFormData in


                //                if(self.imageFilePath != nil)
                //                {
                //                    multipartFormData.append(self.imageFilePath, withName: "fileUpload_video")
                //                }

//        if(self.imgString != "")
//                {
//                    let dataDecoded2:NSData = NSData(base64Encoded: (self.imgString), options: NSData.Base64DecodingOptions(rawValue: 1))!
//                    let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                    let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("newImage2.jpg")
//                    dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
//
//                    multipartFormData.append(fileDestinationUrl2, withName: "image")
//                }

                multipartFormData.append(timeLineID, withName: "timeline_id")
                multipartFormData.append(postTitle, withName: "timeline_description")
                multipartFormData.append(laTITUDE, withName: "latitude")
                multipartFormData.append(longTITUDE, withName: "longitude")
                multipartFormData.append(CREATEDBY, withName: "created_by")



        },
            to: "\(Constant.BASEURL)\(Constant.CREATE_TIMELINE)",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)



                        let datastring = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!
                        print("JSON : \(datastring)")
                        let json = JSON(data:response.data!)
                        // print(json["status"])

                        // print(data:response.data!)
                        if("\(json["ResponseMessage"])" == "success")
                        {
                            // self.loadSpinner(option:"1",Message: "")

//            let alert = UIAlertController(title: "Message!", message: "Created Successfully", preferredStyle: .alert)
//           alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
//           let next = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
//                    self.present(next, animated: false, completion: nil)
//                            })
                            self.timeline_id = "\(json["Data"])"
                            
                            self.g()
//                            self.present(alert, animated: true)
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
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width : collectionView.bounds.size.width,height :197)
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



