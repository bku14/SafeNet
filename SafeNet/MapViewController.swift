//
//  MapViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 5/5/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    
    fileprivate var locations = [MKPointAnnotation]()
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    var ref = FIRDatabase.database().reference().child("/classes/0001/updates")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listen()
    }
    
    @IBAction func accuracyChanged(_ sender: UISegmentedControl) {
        let accuracyValues = [
            kCLLocationAccuracyBestForNavigation,
            kCLLocationAccuracyBest,
            kCLLocationAccuracyNearestTenMeters,
            kCLLocationAccuracyHundredMeters,
            kCLLocationAccuracyKilometer,
            kCLLocationAccuracyThreeKilometers]
    }
    func listen() {
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                print(child.key)
                print(child.value!)
                
            }
        })
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        // Add another annotation to the map.
        let annotation = MKPointAnnotation()
        annotation.coordinate = mostRecentLocation.coordinate
        
        // Also add to our map so we can remove old values later
        self.locations.append(annotation)
        
        // Remove values if the array is too big
        while locations.count > 100 {
            let annotationToRemove = self.locations.first!
            self.locations.remove(at: 0)
            
            // Also remove from the map
            mapView.removeAnnotation(annotationToRemove)
        }
        
        if UIApplication.shared.applicationState == .active {
            mapView.showAnnotations(self.locations, animated: true)
        } else {
            print("App is backgrounded. New location is %@", mostRecentLocation)
        }
    }
    
}
