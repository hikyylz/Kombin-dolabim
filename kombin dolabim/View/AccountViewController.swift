//
//  AccountViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    @IBOutlet var emailLabel: UILabel!
    var resultList : [OutfitClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailLabel.text = "Email: \(Auth.auth().currentUser?.email ?? " none") "
        if Auth.auth().currentUser == nil{
            AlertClass.SequeAfterAlert(E: "You didnot Log in", M: "Please log in", ViewController: self, sequeName: "toGetEmailVC")
            // make alert i bekle ve email , sonra tekrar bas ekrana...
            
            NotificationCenter.default.addObserver(self, selector: #selector( refreshEmailLabel ), name: NSNotification.Name("newUserSigned"), object: nil)
        }
    }
    
    @objc func refreshEmailLabel(){
        emailLabel.text = "Email: \(Auth.auth().currentUser?.email ?? " none") "
    }

    
    @IBAction func showtop3(_ sender: Any) {
        guard let email = Auth.auth().currentUser?.email else{
            return
        }
        let myOutfitManager = OutfitManager(currUserEmail: email)
        myOutfitManager.getDataFromCloud { resultList, isEmpty in
            if isEmpty{
                // dondürülen listede bir şey yok
                // önce cloud a kaydedin diye uyarı mesajı verdirt.
                AlertClass.makeAlertWith(M: "Alert", S: "Firstly you have to save outfits into cloud", ViewController: self)
                self.performSegue(withIdentifier: "toGetEmailVC", sender: nil)
            }else{
                
                self.resultList = resultList
                // listedeki Outfit leri imageViewlara yerleştir.
                switch resultList.count{
                case 1:
                    self.performSegue(withIdentifier: "ToMyTop1VC", sender: nil)
                case 2:
                    self.performSegue(withIdentifier: "ToMyTop2VC", sender: nil)
                case 3:
                    self.performSegue(withIdentifier: "ToMyTop3VC", sender: nil)
                default:
                    break
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMyTop1VC"{
            if let DVC = segue.destination as? MyTop1OutfitViewController{
                DVC.resultList = self.resultList
            }
        }else if segue.identifier == "ToMyTop2VC"{
            if let DVC = segue.destination as? MyTop2OutfitViewController{
                DVC.resultList = self.resultList
            }
        }else if segue.identifier == "ToMyTop3VC"{
            if let DVC = segue.destination as? MyTop3OutfitViewController{
                DVC.resultList = self.resultList
            }
        }
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toStartVC", sender: nil)
        }catch{
            
        }
    }
    

}
