//
//  SettingsViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import CoreData
import FirebaseAuth

class SettingsViewController: UIViewController {

    private let myOutfitManager = OutfitManager(currUserEmail: (Auth.auth().currentUser?.email)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.email == nil{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            }
        }
    }
    

    @IBAction func saveOutfitsCloud(_ sender: Any) {
        // coredata dan image, comment ve top3 bilgisini alacağım..
        
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
        
        myOutfitManager.saveOutfitsToCloud { succes in
            if succes{
                AlertClass.makeAlertWith(M: "Saving Done", S: "your collection was saved in cloud", ViewController: self)
            }else{
                AlertClass.makeAlertWith(M: "Saving Failed", S: "Sorry, your collection could not saved in cloud", ViewController: self)
            }
        }
        
        
    }
    
    
    
    @IBAction func deleteOutfitsPhone(_ sender: Any) {
        // cihazdaki data yı silmek için teknik olarak email e ihtiyacı yok ama ben yine de izin vermiyeyim.
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
        myOutfitManager.clearCoreDataFor("Outfit", ViewController: self)
    }
    
    
    @IBAction func deleteOutfitsCloud(_ sender: Any) {
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
        myOutfitManager.deleteOutfitsFromCloud { succes in
            if succes{
                AlertClass.makeAlertWith(M: "Done", S: "Your data was deleted form cloud", ViewController: self)
            }else{
                AlertClass.makeAlertWith(M: "Error", S: "Your data did not deleted from cloud", ViewController: self)
            }
        }
        
    }
}
