//
//  SignInViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 2/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    //variables
    let databaseref = FIRDatabase.database().reference(fromURL: "https://trihealth-d669c.firebaseio.com/")
    //outlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //actions
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    @IBAction func signupButton(_ sender: Any) {
        signup()
    }
    
    //func
    func login()
    {
        
    }
    func signUp()
    {
        
    }
}
