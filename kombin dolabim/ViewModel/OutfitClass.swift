//
//  OutfitClass.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 8.04.2023.
//

import Foundation
import CoreData
import UIKit

class OutfitsList{
    
    private var Outfits = [OutfitClass]()
    
    init(via fetchResult: [NSFetchRequestResult]){
        
        for result in fetchResult as! [NSManagedObject]{
            
            if let imageData = result.value(forKey: "image") as? Data{
                if let comment = result.value(forKey: "comment") as? String{
                    if let star = result.value(forKey: "top3") as? Bool{
                        if let id = result.value(forKey: "id") as? UUID{
                            
                            let newOutfit = OutfitClass(imageData: imageData, id: id, comment: comment, tab3: star)
                            Outfits.append(newOutfit)
                            
                        }
                    }
                }
            }
            
        }
        
    }
    
    func getOutFitList() -> [OutfitClass]{
        return Outfits
    }
}




class OutfitClass{
    
    private var imageData : Data
    private var id : UUID
    private var comment : String
    private var tab3 : Bool
    
    init(imageData: Data, id: UUID, comment: String, tab3: Bool) {
        self.imageData = imageData
        self.id = id
        self.comment = comment
        self.tab3 = tab3
    }
    
    func getImage() -> UIImage{
        return UIImage(data: imageData)!
    }
    
    func getComment() -> String?{
        return comment
    }
    
    func getTab3() -> Bool?{
        return tab3
    }
    
    func getID() -> UUID?{
        return id
    }
}
