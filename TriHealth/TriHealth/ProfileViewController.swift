//
//  ProfileViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 2/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class ProfielViewController: UIViewController {

    @IBOutlet weak var weightInput: UITextField!
    
    var cupMeasure = 0;
    
    func waterWeight(weightInput: Int) -> Int{
        cupMeasure = (weightInput/20)
        
        return cupMeasure
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
