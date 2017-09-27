//
//  SelectContactViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/27/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit
import Firebase

class SelectContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
   
   @IBOutlet weak var tableView: UITableView!
   
   //creating an array of users
   var users : [User] = []
   
   var imageURL = ""
   var desc = " "
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //tableView config
      self.tableView.delegate = self
      self.tableView.dataSource = self
      
      //pulling data from Database
      Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
         print(snapshot)
         
         
         let user = User()
         
         //from internet stack overflow, they said to cast snapshot.value into NSDictionary and it worked
         let value = snapshot.value as? NSDictionary
         
         //debugged from internet
         user.email = value?["email"] as? String ?? ""
         user.uid = snapshot.key
         
         self.users.append(user)
         
         //updating tableView
         self.tableView.reloadData()
         
         
      }
      
      
      
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return users.count
   }
   
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      //initializing cell
      let cell = UITableViewCell()
      
      //accessing the users array and assigning it to user
      let user = users[indexPath.row]
      
      //initializing the cell to be a text label named with the user email
      cell.textLabel?.text = user.email
      
      return cell
      
   }
   
   //to select from tableView
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      let user = users[indexPath.row]
      
      let snap = ["from" : Auth.auth().currentUser!.email, "description" : desc, "imageURL" : imageURL]

      //initating send
   Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
      
      navigationController?.popToRootViewController(animated: true)
   }
   
   
   
   
   
   
}
