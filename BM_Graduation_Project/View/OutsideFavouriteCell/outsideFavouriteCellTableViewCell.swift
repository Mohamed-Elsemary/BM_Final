//
//  outsideFavouriteCellTableViewCell.swift
//  BM_Graduation_Project
//
//  Created by mohamed on 25/08/2023.
//

import UIKit

class outsideFavouriteCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCurrency: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBOutlet weak var currN: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
