//
//  FitnessViewController.swift
//  TriHealth
//
//  Created by Lucy Ackerman on 5/1/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit

class FitnessViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    
    
    let sportsType = ["Baseball", "Basketball","Cross Country", "Field Hockey", "Frisbee","Ice Hockey", "Lacrosse", "Rock Climbing", "Sailing", "Soccer", "Swimming", "Tennis", "Track & Field", "Water Polo", "Weight Lifting", "Wrestling"]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sportsType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sportsType.count
    }
    



    @IBOutlet var typeFitness: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
