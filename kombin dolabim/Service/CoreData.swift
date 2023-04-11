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


enum FetchError : Error{
    case fectFailed
}

class CoreData{
    
    func makeDarkOutfit(cellID: String){
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        fetchRequest.predicate = NSPredicate(format: "id = %@", cellID)
        
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as![NSManagedObject]{
                if let id = result.value(forKey: "id") as? UUID{
                    if cellID == id.uuidString {
                        result.setValue(false, forKey: "top3")
                    }
                }
            }
            try context.save()
        }catch{ }
    }
    
    func makeTop3(cellID: String, complation: @escaping(UIColor?)->()) {
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        fetchRequest.predicate = NSPredicate(format: "id = %@", cellID)
        
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as![NSManagedObject]{
                
                if let id = result.value(forKey: "id") as? UUID{
                    
                    if cellID == id.uuidString {
                        // star lama bu id li outfit i..
                        guard let isItTop3Already = result.value(forKey: "top3") as? Bool else{
                            return
                        }
                        switch isItTop3Already{
                        case true:
                            // ışığını söndür..
                            result.setValue(false, forKey: "top3")
                            try context.save()
                            complation(.black)
                            break
                        case false:
                            // dünyamı aydınlat..
                            result.setValue(true, forKey: "top3")
                            try context.save()
                            complation(.orange)
                            break
                        }
                    }
                }
            }
        }catch{ }
    }
    
    func canbetop3() -> Bool{
        // 3 tane starlı varsa false döndür, true otherwise.
        var starCounter = 0
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        
        do{
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let isStar = result.value(forKey: "top3") as? Bool{
                    if isStar{
                        starCounter += 1
                    }
                }
            }
            try context.save()
        }catch{ }
        
        if starCounter < 3{
            return true
        }else{
            return false
        }
    }
    
    func clearCoreDataFor(_ EntityName: String, ViewController: UIViewController){
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let content = apdelegate.persistentContainer.viewContext
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        
        do{
            let results = try content.fetch(fr)
            for result in results as! [NSManagedObject]{
                content.delete(result)
            }
            try content.save()
            AlertClass.makeAlertWith(M: "Done", S: "Your collections was deleted in the phone", ViewController: ViewController)
            
        }catch{
            AlertClass.makeAlertWith(M: "Error", S: "Problem", ViewController: ViewController)
        }
    }
    
    
    func getOutfits(EntityName: String, predicateAtribute: String, _ EqualTo: String) -> [OutfitClass] {
        let fetchResult = CoreData.FetchRequstWithPredicate(EntityName: EntityName, predicateAtribute: predicateAtribute, EqualTo)
        guard let FR = fetchResult else{
            return []
        }
        let OutFitsClass = OutfitsList(via: FR)
        return OutFitsClass.getOutFitList()
    }
    
    
    
    func saveNewOutfit(image: UIImage, comment: String) -> Bool{
        // if saving will be succesfull return true else false.
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let newOutfit = NSEntityDescription.insertNewObject(forEntityName: "Outfit", into: context)
        
        guard let imagedata = image.jpegData(compressionQuality: 0.5) else{
            return false
        }
        
        newOutfit.setValue(imagedata, forKey: "image")
        newOutfit.setValue(comment, forKey: "comment")
        newOutfit.setValue(false, forKey: "top3")
        newOutfit.setValue(UUID(), forKey: "id")
        newOutfit.setValue(Auth.auth().currentUser?.email, forKey: "owner")
        
        do{
            try context.save()
            return true
        }catch{
            return false
        }
    }
    
    
    
    static func FetchRequstWithPredicate(EntityName: String, predicateAtribute: String, _ EqualTo: String) -> [NSFetchRequestResult]? {
        
        // coredata ya ulaşmak için lazım olan aracı context e ulaştım
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        // fetch request imi oluşturdum
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: EntityName)
        
        // fetch edilecek olan nesnelere belirtilen sınırlayıcı ayarlanıyor
        fetchRequest.predicate = NSPredicate(format: "\(predicateAtribute) = %@", EqualTo)
        
        do{
            return try context.fetch(fetchRequest)
        }catch{
            print(FetchError.fectFailed)
            return nil
        }
        
    }
}
