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
    }
    
    //actions
    @IBAction func loginButton(_ sender: Any) {
        login()
    }
    @IBAction func signupButton(_ sender: Any) {
        signUp()
    }
    
    //func
    func login()
    {
        if email.text == ""{
            self.messageLabel.text = "Please fill out email."
            return
        }
        if password.text == ""{
            self.messageLabel.text = "Please enter a password."
            return
        }
        guard let email = email.text else{
            print("email issue")
            return
        }
        guard let password = password.text else{
            print("password issue")
            return
        }
        Auth.auth().signIn(withEmail:email, password:password, completion: { (user, error) in
            if error != nil{
                self.messageLabel.text = "Incorrect email or password"
                self.dismiss(animated:true, completion: nil)
                return
            }
            self.openProfile()
        })
    }
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
