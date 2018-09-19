//
//  MaincommonViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 17/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MaincommonViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var headerview: UIView!
    
    @IBOutlet weak var searchingtext: UITextField!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerview.addShadowView()
        searchingtext.text =  UserDefaults.standard.string(forKey: "searchtext")
        searchingtext.delegate = self
        searchingtext.becomeFirstResponder()
       // UserDefaults.standard.set("\(searchingtext.text!)", forKey: "searchtext")
      
        
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "FirstsearchpageViewController") as! FirstsearchpageViewController
        
        
        // page.dataArr = (dataArray[0] as AnyObject) as! [[String : AnyObject]]
        // page.eventID = (dataArray[pageCur] as AnyObject).value(forKey: "event_id") as! String
        //  page.userid = (dataArray[pageCur] as AnyObject).value(forKey: "user_id") as! String
        
        self.present(page, animated: false, completion: nil)
        
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil )
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        searchingtext.text! = ""
        
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
