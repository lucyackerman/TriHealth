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



    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

