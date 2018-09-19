//
//  FirstsearchpageViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 16/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstsearchpageViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    
    @IBOutlet weak var Mytable: UITableView!
    @IBOutlet weak var headerview: UIView!
    
    @IBOutlet weak var searchingtext: UITextField!
     var searchingdetailarray = [[String:AnyObject]]()
    var a = 0
    
    var cellheight = 50 as CGFloat
    override func viewDidLoad() {
        super.viewDidLoad()
        
         UserDefaults.standard.removeObject(forKey: "Controller")
        
        Mytable.delegate = self
        Mytable.dataSource = self
        headerview.addShadowView()
       // Mytable.separatorStyle = .none
        searchingtext.delegate = self
       // indicator.hidesWhenStopped = true
        
        // Do any additional setup after loading the view.
        
        Mytable.tableFooterView = UIView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
 
    
   
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (currentReachabilityStatus != .notReachable) == true {
           
            // self.nochatlable.isHidden = true
            //indicator.hidesWhenStopped = true
            
           
            self.getcommonsearch()
            a = 1
            
        }
        else {
             a = 0
            let alert = UIAlertController(title: "No Internet Connection", message: "Check your internet..", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        return true
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchingdetailarray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       // SearchHeadVC
        //FirstsearchpageViewController
        let page = self.storyboard?.instantiateViewController(withIdentifier: "MainsearchViewController") as! MainsearchViewController
           UserDefaults.standard.set("\(searchingtext.text!)", forKey: "searchtext")
        let searchingvalue = "\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtext") as! String))"+" - "+"\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtype") as! String))"
         UserDefaults.standard.set("\(searchingtext.text!)", forKey: "passingsearchtext")
        self.present(page, animated: false, completion: nil)
      
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstseach", for: indexPath) as! FirstseachTableViewCell
        
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textlabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
       
        
        
       // cell.textLabel?.text = "\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtext") as! String))"+" - "+"\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtype") as! String))"
        
        
        
        let main_string = "\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtext") as! String))"+" - "+"\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtype") as! String))"
        
        let string_to_color = "\(((self.searchingdetailarray[indexPath.row] as AnyObject).value(forKey: "searchtype") as! String))"
        
        let range = (main_string as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.orange , range: range)

        
        
        cell.textLabel?.attributedText = attribute
        
        
       cell.textLabel?.sizeToFit()
        
        let height = cell.textLabel?.frame.height
        
        cellheight = CGFloat(height!) + 20
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(cellheight)
    }
    
    @IBAction func back(_ sender: Any) {
         UserDefaults.standard.removeObject(forKey: "Controller")
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.searchingtext.text = ""
    }
    
    func getcommonsearch()
    {
        
        if a != 0{
        
        print(searchingtext.text!)
            
      //  indicator.startAnimating()
        let parameters = ["search_text" : "\(searchingtext.text!)"]
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH)", method: .post, parameters: parameters)
            
            .responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if let resData = json["Data"].arrayObject {
                    
                    if json["Data"] != "Novalue"
                    {
                    self.searchingdetailarray = (((resData as! NSArray) as! [[String : AnyObject]] ))
                    //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                    
                    }
                    else {
                         self.showToast(message: "No search found!!!")
                    }
                    if(self.searchingdetailarray.count != 0)
                    {
              
                            self.Mytable.reloadData()
                            
                            //  self.nochatlable.isHidden = false
                            
                            self.Mytable.isHidden = false
                            
                        }
                        else {
                             self.Mytable.isHidden = true
                         self.showToast(message: "No search found!!!")
                             // self.indicator.stopAnimating()
                        }
                    }
                else {
                  //   self.indicator.stopAnimating()
                    self.showToast(message: "No search found!!!")
                    //  self.nochatlable.isHidden = true
                    print("No data")
                    }
                   
                    
                }
            
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
