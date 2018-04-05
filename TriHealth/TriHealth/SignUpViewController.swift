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
    
    @IBAction func cancel(_ sender: Any) {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC:SignInViewController = storyboard.instantiateViewController(withIdentifier: "signin") as! SignInViewController
        self.present(signUpVC, animated: true, completion: nil)
    }
    //actions
    @IBAction func signup(_ sender: Any) {
        signUp()
    }
    
    //func
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func signUp()
    {
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
        Auth.auth().createUser(withEmail:email, password:password, completion: {(user,error) in
            if error != nil{
                self.messageLabel.text = "User already exists with that email"
                return
            }
            guard let uid = user?.uid else{
                return
            }
            let userReference = self.databaseref.child("users").child(uid)
            let values = ["email":email]
            
            userReference.updateChildValues(values, withCompletionBlock: {error, ref in
                if error != nil{
                    self.messageLabel.text = error as? String
                    return
                }
                self.dismiss(animated: true, completion: nil)
                self.login()
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
