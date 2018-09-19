//
//  PreviewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 03/05/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit

class PreviewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    
    
    @IBOutlet weak var previewImage: UIImageView!
    var image1 : UIImage = UIImage(named:"img1")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewImage.image = image1
        headerView.addShadowView()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
      
        
        
        
        
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
