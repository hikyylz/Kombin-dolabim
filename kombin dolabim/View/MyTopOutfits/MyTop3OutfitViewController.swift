//
//  MyTop3OutfitViewController.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 13.04.2023.
//

import UIKit
import FirebaseAuth

class MyTop3OutfitViewController: UIViewController {
    
    @IBOutlet var firstOne: UIImageView!
    @IBOutlet var secondOne: UIImageView!
    @IBOutlet var thirdOne: UIImageView!
    @IBOutlet var firstComment: UILabel!
    @IBOutlet var secondComment: UILabel!
    @IBOutlet var thirdComment: UILabel!
    
    var resultList : [OutfitClass]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        // her açıldığında firebase den top3 outfit imi çeksin ve yukarıdaki imageView larda ekrana göstersin.
        
        // snaplistener kullanmak mantıklı gibi.
        // top3 ü görüntüleyebilmek için önce outfit leri cloud a kaydetmesi lazım geliyor.
        // yoksa gösterilecek bir şey yoktur.
        
        guard let resultList = resultList else{
            return
        }
        self.firstOne.image = resultList[0].getImage()
        self.firstComment.text = resultList[0].getComment()
            
        self.secondOne.image = resultList[1].getImage()
        self.secondComment.text = resultList[1].getComment()
            
        self.thirdOne.image = resultList[2].getImage()
        self.thirdComment.text = resultList[2].getComment()
        
        
    }
    


}
