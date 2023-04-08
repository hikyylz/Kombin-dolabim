//
//  CoreData.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 8.04.2023.
//

import Foundation
import CoreData
import Firebase
import UIKit

class CoreData{
    
    static func saveNewOutfit(image: UIImage, comment: String){
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let newOutfit = NSEntityDescription.insertNewObject(forEntityName: "Outfit", into: context)
        
        if let imagedata = image.jpegData(compressionQuality: 0.5){
            newOutfit.setValue(imagedata, forKey: "image")
            newOutfit.setValue(comment, forKey: "comment")
            newOutfit.setValue(false, forKey: "top3")
            newOutfit.setValue(UUID(), forKey: "id")
            newOutfit.setValue(Auth.auth().currentUser?.email, forKey: "owner")
        }
        
        do{
            try context.save()
        }catch{
            
        }
    }
}
