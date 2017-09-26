//
//  PictureViewController.swift
//  Faizchat
//
//  Created by Mohammed Faizuddin on 9/26/17.
//  Copyright © 2017 Faiz Tech. All rights reserved.
//

import UIKit

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
   }
}
