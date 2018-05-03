//
//  RewardsViewController.swift
//  TriHealth
//
//  Created by Tembi Karagianes on 5/1/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class RewardsViewController: UIViewController {
    
    //actions
    @IBAction func backButton(_ sender: UIButton) {
        backToProfile()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //segues back to profile page
    func backToProfile()
    {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
