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
    @IBOutlet weak var checkBtn: RadioButton!
    @IBOutlet weak var currN: UILabel!
    var checkbuttonPressed: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func checkBtnTapped(_ sender: RadioButton) {
        checkbuttonPressed?()
    }
    
}
