//
//  PictureViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/26/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   @IBOutlet weak var nextButton: UIButton!
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var imageDescription: UITextField!
   
   var imagePicker = UIImagePickerController()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      //cam implementation
      imagePicker.delegate = self
      
      
   }
   
   //picking image
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      
      //storing chosen image
      let image = info[UIImagePickerControllerOriginalImage] as! UIImage
      
      //placing image in imageview
      imageView.image = image
      
      //changing backgroud color to transparent
      imageView.backgroundColor = UIColor.clear
      
      //dismissing the image picker
      imagePicker.dismiss(animated: true, completion: nil)
   }
   
   
   @IBAction func cameraTapped(_ sender: Any) {
      
      //specifying we are using camera .camera
      imagePicker.sourceType = .savedPhotosAlbum
      imagePicker.allowsEditing = false
      present(imagePicker, animated: true, completion: nil)
      
      
   }
   
   
   @IBAction func nextTapped(_ sender: Any) {
      
      //As soon as next tapped diabling Next
      nextButton.isEnabled = false
      
      //referencing to the images folder inside Firebase storage
      let imagesFolder = Storage.storage().reference().child("images")
      
      //converting our image to some sort of data in jpeg and compressing it
      let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)!
      
      
      //Replace with beclow if you want full quality images
      //let imageData = UIImagePNGRepresentation(imageView.image!)!
      
      //uploading images...
      imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
         
         print("Trying to upload...")
         
         //checking for error
         if error != nil
         {
            print("Error has occured!")
            print(error!)
         }else
         {
            print("Upload Completed!!")
            
            //performing segue function
            self.performSegue(withIdentifier: "selectSegue", sender: metadata?.downloadURL()?.absoluteString)
         }
      }
   }
   
   //doing something before segue to next screen
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let nextVC = segue.destination as! SelectContactViewController
      nextVC.imageURL = sender as! String
      nextVC.desc = imageDescription.text!
      
      
      
      
   }
}
