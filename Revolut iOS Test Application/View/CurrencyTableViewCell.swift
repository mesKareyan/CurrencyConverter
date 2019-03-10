//
//  CurrencyTableViewCell.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

protocol CurrencyTableViewCellEditingDelegate: AnyObject {
	
	func currencyCell(at indexPath: IndexPath, didChangeText text: String?)
	func currencyCellDidBeginEditing(at indexPath: IndexPath)
	func currencyCellDidEndEditing(at indexPath: IndexPath)
	
}

class CurrencyTableViewCell: UITableViewCell {
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var currancyLabel: UILabel!
	@IBOutlet weak var currancyNameLabel: UILabel!
	@IBOutlet weak var rateTextField: UITextField!
	var item: CurrencyItem?
	var indexPath: IndexPath!
	weak var delegate: CurrencyTableViewCellEditingDelegate?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2.0;
		iconImageView.clipsToBounds = true
		rateTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
		rateTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func configure(for currency: CurrencyItem) {
		item = currency
		currancyLabel.text = currency.abbreviation
		currancyNameLabel.text = currency.abbreviation
		rateTextField.text = currency.value.setMinTailingDigits()
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		delegate?.currencyCell(at: indexPath, didChangeText: textField.text)
	}

}

extension CurrencyTableViewCell: UITextFieldDelegate {
	
	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		delegate?.currencyCellDidBeginEditing(at: indexPath)
		return true
	}
	
	private func textFieldDidEndEditing(_ textField: UITextField) {
		delegate?.currencyCellDidEndEditing(at: indexPath)
	}
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
	}
	func textFieldShouldClear(_ textField: UITextField) -> Bool {
		return true;
	}
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return true;
	}
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		return true;
	}
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder();
		return true;
	}
	
}

extension Double {
	func setMinTailingDigits() -> String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 2
		return formatter.string(from: self as NSNumber)!
	}
}

extension Optional where Wrapped == Double {
	func setMinTailingDigits() -> String {
		switch self {
		case .none:
			return "0.0"
		case .some(let value):
			return value.setMinTailingDigits()
		}
	}
}

