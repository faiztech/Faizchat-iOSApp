//
//  ViewSnapViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/27/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {
   
   var snap = Snap()
   
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var label: UILabel!
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      label.text = snap.descrip
      imageView.sd_setImage(with: URL(string: snap.imageURL), completed: nil)
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      //deleting from databases
      Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
      
      //deleting from storage
      Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
         
         print("Picture deleted from storage")
      }
   }
}
