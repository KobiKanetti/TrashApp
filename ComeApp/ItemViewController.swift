//
//  ViewController.swift
//  ComeApp
//
//  Created by kobi on 27/08/2017.
//  Copyright © 2017 Kobi Kanetti. All rights reserved.
//

import UIKit



class ItemViewController: UIViewController {
    
    var item : Item? //if not nil, you are on view / edit mode
    
    // text fields
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var conditionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    //imageView
    
    @IBOutlet weak var imageView: UIImageView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item{
            descriptionTextField.text = item.description
            descriptionTextField.delegate = self
        }
        
        // Do any additional setup after loading the view, typically from a nib.
     
        descriptionTextField.becomeFirstResponder()
    }
    
    @IBAction func cameraButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
   
    
    // Add button
    @IBAction func addButtonAction(_ sender: Any) {
       
        guard let description = descriptionTextField.text, !description.isEmpty  else {
            return
        }
        
        guard let condition = conditionTextField.text, !condition.isEmpty else {
            return
        }
        
        guard let address = addressTextField.text, !address.isEmpty else {
            return
        }
        
        guard let image = imageView.image else{
            return
        }
        
        DBManager.manager.createItem(condition: condition, description: description, address: address, image: image)
        
        
        
        
        // return to tableViewController (after click "Add")
        navigationController?.popViewController(animated: true)
    }

    
    @IBAction func closeKeyboardAction(_ sender: Any) {
        
        descriptionTextField.resignFirstResponder()
        conditionTextField.resignFirstResponder()
        addressTextField.resignFirstResponder()
        
    }
    

}

extension ItemViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ItemViewController : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let item = item else{
            return true
        }
        
        //is owner
        return item.uid == DBManager.manager.userId
    }
}

