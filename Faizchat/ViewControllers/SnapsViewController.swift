//
//  SnapsViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/26/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   @IBOutlet weak var tableView: UITableView!
   
   
   //creating an array of snaps
   var snaps : [Snap] = []
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      tableView.delegate = self
      tableView.dataSource = self
      
      //pulling data from Database
      Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded) { (snapshot) in
         print(snapshot)
         
         
         let snap = Snap()
         
         //from internet stack overflow, they said to cast snapshot.value into NSDictionary and it worked
         let value = snapshot.value as? NSDictionary
         
         //debugged from internet
         snap.imageURL = value?["imageURL"] as? String ?? ""
         snap.descrip  = value?["description"] as? String ?? ""
         snap.from = value?["from"] as? String ?? ""
         snap.uuid = value?["uuid"] as? String ?? ""
         
         snap.key = snapshot.key
         
         self.snaps.append(snap)
         
         //updating tableView
         self.tableView.reloadData()
         
      }
      
      //deleting data from  tableView
      Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved) { (snapshot) in
         print(snapshot)
         
         var index = 0
         for snap in self.snaps
         {
            if snap.key == snapshot.key{
               self.snaps.remove(at: index)
            }
            
            index += 1
         }
         
         
         //updating tableView
         self.tableView.reloadData()
         
      }
   }
   
   
   @IBAction func logoutTapped(_ sender: Any) {
      
      dismiss(animated: true, completion: nil)
   }
   
   //selecting snap code
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      
      let snap = snaps[indexPath.row]
      
      performSegue(withIdentifier: "ViewSnapSegue", sender: snap)
      
   }
   
   //prepare for segue
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if segue.identifier == "ViewSnapSegue"
      {
         let nextVC = segue.destination as! ViewSnapViewController
         
         nextVC.snap = sender as! Snap
      }
   }
   
   //number of rows in table view
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      //message for no snaps config
      if snaps.count == 0
      {
         return 1
      }
      else
      {
         return snaps.count
      }
   }
   
   
   //what goes inside cell code
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell()
      
      if snaps.count == 0
      {
         cell.textLabel?.text = "You have no snaps 😐"
         
      }
      else
         
         
         
      {  let snap = snaps[indexPath.row]
         
         cell.textLabel?.text = snap.from
      }
      return cell
      
      
   }
   
   
   
}
