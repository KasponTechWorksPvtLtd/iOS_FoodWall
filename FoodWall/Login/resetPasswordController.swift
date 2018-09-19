//
//  resetPasswordController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 11/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class resetPasswordController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var resetPwd: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var backtologin: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var resendin: UILabel!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    var reset : String = ""
    
    @IBOutlet weak var resentbutton: UIButton!
    var textData : String = ""
    
    
   var NUMBER_COUNT_DOWN = 30
    var countDown = 0
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resentbutton.isHidden = true
        countDownLabel.isHidden = true
        resendin.isHidden = true
        
        
        emailTextField.delegate = self
        resetPwd.applyGradient()
        resentbutton.applyGradient()
        headerView.addShadowView()
        resetPwd.layer.cornerRadius = 10.0
        resetPwd.clipsToBounds = true
        resentbutton.layer.cornerRadius = 10.0
        resentbutton.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(resetPasswordController.tapFunction))
        backtologin.isUserInteractionEnabled = true
        backtologin.addGestureRecognizer(tap)
        emailTextField.tag = 0
        
          countDown = NUMBER_COUNT_DOWN
            label.text = "Enter your email below to receive your password reset instructions"
        
      
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tapFunction()
    {
        
        self.dismiss(animated: false, completion: nil)
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if emailTextField.tag == 2
        {
        let charsLimit = 6
        
        let startingLength = textField.text?.characters.count ?? 0
        let lengthToAdd = string.characters.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        return newLength <= charsLimit
        }
        return true
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        let string = "\(testStr)"
        var output = ""
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        var result = emailTest.evaluate(with: testStr)
        if result == true
        {
            for chr in string {
                var str = String(chr)
                if str.lowercased() != str {
                    output += str
                    result = false
                    
                }
            }
            
            
        }
        
        print(output)
        
        
        
        return result
        
    }
    
    
    func isValidVerificationcode(value: String) -> Bool {
        if value.characters.count == 6{
            return true
        }
        else{
            return false
        }
    }
    
    
    @IBAction func backAct(_ sender: UIButton) {
       
//        if headingLabel.text == "Reset Password"
//        {
            self.dismiss(animated: false, completion: nil)
            
//        }
//        else
//        {
//
//            self.headingLabel.text = "Reset Password"
//            self.emailTextField.placeholder = "Enter your email-id"
//            self.resetPwd.setTitle("Reset Password", for: .normal)
//
//
//        }
        
        
        
    }
    
    @IBAction func resetPwdAction(_ sender: UIButton) {
        
        if resetPwd.title(for: .normal) == "Reset Password"
        {
            
        }
        else {
           
        }
   
            
        if resetPwd.title(for: .normal) == "Reset Password"
        {
            
            
           
            
            
           
            if emailTextField.text! == ""
            {
                let alert = UIAlertController(title: "FoodWall!", message: "Please enter your Email-id", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    
                })
                self.present(alert, animated: true)
            }
            else
            {
           if isValidEmail(testStr: emailTextField.text!){
                resetPwdCall()
            print("valid")
            }
            else{
                let alert = UIAlertController(title: "FoodWall!", message: "Please enter your registered email-id", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    
                })
                self.present(alert, animated: true)
            }
            
            }
        
            
            resentbutton.isHidden = true
            countDownLabel.isHidden = true
            resendin.isHidden = true
            
        }
        else
        {
            
           
            
            if emailTextField.text! == ""
            {
                let alert = UIAlertController(title: "FoodWall!", message: "Please enter Verification Code", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    
                })
                self.present(alert, animated: true)
            }
            else {
        
            if isValidVerificationcode(value: emailTextField.text!){
                
                let params: [String:String] = ["email" : Utils.getPreferenceValue(ForKey: Constant.EMAIL_FOR_PWD),"verifycode" :emailTextField.text!]
                
                let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_VERIFYCODE)"
                Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
                    let result = response.result
                    let json = JSON(data: response.data!)
                    
                    if json != nil
                    {
                        if json["ResponseMessage"] == "success"
                            
                        {
                            self.reset = "1"
                            self.headingLabel.text = "E-mail Verification"
                            self.emailTextField.tag = 2
                            self.emailTextField.placeholder = "Enter 6-digit code"
                            self.label.text = "Please enter the verification code sent to your registered email"
                          
                            self.resetPwd.setTitle("Submit", for: .normal)
                            
                            let page = self.storyboard?.instantiateViewController(withIdentifier: "password") as! UpdatePasswordController
                            page.k = self.reset
                            page.emailId =  Utils.getPreferenceValue(ForKey: Constant.EMAIL_FOR_PWD)
                            page.verifyCode = self.emailTextField.text!
                            self.present(page, animated: false, completion: nil)
                            self.emailTextField.text = ""
                            
                        }
                            
                        else
                        {
                            self.emailTextField.text = ""
                            let alert = UIAlertController(title: "FoodWall!", message: "Please enter correct verification code", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                                
                            })
                            self.present(alert, animated: true)
                            
                            
                            
                        }
                        
                    }
                    
                }

                print("valid")
            }
         
            else
            {
                let alert = UIAlertController(title: "FoodWall!", message: "Please enter 6 digits verification code", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    
                })
                self.present(alert, animated: true)
                
                
            }
            
            
            }
            
           
        }
        
        
        
        
    }
    
    func resetPwdCall()
    {
       
        let params: [String:String] = ["email" : emailTextField.text!]
        
        Utils.setPreferenceValue(setValue: emailTextField.text!, ForKey: Constant.EMAIL_FOR_PWD)
        
        let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_FORGOT_PASSWORD)"
        
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    self.emailTextField.tag = 2
                    self.headingLabel.text = "E-mail Verification"
                    self.emailTextField.placeholder = "Enter 6-digit code"
                      self.label.text = "Please enter the verification code sent to your registered email"
                    self.resetPwd.setTitle("Submit", for: .normal)
                    self.emailTextField.text = ""
                    
                   
                    
                    self.resendin.isHidden = false
                    self.resentbutton.isHidden = true
                    self.countDownLabel.isHidden = false
                    
                     self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCountDown), userInfo: nil, repeats: true)
                    
                }
                else {
                    let alert = UIAlertController(title: "FoodWall!", message: "Please Enter your registered Email-id", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        
                    })
                    self.present(alert, animated: true)
                }
                
            }
            
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
    
    
 
    
    @objc func updateCountDown() {
        if(countDown > 0) {
            countDownLabel.text = String(countDown)
            countDown = countDown - 1
        } else {
            removeCountDownLable()
        }
    }
    
    private func removeCountDownLable() {
        
        countDown = NUMBER_COUNT_DOWN
        countDownLabel.text = ""
        countDownLabel.removeFromSuperview()
         resentbutton.isHidden = false
         resendin.isHidden = true
        timer?.invalidate()
        timer = nil
    }
    
    
    @IBAction func Resentbutton(_ sender: Any) {
        let params: [String:String] = ["email" : emailTextField.text!]
        
        Utils.setPreferenceValue(setValue: emailTextField.text!, ForKey: Constant.EMAIL_FOR_PWD)
        
        let urlString = "\(Constant.BASEURL)\(Constant.UPDATE_FORGOT_PASSWORD)"
        
        
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            
            if json != nil
            {
                if json["ResponseMessage"] == "success"
                    
                {
                    let alert = UIAlertController(title: "FoodWall!", message: "OTP Resent to your registered mail id", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        
                    })
                    self.present(alert, animated: true)
                    
                }
                else {
                    let alert = UIAlertController(title: "FoodWall!", message: "Somthing Wrong with Server", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                        
                    })
                    self.present(alert, animated: true)
                }
                
            }
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    

}
