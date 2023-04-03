//
//  CollectionsViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import CoreData
import Firebase

class CollectionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var commentArr = [String]()
    var imageDataArr = [Data]()
    var starArr = [Bool]()
    var idArr = [UUID]()

    
    @IBOutlet var collectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionsTableView.delegate = self
        collectionsTableView.dataSource = self
        
        fetchOutfits()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchOutfits()
    }
    
    func fetchOutfits(){
        
        imageDataArr.removeAll()
        commentArr.removeAll()
        starArr.removeAll()
        idArr.removeAll()
        
        let apdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = apdelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Outfit")
        
        if let email = Auth.auth().currentUser?.email as? String{
            fetchRequest.predicate = NSPredicate(format: "owner = %@", email)
        }else{
            return
        }
            
        
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                
                if let imageData = result.value(forKey: "image") as? Data{
                    imageDataArr.append(imageData)
                }
                
                if let comment = result.value(forKey: "comment") as? String{
                    commentArr.append(comment)
                }
                
                if let star = result.value(forKey: "top3") as? Bool{
                    starArr.append(star)
                }
                
                if let id = result.value(forKey: "id") as? UUID{
                    idArr.append(id)
                }
            }
            
            try context.save()
            
        }catch{
            
        }
        
        collectionsTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OutfitTableViewCell
        Cell.cellimageView.image = UIImage(data: imageDataArr[indexPath.row])
        Cell.cellLabel.text = commentArr[indexPath.row]
        if starArr[indexPath.row]{
            Cell.star.backgroundColor = UIColor.orange
        }else{
            Cell.star.backgroundColor = UIColor.black
        }
        Cell.idlabel.text = idArr[indexPath.row].uuidString
        
        return Cell
    }

}
