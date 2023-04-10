//
//  GetEmailVC.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 4.04.2023.
//

import UIKit
import Firebase


class GetEmailViewController: UIViewController {

    @IBOutlet var typedEmail: UITextField!
    @IBOutlet var typedPasword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if typedEmail.text != "" && typedPasword.text != ""{
            Auth.auth().createUser(withEmail: typedEmail.text!, password: typedPasword.text!) { authData, error in
                if error != nil{
                    // alert
                    AlertClass.makeAlertWith(S: error?.localizedDescription ?? "problem", ViewController: self)
                }else{
                    // go..
                    NotificationCenter.default.post(name: NSNotification.Name("newUserSigned"), object: nil)
                    self.dismiss(animated: true)
                }
                    
            }
        }else{
            // alert
            AlertClass.makeAlertWith(M: "Empty box", S: "please type email and password", ViewController: self)
        }
    }
    
    
    
    @IBAction func signIn(_ sender: Any) {
        
        if typedEmail.text != "" && typedPasword.text != ""{
            Auth.auth().signIn(withEmail: typedEmail.text!, password: typedPasword.text!) { authData, error in
                if error != nil{
                    // alert
                    AlertClass.makeAlertWith(S: error?.localizedDescription ?? "problem", ViewController: self)
                }else{
                    // go..
                    NotificationCenter.default.post(name: NSNotification.Name("newUserSigned"), object: nil)
                    self.dismiss(animated: true)
                }
                    
            }
        }else{
            // alert
            AlertClass.makeAlertWith(M: "Empty box", S: "please type email and password", ViewController: self)
        }
    }
    
    
    
}
