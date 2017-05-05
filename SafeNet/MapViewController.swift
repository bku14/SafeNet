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
                var a = "\(child.value!)"
                a = a.characters.split{$0 == " "}.map(String.init)[0]
                let length = a.characters.count - 1
                a = a.substring(to: length)
                a = a.substring(from: 1)
                let a1 = a.characters.split{$0 == ","}.map(String.init)[0]
                let a2 = a.characters.split{$0 == ","}.map(String.init)[1]
                let latitude: CLLocationDegrees = Double(a1)!
                let longitude: CLLocationDegrees = Double(a2)!
                let newLocation = CLLocation(latitude: latitude, longitude: longitude)
                

                
                let annotation = MKPointAnnotation()
                annotation.coordinate = newLocation.coordinate
                
                self.locations.append(annotation)
                self.mapView.showAnnotations(self.locations, animated: true)
                
            }
        })
    }
}
