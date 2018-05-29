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
    var cupsval: Double = 0.0
    var numCupsLoads: Int = 0
    var goal: Double = 0.0
    var reachedGoal: Bool = false
    
    //outlets
    @IBOutlet var waterStepper: UIStepper!
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
    @IBOutlet var messageLabel: UILabel!
    
    //actions
    //increases water with stepper
    @IBAction func waterAddStp(_ sender: UIStepper) {
            let glassArray: [UIImageView] = [glass1, glass2, glass3, glass4, glass5, glass6, glass7, glass8, glass9, glass10]
            let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
            let tempcups = self.numCupsLoads + Int(sender.value)
            for i in numbers {
                    if (i < tempcups)
                    {
                        glassArray[i].isHidden = false;
                    }
                    else {
                        glassArray[i].isHidden = true;
                    }
            }
            let newtotal = Double(tempcups)*self.cupsval
            //check if newtotal is daily goal
            if newtotal == self.goal
            {
                messageLabel.text = "You met your goal!"
                self.reachedGoal = true
            }
            else{
                messageLabel.text = ""
                self.reachedGoal = false
            }
            self.dailytotal.text = "\(newtotal) oz"
            saveTotal(value: String(newtotal))
    }
    //navigation buttons
    @IBAction func backToProfile(_ sender: Any) {
        openProfile()
    }
    @IBAction func rewards(_ sender: Any) {
        openRewards()
    }

    @IBAction func logButton(_ sender: Any) {
        openLog()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()

        //date
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let date = formatter.string(from: currentDateTime)
        datelabel.text = date //display date
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let hdate = formatter.string(from: currentDateTime) //date in hydration format
    
        //gets the daily goal and daily total from user data on firebase and displayes
        databaseref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                self.dailygoal.text = "\((dict["goal"] as? String)!) oz" //displays daily goal
                self.goal = Double((dict["goal"] as? String)!)!
                self.cupsval = Double((dict["goal"] as? String)!)!/10.0 //calculates and displays amount of water per cup
                self.waterlabel.text = "ADD WATER (\(self.cupsval) oz per cup)"
            }})
        //gets the saved water from hydration log on firebase and displays
        databaseref.child("users").child(uid!).child("hydrationlog").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict2 = snapshot.value as? [String: AnyObject]
            {
                if (snapshot.hasChild(hdate)){ //if already loaded water that day... load the saved water
                    self.dailytotal.text = "\((dict2[hdate])!) oz"
                    let dt = Double(dict2[hdate] as! String)!
                    self.numCupsLoads = Int(dt/self.cupsval)
                }
                else{ //if not updated water yet today... start at 0 
                    self.saveTotal(value: "0") //displays daily goal and ounces drank
                    self.dailytotal.text = "\(0) oz" //sets lastvalue to the amount of cups drank
                    let dailytotal = 0.0
                    self.numCupsLoads = Int(dailytotal/self.cupsval)
                }
                self.waterStepper.minimumValue = Double(-(self.numCupsLoads))//set minimum to previous amount of cups
                
                if Double(self.numCupsLoads)*self.cupsval == self.goal
                {
                    self.reachedGoal = true
                }
                else
                {
                    self.reachedGoal = false
                }
                //loads cups already drank today
                let glassArray: [UIImageView] = [self.glass1, self.glass2, self.glass3, self.glass4, self.glass5, self.glass6, self.glass7, self.glass8, self.glass9, self.glass10]
                let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
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
    }
    func saveTotal(value: String){
        //get date
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let date = formatter.string(from: currentDateTime)
        
        //sets up uid reference to firebase
        let uid = Auth.auth().currentUser?.uid
        let userReference = self.databaseref.child("users").child(uid!).child("hydrationlog")
        
        //gets last saved water value from firebase
        var lastval = ""
        userReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                if (snapshot.hasChild(date)){
                    lastval = dict[date] as! String
                }
                if lastval == "" { //if no value saved yet, increase rewards
                    self.updateRewards(value: 1.0)
                    self.messageLabel.text = "+1 reward point."
                }
                else{
                    //checks difference in new water total and last water total
                    if Double(lastval)! > Double(value)! {
                        self.updateRewards(value: -1.0) //if decreased cups, lose reward
                        if !self.reachedGoal{
                            self.messageLabel.text = "-1 reward point."
                        }
                    }
                    else {
                        self.updateRewards(value: 1.0) //if increased cups, add reward
                        if !self.reachedGoal{
                            self.messageLabel.text = "+1 reward point."
                        }
                    }
                }
            }})
        
        //update the water total
        let values = [date:value]
        userReference.updateChildValues(values, withCompletionBlock: {error, ref in
            if error != nil{
                return
            }})
    }
    func updateRewards(value: Double)
    {
        //save rewards
        let uid = Auth.auth().currentUser?.uid
        let userReference = self.databaseref.child("users").child(uid!)
        userReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let newRewards = dict["rewards"] as! Int + Int(value) //add or subtract from rewards value
                let values2 = ["rewards":newRewards]
                //save to firebase
                userReference.updateChildValues(values2, withCompletionBlock: {error, ref in
                    if error != nil{
                        return
                    }})
            }
        })
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
    
    //NAVIGATION
    func openProfile()
    {
        //segues to profile page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }
    func openRewards()
    {
        //segues to rewards page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC:RewardsViewController = storyboard.instantiateViewController(withIdentifier: "rewards") as! RewardsViewController
        self.present(rewardsVC, animated: true, completion: nil)
    }
    func openLog()
    {
        //segues to log
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let logVC:HydrationLogTableViewController = storyboard.instantiateViewController(withIdentifier: "hydrationLog") as! HydrationLogTableViewController
        self.present(logVC, animated: true, completion: nil)
    }
    
}

    




