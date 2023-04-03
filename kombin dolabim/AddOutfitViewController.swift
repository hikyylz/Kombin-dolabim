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

    @IBOutlet var imageVİew: UIImageView!
    @IBOutlet var enteredComment: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        imageVİew.isUserInteractionEnabled = true
        let gr = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageVİew.addGestureRecognizer(gr)
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
            imageVİew.image = image
            dismiss(animated: true)
        }
    }
    
    

    @IBAction func saveTapped(_ sender: Any) {
        // core dataya kaydediyorum burada sadece. Firebase e kaydetmek ayrı bir işlem.
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let newOutfit = NSEntityDescription.insertNewObject(forEntityName: "Outfit", into: context)
        
        if let imagedata = imageVİew.image?.jpegData(compressionQuality: 0.5){
            newOutfit.setValue(imagedata, forKey: "image")
            newOutfit.setValue(enteredComment.text, forKey: "comment")
            newOutfit.setValue(false, forKey: "top3")
            newOutfit.setValue(UUID(), forKey: "id")
            newOutfit.setValue(Auth.auth().currentUser?.email, forKey: "owner")
        }
        
        do{
            try context.save()
        }catch{
            
        }
        
        imageVİew.image = UIImage(named: "select")
        enteredComment.text = ""
        
    }
    
    
    
}
