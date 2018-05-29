//
//  SignUpViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 3/29/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    //variables
    let databaseref = Database.database().reference()
    
    //outlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet var messageLabel: UILabel!
    
    //actions
    @IBAction func cancel(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC:SignInViewController = storyboard.instantiateViewController(withIdentifier: "signin") as! SignInViewController
        self.present(signUpVC, animated: true, completion: nil)
    }
    @IBAction func signup(_ sender: Any) {
        signUp()
    }
    @IBAction func clearMessage(_ sender: Any) {
        self.messageLabel.text = ""
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func signUp()
    {
        //checks if all fields are filled out
        if email.text == ""{
            self.messageLabel.text = "Please fill out email."
            return
        }
        if password.text == ""{
            self.messageLabel.text = "Please create a password."
            return
        }
        guard let email = email.text else{
            self.messageLabel.text = "Please fill out email."
            return
        }
        guard let password = password.text else{
            self.messageLabel.text = "Please create a password."
            return
        }
        guard let fullname = fullname.text else{
            self.messageLabel.text = "Please enter your name."
            return
        }
        //tries to create user, displays error
        Auth.auth().createUser(withEmail:email, password:password, completion: {(user,error) in
            if error != nil{
                if let errCode = AuthErrorCode(rawValue: error!._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.messageLabel.text = "Email invalid"
                    case .emailAlreadyInUse:
                        self.messageLabel.text = "User already exists with that email"
                    case .weakPassword:
                        self.messageLabel.text = "Password must be at least 6 characters"
                    default:
                        self.messageLabel.text = "Unknown error"
                    }
                }
                return
            }
            guard let uid = user?.uid else{
                return
            }
            let userReference = self.databaseref.child("users").child(uid)
            let values = ["email":email,"name":fullname]
            userReference.updateChildValues(values, withCompletionBlock: {error, ref in
                if error != nil{
                    self.messageLabel.text = error as? String
                    return
                }
                self.dismiss(animated: true, completion: nil)
                self.login() //if successful, logs in
            })
        })
        
    }
    //func
    func login()
    {
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
                return
            }
            self.openProfile()
        })
    }
    func openProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }

}
