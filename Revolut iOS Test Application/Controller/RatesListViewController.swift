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
			
			let oldSelected = listDataSource.selectedItem!
			listDataSource.selectedItem = nil
			tableView.reloadData()
			
			let newSelected = listDataSource.items.remove(at: indexPath.row)
			listDataSource.selectedItem = newSelected
			tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
			
			listDataSource.items.insert(oldSelected, at: 1)
			tableView.insertRows(at: [IndexPath(row: 0, section: 1)], with: .left)
			//tableView.reloadData()
			listDataSource.reloadData(notify: true)
		}
	}
	
	func currencyCellDidEndEditing(at indexPath: IndexPath) {
	}
	
}



