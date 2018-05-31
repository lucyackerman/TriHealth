//
//  SignInViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 2/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignInViewController: UIViewController{
    
    //variables
    let databaseref = Database.database().reference()
    
    //outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet var messageLabel: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.email.text = ""
        self.password.text = ""
        self.messageLabel.text = ""
    }
    
    //actions
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    @IBAction func signupButton(_ sender: Any) {
        signUp()
    }
    
    //functions
    func login()
    {
        if self.email.text == ""{ //checks if email entered
            self.messageLabel.text = "Please fill out email."
            return
        }
        if self.password.text == ""{ //checks if password entered
            self.messageLabel.text = "Please enter a password."
            return
        }
        let email = self.email.text
        let password = self.password.text
        //tries to log in user, displays error
        Auth.auth().signIn(withEmail:email!, password:password!, completion: { (user, error) in
            if error != nil{
                self.messageLabel.text = "Incorrect email or password"
                return
            }
            else{
                //if log in sucessful open profile
                self.openProfile()
            }
        })
    }
    
    //NAVIGATION
    func signUp()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC:SignUpViewController = storyboard.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        self.present(signUpVC, animated: true, completion: nil)
    }
    func openProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            return
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
}
