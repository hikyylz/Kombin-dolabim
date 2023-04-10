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

    private let myOutfitManager = OutfitManager()
    
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
        
        let currUserEmail = (Auth.auth().currentUser?.email)!
        
        let firestoreDB = Firestore.firestore()
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let content = apdelegate.persistentContainer.viewContext
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        
        fr.predicate = NSPredicate(format: "owner = %@", currUserEmail)
        // oluşturduğum FR e predicate önkoşul ekliyorum.
        
        do{
            let results = try content.fetch(fr)
            for result in results as! [NSManagedObject]{
                
                if let imageID = result.value(forKey: "id") as? UUID{
                    if let imageData = result.value(forKey: "image") as? Data{
                        if let imageComment = result.value(forKey: "comment") as? String{
                            if let imageTop3info = result.value(forKey: "top3") as? Bool{
                                // eldeki verileri firestore a kaydet..
                                
                                let newOutfitinfo = ["id":imageID.uuidString ,  // id yi tutmaya cidden gerek var mı emin değilim. ???
                                                     "image":imageData ,
                                                     "comment":imageComment ,
                                                     "is image in top3": imageTop3info ] as [String:Any]
                                 
                                firestoreDB.collection("Users").document(currUserEmail).collection("my collections").document(imageID.uuidString).setData(newOutfitinfo, merge: true)
                                AlertClass.makeAlertWith(M: "Saving Done", S: "your collection was saved in cloud", ViewController: self)
                                
                            }
                        }
                    }
                }
            }
            
            try content.save()
            
            
        }catch{
            AlertClass.makeAlertWith(M: "Error", S: "saving failed", ViewController: self)
        }
        
        
        
    }
    
    
    
    @IBAction func deleteOutfitsPhone(_ sender: Any) {
        // cihazdaki data yı silmek için teknik olarak email e ihtiyacı yok ama ben yine de izin vermiyeyim.
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }else{
            myOutfitManager.clearCoreDataFor("Outfit", ViewController: self)
        }
    }
    
    
    @IBAction func deleteOutfitsCloud(_ sender: Any) {
        
        if Auth.auth().currentUser == nil{
            performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            return
        }
        
        let firestoreDB = Firestore.firestore()
        let currentUserEmail = (Auth.auth().currentUser?.email)!
        
        let userImageColl = firestoreDB.collection("Users").document(currentUserEmail).collection("my collections")
        
        userImageColl.getDocuments { q, e in
            
            guard let data = q?.documents else{
                return
            }
            
            for i in data{
                
                // clod da bir şey sildiğinde içi tamamşyle boşalan her başlık siliniyor .
                userImageColl.document(i.documentID).delete { e in
                    if let _ = e{
                        AlertClass.makeAlertWith(M: "Error", S: "Your data did not deleted from cloud", ViewController: self)
                    }else{
                        AlertClass.makeAlertWith(M: "Done", S: "Your data was deleted form cloud", ViewController: self)
                    }
                }
            }
        }
    }
    
    
    
   
    
    
}
