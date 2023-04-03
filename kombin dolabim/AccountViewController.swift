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

        if Auth.auth().currentUser != nil{
            emailLabel.text = "Email: \(Auth.auth().currentUser?.email ?? "none") "
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            emailLabel.text = "Email: \(Auth.auth().currentUser?.email ?? "none") "
        }
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
