//
//  SignUpViewController.swift
//  GoogleToolboxForMac
//
//  Created by Mohammed Faizuddin on 9/27/17.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

   
   @IBOutlet weak var emailTextField: UITextField!
   
   @IBOutlet weak var passwordTextField: UITextField!
   
   @IBOutlet weak var errorLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

      errorLabel.isHidden = true
      
      
      
    }
   
   @IBAction func SignUpTapped(_ sender: Any) {
   
   
   Auth.auth().createUser(withEmail: self.emailTextField.text!,
   password: self.passwordTextField.text!,
   completion: { (user, error) in
      
      //displaying wrong email error in login page
      if error != nil{
         switch Int((error! as NSError).code)
         {
         case( 17008):
            self.errorLabel.text = "The email doesn't seem to be right, Please try again."
            
         case( 17009):
            self.errorLabel.text = "The password is invalid."
            
         case( 17026):
            self.errorLabel.text = "The password must be 6 characters long or more."
            
         case( 17011):
            self.errorLabel.text = "It seems like you dont have an account. Please Sign up"
            
         case( 17007):
            self.errorLabel.text = "The email address is already in use by another account. Try Login"
            
            
         default:
            self.errorLabel.text = "There seems to be an error."
            
         }
         
         self.errorLabel.isHidden = false
         
      }

      
      
   //debugger
   print("Tried creating a user")
   if error != nil{
   print("Error has occured:")
   print(error!)
   
   }else{
   print("Created user successfully")
   self.performSegue(withIdentifier: "signInSegue", sender: nil)
   //adding the user to the database
   
   //connecting to database
   Database.database().reference().child("users").child(user!.uid).child("email").setValue(user?.email!)
   }
})
}
}
