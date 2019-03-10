//
//  RatesListViewController.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

class RatesListViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var listDataSource: CurrencyListDataSource!
	var isNeedToUpdate = true
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = listDataSource
		tableView.delegate = self
		listDataSource.delegate = self
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	    listDataSource.startUpdating()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		listDataSource.stopUpdating()
	}

}

extension RatesListViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? CurrencyTableViewCell {
			cell.rateTextField.becomeFirstResponder()
		}
	}
	
}

extension RatesListViewController: CurrencyListDataSourceDelegate {
	
	var currencyCellDelegate: CurrencyTableViewCellEditingDelegate {
		return self
	}
	
	func selectedItemUpdated(from indexPath: IndexPath) {
	}
	
	func currencyItemsUpdated() {
		self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
	}
	
	func currencyItemsUpdatingFailed(with error: String?) {
		print(error ?? "")
	}
	
}

extension RatesListViewController: CurrencyTableViewCellEditingDelegate {
	
	func currencyCell(at indexPath: IndexPath, didChangeText text: String?) {
		self.listDataSource.selectedItem.value = Double(text ?? "0.0")
		self.listDataSource.reloadData()
	}
	
	func currencyCellDidBeginEditing(at indexPath: IndexPath) {
		if indexPath.section == 1 {
			
			listDataSource.stopUpdating()
			
			let top = IndexPath(row: 0, section: 0)
			let oldSelected = listDataSource.selectedItem!
			let newSelected = listDataSource.items[indexPath.row]
			
			var newItems = listDataSource.items
			newItems.remove(at: indexPath.row)
			newItems.append(oldSelected)
			newItems.sort { $0.abbreviation < $1.abbreviation }
			let oldSelectedItemIndex = newItems.firstIndex(of: oldSelected)!
			
			
			tableView.beginUpdates()
			
			listDataSource.selectedItem = nil
			tableView.deleteRows(at: [top], with: .automatic)
			
			listDataSource.selectedItem = newSelected
			listDataSource.items.remove(at: indexPath.row)
			tableView.moveRow(at: indexPath, to: top)
			
			listDataSource.items.insert(oldSelected, at: oldSelectedItemIndex)
			tableView.insertRows(at: [IndexPath(row: oldSelectedItemIndex, section: 1)], with: .automatic)
			
			tableView.selectRow(at: top, animated: true, scrollPosition: .top)


			tableView.endUpdates()
			
			listDataSource.startUpdating()
		

		}
	}
	
	func currencyCellDidEndEditing(at indexPath: IndexPath) {
	}
	
}



