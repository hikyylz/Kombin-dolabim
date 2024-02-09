//
//  ViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//


/*
 Bu projeyi 21şubat2023 gününde ilerletmeyi durduruyorum. birkaç gündür buna bakmıştım.
 
 */
import UIKit
import LocalAuthentication
import FirebaseAuth

class EntranceOfApp: UIViewController {

    @IBOutlet var emailF: UITextField!
    @IBOutlet var passwordF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func viaFaceIDTapped(_ sender: Any) {
        
        let autContext = LAContext()
        var error: NSError?
        
        if autContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            autContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "is it you?") { succes, error in
                // eğer faceid ile giriş yapılabilirse succes true, false oterwise.
                if succes{
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toTabVC", sender: nil)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        AlertClass.makeAlertWith(ViewController: self)
                    }
                }
            }
        }
    }
    
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if emailF.text != "" && passwordF.text != ""{
            Auth.auth().createUser(withEmail: emailF.text!, password: passwordF.text!) { _ , error in
                if let error = error{
                    // sign up not succesful
                    AlertClass.makeAlertWith(ViewController: self)
                }
                // sign up succesful
                self.performSegue(withIdentifier: "toTabVC", sender: nil)
            }
        }
    }
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        if emailF.text != "" && passwordF.text != ""{
            Auth.auth().signIn(withEmail: emailF.text!, password: passwordF.text!) { _ , error in
                if let error = error{
                    // sign in not succesful
                    AlertClass.makeAlertWith(ViewController: self)
                }
                // sign in succesful
                self.performSegue(withIdentifier: "toTabVC", sender: nil)
            }
        }
    }
    
    
    
}

