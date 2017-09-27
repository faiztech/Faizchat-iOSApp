//
//  SelectContactViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/27/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit

class SelectContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

   @IBOutlet weak var tableView: UITableView!
   
   
   override func viewDidLoad() {
        super.viewDidLoad()
      
      self.tableView.delegate = self
      self.tableView.dataSource = self

   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 0
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      return UITableViewCell()
   }
   
   
   
   
   

}
