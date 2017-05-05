//
//  CheckLoginViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 4/6/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import FirebaseAuth

class CheckLoginViewController: UIViewController {
    
    var previousVC = "None"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil && previousVC == "Teacher" {
            performSegue(withIdentifier: "teacherMain", sender: nil)
        } else if previousVC == "Student" {
            performSegue(withIdentifier: "studentMain", sender: nil)
        } else {
            performSegue(withIdentifier: "login", sender: nil)
        }
    }
}
