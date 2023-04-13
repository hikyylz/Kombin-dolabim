//
//  OutfitManager.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 10.04.2023.
//

import Foundation
import UIKit
import Firebase

enum OutifitSavingStatus{
    case notSaved
    case saved
}

struct OutfitManager{
    
    private let myCoreData = CoreData()
    private let myCloud = Cloud(currUserEmail: (Auth.auth().currentUser?.email)!)
    
    
    func deleteOutfitsFromCloud(completion: @escaping(_ succes: Bool)->()){
        myCloud.deleteOutfits { succes in
            if succes{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    
    
    func saveOutfitsToCloud(completion:@escaping(_ succes: Bool)->()){
        
        let currUserEmail = (Auth.auth().currentUser?.email)!
        guard let FetchReuslts = CoreData.FetchRequstWithPredicate(EntityName: "Outfit", predicateAtribute: "owner", currUserEmail) else{
            completion(false)
            return
        }
        
        myCloud.saveOutfitsListToCloud(OutfitsList: FetchReuslts) { success in
            if success{
                // save işlemi başarılı.
                completion(true)
            }else{
                // save işlemi başarısız.
                completion(false)
            }
        }
        
        
        
    }
    
    func top3Tapped(cellID: String, completion: @escaping(UIColor)->()){
        let canBeTop3 = myCoreData.canbetop3()
        if canBeTop3 {
            // tıklanılan cell i top3 olarak işaretler
            myCoreData.makeTop3(cellID: cellID) { returnedColor in
                completion(returnedColor ?? .black)
            }
            
        }else{
            // top3 olamaz. Olanı da kaldır.
            myCoreData.makeDarkOutfit(cellID: cellID)
            completion(.black)
        }
    }
    
    
    func clearCoreDataFor(_ EntityName: String, ViewController: UIViewController){
        myCoreData.clearCoreDataFor(EntityName, ViewController: ViewController)
    }
    
    
    func getOutfits(EntityName: String, predicateAtribute: String, _ EqualTo: String, completion: @escaping(_ ListOk: Bool, _ resultList: [OutfitClass]) -> Void){
        let resultList = myCoreData.getOutfits(EntityName: EntityName, predicateAtribute: predicateAtribute, EqualTo)
        
        guard let resultList = resultList else{
            return completion(false, [])
        }
        
        if resultList.isEmpty{
            completion(false, resultList)
        }else{
            completion(true, resultList)
        }
        
    }
    
    
    func saveNewOutfit(image: UIImage, comment: String, completion: @escaping(OutifitSavingStatus) -> Void) {
        let flag = myCoreData.saveNewOutfit(image: image, comment: comment)
        
        if flag{
            completion(OutifitSavingStatus.saved)
        }else{
            completion(OutifitSavingStatus.notSaved)
        }
            
    }
}
