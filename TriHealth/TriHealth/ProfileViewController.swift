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
    
    @IBOutlet weak var weightText: UILabel!
    @IBOutlet weak var HydrationButton: UIButton!
    /*@IBAction func weightButton(_ sender: Any) {
        if weightText.text != ""
        {
            performSegue(withIdentifier: "HydrationButton", sender: <#T##Any?#>)
        }
    }*/
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let weightData =  segue.destination as! HydrationPageViewController
//        weightData.userWeight = weightText.text!
//    }


    //variables
    var cupMeasure = 0
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    
    //outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
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
                {
                    self.weightLabel.text = userWeight
                }
            }})
        }
    }
    func logout(){
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "signin")
        present(loginViewController, animated: true, completion: nil)
    }
}
