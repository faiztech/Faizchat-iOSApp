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
                                   self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                                 
                                 
                                 
                              default:
                                 self.errorLabel.text = "There seems to be an error."
                                 
                              }
                              
                              self.errorLabel.isHidden = false
                              
                           }
                           
                           // for debugger
                           print("Tried signing in:")
                           if error != nil{
                              
                            
                              
                           }  else
                           {
                              print("Signed in Successfully")
                              self.performSegue(withIdentifier: "signInSegue", sender: nil)
                           }
      }
      
   
 
   
}







@IBAction func SignUpTapped(_ sender: Any) {
   
   performSegue(withIdentifier: "SignUpSegue", sender: nil)
}
}

// was trying to implement shake when error occcurs
//extension UIView {
//
//   func shake() {
//      let animation = CABasicAnimation(keyPath: "position")
//      animation.duration = 0.07
//      animation.repeatCount = 3
//      animation.autoreverses = true
//      animation.fromValue = NSValue(cgPoint:CG)
//      animation.toValue = NSValue(cgPoint: CGPoint(x:195,y :395))
//      self.layer.add(animation, forKey: "position")
//   }
//
//}


