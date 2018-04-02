//
//  RecVC.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 3/27/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class RecVC: UIViewController {

    @IBOutlet weak var label: UILabel!
    var myString = String()
    
    override func  viewDidLoad() {
        super.viewDidLoad()
        label.text = myString
    }
    
}
