//
//  PublicEventController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 30/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import IQKeyboardManagerSwift
import TagListView


class PublicEventController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TagListViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate{

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var textView1: UIView!
    @IBOutlet var publicScroll: UIScrollView!
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var postStroy: UITextField!
    @IBOutlet var addCoHosts: UITextField!
    @IBOutlet var ticketUrl: UITextField!
    @IBOutlet var event_desc: UITextField!
    @IBOutlet var location: UITextField!
    @IBOutlet var endTime: UITextField!
    @IBOutlet var startTime: UITextField!
    @IBOutlet var endDate: UITextField!
    @IBOutlet var startDate: UITextField!
    @IBOutlet var headerView: UIView!
    var dataArray : NSArray = []
    let imagePicker = UIImagePickerController()
    var imgStr : String = ""
    var imageFilePath:URL! = nil
    var dataArr = [[String:AnyObject]]()
    var pageCursor : Int = 0
    var Img : UIImage = #imageLiteral(resourceName: "images")
    
    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var normalView: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var eventTextview: UITextView!
    @IBOutlet weak var outerView: UIView!
    //   @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var addCohostsLabel: UILabel!
    @IBOutlet weak var tagOuterView: UIView!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet var imgAddButton: UIButton!
    @IBOutlet var eventImage: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var followTable: UITableView!
    @IBOutlet weak var smallHeaderView: UIView!
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    let datePicker3 = UIDatePicker()
    let datePicker4 = UIDatePicker()
    var followArray : NSArray = []
    var friendNames  : NSMutableArray = []
    var friendArray : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView.addShadowViewpublic()
        imagePicker.delegate = self
        startDate.delegate = self
        
        endDate.delegate = self
        
        startTime.delegate = self
        endTime.delegate = self
        
        eventTextview.delegate = self
        
        startTime.tag = 3
        startDate.tag = 1
        endTime.tag = 4
        endDate.tag = 2
       // addCoHosts.tag = 5
       // addCoHosts.delegate = self
        createDatePicker()
        createDatePicker1()
        smallHeaderView.addDropShadowToView(targetView: smallHeaderView)
        tagListView.delegate = self
        publicScroll.delegate = self
        tagOuterView.isHidden = true
        followTable.delegate = self
        followTable.dataSource = self
        eventTextview.text = "Write something about the event"
        eventTextview.textColor = UIColor.lightGray
        publicScroll.contentSize = CGSize(width: self.publicScroll.frame.size.width , height: self.tagOuterView.frame.maxY + 50)
       
        selectFollowers()
        if dataArr.count != 0
        {
            eventTitle.text! = (dataArr[pageCursor] as AnyObject).value(forKey: "event_name") as! String
           // event_desc.text = (dataArr[pageCursor] as AnyObject).value(forKey: "event_description") as! String
            eventTextview.text = (dataArr[pageCursor] as AnyObject).value(forKey: "event_description") as! String
            let startdate = (dataArr[pageCursor] as AnyObject).value(forKey: "start_date") as! String
            // startDate.text! = (dataArr[pageCursor] as AnyObject).value(forKey: "start_date") as! String
            let enddate = (dataArr[pageCursor] as AnyObject).value(forKey: "end_date") as! String
                        let dateFormatterr1 = DateFormatter()
                        dateFormatterr1.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let myDate1 = dateFormatterr1.date(from: startdate)!
                        dateFormatterr1.dateFormat = "yyyy-MM-dd"
                        let starDate = dateFormatterr1.string(from: myDate1)
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: enddate)!
            dateFormatterr.dateFormat = "yyyy-MM-dd"
            let enddDate = dateFormatterr.string(from: myDate)
            startDate.text! = starDate
            endDate.text! = enddDate
            location.text! = (dataArr[pageCursor] as AnyObject).value(forKey: "location") as! String
            ticketUrl.text! =  (dataArr[pageCursor] as AnyObject).value(forKey: "ticket_url") as! String

            dateFormatterr1.dateFormat  = "hh :mm"//"EE" to get short style
            let time1 = dateFormatterr1.string(from: myDate1)
            startTime.text! = time1
            dateFormatterr.dateFormat  = "hh :mm"//"EE" to get short style
            let time = dateFormatterr.string(from: myDate)
            endTime.text! = time
            editView.isHidden = false
            editImage.sd_setImage(with: URL(string: (dataArr[pageCursor] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "img1"))
            
//            endTime.text! = time1
            
        }
        else
        {
            editView.isHidden = true
            
            
        }
       
        // Do any additional setup after loading the view.
    }
    @IBAction func close(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    func selectFollowers()
    {
        
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWERS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followArray = (resData as! [[String:AnyObject]] as NSArray)
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.followArray.count != 0)
                {
                    print(self.followArray)
                    self.followTable.reloadData()
                   // self.followTable.reloadData()
                    
                }
                    
                else
                {
                    print("No data")
                }
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
            
            textView.text = "Write something about the event"
            textView.textColor = UIColor.lightGray
            
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            
            return false
        }
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        
        return true
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            
            textView.textAlignment = .left
            textView.text = "Write something about the event"
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
    
    
    func textViewDidChange(_ sender: UITextView) {
        
        
        
        let fixedWidth = eventTextview.frame.size.width
        eventTextview.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = eventTextview.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = eventTextview.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        eventTextview.frame = newFrame
        textView1.sizeToFit()
        if newSize.height > 40.0
        {
//            textView1.frame = CGRect( x :locationLabel.frame.minX,y:textView1.frame.maxY + 20, width : self.textView1.frame.size.width ,height : newSize.height + 10)
//            
//            view1.frame = CGRect(x:textView1.frame.minX,y:textView1.frame.maxY + 20,width : view1.frame.size.width,height : view1.frame.size.height)
//            view2.frame = CGRect(x:view1.frame.minX,y:view1.frame.maxY + 20,width : view2.frame.size.width,height : view2.frame.size.height)
//            tagOuterView.frame = CGRect(x:view1.frame.minX,y:view2.frame.maxY + 20,width : tagOuterView.frame.size.width,height : tagOuterView.frame.size.height)
            
            
            
            
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return followArray.count
       
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! followtableViewCell
            
            
            cell.selectionStyle = .none
            cell.profImage.sd_setImage(with: URL(string: (followArray[indexPath.row] as AnyObject).value(forKey: "picture") as! String), placeholderImage: UIImage(named: "img1"))
            cell.userName.text = "\(String(describing: (followArray[indexPath.row] as AnyObject).value(forKey: "first_name")!))  \((followArray[indexPath.row] as AnyObject).value(forKey: "last_name")!)"
            if cell.checkBoxImage.image == #imageLiteral(resourceName: "square_check")
            {
                cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
                
            }
            else
            {
                cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
            }
            cell.selctBtn.tag = indexPath.row
            
            cell.selctBtn.addTarget(self, action: #selector(selectAct), for: .touchUpInside)
            //  cell.bioDetails.text =
            return cell
      
            
        
    }
  
    @IBAction func closeAct(_ sender: UIButton) {
        
        outerView.isHidden = true
    }
    
    
    @objc func selectAct(sender : UIButton!)
    {
        
        let cell = followTable.cellForRow(at: IndexPath(row :sender.tag,section :0)) as! followtableViewCell
//        friendArray.add((followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
//        print(friendArray)
        
        
        if cell.checkBoxImage.image == #imageLiteral(resourceName: "square")
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square_check")
            friendArray.add((followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String)
            friendNames.add("\(String(describing: (followArray[sender.tag] as AnyObject).value(forKey: "first_name")!))  \((followArray[sender.tag] as AnyObject).value(forKey: "last_name")!)")
            
        }
        else
        {
            cell.checkBoxImage.image = #imageLiteral(resourceName: "square")
            var cnt : Int = 0
            cnt = friendArray.count
            for i in 0..<cnt
            {
                
                if i == cnt
                {
                    
                    print("Nothing")
                    
                }
                else if friendArray[i] as! String == (followArray[sender.tag] as AnyObject).value(forKey: "follower_id") as! String
                {
                    
                    friendArray.removeObject(at: i)
                    cnt = cnt - 1
                }
            }
            
            print(friendArray)
        }
        
        
        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if  textField.tag == 1
    {
        resignFirstResponder()
        fromDatePicker()
        
        }
        
        if textField.tag == 2
        {
            resignFirstResponder()
            toDatePicker()
            
        }
        
        
        
        if  textField.tag == 3
        {
            resignFirstResponder()
            createDatePicker()
            
        }
        
        if textField.tag == 4
        {
            resignFirstResponder()
            createDatePicker1()
            
        }
        
        
    }
    
    
    @IBAction func uploadBtnAct(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Upload Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction(title: "Remove Photo", style: .default, handler: { _ in
            self.editImage.image = nil
            self.eventImage.image = nil
            self.editView.isHidden = true
            
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
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
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
            editView.isHidden = true
            imgStr = base64_str!
            eventImage.image = imag
            imgAddButton.isHidden = true
            
        }
        else{
            
            
            //            self.videoFilePath = (info[UIImagePickerControllerMediaURL] as? NSURL)! as URL!
            //            videoImage.image = UIImage(named: "att_video.png")
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
    
    @IBOutlet weak var addCohosts: UIButton!
    
    @IBAction func addcostAct(_ sender: Any) {
        
        tagOuterView.isHidden = false
        outerView.isHidden = false
        tagOuterView.frame = CGRect(x:view2.frame.minX,y:view2.frame.maxY + 20,width : tagOuterView.frame.size.width ,height : tagOuterView.frame.size.height)
        tagListView.frame = CGRect(x:5,y:5,width : tagListView.frame.size.width ,height : tagListView.frame.size.height)
    }
    
    
    func createDatePicker()
    {
        //format for picker
        datePicker.datePickerMode = .time
        
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
        toolbar.setItems([doneButton,cancelButton], animated: false)
        
        //        toolbar.setItems([cancelButton], animated: false)
        startTime.inputAccessoryView=toolbar
        //        toDate.inputAccessoryView=toolbar
        
        //assign date picker to text field
        
        
        startTime.inputView=datePicker
        //        toDate.inputView=datePicker
        
    }
    func createDatePicker1()
    {
        //format for picker
        datePicker1.datePickerMode = .time
        
        //        let birthFromStr = datePicker1.date(from: fromDate.text!)!
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // datePicker1.minimumDate = datePicker.date
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
        toolbar.setItems([doneButton, cancelButton], animated: false)
        endTime.inputAccessoryView=toolbar
        
        //assign date picker to text field
        
        
        endTime.inputView=datePicker1
        
    }
    
    
    @IBAction func doneAct(_ sender: UIButton) {
        
       
        
        
        let params: [String:Any] = ["eventid" :"0","userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID),"friends" :friendArray]
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_EVENTS_COHOSTS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json["status"] == 200 {
                
                if json["ResponseMessage"] == "success"
                    
                {
                    print("RequestSuccess")
                    self.outerView.isHidden = true
                    var loop1 : Int = 2
                    for i in 0..<self.friendNames.count
                    {
                        if i > loop1
                            
                        {
                            self.tagListView.addTag(self.friendNames[i] as! String)
                            //                addCohostsLabel.frame = CGRect(x:eventView.frame.minX,y:eventView.frame.maxY + 20,width : cohostView.frame.size.width,height : cohostView.frame.size.height)
                            
                            self.self.tagOuterView.frame = CGRect(x:self.addCohostsLabel.frame.minX,y:self.addCohostsLabel.frame.maxY + 20,width : self.tagOuterView.frame.size.width,height : self.tagOuterView.frame.size.height + 15)
                        self.tagListView.frame = CGRect(x: self.tagOuterView.frame.minX + 5,y:5,width : self.tagOuterView.frame.size.width - 4,height : self.tagListView.frame.size.height + 15)
                            
                            loop1 = i
                            
                        }
                        else
                        {
                            self.tagListView.addTag(self.friendNames[i] as! String) // friendNames[i] as! String
                        }
                    }
                    // red.cont()
                }
                    
                else
                {
                    print("No data")
                }
            }
        }
        
    }
    
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
        
        
        tagOuterView.frame = CGRect(x:addCohostsLabel.frame.minX,y:addCohostsLabel.frame.maxY + 20,width : tagOuterView.frame.size.width,height : tagOuterView.frame.size.height - 15)
        tagListView.frame = CGRect(x:tagOuterView.frame.minX + 5,y:5,width : tagOuterView.frame.size.width - 4,height : tagListView.frame.size.height - 15)
       
    }
    
    @objc func donePressed()
    {
        //format date
        datePicker1.minimumDate = datePicker.date
        endTime.text = ""
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "HH:mm"
        
        
        dateFormatter.timeStyle = .short
        
        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatter.contains("a") {
            let dateAsString = dateFormatter.string(from: datePicker.date)
            // let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            let date = dateFormatter.date(from: dateAsString)
            //  dateFormatter.dateFormat = "HH:mm"
            
            let Date24 = dateFormatter.string(from: date!)
            print("24 hour formatted Date:",Date24)
            startTime.text = Date24
        } else {
            startTime.text=dateFormatter.string(from: datePicker.date)
        }
        
        
        
        //        fromDate.text=dateFormatter.string(from: datePicker.date)
        print(startTime.text!)
        self.view.endEditing(true)
        
        
        //        toDate.text=dateFormatter.string(from: datePicker.date)
        //        self.view.endEditing(true)
        
        
        
        
        
    }
   
    @objc func donePressed1()
    {
        //format date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "HH:mm"
        
        dateFormatter.timeStyle = .short
        
        
        
        let locale = NSLocale.current
        let formatter : String = DateFormatter.dateFormat(fromTemplate: "j", options:0, locale:locale)!
        if formatter.contains("a") {
            let dateAsString = dateFormatter.string(from: datePicker1.date)
            //  let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            let date = dateFormatter.date(from: dateAsString)
            // dateFormatter.dateFormat = "HH:mm"
            
            let Date24 = dateFormatter.string(from: date!)
            print("24 hour formatted Date:",Date24)
            endTime.text = Date24
        } else {
            endTime.text=dateFormatter.string(from: datePicker1.date)
        }
        
        print(endTime.text!)
        self.view.endEditing(true)
    }
    @objc func cancel()
    {
        
        self.view.endEditing(true)
    }
    
    
    
    func  fromDatePicker()
    {
        datePicker.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
//        let birthFromStr = dateFormatter.date(from: startDate.text!)!
        
      //  datePicker1.minimumDate = birthFromStr
       
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done))
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
        toolbar.setItems([doneButton,cancelButton], animated: false)
        
        //        toolbar.setItems([cancelButton], animated: false)
        startDate.inputAccessoryView=toolbar
        //        toDate.inputAccessoryView=toolbar
        
        //assign date picker to text field
        
        
        startDate.inputView=datePicker
        
        //         self.view.addSubview(Ui)
        
        //        toDate.inputView=datePicker
        
        
    }
    
    
    
    
    @objc func done()
        
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        
        startDate.text = dateFormatter.string(from: datePicker.date)
        
        
      //  let strDate = "\(dateFormatter.string(from: datePicker.date))"
        
//        let dateFormatter1 = DateFormatter()
//
//        dateFormatter1.dateFormat = "YYYY-MM-dd"
//
//        let birthFromStr = dateFormatter1.date(from: strDate)! as Date
//
//        datePicker.minimumDate = birthFromStr
        
        
        
        print("Date Stamp: \(dateFormatter.string(from: datePicker.date))")
        
        self.view.endEditing(true)
        
        
        
        
        
        
        
    }
  
    
    func toDatePicker()
    {
        //format for picker
        
        
        //        let birthFromStr = datePicker1.date(from: fromDate.text!)!
        if startDate.text == ""
        {
            
            let alert = UIAlertController(title: "", message: "Please select From Date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            
            datePicker1.datePickerMode = .date
            let dateFormatter1 = DateFormatter()
            
            dateFormatter1.dateFormat = "YYYY-MM-dd"
            
            let birthFromStr = dateFormatter1.date(from: startDate.text!)!
            
            datePicker1.minimumDate = birthFromStr
            
            //toolbar
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            //bar button item
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(done1))
            let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
            toolbar.setItems([doneButton, cancelButton], animated: false)
            endDate.inputAccessoryView=toolbar
            
            //assign date picker to text field
            
            
            endDate.inputView=datePicker1
        }
    }
    
    
    @objc func done1()
    {
        //format date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        
        endDate.text = dateFormatter.string(from: datePicker1.date)
        
        print("Date Stamp: \(dateFormatter.string(from: datePicker1.date))")
        
        
        
        
        
        
        self.view.endEditing(true)
    }
    
    @IBAction func createEvent(_ sender: UIButton) {
        
           
        if eventImage.image == nil
        {
            let alert = UIAlertController(title: "Alert!", message: "Please choose  picture", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
        else if eventTextview.text! == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter event description", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
        else if startDate.text! == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter start date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
        else if endDate.text == ""
        {
            let alert = UIAlertController(title: "Alert!", message: "Please enter end Date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
            })
            self.present(alert, animated: true)
            
        }
     
      
        
             else
        {
            
            
//            if(self.imgStr != "")
//            {
//                let dataDecoded2:NSData = NSData(base64Encoded: (self.imgStr), options: NSData.Base64DecodingOptions(rawValue: 1))!
//                let documentDirectoryURL2 = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//                let fileDestinationUrl2:URL = documentDirectoryURL2.appendingPathComponent("newImage3.jpg")
//                dataDecoded2.write(to: fileDestinationUrl2, atomically: true)
//
//                multipartFormData.append(fileDestinationUrl2, withName: "file")
//            }
            
            let jsonParam = friendArray;
           
            
            print("\(json(from:friendArray as Any))")
            
            let params : [String: Any] = [
                "event_id" : "0" ,
                "event_name" : eventTitle.text! ,
                "image_exists" : " " ,
                "event_type" :"2" ,
                "ticket_url":ticketUrl.text! ,
                "location":location.text! ,
                "start_date":startDate.text! ,
                "end_date":endDate.text! ,
                "latitude":"0.0",
                "longitude":"0.0" ,
                "created_by":Utils.getPreferenceValue(ForKey: Constant.USER_ID),
                "friends" : "" ,
                "cohost" : json(from:friendArray as Any),
                "share_type" : "0" ,
                "event_description":eventTextview.text!
            ]

            let image = UIImage.init(named: "default")
            let imgData = UIImageJPEGRepresentation(image!, 0.2)!
            
            //let parameters = ["name": rname] //Optional for extra parameter
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
                
                for (key, value) in params {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                } //Optional for extra parameters
            },
                             to:"http://52.35.246.28/food_wall/index.php/mobile/webservice?methodname=create_events")
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        print(response.result.value)
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
            }

        }
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
        
    
    @IBAction func imgUpload(_ sender: UIButton) {
        
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
    
   
    
    
  
    
    
    
    @IBOutlet var imagUploadAction: UIButton!
  
    @IBAction func closeAction(sender: UIButton) {
        
        
       
        
        
//        let page:EventsViewController = self.storyboard?.instantiateViewController(withIdentifier: "eventsview") as! EventsViewController
//        self.present(page, animated: false, completion: nil)
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
    
    func addShadowViewpublic() {
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
    
}

extension Dictionary {
    init(elements:[(Key, Value)]) {
        self.init()
        for (key, value) in elements {
            updateValue(value, forKey: key)
        }
    }
}


