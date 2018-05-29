//
//  RewardsInfoViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 5/27/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class RewardsInfoViewController: UIViewController {

    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func backButton(_ sender: Any) {
        openRewards()
    }
    //NAVIGATION
    func openRewards()
    {
        //segues to rewards page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC:RewardsViewController = storyboard.instantiateViewController(withIdentifier: "rewards") as! RewardsViewController
        self.present(rewardsVC, animated: true, completion: nil)
    }
}
