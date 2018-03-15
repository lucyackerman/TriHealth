//
//  HydrationPageViewController.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 3/14/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class HydrationPageViewController: UIViewController {

    @IBOutlet weak var waterNeeded: UILabel!
    
    var userWeight = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        waterNeeded.text = userWeight

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
