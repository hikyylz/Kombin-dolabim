//
//  Error.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 8.04.2023.
//

import Foundation
import UIKit

class ErrorClass{
    
    
    static func makeAlertWith(M: String = "error", S: String = "problem", ViewController: UIViewController){
        let alert = UIAlertController(title: M, message: S, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default)
        alert.addAction(ok)
        ViewController.present(alert, animated: true)
    }
    
    static func SequeAfterAlert(E: String, M: String , ViewController: UIViewController, sequeName: String) {
        let alert = UIAlertController(title: E, message: M, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { _ in
            ViewController.performSegue(withIdentifier: sequeName, sender: nil)
        }
        alert.addAction(ok)
        ViewController.present(alert, animated: true)
    }
    
}
