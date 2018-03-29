//
//  RecVC.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 3/27/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class RecVC: UIViewController {
    
    var text: String?
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        if let receivedText = text {
        label.text = receivedText
        }
    }

}
