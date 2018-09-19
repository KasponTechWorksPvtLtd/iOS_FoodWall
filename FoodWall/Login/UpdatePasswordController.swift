//
//  UpdatePasswordController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 11/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UpdatePasswordController: UIViewController {

    @IBOutlet weak var confirmPwd: UITextField!
    @IBOutlet weak var newPwd: UITextField!
    @IBOutlet weak var oldPwd: UITextField!
    @IBOutlet weak var updatePwd: UIButton!
    @IBOutlet weak var headerView: UIView!
    var k : String = "0"
    var emailId : String = ""
    var verifyCode : String = ""
    
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.addShadowView()
        updatePwd.applyGradient()
        updatePwd.layer.cornerRadius = 10.0
        updatePwd.clipsToBounds = true
        newPwd.isSecureTextEntry = true
        oldPwd.isSecureTextEntry = true
        confirmPwd.isSecureTextEntry = true
        
//        label.text = "Your password must be at least 9 characters long,include no sapces,and must contain 3 of the following character types: uppercase,lowercase,numerals,special characters(#,$,%,etc.)"
//        label.sizeToFit()
        if k == "1"
        {
            
            oldPwd.isHidden = true
        }
        else
        {
            
            oldPwd.isHidden = false
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    

    @IBAction func backAct(_ sender: UIButton) {
        
        
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func updatePwdAction(_ sender: UIButton) {
        
        if self.newPwd.text! != confirmPwd.text!
        {
            
            let alert = UIAlertController(title: "", message: "New password should be same as old password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                
                
            })
            self.present(alert, animated: true)
            
            
        }
        
        else
        {
        
        if k == "1"
        {
            
             let params: [String:String] = ["email" : emailId ,"verifycode":verifyCode,"new_password" : newPwd.text!]
            
            let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_NEW_PASSWORD)"
            Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                let result = response.result
                let json = JSON(data: response.data!)
                
                if json != nil
                {
                    if json["ResponseMessage"] == "success"
                        
                    {
                        let alert = UIAlertController(title: "", message: "Updated Succcefully", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginController
                            self.present(next, animated: false, completion: nil)
                            
                            Utils.setPreferenceValue(setValue: "0", ForKey: Constant.isLoggedIn)
                            
                        })
                        self.present(alert, animated: true)
                        
                        
                    }
                    
                }
                
            }
            
            
        }
        
        else
        {
        
        let params: [String:String] = ["userid" :Utils.getPreferenceValue(ForKey: Constant.USER_ID) ,"old_password":oldPwd.text!,"new_password" : newPwd.text!]
        
        let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_PASSWORD)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    let alert = UIAlertController(title: "", message: "Updated Succcefully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginController
                        self.present(next, animated: false, completion: nil)
                        
                        Utils.setPreferenceValue(setValue: "0", ForKey: Constant.isLoggedIn)
                       // self.dismiss(animated: false, completion: nil)
                    })
                    self.present(alert, animated: true)
                    
                    
                }
                
            }
            
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
