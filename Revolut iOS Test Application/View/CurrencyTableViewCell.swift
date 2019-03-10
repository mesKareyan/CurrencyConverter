//
//  CurrencyTableViewCell.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

protocol CurrencyTableViewCellEditingDelegate: AnyObject {
	func currencyCell(_ cell: CurrencyTableViewCell, didChangeText text: String?)
	func currencyCellDidBeginEditing(_ cell: CurrencyTableViewCell)
	func currencyCellDidEndEditing(_ cell: CurrencyTableViewCell)
}

class CurrencyTableViewCell: UITableViewCell {
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var currancyLabel: UILabel!
	@IBOutlet weak var currancyNameLabel: UILabel!
	@IBOutlet weak var rateTextField: UITextField!
	@IBOutlet weak var bottomLineView: UIView!
	
	var item: CurrencyItem?
	weak var delegate: CurrencyTableViewCellEditingDelegate?
	
	private struct Colors {
		private init() {}
		static let selectedColor = UIColor.blue
		static let deselectedColor = UIColor.groupTableViewBackground
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2.0;
		iconImageView.clipsToBounds = true
		rateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		rateTextField.delegate = self
    }
	
	func configure(for currency: CurrencyItem) {
		item = currency
		if let currecyItem = Currency.Item(rawValue: currency.abbreviation) {
			iconImageView.image = UIImage(named: currency.abbreviation)
			currancyNameLabel.text = currecyItem.countryName
		}
		currancyLabel.text = currency.abbreviation
		rateTextField.text = currency.value.stringValue
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		delegate?.currencyCell(self, didChangeText: textField.text)
	}

}

extension CurrencyTableViewCell: UITextFieldDelegate {
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		delegate?.currencyCellDidBeginEditing(self)
		return true
	}
	
	private func textFieldDidEndEditing(_ textField: UITextField) {
		delegate?.currencyCellDidEndEditing(self)
		bottomLineView.backgroundColor = Colors.deselectedColor
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		bottomLineView.backgroundColor = Colors.selectedColor
	}
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		return true;
	}
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		bottomLineView.backgroundColor = Colors.deselectedColor
		return true;
	}
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let text = textField.text else { return true }
		let newLength = text.count + string.count - range.length
		return newLength <= 10
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		bottomLineView.backgroundColor = Colors.deselectedColor
		textField.resignFirstResponder();
		return true;
	}
	
}


