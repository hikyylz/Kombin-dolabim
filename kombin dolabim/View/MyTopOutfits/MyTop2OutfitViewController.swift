//
//  MyTop2OutfitViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 29.04.2023.
//

import UIKit

class MyTop2OutfitViewController: UIViewController {
    
    @IBOutlet var firstOne: UIImageView!
    @IBOutlet var secondOne: UIImageView!
    @IBOutlet var firstComment: UILabel!
    @IBOutlet var secondComment: UILabel!
    
    var resultList : [OutfitClass]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let resultList = resultList else{
            return
        }
        
        self.firstOne.image = resultList[0].getImage()
        self.firstComment.text = resultList[0].getComment()
            
        self.secondOne.image = resultList[1].getImage()
        self.secondComment.text = resultList[1].getComment()
        
    }



}
