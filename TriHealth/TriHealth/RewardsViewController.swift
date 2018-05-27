//
//  RewardsViewController.swift
//  TriHealth
//
//  Created by Tembi Karagianes on 5/1/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class RewardsViewController: UIViewController {
    
    //variables
    var points: Int = 0
    //database reference
    let databaseref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    //outlets
    @IBOutlet var pointsdisplay: UILabel!
    @IBOutlet var redeemButton: UIButton!
    @IBOutlet var messagelabel1: UILabel!
    @IBOutlet var messagelabel2: UILabel!
    
    //actions
    @IBAction func backButton(_ sender: UIButton) {
        backToProfile()
    }
    @IBAction func redeemButton(_ sender: Any){
        //if user hasnt reached goal
        if self.points > 100
        {
            updateRewards()
            openRedeemRewards()
        }
    }
    
    //on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get rewards points from firebase and display
        databaseref.child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot)
            in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                self.points = dict["rewards"] as! Int
                self.pointsdisplay.text = "\(dict["rewards"]!) points"
                
                //update message label based on if goal reach
                //if user hasnt reached goal
                if self.points < 100
                {
                    self.messagelabel1.text = "You have not earned 100 points!"
                    self.messagelabel2.text = "Keep healthy to collect your reward."
                    self.redeemButton.isEnabled = false
                }
                    //open rewards if reached goal
                else{
                    self.messagelabel1.text = "You have earned 100 points!"
                    self.messagelabel2.text = "Click redeem to collect your reward."
                }
            }
        })
    }
    //NAVIGATION
    //segues to profile
    func updateRewards()
    {
        let uid = Auth.auth().currentUser?.uid
        let userReference = self.databaseref.child("users").child(uid!)
        let values = ["rewards":self.points-100]
        userReference.updateChildValues(values, withCompletionBlock: {error, ref in
            if error != nil{
                return
            }})

    }
    func backToProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }
    //segues to redeem rewards
    func openRedeemRewards()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let redeemVC:RedeemRewardsViewController = storyboard.instantiateViewController(withIdentifier: "redeem") as! RedeemRewardsViewController
        self.present(redeemVC, animated: true, completion: nil)
    }

}
