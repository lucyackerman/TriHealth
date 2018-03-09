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

class ProfileViewController: UIViewController {
    
        //variables
    var cupMeasure = 0
    
    //outlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var weight: UILabel!
    
    //actions
    
    //functions
    func waterWeight(weightInput: Int) -> Int{
        cupMeasure = (weightInput/20)
        
        return cupMeasure
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser?.uid == nil{
            self.logout()
        }
        else{
            email.text = Auth.auth().currentUser?.email
        }
    }
    func logout(){
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "signin")
        present(loginViewController, animated: true, completion: nil)
    }
}
