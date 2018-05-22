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
    
    //Message label
    @IBOutlet weak var saveConfirmation: UILabel!
    
    //Back Button
    @IBAction func fitnessBackButton(_ sender: Any) {
        openProfile()
    }
    
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    let sportsType = ["Baseball", "Basketball","Cross Country", "Field Hockey", "Frisbee","Ice Hockey", "Lacrosse", "Rock Climbing", "Sailing", "Soccer", "Swimming", "Tennis", "Track & Field", "Water Polo", "Weight Lifting", "Wrestling"]
    
    @IBAction func saveChangesFitness(_ sender: Any) {
        if timeMINFitness.text != ""
        {
            //get variables of selected
            
            //date
            // get the current date and time
            let currentDateTime = NSDate()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .long
            let date = formatter.string(from: currentDateTime as Date) // October 8, 2016 at 10:48:53 PM
            
            //type
            let type = sportsType[typeFitness.selectedRow(inComponent: 0)]
            //rigor
            var rigor = ""
            if(currentSlide.value <= 1){
                 rigor = "easy"}
            else if(currentSlide.value <= 2){
                 rigor = "medium"}
            else{
                 rigor = "hard"}
            
            //total time in min
            let time = String((Int(timeHRFitness.text!)!*60) + Int(timeMINFitness.text!)!)
            
            //uid and references
            let uid = Auth.auth().currentUser?.uid
            let userReference = self.databaseref.child("users").child(uid!)
            
            //upload time
            let post: [String : Any] = ["day":date, "fitnesstype":type, "rigor":rigor, "time": time]
            userReference.updateChildValues(post, withCompletionBlock: {error, ref in
                if error != nil{
                    return
                }})
            
            //call reset to zero button
            resetButton((Any).self)
            saveConfirmation.text = "Your fitness data has been saved."
        }
    }
    
    //Reset to zero button function
    func resetButton(_ sender: Any) {
        timeMINFitness.text = ""
        timeHRFitness.text = ""
        currentSlide.value = 0
        typeFitness.selectRow(0, inComponent: 0, animated: true)
    }
    

    //TYPE
    @IBOutlet var typeFitness: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportsType[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportsType.count
    }
    
    
    //RIGOR
    
    @IBOutlet weak var currentSlide: UISlider!
    

    //TIME
    @IBOutlet weak var timeHRFitness: UITextField!
    @IBOutlet weak var timeMINFitness: UITextField!
    
    //Back Button
    func openProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
