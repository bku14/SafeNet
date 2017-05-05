//
//  TeacherLoginViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 4/17/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TeacherLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        ref = FIRDatabase.database().reference()
        
        ref.child("teachers").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let email = self.emailTextField.text!.substring(to: self.emailTextField.text!.characters.count - 4)
            
            if (value?["\(email)"]) == nil {
                print("Teacher Account Not Found.")
            } else {
                FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    if error != nil {
                        print("Wrong Password ")
                    }
                    else {
                        print("Login Successfully :)")
                        self.performSegue(withIdentifier: "showMain", sender: nil)
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMain" {
            let nextVC = segue.destination as! CheckLoginViewController
            nextVC.previousVC = "teacher"
        }
    }
}
