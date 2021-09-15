//
//  StepsTableViewCell.swift
//  wegotrip
//
//  Created by Владислав Бочаров on 14.09.2021.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var nameStepLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initCell(item: Step){
        nameStepLabel.text = item.name
        DispatchQueue.main.async {
            Loader.shared.loadImage(icon: item.images[0]) { (data) in
            self.img.image = data
            }
        }
    }
}
