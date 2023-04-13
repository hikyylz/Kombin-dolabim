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
    
    private let navigationTitle = "Collections from Cloud"
    private var userEmail = String()
    private var Outfits = [OutfitClass]()
    private let myOutfitManager = OutfitManager()
    @IBOutlet var collectionsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionsTableView.delegate = self
        collectionsTableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: navigationTitle, style: .plain, target: self, action: #selector(getCollection))
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // log in olmadan collection göremezsin diye uyar ve log in olmasını sağla.
        if Auth.auth().currentUser?.email == nil{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            }
            
        }else{
            // load data ...
            userEmail = Auth.auth().currentUser?.email ?? ""
            myOutfitManager.getOutfits(EntityName: "Outfit", predicateAtribute: "owner", userEmail) { ListOk, resultList in
                if ListOk{
                    self.Outfits = resultList
                    self.collectionsTableView.reloadData()
                }else{
                    AlertClass.makeAlertWith(M: "Collection Display Error", S: "Collections could not prepared", ViewController: self)
                }
            }
        }
    }
    
    @objc func getCollection(){
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Outfits.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OutfitTableViewCell
        Cell.cellimageView.image = self.Outfits[indexPath.row].getImage()
        Cell.cellLabel.text = self.Outfits[indexPath.row].getComment()
        if self.Outfits[indexPath.row].getTab3()!{
            Cell.star.backgroundColor = UIColor.orange
        }else{
            Cell.star.backgroundColor = UIColor.black
        }
        Cell.idlabel.text = self.Outfits[indexPath.row].getID()?.uuidString
        return Cell
    }

}
