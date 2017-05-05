//
//  StudentMainViewController.swift
//  SafeNet
//
//  Created by rrao on 5/5/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class StudentMainViewController: UIViewController {
    
    fileprivate var locations = [MKPointAnnotation]()
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        locationManager.startUpdatingLocation()
        super.viewDidLoad()
    }

}

extension StudentMainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        // Add another annotation to the map.
        let annotation = MKPointAnnotation()
        annotation.coordinate = mostRecentLocation.coordinate
        
        // Also add to our map so we can remove old values later
        self.locations.append(annotation)
        print("Location: ", mostRecentLocation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            self.locations.remove(at: 0)
        }
        
        if UIApplication.shared.applicationState == .active {
        } else {
            print("App is backgrounded. New location is %@", mostRecentLocation)
        }
    }
    
}
