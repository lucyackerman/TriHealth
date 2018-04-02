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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let HydrationPageViewController = segue.destination as! HydrationPageViewController
        HydrationPageViewController.weightSet = weight.text!
    }
    
    //variables
    var cupMeasure = 0
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    
    //outlets
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBAction func HydrationButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToHydrationSegue", sender: self)
    }
    
    @IBAction func setWeightButton(_ sender: Any) {
        if weight.text != ""
        {
            performSegue(withIdentifier: "ToHydrationSegue", sender: self)
        }
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
            }})
        }
    }
    func logout(){
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        print("LOGGED OUT")
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "signin")
        present(loginViewController, animated: true, completion: nil)
    }
}
