//
//  GetEmailVC.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 4.04.2023.
//

import UIKit
import Firebase


class GetEmailVC: UIViewController {

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
                    self.makeAlert(M: "error", S: error?.localizedDescription ?? "problem")
                }else{
                    // go..
                    NotificationCenter.default.post(name: NSNotification.Name("newUserSigned"), object: nil)
                    self.dismiss(animated: true)
                }
                    
            }
        }else{
            // alert
            makeAlert(M: "Empty box", S: "please type email and password")
        }
    }
    
    
    
    @IBAction func signIn(_ sender: Any) {
        
        if typedEmail.text != "" && typedPasword.text != ""{
            Auth.auth().signIn(withEmail: typedEmail.text!, password: typedPasword.text!) { authData, error in
                if error != nil{
                    // alert
                    self.makeAlert(M: "error", S: error?.localizedDescription ?? "problem")
                }else{
                    // go..
                    NotificationCenter.default.post(name: NSNotification.Name("newUserSigned"), object: nil)
                    self.dismiss(animated: true)
                }
                    
            }
        }else{
            // alert
            makeAlert(M: "Empty box", S: "please type email and password")
        }
    }
    
    
    
    func makeAlert(M:String , S:String){
        let alert = UIAlertController(title: M, message: S, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}
