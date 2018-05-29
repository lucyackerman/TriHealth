//
//  FitnessTableViewCell.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 5/26/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class FitnessTableViewCell: UITableViewCell {

    //outlets
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var exerciseLabel: UILabel!
    @IBOutlet var rigorLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
