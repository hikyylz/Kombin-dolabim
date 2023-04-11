//
//  OutfitTableViewCell.swift
//  kombin dolabim
//
//  Created by Kaan Yıldız on 19.02.2023.
//

import UIKit
import CoreData

class OutfitTableViewCell: UITableViewCell {

    @IBOutlet var cellimageView: UIImageView!
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var star: UIView!
    @IBOutlet var idlabel: UILabel!
    
    private let myOutfitManager = OutfitManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func top3Tapped(_ sender: Any) {
        myOutfitManager.top3Tapped(cellID: idlabel.text!) { ReturnedColor in
            self.star.backgroundColor = ReturnedColor
        }
    }
    
    
    
}
