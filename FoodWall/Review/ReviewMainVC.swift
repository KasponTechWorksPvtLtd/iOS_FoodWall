//
//  ReviewMainVC.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 28/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//



import UIKit
import SJSegmentedScrollView

class ReviewMainVC: SJSegmentedViewController,UITabBarDelegate {
    
    var selectedSegment: SJSegmentTab?
    
    
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var bottombar: UITabBar!
    override func viewDidLoad() {
        
       // bottomView.isHidden = false
        
        if let storyboard = self.storyboard {
            
//           // bottomBar.selectedItem = homeButton
//            bottombar.delegate = self
//            bottombar.unselectedItemTintColor = UIColor.gray
//            bottombar.selectedItem?.title = "Home"
            
            let headerController = storyboard
                .instantiateViewController(withIdentifier: "reviewhead")
            
            let FirstVC = storyboard
                .instantiateViewController(withIdentifier: "review")
            FirstVC.title = "DINE IN"
            
            let SecondVC = storyboard
                .instantiateViewController(withIdentifier: "signup")
            SecondVC.title = "DELIVERY"
            
            let ThirdVC = storyboard
                .instantiateViewController(withIdentifier: "signup")
            ThirdVC.title = "CAFE & MORE"
            
            let FOURTHVC = storyboard
                .instantiateViewController(withIdentifier: "signup")
            FOURTHVC.title = "DRINKS"
            
            
            //ThirdVC?.loadViewController = { (index) in
            //self.setSelectedSegmentAt(index, animated: true)
            //}
            
            //let FourthVC = storyboard
            //     .instantiateViewController(withIdentifier: "FourthVC")
            //FourthVC.title = "Fourth"
            
            headerViewController = headerController
            
            segmentControllers = [FirstVC,
                                  SecondVC,ThirdVC,FOURTHVC]
            headerViewHeight = 80.0
            selectedSegmentViewHeight = 5.0
            
            selectedSegment?.backgroundColor = UIColor.black
            segmentTitleColor = .gray
            segmentTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 12)!
            selectedSegmentViewColor = UIColor.black
            segmentShadow = SJShadow.light()
            delegate = self as SJSegmentedViewControllerDelegate
        }
        
        title = "Segment"
        
        
        super.viewDidLoad()
        
        func getSegmentTabWithImage(_ imageName: String) -> UIView {
            
            
            
            let view = UIImageView()
            view.frame.size.width = 100
            view.image = UIImage(named: imageName)
            view.contentMode = .scaleAspectFit
            view.backgroundColor = UIColor.black
            return view
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension ReviewMainVC: SJSegmentedViewControllerDelegate {
    
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.darkGray)
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
//            selectedSegment?.titleColor = UIColor(red: 194.0/255.0, green: 52.0/255.0, blue: 57.0/255.0, alpha: 1)
        }
    }
}
