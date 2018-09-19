//
//  MainsearchViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 17/08/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import SJSegmentedScrollView

class MainsearchViewController: SJSegmentedViewController {
    
    var selectedSegment: SJSegmentTab?
    
    
    
    
    
    override func viewDidLoad() {
        
        
        UserDefaults.standard.set("MainsearchViewController", forKey: "Controller")
        
        
       // UserDefaults.standard.string(forKey: "Controller")
        
        
        if let storyboard = self.storyboard {
            
            
            
            
            let headerController = storyboard
                .instantiateViewController(withIdentifier: "MaincommonViewController")
            
           
            
//
//            let FirstVC = storyboard
//                                        .instantiateViewController(withIdentifier: "home")
//
//                                    FirstVC.title = "ALL"
//
//            let SecondVC = storyboard
//                                        .instantiateViewController(withIdentifier: "home")
//                                    SecondVC.title = "PEOPLE"
//
//
//            let ThirdVC = storyboard
//                            .instantiateViewController(withIdentifier: "home")
//                        ThirdVC.title = "FEEDS"
//
//            let FourthVC = storyboard
//                            .instantiateViewController(withIdentifier: "home")
//                        FourthVC.title = "REVIEW"
//
//            let FifthVC = storyboard
//                                        .instantiateViewController(withIdentifier: "home")
//                                   // FirstVC.ab = 2
//                                    FifthVC.title = "EVENTS"
//
//
//                        let SixthVC = storyboard
//                            .instantiateViewController(withIdentifier: "home")
//                        SixthVC.title = "Q&A"
//
            
            let FirstVC = storyboard
                            .instantiateViewController(withIdentifier: "allsearch")

                        FirstVC.title = "ALL"
            
            
            let SecondVC = storyboard
                .instantiateViewController(withIdentifier: "peoplesearchViewController")
            SecondVC.title = "PEOPLE"
            
//            let SecondVC = storyboard
//                            .instantiateViewController(withIdentifier: "FeedsearchViewController")
//                        SecondVC.title = "PEOPLE"
//
            
//            let ThirdVC = storyboard
//                .instantiateViewController(withIdentifier: "FeedsearchViewController")
//            ThirdVC.title = "FEEDS"
            
            let ThirdVC = storyboard
                .instantiateViewController(withIdentifier: "feed")
            ThirdVC.title = "FEEDS"
            
//            let FourthVC = storyboard
//                .instantiateViewController(withIdentifier: "ReviewsearchViewController")
//            FourthVC.title = "REVIEW"

            let FourthVC = storyboard
                .instantiateViewController(withIdentifier: "review")
            FourthVC.title = "REVIEW"

//            let FifthVC = storyboard
//                .instantiateViewController(withIdentifier: "eventsearchViewController")
//            FifthVC.title = "EVENTS"


                        let FifthVC = storyboard
                            .instantiateViewController(withIdentifier: "eventsview")
                       // FirstVC.ab = 2
                        FifthVC.title = "EVENTS"

            
//            let SixthVC = storyboard
//                .instantiateViewController(withIdentifier: "QAsearchViewController")
//            SixthVC.title = "Q&A"
            
            
            
            let SixthVC = storyboard
                            .instantiateViewController(withIdentifier: "foodhelp")
                        SixthVC.title = "Q&A"
           
            //            if(UserDefaults.standard.string(forKey: "strheaduserid")! == ""){
            //
            //                headerViewController = headerController
            //                segmentControllers = [FirstVC]
            //
            //
            //            }
            //            else{
            //
            //                let booleanPaidStatus = UserDefaults.standard.bool(forKey: "strheaduserPaidStatus")
            //
            //                if booleanPaidStatus == true {
            
            headerViewController = headerController
            segmentControllers = [FirstVC,
                                  SecondVC,ThirdVC,FourthVC,FifthVC,SixthVC]
            
            //
            //                }
            //                else{
            //
            //                    headerViewController = headerController
            //                    segmentControllers = [FirstVC]
            //
            //
            //                }
            //            }
            
            
            //ThirdVC?.loadViewController = { (index) in
            //self.setSelectedSegmentAt(index, animated: true)
            //}
            
            //let FourthVC = storyboard
            //     .instantiateViewController(withIdentifier: "FourthVC")
            //FourthVC.title = "Fourth"
            
            headerViewHeight = 80
            selectedSegmentViewHeight = 5.0
            selectedSegment?.backgroundColor = UIColor.black
            segmentTitleColor = .gray
            segmentTitleFont = UIFont(name: "HelveticaNeue-Medium", size: 12)!
            //selectedSegmentViewColor = UIColor.init(colorLiteralRed: 194.0/255.0, green: 52.0/255.0, blue: 57.0/255.0, alpha: 1)
            segmentShadow = SJShadow.light()
            delegate = self
        }
        
        title = "Segment"
        
        
        super.viewDidLoad()
        
        func getSegmentTabWithImage(_ imageName: String) -> UIView {
            
            
            
            let view = UIImageView()
            view.frame.size.width = 100
            view.image = UIImage(named: imageName)
            view.contentMode = .scaleAspectFit
            //  view.backgroundColor = UIColor.init(colorLiteralRed: 194.0/255.0, green: 52.0/255.0, blue: 57.0/255.0, alpha: 1)
            return view
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension MainsearchViewController: SJSegmentedViewControllerDelegate {
    
    
    func didMoveToPage(_ controller: UIViewController, segment: SJSegmentTab?, index: Int) {
        
        
        if selectedSegment != nil {
            selectedSegment?.titleColor(.darkGray)
        }
        
        if segments.count > 0 {
            
            selectedSegment = segments[index]
            selectedSegment?.titleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
           
            // selectedSegment?.titleColor(UIColor.init(colorLiteralRed: 194.0/255.0, green: 52.0/255.0, blue: 57.0/255.0, alpha: 1))
        }
    }
}


