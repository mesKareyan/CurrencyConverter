//
//  CurrencyCellDelegate.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 10/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

protocol CurrencyListDelegateProtocol: AnyObject, UITableViewDelegate {
}

// MARK: - UITableViewDelegate
class CurrencyListDelegate: NSObject, CurrencyListDelegateProtocol {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? CurrencyTableViewCell {
			tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
			cell.rateTextField.becomeFirstResponder()
		}
	}
}

