//
//  Cloud.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 10.04.2023.
//

import Foundation
import Firebase

class Cloud{
    
    private let currUserEmail : String
    
    init(currUserEmail: String) {
        self.currUserEmail = currUserEmail
    }
    
    func deleteOutfits(completion: @escaping(_ succes: Bool)->()){
        
        let firestoreDB = Firestore.firestore()
        
        let userImageColl = firestoreDB.collection("Users").document(currUserEmail).collection("my collections")
        
        userImageColl.getDocuments { q, e in
            
            guard let data = q?.documents else{
                return
            }
            
            for i in data{
                
                // clod da bir şey sildiğinde içi tamamşyle boşalan her başlık siliniyor .
                userImageColl.document(i.documentID).delete { e in
                    if let _ = e{
                        completion(false)
                    }else{
                        completion(true)
                    }
                }
            }
        }

    }
    
    func saveOutfitsListToCloud(OutfitsList: [OutfitClass], completion: @escaping(_ success: Bool)->()){
        let firestoreDB = Firestore.firestore()
        
        for result in OutfitsList {
            
            if let imageID = result.getID(){
                if let imageData = result.getImage().jpegData(compressionQuality: 0.5){
                    if let imageComment = result.getComment() {
                        if let imageTop3info = result.getTab3() {
                            // eldeki verileri firestore a kaydet..
                            
                            let newOutfitinfo = ["id":imageID.uuidString ,  // id yi tutmaya cidden gerek var mı emin değilim. ???
                                                 "image":imageData ,
                                                 "comment":imageComment ,
                                                 "is image in top3": imageTop3info ] as [String:Any]
                             
                            firestoreDB.collection("Users").document(currUserEmail).collection("my collections").document(imageID.uuidString).setData(newOutfitinfo, merge: true)
                            completion(true)
                            
                        }else{
                            completion(false)
                        }
                    }else{
                        completion(false)
                    }
                }else{
                    completion(false)
                }
            }else{
                completion(false)
            }
        }
        
    }
    
}
