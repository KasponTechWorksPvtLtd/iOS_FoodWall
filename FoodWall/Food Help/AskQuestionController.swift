//
//  AskQuestionController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 25/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AskQuestionController: UIViewController ,UITextViewDelegate,UIScrollViewDelegate{

    @IBOutlet weak var ansView: UIView!
    @IBOutlet weak var quesView: UIView!
    @IBOutlet weak var quesTextView: UITextView!
    @IBOutlet weak var segmentCtrl: UISegmentedControl!
   // @IBOutlet weak var quesTextField: UITextField!
    @IBOutlet weak var answer4: UITextField!
    @IBOutlet weak var answer3: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var point2: UILabel!
    @IBOutlet weak var point1: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    var ans1 : String = ""
    var ans2 : String = ""
    var ans3 : String = ""
    var ans4 : String = ""
    var question : String = ""
    var questionID : String = ""
    
    var answerArr : NSMutableArray = []
    var ques_type : String = ""
    var act : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let progressBar = customProgressView(progressViewStyle: .bar)
//        progressBar.progress = 0.5
//        progressBar.height = 20.0
//        progressBar.frame = CGRect(x: 0,y : 10,width : 200,height : 300)
//        self.navigationItem.titleView = progressBar

        
        ansView.isHidden = true
        scroll.delegate = self
        headerView.addShadowView()
        point1.text = "\u{2022} Keep your questions short and sweet"
        point2.text = "\u{2022} Ask everything that related to foods"
        quesTextView.delegate = self
        quesTextView.text = "Ask your question"
        quesTextView.textColor = UIColor.lightGray
        scroll.contentSize = CGSize(width: self.scroll.frame.size.width , height: self.scroll.frame.size.height)
        
        if act == "0"
        {
            quesTextView.text  = question
            quesTextView.textColor = UIColor.black
            ques_type = "0"
        
        }
        
        else
        {
            if act == "1"
            {
                quesTextView.text = question
                answer1.text = ans1
                answer2.text = ans2
                ques_type = "1"
                ansView.isHidden = false
                
            }
            
            else if act == "2"
            {
                quesTextView.text = question
                answer1.text = ans1
                answer2.text = ans2
                answer3.text = ans3
                ques_type = "1"
                ansView.isHidden = false
            }
            
            else
            {
                quesTextView.text = question
                answer1.text = ans1
                answer2.text = ans2
                answer3.text = ans3
                answer4.text = ans3
                ques_type = "1"
                ansView.isHidden = false
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func quesPollTab(_ sender: UISegmentedControl) {
        
        switch segmentCtrl.selectedSegmentIndex
        {
        case 0:
           ques_type = "0"
            ansView.isHidden = true
        case 1:
            
            ques_type = "1"
            ansView.isHidden = false
            
        default:
            break
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
            
            textView.text = "Ask your question"
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
            textView.text = "Ask your question"
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
        
        
        
        let fixedWidth = quesTextView.frame.size.width
        quesTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = quesTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = quesTextView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        quesTextView.frame = newFrame
        quesView.sizeToFit()
        if newSize.height > 40.0
        {
            quesView.frame = CGRect( x : 0,y:185, width : self.view.frame.size.width ,height : newSize.height + 10)
            
            ansView.frame = CGRect( x : 0,y:quesView.frame.maxY , width : self.view.frame.size.width ,height : self.ansView.frame.size.height)
            
        }
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func create_ques(_ sender: UIButton) {
        
        if ques_type == "1"
        {
            
            if answer1.text == "" && answer2.text == "" && answer3.text == "" && answer4.text == ""
            {
                let alert = UIAlertController(title: "", message: "Give minimum two answers", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                if answer1.text != ""
                {
                    answerArr.add(answer1.text!)
                }
                if answer2.text != ""
                {
                    answerArr.add(answer2.text!)
                }
                if answer3.text != ""
                {
                    answerArr.add(answer3.text!)
                }
                if answer4.text != ""
                {
                    answerArr.add(answer4.text!)
                }
            }
            
           print(answerArr)
            

        }
        
        
        if questionID == ""
        {
            
            questionID = "0"
        }
        
       
        
        
        let params: [String:Any] = ["created_by" :Utils.getPreferenceValue(ForKey: Constant.USER_ID) ,"latitude" :Utils.getPreferenceValue(ForKey: Constant.LATITUDE) ,"longitude" : Utils.getPreferenceValue(ForKey: Constant.LONGITUDE),"questid" : questionID,"ask_question" :quesTextView.text!,"ques_type" :ques_type,"poll" : answerArr]
        
        
        let urlString = "\(Constant.BASEURL)\(Constant.CREATE_QUESTION)"
        Alamofire.request(urlString, method: .post, parameters: params).responseJSON { response in
            let result = response.result
            let json = JSON(data: response.data!)
            if result != nil{
                if   json["ResponseCode"] ==  1
                {
                    
                    let alert = UIAlertController(title: "", message: "Created Successfully", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    self.answer4.text! = ""
                    self.answer1.text! = ""
                    self.answer2.text! = ""
                    self.answer3.text! = ""
                    self.quesTextView.text = ""
                    
                    print("success")
                    // self.dataArray1 = innerDict as! NSArray
                    
                    // self.tableView.reloadData()
                    
                    
                    
                }
                    
                else
                    
                {
                    
                    print("error")
                }
            }
            else
                
            {
                
                print("error")
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
