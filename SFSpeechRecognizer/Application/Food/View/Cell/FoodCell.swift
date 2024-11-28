//
//  FoodCell.swift
//  SFSpeechRecognizer
//
//  Created by lymanny on 26/11/24.
//

import UIKit

class FoodCell: UITableViewCell {

    //MARK: - @IBOutlet
    @IBOutlet weak var labelPrice : UILabel!
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var imageFood  : UIImageView!
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Function
    func configData(data: FoodItem) {
        imageFood.image = UIImage(named: data.image)
        labelTitle.text = data.name
        labelPrice.text = "\(data.price)$"
    }

}
