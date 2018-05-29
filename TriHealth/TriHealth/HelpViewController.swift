//
//  HelpViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 5/27/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    //functions
    @IBAction func backButton(_ sender: Any) {
        openFitness()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //NAVIGATION
    func openFitness()
    {
        //segues to fitness page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let fitnessVC:FitnessViewController = storyboard.instantiateViewController(withIdentifier: "Fitness") as! FitnessViewController
        self.present(fitnessVC, animated: true, completion: nil)
    }
}
