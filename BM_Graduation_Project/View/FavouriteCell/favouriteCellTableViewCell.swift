//
//  favouriteCellTableViewCell.swift
//  BM_Graduation_Project
//
//  Created by mohamed on 24/08/2023.
//

import UIKit

class favouriteCellTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCurrency: UIImageView!
    @IBOutlet weak var currencyRate: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

