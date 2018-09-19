//
//  peoplesearchViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 17/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class peoplesearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
   
    @IBOutlet weak var Nosearch: UILabel!
    @IBOutlet weak var mytable: UITableView!
    
     var searchingdetailarray = [[String:AnyObject]]()
      var peoplearray : NSArray = []
     var myIndexPath = -1
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mytable.delegate = self
        mytable.dataSource = self
       
        self.Nosearch.isHidden = false
        self.mytable.isHidden = true
        
        //mytable.separatorStyle = .none
        mytable.tableFooterView = UIView()
          getcommonsearchall()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myIndexPath)
      
        
        
     //
            if peoplearray.count >= 1
        {
          
             if myIndexPath >= 0
             {
       print("\( ((self.peoplearray[self.myIndexPath] as AnyObject).value(forKey: "search_val") as! String))")
            //search_val
          let  searchvalue =  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as! String)
            
            if searchvalue == "0"
                
            {
                return 0
            }
                
            else {
                return peoplearray.count
            }
            
        }
             else {
                return peoplearray.count
            }
            }
            
        else {
             return 0
        }
        
      
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peoplesearch", for: indexPath) as! PeoplesearchTableViewCell
        //first_name
        //last_name
        //picture
        
        self.myIndexPath = indexPath.row
        
         
        
      //
        //(((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "first_name") as! NSArray)[0] as AnyObject).value(forKey: "quest_id") as! String
         print(self.peoplearray)
        
        if peoplearray.count >= 1
        {
     if  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as? String)! == "0"
        
     {
       
     }
     else {  
        
        cell.peoplelabel.text = ""
       print(self.peoplearray)
           cell.peoplelabel.text = "\( ((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))"+"\( ((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        if "\(((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "picture") as? String)!)" != "0"
        {
            
            
            
          
            cell.peopleimage.sd_setImage(with: URL(string: "\(((self.peoplearray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"), placeholderImage: UIImage(named: "default"))
            
        }
        
        
        }
        
        
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    func  getcommonsearchall()
    {
        //passingsearchtext
        let searchtext = UserDefaults.standard.string(forKey: "passingsearchtext")!
        let username = "\(Utils.getPreferenceValue(ForKey: Constant.USER_ID))"
        let parameters = ["userid": username,"search_text" : searchtext]
        
        Alamofire.request("\(Constant.BASEURL)\(Constant.GET_COMMON_SEARCH_RESULT)", method: .post, parameters: parameters)
            
            .responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
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
                        
                        
                        
                        
                        self.peoplearray = (((self.searchingdetailarray[0] as AnyObject).value(forKey: "people") as! NSArray))
                        
                        print("\((((self.searchingdetailarray[1] as AnyObject).value(forKey: "timeline") as! NSArray)))")
                        print("\((((self.searchingdetailarray[2] as AnyObject).value(forKey: "review") as! NSArray)))")
                        
                        print("\((((self.searchingdetailarray[3] as AnyObject).value(forKey: "question") as! NSArray)))")
                        print("\((((self.searchingdetailarray[4] as AnyObject).value(forKey: "events") as! NSArray)))")
                        if(self.peoplearray.count != 0){
                            var  searchvalue =  ((self.peoplearray[0] as AnyObject).value(forKey: "search_val") as! String)
                            
                            if searchvalue != "0"
                            {
                                self.Nosearch.isHidden = true
                                self.mytable.isHidden = false
                                self.mytable.reloadData()
                            }
                            else {
                                self.Nosearch.isHidden = false
                                self.mytable.isHidden = true
                            }
                        }
                        else {
                            self.Nosearch.isHidden = false
                            self.mytable.isHidden = true
                        }
                        //  self.nochatlable.isHidden = false
                        
                        // self.Mytable.isHidden = false
                        
                    }
                    else {
                        self.Nosearch.isHidden = false
                        self.mytable.isHidden = true
                    }
                }
                else {
                    self.Nosearch.isHidden = false
                    self.mytable.isHidden = true
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
