//
//  SettingsViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import CoreData
import Firebase

class SettingsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let currUserEmail = (Auth.auth().currentUser?.email)!
        
        let firestoreDB = Firestore.firestore()
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let content = apdelegate.persistentContainer.viewContext
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        
        do{
            let results = try content.fetch(fr)
            for result in results as! [NSManagedObject]{
                
                if let imageID = result.value(forKey: "id") as? UUID{
                    if let imageData = result.value(forKey: "image") as? Data{
                        if let imageComment = result.value(forKey: "comment") as? String{
                            if let imageTop3info = result.value(forKey: "top3") as? Bool{
                                // eldeki verileri firestore a kaydet..
                                
                                let newOutfitinfo = ["id":imageID.uuidString ,
                                                     "image":imageData ,
                                                     "comment":imageComment ,
                                                     "is image in top3": imageTop3info ] as [String:Any]
                                
                                //firestoreDB.collection("Outfits").document(imageID.uuidString).setData(newOutfitinfo, merge: true)
                                firestoreDB.collection("Users").document(currUserEmail).collection("my collections").document(imageID.uuidString).setData(newOutfitinfo, merge: true)
                                makeAlert(M: "Saving Done", S: "your collection was saved in cloud")
                                
                            }
                        }
                    }
                }
            }
            
            try content.save()
            
            
        }catch{
            makeAlert(M: "Error", S: "saving failed")
        }
        
        
        
    }
    
    func makeAlert(M:String , S:String){
        let alert = UIAlertController(title: M, message: S, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    @IBAction func deleteOutfitsPhone(_ sender: Any) {
        
        // cihazdaki data yı silmek için teknik olarak email e ihtiyacı yok ama ben yine de izin vermiyeyim. 
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let content = apdelegate.persistentContainer.viewContext
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        
        do{
            let results = try content.fetch(fr)
            for result in results as! [NSManagedObject]{
                content.delete(result)
            }
            try content.save()
            makeAlert(M: "done", S: "your collections was deleted in the phone")
        }catch{
            makeAlert(M: "Error", S: "problem")
        }
    }
    
    
    @IBAction func deleteOutfitsCloud(_ sender: Any) {
        
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
        
        
    }
    
    
    
   
    
    
}
