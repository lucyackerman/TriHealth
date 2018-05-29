//
//  FitnessLogTableViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 5/26/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FitnessLogTableViewController: UITableViewController {

    //variables
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var submissionList = [FitnessSubmission]()
    
    //actions
    @IBAction func homeButton(_ sender: Any) {
        openProfile()
    }
    @IBAction func addButton(_ sender: Any) {
        openFitness()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load exercises
        loadExercise()
    }
    func loadExercise()
    {
        var dateArr = [String]() //array of dates
        databaseref.child("users").child(uid!).child("fitnesslog").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let arr = Array(dict)
                var a = 0
                while a < dict.count
                {
                    let date = arr[a].key
                    dateArr.append(date)
                    a = a + 1
                }
                for dateval in dateArr
                {
                    self.databaseref.child("users").child(self.uid!).child("fitnesslog").child(dateval).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let dict2 = snapshot.value as? [String: AnyObject]
                        {
                            
                            var timeArr = [String]()
                            let subarr = Array(dict2)
                            var b = 0
                            while b < dict2.count
                            {
                                timeArr.append(subarr[b].key)
                                b = b+1
                            }
                            for timeval in timeArr
                            {
                                self.databaseref.child("users").child(self.uid!).child("fitnesslog").child(dateval).child(timeval).observeSingleEvent(of: .value, with: { (snapshot) in
                                        if let dict3 = snapshot.value as? [String: AnyObject]
                                        {
                                            let submission = FitnessSubmission()
                                            submission.date = dateval
                                            submission.type = (dict3["fitnesstype"] as! String)
                                            submission.rigor = (dict3["rigor"] as! String)
                                            submission.time = (dict3["time"] as! String)
                                            self.submissionList.append(submission)
                                            self.submissionList.sort {
                                                return $0.date! > $1.date!
                                            }
                                            DispatchQueue.main.async {
                                                self.tableView.reloadData()
                                            }
                                        }
                                    })
                            }
                        }
                    })
                }
            }})
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // sets num of cells in table view to num of submissions
        return self.submissionList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = FitnessTableViewCell(style: .subtitle, reuseIdentifier: "cellid")
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "FitnessTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FitnessTableViewCell  else {
            fatalError("The dequeued cell is not an instance of FitnessTableViewCell.")
        }
        
        //set cell contents
        cell.dateLabel.text = submissionList[indexPath.row].date
        cell.exerciseLabel.text = submissionList[indexPath.row].type
        cell.rigorLabel.text = submissionList[indexPath.row].rigor
        let timeinHR = Int(submissionList[indexPath.row].time!)!/60
        let timeinMIN = Int(submissionList[indexPath.row].time!)!%60
        cell.timeLabel.text = "\(timeinHR) hr \(timeinMIN) min"

        return cell
    }
    //NAVIGATION
    func openProfile()
    {
        //segues to profile page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC:ProfileViewController = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
        self.present(profileVC, animated: true, completion: nil)
    }
    func openFitness()
    {
        //segues to fitness page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let fitnessVC:FitnessViewController = storyboard.instantiateViewController(withIdentifier: "Fitness") as! FitnessViewController
        self.present(fitnessVC, animated: true, completion: nil)
    }
}

