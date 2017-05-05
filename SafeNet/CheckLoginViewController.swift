//
//  CheckLoginViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 4/6/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CheckLoginViewController: UIViewController {
    
    var previousVC = "None"
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkUser()
    }
    
    func checkUser() {
        
        ref = FIRDatabase.database().reference()
        
        if FIRAuth.auth()?.currentUser != nil {
            let user = FIRAuth.auth()?.currentUser
            if let user = user {
                
                ref.child("teachers").observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    let value = snapshot.value as? NSDictionary
                    let email = user.email?.substring(to: (user.email?.characters.count)! - 4)
                    
                    if (value?["\(email!)"]) == nil {
                        self.previousVC = "Student"
                    } else {
                        self.previousVC = "Teacher"
                    }
                    
                    if FIRAuth.auth()?.currentUser != nil && self.previousVC == "Teacher" {
                        self.performSegue(withIdentifier: "teacherMain", sender: nil)
                    } else if FIRAuth.auth()?.currentUser != nil && self.previousVC == "Student" {
                        self.performSegue(withIdentifier: "studentMain", sender: nil)
                    } else {
                        self.performSegue(withIdentifier: "login", sender: nil)
                    }
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
                
                
            }
        }
    }
}
