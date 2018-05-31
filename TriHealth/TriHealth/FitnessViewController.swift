//
//  FitnessViewController.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 5/1/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FitnessViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //variables
    //firebase referneces
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    //sports in sports selector
    let sportsType = ["Baseball", "Basketball","Cross Country", "Field Hockey", "Frisbee","Ice Hockey", "Lacrosse", "Rock Climbing", "Sailing", "Soccer", "Swimming", "Tennis", "Track & Field", "Water Polo", "Weight Lifting", "Wrestling"]
    
    //outlets
    @IBOutlet weak var saveConfirmation: UILabel!
    @IBOutlet weak var currentSlide: UISlider! //rigor
    @IBOutlet weak var timeHRFitness: UITextField! //hour time text box
    @IBOutlet weak var timeMINFitness: UITextField! //minute time text box
    @IBOutlet var typeFitness: UIPickerView! //fitness type selector
    @IBOutlet var datelabel: UILabel!
    
    //actions
    @IBAction func editingText(_ sender: Any) {
        //sets message label back to empty when textfields are being edited
        saveConfirmation.text = ""
    }
    @IBAction func rewardsButton(_ sender: Any) {
        openRewards() //navigation button to rewards page
    }
    @IBAction func fitnessBackButton(_ sender: Any) {
        openFitness() //navigation button to fitness log
    }
    @IBAction func helpButton(_ sender: Any) {
        openHelp() //navigation button to help page
    }
    @IBAction func saveChangesFitness(_ sender: Any) {
            saveConfirmation.text = ""
            //checks if time entered is valid
            if timeHRFitness.text == "" && timeMINFitness.text == ""{
                saveConfirmation.text = "Please enter a how long you exercised."
            }
            else if Int(timeHRFitness.text!) == nil && timeHRFitness.text != ""{
                saveConfirmation.text = "Please enter a number for time."
            }
            else if Int(timeMINFitness.text!) == nil && timeMINFitness.text != ""{
                saveConfirmation.text = "Please enter a number for time."
            }
            else{
            //date
            // get the current date and time
            let currentDateTime = NSDate()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .none
            let timedate = formatter.string(from: currentDateTime as Date) // October 8, 2016 at 10:48:53 PM
            
            formatter.timeStyle = .none
            formatter.dateStyle = .long
            let timelessdate = formatter.string(from: currentDateTime as Date)
            
            //type
            let type = sportsType[typeFitness.selectedRow(inComponent: 0)]
            //rigor
            var rigor = "" //rigor string stored in firebase
            var rigorval = 1 //rigor value to calculate rewards
            if(currentSlide.value <= 1){
                rigor = "Easy"
                rigorval = 1
            }
            else if(currentSlide.value <= 2){
                rigor = "Medium"
                rigorval = 2
            }
            else{
                rigor = "Hard"
                rigorval = 3
            }
            
            //total time in min
            var time = "0"
            if timeHRFitness.text == "" || timeMINFitness.text == ""{ //if either of the text fields are empty
                if timeHRFitness.text == ""{                           //upload only the entered text field
                    time = String(Int(timeMINFitness.text!)!)}
                if timeMINFitness.text == ""{
                    time = String(Int(timeHRFitness.text!)!*60)
                }
            }
            else{
                time = String((Int(timeHRFitness.text!)!*60) + Int(timeMINFitness.text!)!)
            }
            
            //uid and references
            let uid = Auth.auth().currentUser?.uid
            let userReference = self.databaseref.child("users").child(uid!).child("fitnesslog").child(timelessdate).child(timedate)
            
            //upload time
                let dictPost = ["fitnesstype":type, "rigor":rigor, "time": time]
            userReference.updateChildValues(dictPost, withCompletionBlock: {error, ref in
                if error != nil{
                    return
                }})
            
            //update rewards
            let tval = Int(time)
            let rewards = tval!/20*rigorval
            
            //upload rewards
            databaseref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                if dict["rewards"] != nil{
                    let currrewards = dict["rewards"] as! Int //gets old rewards points to add to current rewards
                    let userRef = self.databaseref.child("users").child(uid!)
                    let newrewards = currrewards + rewards
                    let dictPost2 = ["rewards":newrewards] //uploads new reward points
                    userRef.updateChildValues(dictPost2, withCompletionBlock: {error, ref in
                        if error != nil{
                            return
                        }})
                }
                else{ //if no rewards points uploaded yet, create rewards value
                    let dictPost2 = ["rewards":rewards]
                    let userRef = self.databaseref.child("users").child(uid!)
                    userRef.updateChildValues(dictPost2, withCompletionBlock: {error, ref in
                        if error != nil{
                            return
                        }})
                }
            }})
            //call reset to zero button
            resetButton((Any).self)
            saveConfirmation.text = "Saved. You earned \(rewards) points."
            }
        
    }
    
    //fitness picker set up
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportsType[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportsType.count
    }
    
    //functions
    //on load
    override func viewDidLoad() {
        super.viewDidLoad()
        //display the date
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        let date = formatter.string(from: currentDateTime)
        datelabel.text = date
    }
    //Reset to zero button function
    func resetButton(_ sender: Any) {
        timeMINFitness.text = ""
        timeHRFitness.text = ""
        currentSlide.value = 0
        typeFitness.selectRow(0, inComponent: 0, animated: true)
    }
    //NAVIGATION
    func openFitness()
    {
        //segues to fitness page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let fitnessVC:FitnessLogTableViewController = storyboard.instantiateViewController(withIdentifier: "FitnessLog") as! FitnessLogTableViewController
        self.present(fitnessVC, animated: true, completion: nil)
    }
    //rewards button to rewards page
    func openRewards()
    {
        //segues to rewards page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC:RewardsViewController = storyboard.instantiateViewController(withIdentifier: "rewards") as! RewardsViewController
        self.present(rewardsVC, animated: true, completion: nil)
    }
    func openHelp()
    {
        //segues to help page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let helpVC:HelpViewController = storyboard.instantiateViewController(withIdentifier: "help") as! HelpViewController
        self.present(helpVC, animated: true, completion: nil)
    }

}
