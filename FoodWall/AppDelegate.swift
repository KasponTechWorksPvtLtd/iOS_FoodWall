  //
//  AppDelegate.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 27/03/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import CoreData
import FacebookCore
import FBSDKCoreKit
import GoogleSignIn
import MapKit
import UserNotifications
import Firebase
import Alamofire
import SwiftyJSON
import GooglePlaces
import GoogleMaps
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,MessagingDelegate{
    // CLLocationManagerDelegate
    var window: UIWindow?
    let locManager = CLLocationManager()
    
    var dataArray : NSArray = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UserDefaults.standard.removeObject(forKey: "Controller")
      //  locManager.delegate = self
       // locManager.requestWhenInUseAuthorization()
       // locManager.requestAlwaysAuthorization()
        IQKeyboardManager.sharedManager().enable = true
        GMSServices.provideAPIKey("AIzaSyDTV3YxP-zWn4ss-UD4dTXB4dbzwiNxJqk")
        GMSPlacesClient.provideAPIKey("AIzaSyDTV3YxP-zWn4ss-UD4dTXB4dbzwiNxJqk")
            //GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().clientID = "1032084003703-illnb4180egjafelk1haijgo35ujcm38.apps.googleusercontent.com"
        
       // GIDSignIn.sharedInstance().delegate = self as! GIDSignInDelegate
        
        
        if Utils.getPreferenceValue(ForKey: Constant.isLoggedIn) == "1"
        {
            
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "home") as! ViewController
            self.window?.rootViewController = mainViewController
            self.window?.makeKeyAndVisible()
            //
        
            
        }
            
        else
        {
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "login") as! LoginController
            self.window?.rootViewController = mainViewController
            self.window?.makeKeyAndVisible()
     
        }
        
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().remoteMessageDelegate = self
           // UIApplication.shared.registerForRemoteNotifications()
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()


//    FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
//    SDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        UITabBarItem.appearance()
        .setTitleTextAttributes(
        [NSAttributedStringKey.font: UIFont(name: "Didot", size: 12)!],
        for: .normal)
        // Override point for customization after application launch.
        return  FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {


        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
//    func application(_ app: UIApplication, open url: URL, options: [String : AnyObject] = [:]) -> Bool {
//        return FBSDKApplicationDelegate.sharedInstance().application(app,open: url,sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String,annotation: options [UIApplicationOpenURLOptionsAnnotationKey])
//    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
            Utils.setPreferenceValue(setValue: "\(refreshedToken)", ForKey:Constant.GCM_KEY)
        }
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Working")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    
        
         FBSDKAppEvents.activateApp()
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
             Utils.setPreferenceValue(setValue: "\(refreshedToken)", ForKey:Constant.GCM_KEY)
        }
        else {
         Utils.setPreferenceValue(setValue: "AIzaSyAbZoXA9GJRUWMVhUo48GY3zTrUy4Z6-S0", ForKey:Constant.GCM_KEY)
        }
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "FoodWall")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

