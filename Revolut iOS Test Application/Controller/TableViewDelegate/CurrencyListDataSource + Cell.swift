//
//  CurrencyListDataSource + Cell.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 10/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

// MARK: - CurrencyTableViewCellEditingDelegate
extension CurrencyListDataSource: CurrencyTableViewCellEditingDelegate {
	
	func currencyCell(_ cell: CurrencyTableViewCell, didChangeText text: String?) {
		selectedItem.value = text?.decimalValue
		reloadData()
	}
	
	func currencyCellDidBeginEditing(_ cell: CurrencyTableViewCell) {
		guard let indexPath = tableView.indexPath(for: cell) else {
			return
		}
		moveSelectedItemToTop(form: indexPath)
	}
	
	func currencyCellDidEndEditing(_ cell: CurrencyTableViewCell) {
	}
	
	func moveSelectedItemToTop(form indexPath: IndexPath) {
		guard let oldSelectedItem = selectedItem, indexPath.section == 1 else {
			return
		}
		stopUpdating()
		let top = IndexPath(row: 0, section: 0)
		let newSelectedItem = items[indexPath.row]
		
		//find selected element position
		var newItems = items
		newItems.remove(at: indexPath.row)
		newItems.append(oldSelectedItem)
		newItems.sort { $0.abbreviation < $1.abbreviation }
		let oldSelectedItemIndex = newItems.firstIndex(of: oldSelectedItem)!
		tableView.beginUpdates()
		
		//replace first element with selected one
		selectedItem = nil
		tableView.deleteRows(at: [top], with: .automatic)
		selectedItem = newSelectedItem
		items.remove(at: indexPath.row)
		tableView.moveRow(at: indexPath, to: top)
		
		//insert previous selected element at right position
		items.insert(oldSelectedItem, at: oldSelectedItemIndex)
		tableView.insertRows(at: [IndexPath(row: oldSelectedItemIndex, section: 1)], with: .automatic)
		
		//scrol to top
		tableView.selectRow(at: top, animated: true, scrollPosition: .top)
		tableView.endUpdates()
		startUpdating()
	}
	
}
