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
    @Published var resturants = [Business]()
    @Published var sights = [Business]()
    
    
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
        
        
        let userLocation = locations.first
        
        if userLocation != nil {
            
            
            
            
            // Stop requesting the location
            locationManager.stopUpdatingLocation()

            // Pass into yelpi-i
            getBuisness(category: constants.artsKey, location: userLocation!)
            getBuisness(category: constants.restaurantsKey, location: userLocation!)
        }
        
        
            }
    
    
    //MARK: Yelp API Methods
    
    func getBuisness(category: String, location: CLLocation) {
        
        //create URL
        var urlComponents = URLComponents(string: constants.apiURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
            
        ]
        
        let url = urlComponents?.url
        
        
        if let url = url {
            
        
            //create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            request.addValue("Bearer \(constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            //create URL session
            let session = URLSession.shared
            
            
            //create URL dataTask
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        DispatchQueue.main.async {
                            
                            switch category{
                            
                            case constants.restaurantsKey:
                                
                                self.resturants = result.businesses
                            
                            case constants.artsKey:
                                
                                self.sights = result.businesses
                                
                            default:
                                break
                            }
                        }
                        
                    }
                    catch {
                        print(error)
                    }
                    
                }
                
            }
            
            dataTask.resume()
            
        }
    }
    
}
