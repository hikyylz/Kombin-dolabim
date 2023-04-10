//
//  AddOutfitViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import CoreData
import Firebase

class AddOutfitViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var enteredComment: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    private let myOutfitManager = OutfitManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        imageView.isUserInteractionEnabled = true
        let gr = UITapGestureRecognizer(target: self, action: #selector( pickImage ))
        imageView.addGestureRecognizer(gr)
    }
    
    @objc func pickImage(){
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
            
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage{
            saveButton.isEnabled = true
            imageView.image = image
            dismiss(animated: true)
        }
    }
    
    

    @IBAction func saveTapped(_ sender: Any) {
        // core dataya kaydediyorum burada sadece. Firebase e kaydetmek ayrı bir işlem.
        
        myOutfitManager.saveNewOutfit(image: imageView.image!, comment: enteredComment.text!) {savingSattus in
            if savingSattus == OutifitSavingStatus.notSaved{
                AlertClass.makeAlertWith(M: "Not saved", S: "Your outfit is not enough georgeus", ViewController: self)
            }
        }
        
        imageView.image = UIImage(named: "select")
        enteredComment.text = ""
        saveButton.isEnabled = false
    }
    
    
    
}
