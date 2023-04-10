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

class EntranceOfApp: UIViewController {

    @IBOutlet var emailF: UITextField!
    @IBOutlet var passwordF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
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
    
    
    
    @IBAction func saveTapped(_ sender: Any) {
        // new user bilgilerini girer, kaydolur, app açılır...
        
    }
    
    
    
}

