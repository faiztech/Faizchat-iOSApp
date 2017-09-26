//
//  SignInViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/26/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
   
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var emailTextField: UITextField!
   @IBOutlet weak var errorLabel: UILabel!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //hiding error label until wanted
      errorLabel.isHidden = true
   }
   
   @IBAction func SignTapped(_ sender: Any) {
      
      // Firebase Login Configuration 'Auth' is a firebase function previously 'FIRAuth'
      // the code after 'in' is the completion block where you can authenticated the email and pass
      Auth.auth().signIn(withEmail: emailTextField.text!,
                         password: passwordTextField.text!) { (user, error) in
                           
                           //displaying wrong email error in login page
                           if error != nil{
                           if Int((error! as NSError).code) == 17008
                           {
                              self.errorLabel.text = "The email doesn't seem to be right"
                              self.errorLabel.isHidden = false
                           }
                           }
                           
                           // for debugger
                           print("Tried signing in:")
                           if error != nil{
                              print("Error has occured:")
                              print(error!)
                              
                              Auth.auth().createUser(withEmail: self.emailTextField.text!,
                                                     password: self.passwordTextField.text!,
                                                     completion: { (user, error) in
                                                      //debugger
                                                      print("Tried creating a user")
                                                      if error != nil{
                                                         print("Error has occured:")
                                                         print(error!)
                                                         
                                                      }else{
                                                         print("Created user successfully")
                                                         self.performSegue(withIdentifier: "signInSegue", sender: nil)

                                                      }
                              })
                           }
                           else
                           {
                              print("Signed in Successfully")
                              self.performSegue(withIdentifier: "signInSegue", sender: nil)
                           }
                           
      }
      
      
      
   }
   
}

