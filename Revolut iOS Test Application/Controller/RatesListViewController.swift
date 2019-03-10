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
		listDataSource.stopUpdating()
		self.listDataSource.selectedItem.value = Double(text ?? "0.0")
		self.listDataSource.reloadData()
	}
	
	func currencyCellDidBeginEditing(at indexPath: IndexPath) {
		listDataSource.stopUpdating()
		if indexPath.row == 1 {
			
			let selected = listDataSource.selectedItem!
			let currencyItem = listDataSource.items.remove(at: indexPath.row)
			listDataSource.selectedItem = currencyItem
			tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
//			listDataSource.reloadData(notify: true)
		}
	}
	
	func currencyCellDidEndEditing(at indexPath: IndexPath) {
		listDataSource.stopUpdating()
	}
	
}



