//
//  AddNewClassViewController.swift
//  SafeNet
//
//  Created by Bryan Ku on 5/5/17.
//  Copyright © 2017 SafeNet. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddNewClassViewController: UIViewController {
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var classCodeTextField: UITextField!
    
    var ref: FIRDatabaseReference!
    
    @IBAction func create(sender: AnyObject) {
        
        ref = FIRDatabase.database().reference()
        
        if let user = FIRAuth.auth()?.currentUser {
            self.ref.child("classes/\(classCodeTextField.text!)/teacher").setValue(user.displayName!)
            self.ref.child("classes/\(classCodeTextField.text!)/name").setValue(classNameTextField.text!)
        }
        
    }
}
