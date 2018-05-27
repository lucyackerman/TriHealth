//
//  RedeemRewardsViewController.swift
//  TriHealth
//
//  Created by Tembi Karagianes on 5/11/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class RedeemRewardsViewController: UIViewController {
    //actions
    @IBAction func backToRewards(_ sender: UIButton){
        openRewards()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
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
