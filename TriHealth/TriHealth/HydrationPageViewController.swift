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
    @IBOutlet var waterlabel: UILabel!
    @IBOutlet var datelabel: UILabel!
    
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
        //lastValue = Int(sender.value)
        let newtotal = tempcups*self.cupsval
        self.dailytotal.text = "\(newtotal) oz"
        saveTotal(value: String(newtotal))
    }
    @IBAction func backToProfile(_ sender: Any) {
        openProfile()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //display the date
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let date = formatter.string(from: currentDateTime)
        datelabel.text = date
    
        //gets the daily goal and daily total from firebase and displayes
        databaseref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot)
            in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                //displays daily goal
                self.dailygoal.text = "\((dict["goal"] as? String)!) oz"

                //calculates and displays amount of water per cup
                self.cupsval = Int((dict["goal"] as? String)!)!/10
                self.waterlabel.text = "ADD WATER (\(self.cupsval) oz per cup)"
                
                //takes last saved date and compares to todays date
                let lastsaved = dict["lastsaved"] as? String
                if (lastsaved == date){
                    //displays daily goal and ounces drank
                    self.dailytotal.text = "\((dict["dailytotal"] as? String)!) oz"
                    //sets lastvalue to the amount of cups drank
                    let dailytotal = Int((dict["dailytotal"] as? String)!)!
                    self.numCupsLoads = dailytotal/self.cupsval
                }
                else{
                    self.saveTotal(value: "0")
                    //displays daily goal and ounces drank
                    self.dailytotal.text = "\(0) oz"
                    //sets lastvalue to the amount of cups drank
                    let dailytotal = 0
                    self.numCupsLoads = dailytotal/self.cupsval
                }
                //set minimum to previous amount of cups
                self.waterStepper.minimumValue = Double(-(self.numCupsLoads))
                
                //loads cups already drank today
                let glassArray: [UIImageView] = [self.glass1, self.glass2, self.glass3, self.glass4, self.glass5, self.glass6, self.glass7, self.glass8, self.glass9, self.glass10]
                let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                print(self.numCupsLoads)
                for i in numbers {
                    if (i < self.numCupsLoads)
                    {
                        glassArray[i].isHidden = false;
                    }
                    else{
                        glassArray[i].isHidden = true
                    }
                }
            }})
        //saves date to firebase
        saveDate(value: String(date))
    }
    func saveTotal(value: String){
        //saves how much water to dailytotal on firebase
        let uid = Auth.auth().currentUser?.uid
        let userReference = self.databaseref.child("users").child(uid!)
        let values = ["dailytotal":value]
        userReference.updateChildValues(values, withCompletionBlock: {error, ref in
            if error != nil{
                return
            }})
    }
    func saveDate(value: String){
        //saves todays date
        let uid = Auth.auth().currentUser?.uid
        let userReference = self.databaseref.child("users").child(uid!)
        let values2 = ["lastsaved":value]
        userReference.updateChildValues(values2, withCompletionBlock: {error, ref in
            if error != nil{
                return
            }})
    }
    func openProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }
}

    




