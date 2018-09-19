//
//  bottomViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 29/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class bottomViewController: UIViewController,UITabBarDelegate {
    
    
    @IBOutlet var bottomBar: UITabBar!
    
    @IBOutlet var menuBarItem: UITabBarItem!
    @IBOutlet var notificationsButton: UITabBarItem!
    @IBOutlet var foodHelpButton: UITabBarItem!
    @IBOutlet var reviewButton: UITabBarItem!
    @IBOutlet var homeButton: UITabBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.selectedItem = reviewButton
        bottomBar.delegate = self
        bottomBar.unselectedItemTintColor = UIColor.gray
        bottomBar.selectedItem?.badgeColor = UIColor.orange
        bottomBar.selectedItem?.title = "Review"
        bottomBar.isHidden = false

        // Do any additional setup after loading the view.
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        if(bottomBar.selectedItem == homeButton){
            //            print("Segue Buzz")
            
            let page:ViewController = self.storyboard?.instantiateViewController(withIdentifier: "home") as! ViewController
            self.present(page, animated: true, completion: nil)
            
        }
        
        if(bottomBar.selectedItem == foodHelpButton){
            //            self.performSegue(withIdentifier: "hiveTasks", sender: self)
            
            let page:FoodHelpController = self.storyboard?.instantiateViewController(withIdentifier: "foodhelp") as! FoodHelpController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == notificationsButton){
            
            
            let page:NotificationsViewController = self.storyboard?.instantiateViewController(withIdentifier: "notifications") as! NotificationsViewController
            self.present(page, animated: true, completion: nil)
        }
        
        if(bottomBar.selectedItem == menuBarItem){
            
            
            let page:MenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuview") as! MenuViewController
            self.present(page, animated: true, completion: nil)
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
