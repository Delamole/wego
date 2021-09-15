//
//  ExcursionTableViewCell.swift
//  wegotrip
//
//  Created by Владислав Бочаров on 14.09.2021.
//

import UIKit

class ExcursionTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func initCell(item: Excursion){
        name.text = item.name
        DispatchQueue.main.async {
            Loader.shared.loadImage(icon: item.image) { (data) in
            self.img.image = data
            }
        }
    }
}
