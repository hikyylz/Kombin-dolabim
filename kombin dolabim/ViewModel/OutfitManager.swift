//
//  OutfitManager.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 10.04.2023.
//

import Foundation
import UIKit

enum OutifitSavingStatus{
    case notSaved
    case saved
}

struct OutfitManager{
    
    private let myCoreData = CoreData()
    
    func clearCoreDataFor(_ EntityName: String, ViewController: UIViewController){
        myCoreData.clearCoreDataFor(EntityName, ViewController: ViewController)
    }
    
    func getOutfits(EntityName: String, predicateAtribute: String, _ EqualTo: String, completion: @escaping(_ ListOk: Bool, _ resultList: [OutfitClass]) -> Void){
        let resultList = myCoreData.getOutfits(EntityName: EntityName, predicateAtribute: predicateAtribute, EqualTo)
        
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
