//
//  StudentLoginViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 4/18/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class StudentLoginViewController: UIViewController {
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var teacherCodeTextField: UITextField!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        ref = FIRDatabase.database().reference()
        let email = ("\(usernameTextField.text!)@\(teacherCodeTextField.text!).com")
        let password = ("p-\(teacherCodeTextField.text!)")
            
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            if let errCode = FIRAuthErrorCode(rawValue: error!._code) {
                
                switch errCode {
                    case .errorCodeEmailAlreadyInUse:
                        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                print("Wrong Password ")
                            }
                            else {
                                print("Login Successfully :)")
                                self.performSegue(withIdentifier: "showMain", sender: nil)
                            }
                        }
                    default:
                        print("Create User Error: \(error)")
                }
            } else {
                FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                    if error != nil {
                        print("Wrong Password ")
                    }
                    else {
                        print("Login Successfully :)")
                        self.performSegue(withIdentifier: "showMain", sender: nil)
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMain" {
            let nextVC = segue.destination as! CheckLoginViewController
            nextVC.previousVC = "Student"
        }
    }
}
