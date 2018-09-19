//
//  storyTableViewCell.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 06/04/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import ALCameraViewController

//protocol PlayVideoCellProtocol {
//    func playVideoButtonDidSelect()
//}

class storyTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var window1: UIWindow?
    
   
    var a :Int = 0

    @IBOutlet var collectionView1: UICollectionView!
    @IBOutlet var storyProfImage: UIImageView!
    var data : NSArray = []
     var data1 : [String]?
    var data2 : [String]?
    var data3 : [String]?
    var thisWidth:CGFloat = 0
       let imagePicker = UIImagePickerController()
    var imgStr : String = ""
    
   // var delegate: PlayVideoCellProtocol!
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePicker.delegate = self
        
//        storyProfImage.layer.cornerRadius = storyProfImage.frame.height/2
//        storyProfImage.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
        return (data.count)
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCollectCell", for: indexPath) as! storyCollectionViewCell
       
        cell.B1.tag = indexPath.row
         cell.B1.addTarget(self, action: #selector(createStoryAct), for: .touchUpInside)
        
        
        if indexPath.section == 0
        {
            cell.B1.isHidden = false
            cell.storyLabel.isHidden = false
            cell.youLabel.text = "You"
            cell.storyImageView.sd_setImage(with: URL(string: Utils.getPreferenceValue(ForKey: Constant.PROFILE_URL)), placeholderImage: UIImage(named: "default"))
        }
        
        else
        {
            cell.B1.isHidden = true
            cell.storyLabel.isHidden = true
            cell.youLabel.text = (data[indexPath.row] as! AnyObject).value(forKey: "first_name") as! String
            cell.storyImageView.sd_setImage(with: URL(string: (data[indexPath.row] as! AnyObject).value(forKey: "stories_image") as! String), placeholderImage: UIImage(named: "default"))
        }
//        if indexPath.item != 0
//        {
//            cell.B1.isHidden = true
//            cell.storyLabel.isHidden = true
//            cell.youLabel.text = (data[indexPath.row] as! AnyObject).value(forKey: "first_name") as! String
//             cell.storyImageView.sd_setImage(with: URL(string: (data[indexPath.row] as! AnyObject).value(forKey: "stories_image") as! String), placeholderImage: UIImage(named: "default"))
//
//        }
//        else{
//            cell.B1.isHidden = false
//            cell.storyLabel.isHidden = false
//           cell.youLabel.text = "You"
//           cell.storyImageView.sd_setImage(with: URL(string: (data[indexPath.row] as! AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "default"))
//
//        }
        return cell
    }
    
    
    
    
    @objc func createStoryAct(sender:UIButton!)
    {

//
//        self.window1 = UIWindow(frame: UIScreen.main.bounds)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
//        self.window1?.rootViewController = mainViewController
//        // mainViewController.testArray1 = data
//        mainViewController.b = 2
//        //mainViewController.storyImage = imag
//        self.window1?.makeKeyAndVisible()
        self.window1 = UIWindow(frame: UIScreen.main.bounds)
        let cameraViewController = CameraViewController { [weak self] image, asset in
            // Do something with your image here.
            //self?.dismiss(animated: true, completion: nil)
            //self?.removeFromSuperview()
            
            self?.window1 = UIWindow(frame: UIScreen.main.bounds)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyboard.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
            self?.window1?.rootViewController = mainViewController
                    // mainViewController.testArray1 = data
                    mainViewController.b = 2
            mainViewController.storyImage = image!
            self?.window1?.makeKeyAndVisible()
        }
        
        //present(cameraViewController, animated: true, completion: nil)
        self.window1?.rootViewController = cameraViewController
         self.window1?.makeKeyAndVisible()
            
            
            
        }
    
   
        
        
        
//        func openCamera()
//        {
//            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
//            {
//                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//                imagePicker.allowsEditing = true
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//            else
//            {
//                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.presentViewController(imagePicker, animated: true, completion: nil)
//            }
//        }
//        
//        func openGallary()
//        {
//            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
//            imagePicker.allowsEditing = true
//            
//           self.window?.rootViewController?.presentationController(animated: true, completion: nil)
//        }
//        
//        
//        
//        
//        
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            dismiss(animated: true, completion: nil)
//        }
//        
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//            
//            print("Got a Image")
//            if let imag:UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//                let reduced_sizeImg:UIImage = RBResizeImage(image: imag,targetSize: CGSize(width:200,height:200))
//                let seleImg_Data = UIImageJPEGRepresentation(reduced_sizeImg , 1)
//                let base64_str = seleImg_Data?.base64EncodedString(options: .lineLength64Characters)
//                print("the img str : \(base64_str?.characters.count)")
//                
//                imgStr = base64_str!
//               // uploadImage.image = imag
//                
//
//            }
//            else{
//                
//                
//                //            self.videoFilePath = (info[UIImagePickerControllerMediaURL] as? NSURL)! as URL!
//                //            videoImage.image = UIImage(named: "att_video.png")
//            }
//            
//            
//             self.window?.rootViewController?.dismiss(animated: true, completion: nil)
//        }
//        
//        
//        
//        func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//            let size = image.size
//            
//            let widthRatio  = targetSize.width  / image.size.width
//            let heightRatio = targetSize.height / image.size.height
//            
//            // Figure out what our orientation is, and use that to form the rectangle
//            var newSize: CGSize
//            if(widthRatio > heightRatio) {
//                newSize = CGSize(width: size.width * heightRatio,height: size.height * heightRatio)
//            } else {
//                newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
//            }
//            
//            // This is the rect that we've calculated out and this is what is actually used below
//            let rect = CGRect(x:0,y:0, width:newSize.width, height: newSize.height)
//            
//            // Actually do the resizing to the rect using the ImageContext stuff
//            UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//            image.draw(in: rect)
//            let newImage = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            
//            return newImage!
//        }
//        
//        func getDirectoryPath() -> String {
//            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//            let documentsDirectory = paths[0]
//            return documentsDirectory
//        }
//        
//        
//    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "storyCollectCell", for: indexPath) as! storyCollectionViewCell
        
//        let page = self.storyboard?.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
//        page.newImage = data![indexPath.row]
//
//        self.present(page, animated: false, completion: nil)
        
//        let myWebView = self.storyboard!.instantiateViewController(withIdentifier: "timeline") as! timeline
//        //self.present(myWebView, animated: true, completion: nil)
//        //self.performSegue(withIdentifier: "Employees", sender: nil)
//        self.navigationController?.pushViewController(myWebView, animated: true)
        
//        a = indexPath.row
//        for a in 0..<((data?.count)! - a)
//        {
//        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(storyTableViewCell.actions), userInfo: nil, repeats: true)
//
//        }
        
        self.window1 = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
        self.window1?.rootViewController = mainViewController
        mainViewController.testArray1 = data 
        mainViewController.a = indexPath.row
        mainViewController.b = 1
        self.window1?.makeKeyAndVisible()
        
    }
    
    
    
//    @objc func actions()
//    {
//        if time < 10
//        {
//        time += 1
//            
//            
//        }
//        else
//        {
//            timer.invalidate()
//            
//        }
//        
//        
//    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //  self.pageCtrl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //thisWidth = CGFloat(self.frame.width)
        return CGSize(width: 100, height: 150)
    }
    
    
    func initCollection()
    {
        self.collectionView1.dataSource = self
        self.collectionView1.delegate = self
//        self.collectionView2.register(UINib(nibName:"timelineCollectionCell", bundle: nil), forCellWithReuseIdentifier: "parts")
    }
    
    
    func setData(data: NSArray)
    {
        self.data = data
        
        self.initCollection()
        self.collectionView1.reloadData()
    }
//    func setData1(data1: [String])
//    {
//        self.data1 = data1
//
//        self.initCollection()
//        self.collectionView1.reloadData()
//    }
//    func setData2(data2: [String])
//    {
//        self.data2 = data2
//
//        self.initCollection()
//        self.collectionView1.reloadData()
//    }
//    func setData3(data3: [String])
//    {
//        self.data3 = data3
//
//        self.initCollection()
//        self.collectionView1.reloadData()
//    }
    
    
    
    
    
    
    

}
