//
//  Utils.swift
//  Office Manager
//
//  Created by Ramesh P on 24/04/17.
//  Copyright © 2017 Ramesh P. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SystemConfiguration
import SVProgressHUD

struct Utils {
    
    
   static func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    
    
    
    //NSUserDefault
    static func setPreferenceValue(setValue value : String, ForKey key: String) {
        
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
    }
    
    static func getPreferenceValue(ForKey key: String) -> String {
        
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: key as String) {
            return name;
        }
        return "";
    }
    
    static func getPreferenceBoolValue(ForKey key:String) -> Bool {
        
        let defaults = UserDefaults.standard
        let isBool = defaults.bool(forKey: key as String)
        return isBool;
        
    }
    
    static func setPreferenceBoolValue(value: Bool, ForKey key:String) {
        
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key as String)
    }
    
    static func removePreferenceValue (ForKey key:String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key as String)
        
    }
    
    static func svprogressHudShow(title:String,view:UIViewController) -> Void
        
    {
        
        SVProgressHUD.show(withStatus: title);
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        view.view.isUserInteractionEnabled = false;
        
    }
    
    static func svprogressHudDismiss(view:UIViewController) -> Void
        
    {
        
        SVProgressHUD.dismiss();
        
        view.view.isUserInteractionEnabled = true;
        
    }
    

    
    
    static func presentMenu(viewController1 : UIViewController) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let viewController = storyboard.instantiateViewController(withIdentifier :"login") as! LoginController
    
    let transition = CATransition()
    
    transition.duration = 0.5
    
    transition.type = kCATransitionPush
    
    transition.subtype = kCATransitionFromTop
    
    viewController1.view.window!.layer.add(transition, forKey: kCATransition)
    
    viewController1.present(viewController, animated: false)
        
        
        
        
    }
    
    
    

    
    //NSUserDefault
    
    static func isReachable()->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
    //Document Directory
    static func createDirectoryDocument(folderName:String)
    {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: NSString = paths[0] as NSString
        let dataPath = documentsDirectory.appendingPathComponent("\(folderName)")
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
    
    
    static func returnDocumentPath()->String
    {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    static func searchPath(path:String)->Bool
    {
        print(path)
        if((path as NSString).length == 0 )
        {
            print("Empty path")
            return false
        }
        
        let documentsURL = try! FileManager().url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        let fooURL = try! documentsURL.appendingPathComponent("\(path)")
        let fileExists = FileManager().fileExists(atPath:fooURL.path)
        print(fileExists)
        if(fileExists)
        {
            print("File exists")
            return true
        }
        else
        {
            print("File does not exist")
            return false
        }
    }
    
    //Document Directory
    
    //Time stamp
    
    static func getTimeStamp()->String
    {
        let intValue:Int64 = Int64(NSDate().timeIntervalSince1970 * 1000)
        return "\(intValue)"
    }
    
    //Add Gradient
    static func addGradientBackgroundLayer(_ sender:AnyObject) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
        //let colorTop: AnyObject = UIColor(red: 24.0/255.0, green: 107.0/255.0, blue: 152.0/255.0, alpha: 1.0).CGColor
        let colorTop: AnyObject = UIColor(red: 22.0/255.0, green: 150.0/255.0, blue: 152.0/255.0, alpha: 1.0).cgColor
        let colorBottom: AnyObject = UIColor(red: 88.0/255.0, green: 218.0/255.0, blue: 239.0/255.0, alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        
        gradientLayer.locations = [0.0, 1.0]
        sender.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func makeShadowAndBorder(_ sender:AnyObject)
    {
        //        sender.layer.borderWidth = 0.5
        //        sender.layer.borderColor = UIColor.gray.cgColor
        sender.layer.shadowColor = UIColor.black.cgColor
        sender.layer.shadowOffset = CGSize(width: 5, height: 5)
        sender.layer.shadowRadius = 5
        sender.layer.shadowOpacity = 0.7
    }
    
}
