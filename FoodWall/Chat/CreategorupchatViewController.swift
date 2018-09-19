//
//  CreategorupchatViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 23/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreategorupchatViewController: UIViewController,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource {
@IBOutlet var headerView: UIView!
     @IBOutlet weak var Mytable: UITableView!
    
    @IBOutlet weak var Nextbutton: UIButton!
    @IBOutlet weak var profileview: UIView!
    var followarray = [[String:AnyObject]]()
    
    
    @IBOutlet weak var Profilelabel: UILabel!
    
    @IBOutlet weak var profileimageview: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      headerView.addShadowView()
         profileview.isHidden = true
        Mytable.delegate = self
        Mytable.dataSource = self
        
        profileview.isHidden = true
//
//        indicator.hidesWhenStopped = true
        
        Mytable.separatorStyle = .none
        self.Mytable.isHidden = false
        self.Nextbutton.isHidden = true
        showfollowers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let page = self.storyboard?.instantiateViewController(withIdentifier: "chatview") as! chatViewController
        
        
         page.username1 = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
         page.username2 = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
          page.userimage = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"
        page.friendid = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "follower_id") as! String))"
       
        
        
        self.present(page, animated: false, completion: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "createchatcell", for: indexPath) as! creategroupTableViewCell
          cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MainChatViewController.connected(_:)))
        cell.followerimage.isUserInteractionEnabled = true
        cell.followerimage.tag = indexPath.row
        cell.followerimage.addGestureRecognizer(tapGestureRecognizer)
        
        
        profileimageview.sd_setImage(with: URL(string: "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"), placeholderImage: UIImage(named: "default"))
        Profilelabel.text = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        
        
      
        
       cell.Firstnamebold.text! =  "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        
         cell.firstnamesmall.text! = "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "first_name") as! String))\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "last_name") as! String))"
        cell.followerimage.sd_setImage(with: URL(string: "\(((self.followarray[indexPath.row] as AnyObject).value(forKey: "picture") as! String))"), placeholderImage: UIImage(named: "default"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return followarray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
    }
    @objc func connected(_ sender:AnyObject){
        
//        print("you tap image number : \(sender.view.tag)")
//        
//        profileview.isHidden = false
        
        
    }
    @IBAction func dismiss(_ sender: Any) {
        profileview.isHidden = true
    }
    func showfollowers()
    {
//          indicator.hidesWhenStopped = true
         // indicator.startAnimating()
        Utils.svprogressHudShow(title: "Loading..", view: self)
         let params: [String:String] = ["userid" : Utils.getPreferenceValue(ForKey: Constant.USER_ID)]
      //  let params: [String:String] = ["userid" : "4"]
        let urlString = "\(Constant.BASEURL)\(Constant.GET_FOLLOWERS)"
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if let resData = json["Data"].arrayObject {
                
                self.followarray = ((resData as! [[String:AnyObject]] as NSArray) as! [[String : AnyObject]])
                //self.guestArray = (resData as! [[String:AnyObject]] as NSArray)
                
                
                if(self.followarray.count != 0)
                {
                    print(self.followarray)
                    self.Mytable.reloadData()
                     Utils.svprogressHudDismiss(view: self)
                    //self.indicator.stopAnimating()
                    // self.followTable.reloadData()
                    
                }
                    
                else
                {
                     Utils.svprogressHudDismiss(view: self)
                  //  self.indicator.stopAnimating()
                    print("No data")
                }
            }
        }
        
        
    }
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func chat(_ sender: Any) {
    }
    
    
    @IBAction func info(_ sender: Any) {
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
