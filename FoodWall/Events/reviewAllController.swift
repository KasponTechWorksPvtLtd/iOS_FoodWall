//
//  reviewAllController.swift
//  nithya
//
//  Created by apple on 7/26/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class reviewAllController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var newTable1: UITableView!
    var a :Int = 1
    var index1 : Int!
    var StringArr : [String] = ["Use this method to set the title for the button. The title you specify derives its formatting from the button’s associated label object. If you set both a title and an attributed title for the button, the button prefers the use of the attributed title over this one.At a minimum, you should set the value for the normal state. If a title is not specified for a state, the default behavior is to use the title associated with the UIControlStateNormal state. If the value for UIControlStateNormal is not set, then the property defaults to a system value."]
    var cellSpacingHeight = 670.0
    override func viewDidLoad() {
        super.viewDidLoad()
        newTable1.delegate = self
        newTable1.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if a == 1
        {
            return 670.0
        }
        else
        {
            if index1 == indexPath.row
            {
                return CGFloat(cellSpacingHeight)
            }
            else
            {
                return 670.0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! reviewCell
        cell.selectionStyle = .none
        cell.reviewLabel.text = StringArr[indexPath.row]
        
        
        if a == 1
        {
            cell.moreLessBtn.setTitle("More", for: .normal)
            cell.reviewLabel.numberOfLines = 2
            cell.reviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.reviewLabel.sizeToFit()
        }
            
        else
        {
            
            
            if index1 == indexPath.row
            {
                
                if cell.moreLessBtn.title(for: .normal) == "More"
                {
                    cell.reviewLabel.numberOfLines = 2
                    cell.reviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.reviewLabel.sizeToFit()
                    /*
                    cell.moreLessBtn.frame = CGRect(x: 365.0,y : cell.reviewLabel.frame.maxY - 10,width : cell.moreLessBtn.frame.size.width,height : cell.moreLessBtn.frame.size.height)
 */
                }
                    
                else
                {
                    cell.reviewLabel.numberOfLines = 0
                    cell.reviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                    cell.reviewLabel.sizeToFit()
                    
                    /*
                    cell.moreLessBtn.frame = CGRect(x: 365.0,y : cell.reviewLabel.frame.maxY - 10,width : cell.moreLessBtn.frame.size.width,height : cell.moreLessBtn.frame.size.height)
 */
                    cell.topDishesView.frame = CGRect(x: 0,y:cell.ratingView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.reviewLabel.frame.maxY + 10)
                    cell.dishesToAvoidView.frame = CGRect(x: 0,y:cell.topDishesView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.dishesToAvoidView.frame.size.height)
                    cell.hotelReview.frame = CGRect(x: 0,y:cell.dishesToAvoidView.frame.maxY + 5,width : cell.hotelReview.frame.size.width,height : cell.hotelReview.frame.size.height)
                    cellSpacingHeight = Double(cell.hotelReview.frame.maxY + 20)
                    
                }
                //cell.moreLessBtn.setTitle("Less", for: .normal)
                //cell.moreLessBtn.setTitle("More", for: .normal)
                
                
            }
            else
            {
                cell.moreLessBtn.setTitle("More", for: .normal)
                //cell.moreLessBtn.setTitle("More", for: .normal)
                cell.reviewLabel.numberOfLines = 2
                cell.reviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.reviewLabel.sizeToFit()
                cell.topDishesView.frame = CGRect(x: 0,y:cell.ratingView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.reviewLabel.frame.maxY + 10)
                cell.dishesToAvoidView.frame = CGRect(x: 0,y:cell.topDishesView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.dishesToAvoidView.frame.size.height)
                cell.hotelReview.frame = CGRect(x: 0,y:cell.dishesToAvoidView.frame.maxY + 5,width : cell.hotelReview.frame.size.width,height : cell.hotelReview.frame.size.height)
                /*
                cell.moreLessBtn.frame = CGRect(x: 365.0,y : cell.reviewLabel.frame.maxY - 10,width : cell.moreLessBtn.frame.size.width,height : cell.moreLessBtn.frame.size.height)
 */
                
            }
        }
         
    
        cell.moreLessBtn.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        cell.moreLessBtn.tag = indexPath.row
        return cell
      
    }
        
        @objc func performAction(sender:UIButton!)
        {
            let cell = newTable1.cellForRow(at: IndexPath(row : sender.tag,section : 0)) as! reviewCell
            
            
            
            index1 = sender.tag
            a = 2
            if cell.moreLessBtn.title(for: .normal) == "More"
            {
                cell.moreLessBtn.setTitle("Less", for: .normal)
                cell.reviewLabel.text = StringArr[sender.tag]
                cell.reviewLabel.numberOfLines = 0
                cell.reviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.reviewLabel.sizeToFit()
               /*
                cell.moreLessBtn.frame = CGRect(x:365.0,y : cell.reviewLabel.frame.maxY - 10 ,width : cell.moreLessBtn.frame.size.width,height : cell.moreLessBtn.frame.size.height)
 */
                //            newTable1.reloadRows(at: [IndexPath(row : sender.tag ,section : 0)], with: .automatic)
                
                cell.topDishesView.frame = CGRect(x: 0,y:cell.ratingView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.reviewLabel.frame.maxY + 10)
                cell.dishesToAvoidView.frame = CGRect(x: 0,y:cell.topDishesView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.dishesToAvoidView.frame.size.height)
                 cell.hotelReview.frame = CGRect(x: 0,y:cell.dishesToAvoidView.frame.maxY + 5,width : cell.hotelReview.frame.size.width,height : cell.hotelReview.frame.size.height)
                cellSpacingHeight = Double(cell.hotelReview.frame.maxY + 20)
                
                newTable1.reloadData()
                
                
                
            }
            else
            {
                cell.moreLessBtn.setTitle("More", for: .normal)
                cell.reviewLabel.text = StringArr[sender.tag]
                cell.reviewLabel.numberOfLines = 2
                cell.reviewLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
                cell.reviewLabel.sizeToFit()
                cell.topDishesView.frame = CGRect(x: 0,y:cell.ratingView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.reviewLabel.frame.maxY + 10)
                cell.dishesToAvoidView.frame = CGRect(x: 0,y:cell.topDishesView.frame.maxY + 5,width : cell.topDishesView.frame.size.width,height : cell.dishesToAvoidView.frame.size.height)
                cell.hotelReview.frame = CGRect(x: 0,y:cell.dishesToAvoidView.frame.maxY + 5,width : cell.hotelReview.frame.size.width,height : cell.hotelReview.frame.size.height)
                //            newTable1.reloadRows(at: [IndexPath(row : sender.tag ,section : 0)], with: .automatic)
                /*
                cell.moreLessBtn.frame = CGRect(x: 365.0,y : cell.reviewLabel.frame.maxY - 10,width : cell.moreLessBtn.frame.size.width,height : cell.moreLessBtn.frame.size.height)
 */
                
                cellSpacingHeight = 670.0
                newTable1.reloadData()
                
                
            }
            
            //        cell.moreLessBtn.frame = CGRect(x:cell.reviewLabel.frame.maxX - 60,y:cell.reviewLabel.frame.maxX - 60,width:cell.moreLessBtn.fr,height:)
            
            
            
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
