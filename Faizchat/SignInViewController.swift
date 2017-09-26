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
        Auth.auth().signIn(withEmail: emailTextField.text!,
                           password: passwordTextField.text!) { (user, error) in
                            
                            // for debugging
                            print("Tried signing in:")
                            if error != nil{
                                //displaying wrong email error in login page
                                if Int((error! as NSError).code) == 17008
                                {
                                    self.errorLabel.text = "The email doesn't seem to be right"
                                    self.errorLabel.isHidden = false
                                    
                                }
                                
                                print("Error has occured:")
                                print(error!)
                                
                            } else
                            {
                                print("No error")
                            }
        }
        
        
        
    }
    
}

