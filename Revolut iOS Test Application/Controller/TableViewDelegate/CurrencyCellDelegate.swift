//
//  CurrencyCellDelegate.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 10/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate
class CurrencyListDelegate: NSObject, UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? CurrencyTableViewCell {
			cell.rateTextField.becomeFirstResponder()
		}
	}
}

