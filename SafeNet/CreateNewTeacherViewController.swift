//
//  CreateNewTeacherViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 4/18/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateNewTeacherViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        let name = "\(firstNameTextField.text!) \(lastNameTextField.text!)"
        let email = emailTextField.text!.substring(to: emailTextField.text!.characters.count - 4)
        
        ref = FIRDatabase.database().reference()
        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error)
            } else {
                
                self.ref.child("teachers/\(email)").setValue(["name" : "\(name)"])
                
                FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    if error != nil {
                        print("Wrong Password")
                    } else {
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
            nextVC.previousVC = "Teacher"
        }
    }
}
