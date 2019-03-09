//
//  CurrencyTableViewCell.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
	
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var currancyLabel: UILabel!
	@IBOutlet weak var currancyNameLabel: UILabel!
	@IBOutlet weak var rateTextField: UITextField!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
		iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2.0;
		iconImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func configure(for currency: CurrencyItem) {
		self.currancyLabel.text = currency.abbreviation
		self.currancyNameLabel.text = currency.abbreviation
		self.rateTextField.text = String(currency.rate ?? 0)
	}

}
