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
    
    //variables
    var cupMeasure = 0
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    
    //outlets
    @IBOutlet var errorMessage: UILabel!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var email: UILabel!

    //actions
    @IBAction func hydrationButton(_ sender: Any) {
        if(weight.text != "")//checks that user has a weight
        {
            openHydration() //segues to hydration page
        }
        else{ errorMessage.text = "Please add a weight to your profile."}
    }
    
    @IBAction func fitnessButton(_ sender: Any) {
        openFitness() //segues to fitness page
    }
    
    @IBAction func saveChangesButton(_ sender: Any) {
        if weight.text != ""
        {
            let uid = Auth.auth().currentUser?.uid
            let userReference = self.databaseref.child("users").child(uid!)
            let goal = String(Int(weight.text!)!*2/3)
            let values = ["weight":weight.text]
            errorMessage.text = "Weight Saved."
            userReference.updateChildValues(values, withCompletionBlock: {error, ref in
                if error != nil{
                    return
                }})
            let values2 = ["goal":goal]
            userReference.updateChildValues(values2, withCompletionBlock: {error, ref in
                if error != nil{
                    return
                }})
            let values3 = ["dailytotal":String(0)]
            userReference.updateChildValues(values3, withCompletionBlock: {error, ref in
                if error != nil{
                    return
                }})
        }
    }
    @IBAction func logout(_ sender: Any) {
        logout()
    }
    
    //functions
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
                self.usernameLabel.text = dict["name"] as? String
                if dict["weight"] as? String != nil{
                    self.weight.text = dict["weight"] as? String
                }
            }})
        }
    }
    func logout(){
        do{
            try Auth.auth().signOut() //logs out user
        }catch{
            print("error logging out")
        }
        
        //segues to sign in screen
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "signin")
        present(loginViewController, animated: true, completion: nil)
    }
    func openHydration()
    {
        //segues to hydration page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let hydrationVC:HydrationPageViewController = storyboard.instantiateViewController(withIdentifier: "hydration") as! HydrationPageViewController
        self.present(hydrationVC, animated: true, completion: nil)
    }
    
    func openFitness()
    {
        //segues to hydration page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let fitnessVC:FitnessViewController = storyboard.instantiateViewController(withIdentifier: "Fitness") as! FitnessViewController
        self.present(fitnessVC, animated: true, completion: nil)
    }
}
