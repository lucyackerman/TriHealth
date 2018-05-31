//
//  HydrationLogTableViewController.swift
//  TriHealth
//
//  Created by Wattendorf Laptop on 5/28/18.
//  Copyright © 2018 Lucy Ackerman. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class HydrationLogTableViewController: UITableViewController {

    //variables
    let storageref = Storage.storage().reference()
    let databaseref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var hydrationList = [HydrationSubmission]()
    
    //actions
    @IBAction func back(_ sender: Any) {
        openHydration()
    }
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //load exercises
        loadHydration()
    }
    func loadHydration()
    {
        //collect water totals from hydration log on firebase
        databaseref.child("users").child(uid!).child("hydrationlog").observeSingleEvent(of: .value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject]
            {
                let arr = Array(dict)
                var a = 0
                while a < dict.count
                {
                    let date = arr[a].key
                    let oz = arr[a].value
                    let submission = HydrationSubmission()
                    //set date and oz to values from firebase
                    submission.date = date
                    submission.oz = (oz as! String)
                    //add to log of water totals
                    self.hydrationList.append(submission)
                    self.hydrationList.sort { //sorts by date most recent on top oldest on bottom
                        return $0.date! > $1.date!
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData() //displays data
                    }
                    a = a + 1
                }
            }
        })
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // sets num of cells in table view to num of submissions
        return self.hydrationList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "HydrationTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HydrationTableViewCell  else {
            fatalError("The dequeued cell is not an instance of HydrationTableViewCell.")
        }
        //displays date and water in table cells
        cell.dateLabel.text = hydrationList[indexPath.row].date
        cell.waterLabel.text = "\(hydrationList[indexPath.row].oz!) oz"
        
        return cell
    }
    //NAVIGATION
    func openHydration()
    {
        //segues to hydration page
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let hydrationVC:HydrationPageViewController = storyboard.instantiateViewController(withIdentifier: "hydration") as! HydrationPageViewController
        self.present(hydrationVC, animated: true, completion: nil)
    }
}
