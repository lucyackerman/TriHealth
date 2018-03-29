//
//  ProfileViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 2/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var textFieldTest: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as! RecVC
        if case let text != nil{
            receiverVC.text = textFieldTest.text!
        }
    }
    
    //variables
    var cupMeasure = 0
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    
    //outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var HydrationButton: UIButton!
    @IBOutlet weak var weightField: UITextField!
    @IBAction func setWeight(_ sender: Any) {
        
    }
    
    //actions
    @IBAction func logout(_ sender: Any) {
        logout()
    }
    
    //functions
    /*func waterWeight(weightInput: Int) -> Int{
        cupMeasure = (weightInput/20)
        
        return cupMeasure
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        logout()
        let uid = Auth.auth().currentUser?.uid
        if uid == nil{
            self.logout()
        }
        else{
            databaseref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot)
            in
                if let dict = snapshot.value as? [String: AnyObject]
            {
                self.email.text = dict["email"] as? String
                self.usernameLabel.text = dict["username"] as? String
                if let userWeight = dict["weight"] as? String
//                {
//                    self.weightLabel.text = userWeight
//                }
            }})
        }
    }
    func logout(){
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "signin")
        present(loginViewController, animated: true, completion: nil)
    }
}
