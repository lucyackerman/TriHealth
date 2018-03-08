//
//  ProfileViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 2/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase

class ProfielViewController: UIViewController {
    
    @IBOutlet weak var stepper: UIStepper!

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var weightInput: UITextField!
    
    var cupMeasure = 0
    //variables
    
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
    }

}
