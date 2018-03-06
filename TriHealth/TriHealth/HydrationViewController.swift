//
//  ViewController.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 2/6/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var glass1: UIImageView!
    
    @IBOutlet weak var glass2: UIImageView!
    
    @IBOutlet weak var glass3: UIImageView!
    
    @IBOutlet weak var glass4: UIImageView!
    
    @IBOutlet weak var glass5: UIImageView!
    
    @IBOutlet weak var glass6: UIImageView!
    
    @IBOutlet weak var glass7: UIImageView!
    
    @IBOutlet weak var glass8: UIImageView!
    
    @IBOutlet weak var glass9: UIImageView!
    
    @IBOutlet weak var glass10: UIImageView!
    
    @IBOutlet weak var waterCount: UILabel!

    @IBAction func waterAddStp(_ sender: UIStepper) {
        waterCount.text = String(sender.value)
        
        let glasses = [glass1, glass2, glass3, glass4, glass5, glass6, glass7, glass8, glass9, glass10]
 
        
        for i in 1...Int(sender.value) {
            glasses[i - 1]?.isHidden = false;
        }
        
        /*if sender.value == 0 {
            glass1.isHidden = true;
            glass2.isHidden = true;
            glass3.isHidden = true;
            glass4.isHidden = true;
            glass5.isHidden = true;
            glass6.isHidden = true;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
        }
        
        if sender.value == 1 {
            glass1.isHidden = false;
            glass2.isHidden = true;
            glass3.isHidden = true;
            glass4.isHidden = true;
            glass5.isHidden = true;
            glass6.isHidden = true;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;

        }
        
        if sender.value == 2 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = true;
            glass4.isHidden = true;
            glass5.isHidden = true;
            glass6.isHidden = true;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
        }

        if sender.value == 3 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = true;
            glass5.isHidden = true;
            glass6.isHidden = true;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
        }
        
        if sender.value == 4 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = true;
            glass6.isHidden = true;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
        }
        
        if sender.value == 5 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = false;
            glass6.isHidden = true;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
            
        }
        
        if sender.value == 6 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = false;
            glass6.isHidden = false;
            glass7.isHidden = true;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
            
        }
        
        if sender.value == 7 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = false;
            glass6.isHidden = false;
            glass7.isHidden = false;
            glass8.isHidden = true;
            glass9.isHidden = true;
            glass10.isHidden = true;
        }

        if sender.value == 8 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = false;
            glass6.isHidden = false;
            glass7.isHidden = false;
            glass8.isHidden = false;
            glass9.isHidden = true;
            glass10.isHidden = true;
        }
        
        if sender.value == 9 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = false;
            glass6.isHidden = false;
            glass7.isHidden = false;
            glass8.isHidden = false;
            glass9.isHidden = false;
            glass10.isHidden = true;
        }
        
        if sender.value == 10 {
            glass1.isHidden = false;
            glass2.isHidden = false;
            glass3.isHidden = false;
            glass4.isHidden = false;
            glass5.isHidden = false;
            glass6.isHidden = false;
            glass7.isHidden = false;
            glass8.isHidden = false;
            glass9.isHidden = false;
            glass10.isHidden = false;
        }*/

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

