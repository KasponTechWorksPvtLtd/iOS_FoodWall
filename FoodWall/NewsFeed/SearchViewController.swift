//
//  SearchViewController.swift
//  FoodWall
//
//  Created by Ramesh Ponnuvel on 14/07/18.
//  Copyright © 2018 Ramesh Ponnuvel. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

 //let locManager = CLLocationManager()

class SearchViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate{

    
        
        @IBOutlet weak var mapView: GMSMapView!
    
        var activeField : UITextField?
        var currentLocation = CLLocation()
        var search = 0
        let markerSource = GMSMarker()
        var searchController: UISearchController?
        
        override func viewDidLoad() {
            super.viewDidLoad()
          
            locManager.delegate = self
          
//            let autocompleteController = GMSAutocompleteViewController()
//            autocompleteController.delegate = self
//
//            present(autocompleteController, animated: true, completion: nil)
            mapView.isMyLocationEnabled = true
            mapView.delegate = self
            locManager.requestWhenInUseAuthorization()
            locManager.requestAlwaysAuthorization()
            locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locManager.requestAlwaysAuthorization()
            locManager.startUpdatingLocation()
            findCoordinates()
            //        findGeocode()
            
            //  callCamera()
        }
        
    
        
        @IBAction func btnAction(_ sender: UIButton) {
            
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            
            present(autocompleteController, animated: true, completion: nil)
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            
            //activeField?.text = place.name
            
            //Utils.setPreferenceValue(setValue: (place.name), ForKey: Constant.SEARCH_LOCATION)
            dismiss(animated: true, completion: nil)
            //locManager.startUpdatingLocation()
            let page = self.storyboard?.instantiateViewController(withIdentifier: "timeline") as! TimelineDetailViewController
            page.b = 3
            page.searchLocation = place.name
            self.present(page, animated: false, completion: nil)
            search = 1
            
            
            
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }
        
        
        
        
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            dismiss(animated: true, completion: nil)
        }
        
        
        
        func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
        func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
            let views = viewController.view.subviews
            let subviewsOfSubview = views.first!.subviews
            let subOfNavTransitionView = subviewsOfSubview[1].subviews
            let subOfContentView = subOfNavTransitionView[2].subviews
            let searchBar = subOfContentView[0] as! UISearchBar
            if search == 1{
                searchBar.text = activeField?.text
                search = 0
            }
            
            
        }
        
        
      
        //
        func findCoordinates()
        {
            
            if(CLLocationManager.locationServicesEnabled())
            {
                print("3")
                // let location = CLLocation()
                //            location.delegate = self
                //            location.requestLocation()
                
                //            location.desiredAccuracy = kCLLocationAccuracyBest
                //            location.startUpdatingLocation()
                //            map.showsUserLocation = true
                //            map.delegate = self
                
                
                if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
                    
                    CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorized){
                    
                    print("2")
                    if locManager.location != nil{
                        print("1")
                        currentLocation = locManager.location!
                        print(currentLocation.coordinate)
                        print(currentLocation.coordinate.latitude)
                        print(currentLocation.coordinate.longitude)
                        // findGeocode()
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last
            
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
            
            self.mapView?.animate(to: camera)
            locManager.stopUpdatingLocation()
            
            //  self.locationManager.stopUpdatingLocation()
            
}
}
