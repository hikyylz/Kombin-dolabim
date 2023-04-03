//
//  OutfitTableViewCell.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import CoreData

class OutfitTableViewCell: UITableViewCell {

    // kaan github
    
    @IBOutlet var cellimageView: UIImageView!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var star: UIView!
    @IBOutlet var idlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func top3Tapped(_ sender: Any) {
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        fetchRequest.predicate = NSPredicate(format: "id = %@", idlabel.text!)
        
        if star.backgroundColor == UIColor.orange {
            // zaten seçili yıldızı kaldır..
            
            do{
                let results = try context.fetch(fetchRequest)
                
                for result in results as![NSManagedObject]{
                    
                    if let id = result.value(forKey: "id") as? UUID{
                        
                        if idlabel.text! == id.uuidString {
                            // star lama bu id li outfit i..
                            result.setValue(false, forKey: "top3")
                            star.backgroundColor = UIColor.black
                        }
                    }
                }
                
                try context.save()
                
            }catch{
                
            }
            
        }else{
            // seç nunu şimdi..
            
            
            do{
                let results = try context.fetch(fetchRequest)
                
                for result in results as![NSManagedObject]{
                    
                    if let id = result.value(forKey: "id") as? UUID{
                        let canBeTop3 = canbetop3()
                        if canBeTop3 && idlabel.text! == id.uuidString {
                            // star la bu id li outfit i..
                            result.setValue(true, forKey: "top3")
                            star.backgroundColor = UIColor.orange
                        }
                    }
                }
                
                try context.save()
                
            }catch{
                
            }
        }
        
        
        
        
        
        
        
        
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
            
        }catch{
            
        }
        
        if starCounter < 3{
            return true
        }else{
            return false
        }
    }
    
}
