//
//  StudentMainViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 5/5/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import FirebaseDatabase
import FirebaseAuth

class StudentMainViewController: UIViewController {
    
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var locationEnableButton: UIButton!
    
    var count = 0
    var className: String!
    var teacherName: String!
    var locationEnable = false;
    fileprivate var locations = [MKPointAnnotation]()
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teacherNameLabel.text = "Teacher: \(teacherName!)"
        classNameLabel.text   = "Class: \(className!)"
    }
    
    @IBAction func notifyTeacher(_ sender: AnyObject) {
        
    }
    
    @IBAction func locationDataEnable(_ sender: AnyObject) {
        if locationEnable {
            locationManager.stopUpdatingLocation()
            locationEnableButton.setTitle("Enable Location Data", for: .normal)
            locationEnable = false
        } else {
            locationManager.startUpdatingLocation()
            locationEnableButton.setTitle("Disable Location Data", for: .normal)
            locationEnable = true
        }
    }

}

extension StudentMainViewController: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        
        if FIRAuth.auth()?.currentUser != nil {
            let user = FIRAuth.auth()?.currentUser
            let refRecord = FIRDatabase.database().reference().child("/classes/\(user!.displayName!)/students/\(user!.uid)/location/")
            let refUpdate = FIRDatabase.database().reference().child("/classes/\(user!.displayName!)/updates/")
            refRecord.updateChildValues(["\(count)" : "\(mostRecentLocation)"])
            refUpdate.updateChildValues(["\(user!.uid)" : "\(mostRecentLocation)"])
        }
        
//        print("fadfa" , count)
//        print("fdsafas \(locations)")
//        print("Location: ", mostRecentLocation)
        
        count += 1
        
        // Remove values if the array is too big
        while locations.count > 100 {
            self.locations.remove(at: 0)
        }
        
        if UIApplication.shared.applicationState == .active {
        } else {
            if FIRAuth.auth()?.currentUser != nil {
                let user = FIRAuth.auth()?.currentUser
                let refRecord = FIRDatabase.database().reference().child("/classes/\(user!.displayName!)/students/\(user!.uid)/location/")
                let refUpdate = FIRDatabase.database().reference().child("/classes/\(user!.displayName!)/updates/")
                refRecord.updateChildValues(["\(count)" : "\(mostRecentLocation)"])
                refUpdate.updateChildValues(["\(user!.uid)" : "\(mostRecentLocation)"])
            }
            print("App is backgrounded. New location is %@", mostRecentLocation)
        }
    }
    
}
