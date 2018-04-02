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
//
//        waterNeeded.text = userWeight
//
//        // Do any additional setup after loading the view.
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

    
    @IBOutlet var glass1: UIImageView!
    
    @IBOutlet var glass2: UIImageView!
    
    @IBOutlet var glass3: UIImageView!
    
    @IBOutlet var glass4: UIImageView!
    
    @IBOutlet var glass5: UIImageView!
    
    @IBOutlet var glass6: UIImageView!
    
    @IBOutlet var glass7: UIImageView!
    
    @IBOutlet var glass8: UIImageView!
    
    @IBOutlet var glass9: UIImageView!
    
    @IBOutlet var glass10: UIImageView!
    

    @IBOutlet weak var waterCount: UILabel!

    @IBOutlet weak var waterStepper: UIStepper!

    
    @IBAction func waterAddStp(_ sender: UIStepper) {
        //var lastValue = waterStepper.value
        
        let glassArray: [UIImageView] = [glass1, glass2, glass3, glass4, glass5, glass6, glass7, glass8, glass9, glass10]
        
        
        let numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        
        //if (Int(sender.value)>lastValue)
        //{
            for i in numbers {
                if (i < Int(sender.value))
                {
                    glassArray[i].isHidden = false;
                }
       /* }
        else
        {
            lastValue = lastValue - 1
            glassArray[Int(sender.value)].isHidden = false;
        }*/


    }
//
//            /*if sender.value == 0 {
//             glass1.isHidden = true;
//
//             glass2.isHidden = true;
//
//             glass3.isHidden = true;
//
//             glass4.isHidden = true;
//
//             glass5.isHidden = true;
//
//             glass6.isHidden = true;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//             }
//
//
//
//             if sender.value == 1 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = true;
//
//             glass3.isHidden = true;
//
//             glass4.isHidden = true;
//
//             glass5.isHidden = true;
//
//             glass6.isHidden = true;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//
//             }
//
//
//
//             if sender.value == 2 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = true;
//
//             glass4.isHidden = true;
//
//             glass5.isHidden = true;
//
//             glass6.isHidden = true;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//             }
//
//
//             if sender.value == 3 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = true;
//
//             glass5.isHidden = true;
//
//             glass6.isHidden = true;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//             }
//
//
//
//             if sender.value == 4 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = true;
//
//             glass6.isHidden = true;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//             }
//
//
//
//             if sender.value == 5 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = false;
//
//             glass6.isHidden = true;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//
//
//             }
//
//
//
//             if sender.value == 6 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = false;
//
//             glass6.isHidden = false;
//
//             glass7.isHidden = true;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//
//
//             }
//
//
//
//             if sender.value == 7 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = false;
//
//             glass6.isHidden = false;
//
//             glass7.isHidden = false;
//
//             glass8.isHidden = true;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//             }
//
//
//             if sender.value == 8 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = false;
//
//             glass6.isHidden = false;
//
//             glass7.isHidden = false;

//             glass8.isHidden = false;
//
//             glass9.isHidden = true;
//
//             glass10.isHidden = true;
//
//             }
//
//
//
//             if sender.value == 9 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = false;
//
//             glass6.isHidden = false;
//
//             glass7.isHidden = false;
//
//             glass8.isHidden = false;
//
//             glass9.isHidden = false;
//
//             glass10.isHidden = true;
//
//             }
//
//
//
//             if sender.value == 10 {
//
//             glass1.isHidden = false;
//
//             glass2.isHidden = false;
//
//             glass3.isHidden = false;
//
//             glass4.isHidden = false;
//
//             glass5.isHidden = false;
//
//             glass6.isHidden = false;
//
//             glass7.isHidden = false;
//
//             glass8.isHidden = false;
//
//             glass9.isHidden = false;
//
//             glass10.isHidden = false;
//
//             }
//             }*/
    
//        }
//
   }
    
}



