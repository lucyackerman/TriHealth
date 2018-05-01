//
//  HydrationPageViewController.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 3/14/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class HydrationPageViewController: UIViewController {

    //variables
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var lastValue: Int = 0
    @IBOutlet var waterStepper: UIStepper!
    @IBOutlet weak var waterNeeded: UILabel!
    var weightSet = String()
    
    @IBOutlet var glass1: UIImageView!
    @IBOutlet var glass2: UIImageView!
    @IBOutlet var glass3: UIImageView!
    @IBOutlet var glass4: UIImageView!
    @IBOutlet var glass5: UIImageView!
    @IBOutlet var glass6: UIImageView!
    @IBOutlet var glass7: UIImageView!
    @IBOutlet var glass8: UIImageView!
    @IBOutlet var glass9: UIImageView!
    @IBOutlet var glass10: UIImageView!
    @IBOutlet var dailygoal: UILabel!
    @IBOutlet var dailytotal: UILabel!

    
    //actions
    @IBAction func waterAddStp(_ sender: UIStepper) {
        let glassArray: [UIImageView] = [glass1, glass2, glass3, glass4, glass5, glass6, glass7, glass8, glass9, glass10]
        let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        if (Int(sender.value)>lastValue)
        {
            for i in numbers {
                if (i < Int(sender.value))
                {
                    glassArray[i].isHidden = false;
                }
            }
        } else {
            glassArray[Int(sender.value)].isHidden = true;
        }
        lastValue = Int(sender.value)
    }
    @IBAction func backToProfile(_ sender: Any) {
        openProfile()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot)
            in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                //displays daily goal and ounces drank
                self.dailytotal.text = "\((dict["dailytotal"] as? String)!) oz"
                self.dailygoal.text = "\((dict["goal"] as? String)!) oz"
                let tempval = dict["dailytotal"] as? String
                self.lastValue = Int(tempval!)!
            }})
        let ouncesNeeded = Int(weightSet)
        if(ouncesNeeded != nil){
            waterNeeded.text = String(ouncesNeeded!/10)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func openProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }
    
}

    




