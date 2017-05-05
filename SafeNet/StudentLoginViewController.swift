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
    var className: String!
    var teacherName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: AnyObject) {
        
        ref = FIRDatabase.database().reference()
        
        let fullNameArr = usernameTextField.text!.characters.split{$0 == " "}.map(String.init)
        let email = ("\(fullNameArr[0])\(fullNameArr[1])@\(teacherCodeTextField.text!).com")
        let password = ("p-\(teacherCodeTextField.text!)")
        
        
        ref.child("classes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.teacherName = value?["teacher"] as! String! ?? ""
            self.className   = value?["name"] as! String! ?? ""
            
            if (value?["\(self.teacherCodeTextField.text!)"]) == nil {
                print("Teacher Code Not Found.")
            } else {
                
                FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
                    if error != nil {
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
                        }
                    } else {
                        
                        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
                            if error != nil {
                                print("Wrong Password ")
                            } else {
                                
                                self.ref.child("classes/\(self.teacherCodeTextField.text!)/students/\(user!.uid)/name/").setValue(self.usernameTextField.text!)
                                self.performSegue(withIdentifier: "showMain", sender: nil)
                                
                            }
                        }
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
            nextVC.previousVC  = "Student"
            nextVC.teacherName = self.teacherName
            nextVC.className   = self.className
        }
    }
}
