//
//  ContentModel.swift
//  YelpAPIApp
//
//  Created by James Goldston on 9/1/21.
//

import Foundation
import CoreLocation

class contentModel: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    var locationManager = CLLocationManager()
    
    override init() {
        // NSObject init()
        super.init()
        
        // Set ContentModel as delagate for locationManager
        locationManager.delegate = self
        
        // Request permision from the user
        locationManager.requestWhenInUseAuthorization()
        
        
        
    }
    
    //MARK: locationManagerMethods
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // Start geoLocating the User
            locationManager.startUpdatingLocation()
            
        }
        else if locationManager.authorizationStatus == .denied {
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Gives us the location of the user
        
        
        
        
        
        // Stop requesting the location
        locationManager.stopUpdatingLocation()
    }
    
}
