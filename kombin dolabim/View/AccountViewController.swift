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
        performSegue(withIdentifier: "ToMyTop3VC", sender: nil)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toStartVC", sender: nil)
        }catch{
            
        }
    }
    

}
