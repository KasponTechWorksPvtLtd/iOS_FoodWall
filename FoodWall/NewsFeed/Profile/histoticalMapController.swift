//
//  histoticalMapController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 05/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class histoticalMapController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var newTable: UITableView!
    var hotelArray = [[String:AnyObject]]()
    var monthArray = [String]()
    //    var month1 : String = ""
    //    var month : String = ""
    //    var checkMonth : String = ""
    var Created_date = Date()
    var Created_date1 = Date()
    var createdDate = Date()
    //    var new_date = Date()
    //    var date1 : String = ""
    //    var year1 : String = ""
    //    var year2 : String = ""
    //    var year3 : String = ""
    var filteredCall = [[String:AnyObject]]()
    var filteredArray = [String]()
    
   
    @IBOutlet weak var oopsView: UIView!
    var Filter : Int = 0
    let datePicker = UIDatePicker()
    let datePicker1 = UIDatePicker()
    //rivate var customLabel : UILabel?
    
    @IBOutlet weak var clearBtn: UIButton!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var toDate: UITextField!
    @IBOutlet weak var fromDate: UITextField!
    @IBOutlet weak var searchBarIn: UISearchBar!
    /// MAximum Count to which label will be Updated
    private var maxCount : Int?
    /// Count which is currently displayed in Label
    private var currentCount : Int?
    /// Timer To animate label text
    // private var updateTimer : Timer?
    var timer = Timer()
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        scrollView1.delegate = self
        //        scrollView1.contentSize = CGSize(width: 375.0, height: self.newTable.frame.size.height)
    }
    
    override func viewDidLoad() {
        newTable.delegate = self
        newTable.dataSource = self
        //        scrollView1.delegate = self
        //        scrollView1.contentSize = CGSize(width: 375.0, height: self.newTable.frame.size.height)
        historicalDataCall()
        fromDate.delegate = self
        toDate.delegate = self
        fromDate.tag = 0
        toDate.tag = 1
        monthLabel.layer.cornerRadius = 15.0
        monthLabel.clipsToBounds = true
        //  monthLabel.applyGradientblue()
        monthLabel.textColor = UIColor.white
        filterBtn.layer.cornerRadius = 5.0
        filterBtn.clipsToBounds = true
        clearBtn.layer.cornerRadius = 5.0
        clearBtn.clipsToBounds = true
        filterBtn.applyGradient()
        clearBtn.applyGradient()
        //        datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: 60, to: Date())
        //        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -0, to: Date())
        //        datePicker1.maximumDate = Calendar.current.date(byAdding: .day, value: 60, to: Date())
        //        datePicker1.minimumDate = Calendar.current.date(byAdding: .day, value: -10, to: Date())
        //  searchBarIn.delegate = self
        
        // DispatchQueue.main.async {
        //            self.maxCount = self.hotelArray.count
        //            self.currentCount = 0
        //            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(histoticalMapController.updateLabel), userInfo: nil, repeats: true)
        // }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0
        {
            resignFirstResponder()
            createDatePicker()
            filteredCall.removeAll()
        }
        else
        {
            createDatePicker1()
            filteredCall.removeAll()
        }
    }
    
    
    func historicalDataCall()
    {
        Utils.svprogressHudShow(title: "Loading...", view: self)
        
      //  indicator.startAnimating()
       // indicator.hidesWhenStopped = true
        let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.SELECTED_USER_ID)] //
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.GET_HISTORICAL_DATA)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.hotelArray = resData as! [[String:AnyObject]]
                
                if(self.hotelArray.count != 0){
                  
                    Utils.svprogressHudDismiss(view: self)
                  //  self.indicator.stopAnimating()
                    
                    self.newTable.reloadData()
                }
                    
                else
                    
                {
                 
                    Utils.svprogressHudDismiss(view: self)
                   // self.indicator.stopAnimating()
                    self.showToast(message: "No data Found")
                    
                    
                }
            }
            else
            {
               
                Utils.svprogressHudDismiss(view: self)
                self.showToast(message: "No data found")
            }
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 5))
        //  view.backgroundColor = UIColor(red: 225/255, green: 224/255, blue: 226/255, alpha: 0.1)
        return view
        
        
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    //        customView.backgroundColor = UIColor.red
    //    }
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        
        if hotelArray.count != 0
        {
            monthLabel.isHidden = false
            return hotelArray.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! RestaurantVisitCell
        
        cell.selectionStyle = .none
        if (hotelArray[indexPath.section] as AnyObject).value(forKey: "image_count") as! Int != 0
        {
            
            
            let cnt = (((hotelArray[indexPath.section] as AnyObject).value(forKey : "image") as! NSArray).count)
            if cnt == 1
            {
                cell.hotelPic.isHidden = false
                cell.photosCountLabel.isHidden = true
                cell.hotelPic.sd_setImage(with: URL(string: (((hotelArray[indexPath.section] as AnyObject).value(forKey : "image") as! NSArray)[0] as AnyObject).value(forKey : "img") as! String), placeholderImage: UIImage(named: "default"))
            }
                
            else
            {
                
                
                cell.photosCountLabel.isHidden = false
                cell.hotelPic.isHidden = false
                cell.hotelPic.sd_setImage(with: URL(string: (((hotelArray[indexPath.section] as AnyObject).value(forKey : "image") as! NSArray)[0] as AnyObject).value(forKey : "img") as! String), placeholderImage: UIImage(named: "default"))
                cell.photosCountLabel.text = "+ \((((hotelArray[indexPath.section] as AnyObject).value(forKey : "image") as! NSArray).count) - 1) PHOTOS"
                //  cell.photosCountLabel.font = .bold
            }
            
            
            
        }
            
        else
        {
            cell.photosCountLabel.isHidden = true
            cell.hotelPic.isHidden = true
            cell.dateView.frame = CGRect( x:8.0,y:12.0,width:cell.dateView.frame.size.width,height:50.0)
            cell.view1.frame =  CGRect( x:0,y:10.0,width:cell.view1.frame.size.width,height:70.0)
            
        }
        
        
        cell.view1.layer.cornerRadius = 10.0
        cell.view1.clipsToBounds = true
        
        cell.dateView.layer.cornerRadius = 15.0
        cell.dateView.clipsToBounds = true
        cell.hotelPic.layer.cornerRadius = 10.0
        cell.hotelPic.clipsToBounds = true
        
        
        cell.restaurantName.text = (hotelArray[indexPath.section] as AnyObject).value(forKey: "hotel_name") as! String
        
        if (hotelArray[indexPath.section] as AnyObject).value(forKey: "whom_count") as! Int != 0
        {
            
            let cnt =  (((hotelArray[indexPath.section] as AnyObject).value(forKey : "whom") as! NSArray).count) - 1
            
            if cnt == 1
            {
                cell.withFriendLabel.isHidden = false
                cell.withFriendLabel.text! = "With - \((((hotelArray[indexPath.section] as AnyObject).value(forKey : "whom") as! NSArray)[0] as AnyObject).value(forKey: "first_name") as! String) and 1 other"
            }
                
            else if cnt == 0
            {
                
                cell.withFriendLabel.isHidden = false
                cell.withFriendLabel.text! = "With - \((((hotelArray[indexPath.section] as AnyObject).value(forKey : "whom") as! NSArray)[0] as AnyObject).value(forKey: "first_name") as! String)"
            }
                
            else
            {
                cell.withFriendLabel.isHidden = false
                cell.withFriendLabel.text! = "With - \((((hotelArray[indexPath.section] as AnyObject).value(forKey : "whom") as! NSArray)[0] as AnyObject).value(forKey: "first_name") as! String)  and \(cnt) others"
                print(cell.withFriendLabel.text!)
            }
            
            
        }
            
        else
        {
            //            cell.withFriendLabel.text = "Alone"
            cell.withFriendLabel.isHidden = true
        }
        
        cell.dateView.applyGradient()
        cell.view1.addShadowView()
        
        //   print(month1)
        let createdTime = "\((hotelArray[indexPath.section] as AnyObject).value(forKey: "created_on")!)"
        let dateFormatterr = DateFormatter()
        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myDate = dateFormatterr.date(from: createdTime)!
        dateFormatterr.dateFormat = "dd"
        let date1 = dateFormatterr.string(from: myDate)
        cell.datelabel.text = date1
        return cell
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if hotelArray.count == 0
        {
            
        }
        else
        {
            let createdTime = "\((hotelArray[indexPath.section] as AnyObject).value(forKey: "created_on")!)"
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myDate = dateFormatterr.date(from: createdTime)!
            dateFormatterr.dateFormat = "dd"
            let date1 = dateFormatterr.string(from: myDate)
            //  cell.datelabel.text = date1
            dateFormatterr.dateFormat = "MMMM yyyy"
            let month1 = dateFormatterr.string(from: myDate)
            monthLabel.textColor = UIColor.white
            monthLabel.text = month1
            print("section:\(indexPath.section)" )
        }
        // monthLabel.text = hotelArray[indexPath.section]
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //
    //        let createdTime = "\((hotelArray[indexPath.section] as AnyObject).value(forKey: "created_on")!)"
    //        let dateFormatterr = DateFormatter()
    //        dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //        let myDate = dateFormatterr.date(from: createdTime)!
    //        dateFormatterr.dateFormat = "dd"
    //        let date1 = dateFormatterr.string(from: myDate)
    //        dateFormatterr.dateFormat = "MMM"
    //        let month1 = dateFormatterr.string(from: myDate)
    //        monthLabel.text = month1
    //    }
    
    //    func table
    
    @IBAction func filterData(_ sender: Any) {
        
        
        Filter = 1
        histoticalFilterCall()
        // newTable.reloadData()
        
        
    }
    
    
    @IBAction func clear(_ sender: UIButton) {
        filteredCall.removeAll()
        Filter = 0
        
        createDatePicker()
        createDatePicker1()
        fromDate.text! = ""
        toDate.text! = ""
        oopsView.isHidden = true
        newTable.isHidden = false
        historicalDataCall()
        // newTable.reloadData()
        
    }
    
    
    
    
    
    func createDatePicker()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
        toolbar.setItems([doneButton,cancelButton], animated: false)
        
        //        toolbar.setItems([cancelButton], animated: false)
        fromDate.inputAccessoryView=toolbar
        //        toDate.inputAccessoryView=toolbar
        
        //assign date picker to text field
        
        
        fromDate.inputView=datePicker
        
        //         self.view.addSubview(Ui)
        
        //        toDate.inputView=datePicker
        
        
        
    }
    
    
    
    @objc func donePressed()
        
    {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        
        fromDate.text = dateFormatter.string(from: datePicker.date)
        
        
        // let strDate = "\(dateFormatter.string(from: datePicker.date))"
        
        let dateFormatter1 = DateFormatter()
        
        dateFormatter1.dateFormat = "YYYY-MM-dd"
        
        //  let birthFromStr = dateFormatter1.date(from: strDate)! as Date
        
        //  datePicker.minimumDate = birthFromStr
        
        
        
        print("Date Stamp: \(dateFormatter.string(from: datePicker.date))")
        
        self.view.endEditing(true)
        
        
        
        
        
        
    }
    func createDatePicker1()
    {
        //format for picker
        datePicker1.datePickerMode = .date
        let dateFormatter1 = DateFormatter()
        
        dateFormatter1.dateFormat = "YYYY-MM-dd"
        
        let birthFromStr = dateFormatter1.date(from: fromDate.text!)!
        
        datePicker1.minimumDate = birthFromStr
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed1))
        let cancelButton = UIBarButtonItem (barButtonSystemItem: .cancel, target: nil, action: #selector(cancel))
        toolbar.setItems([doneButton, cancelButton], animated: false)
        toDate.inputAccessoryView=toolbar
        
        //assign date picker to text field
        
        
        toDate.inputView=datePicker1
        
    }
    
    
    @objc func donePressed1()
    {
        //format date
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        
        toDate.text = dateFormatter.string(from: datePicker1.date)
        
        print("Date Stamp: \(dateFormatter.string(from: datePicker1.date))")
        
        // histoticalFilterCall()
        self.view.endEditing(true)
    }
    @objc func cancel()
    {
        if fromDate.text == ""
        {
        }
        if toDate.text == ""
        {
            
        }
        
        self.view.endEditing(true)
    }
    
    
    func  histoticalFilterCall()
        
    {
        for i in 0..<hotelArray.count
        {
            
            let dateFormatterr = DateFormatter()
            dateFormatterr.dateFormat = "yyyy-MM-dd HH:mm:ss"
            createdDate = dateFormatterr.date(from: (hotelArray[i] as AnyObject).value(forKey: "created_on") as! String)!
            dateFormatterr.dateFormat = "yyyy-MM-dd"
            let date1 = dateFormatterr.string(from: createdDate)
            filteredArray.append(date1)
            print(filteredArray)
            
            if  fromDate.text! <= filteredArray[i] && toDate.text! >= filteredArray[i]
            {
                
                filteredCall.append(((hotelArray[i] as AnyObject) as! [String : AnyObject]))
                print(filteredCall)
            }
            
            
        }
        
        hotelArray = filteredCall
        print(hotelArray)
        
        if hotelArray.count == 0
        {
            oopsView.isHidden = false
            newTable.isHidden = true
        }
        else
        {
            oopsView.isHidden = true
            newTable.isHidden = false
        }
        self.newTable.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = hotelArray[indexPath.row] as! NSDictionary
        
        let page:TimelineDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
        
        page.timeLine_id = dict.value(forKey: "timeline_id") as! String
        page.user_id = dict.value(forKey: "user_id") as! String
        self.present(page, animated: false, completion: nil)
        
        
        
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        self.showToast1(message: Utils.getPreferenceValue(ForKey: Constant.MONTH))
    //    }
    //
    //    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    //        self.showToast2(message: Utils.getPreferenceValue(ForKey: Constant.MONTH))
    //    }
    
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        DispatchQueue.main.async {
            self.showToast1(message: Utils.getPreferenceValue(ForKey: Constant.MONTH))
        }
        
        // self.newTable.reloadData()
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        DispatchQueue.main.async {
    //            self.showToast1(message: Utils.getPreferenceValue(ForKey: Constant.MONTH))
    //        }
    //    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        self.showToast1(message: Utils.getPreferenceValue(ForKey: Constant.MONTH))
    //    }
    //
    
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.showToast1(message: Utils.getPreferenceValue(ForKey: Constant.MONTH))
        print("Scroll Top")
        //self.newTable.reloadData()
    }
    @objc func updateLabel()
    {
        
        let cell = newTable.cellForRow(at: IndexPath(row :0,section:0)) as! RestaurantVisitCell
        cell.totalRestaurants.text = String(currentCount!)
        currentCount! += 1
        // var i = 0
        
        if currentCount! > maxCount! {
            /// Release All Values
            self.timer.invalidate()
            // self.timer = nil
            self.maxCount = nil
            self.currentCount = nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (hotelArray[indexPath.section] as AnyObject).value(forKey: "image_count") as! Int == 0
        {
            return 80.0
        }
        else
        {
            return 190.0
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




