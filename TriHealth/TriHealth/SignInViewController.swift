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
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
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
                print(error!)
                return
            }
            self.dismiss(animated:true, completion: nil)
        })
    }
    func signUp()
    {
        guard let username = username.text else{
            print("username issue")
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
        Auth.auth().createUser(withEmail:email, password:password, completion: {(user,error) in
            if error != nil{
                print(error!)
                return
            }
            guard let uid = user?.uid else{
                return
            }
            let userReference = self.databaseref.child("users").child(uid)
            let values = ["username":username, "email":email]
            
            userReference.updateChildValues(values, withCompletionBlock: {error, ref in
                if error != nil{
                    print(error!)
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
        })
        
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
