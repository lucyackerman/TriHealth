//
//  HydrationTableViewCell.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 5/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class HydrationTableViewCell: UITableViewCell {
    
    //outlets
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var waterLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
