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
	var tapToHideKeyboardGesture: UITapGestureRecognizer!
	
	//MARK - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = listDataSource
		tableView.delegate = self
		listDataSource.delegate = self
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	    listDataSource.startUpdating()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		listDataSource.stopUpdating()
	}
	
	//MARK - Keyboard
	@objc func keyboardWillShow(notification: Notification) {
		tapToHideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
		self.view.addGestureRecognizer(tapToHideKeyboardGesture)
	}
	
	@objc func keyboardWillHide(notification: Notification) {
		view.removeGestureRecognizer(tapToHideKeyboardGesture)
	}
	
	@objc func endEditing() {
		self.view.endEditing(true)
	}

}

// MARK: - UITableViewDelegate
extension RatesListViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) as? CurrencyTableViewCell {
			cell.rateTextField.becomeFirstResponder()
		}
	}
	
}

// MARK: - CurrencyListDataSourceDelegate
extension RatesListViewController: CurrencyListDataSourceDelegate {
	
	func currencyItemsDidUpdated() {
		self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
	}
	
	func currencyItemsUpdatingDidFailed(with error: String?) {
		print(error ?? "")
	}
	
	var currencyCellDelegate: CurrencyTableViewCellEditingDelegate {
		return self
	}
	
}

// MARK: - CurrencyTableViewCellEditingDelegate
extension RatesListViewController: CurrencyTableViewCellEditingDelegate {
	
	func currencyCell(_ cell: CurrencyTableViewCell, didChangeText text: String?) {
		self.listDataSource.selectedItem.value = Double(text ?? "0.0")
		self.listDataSource.reloadData()
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
		if indexPath.section == 1 {
			listDataSource.stopUpdating()
			let top = IndexPath(row: 0, section: 0)
			let oldSelected = listDataSource.selectedItem!
			let newSelected = listDataSource.items[indexPath.row]
			
			//find selected element position
			var newItems = listDataSource.items
			newItems.remove(at: indexPath.row)
			newItems.append(oldSelected)
			newItems.sort { $0.abbreviation < $1.abbreviation }
			let oldSelectedItemIndex = newItems.firstIndex(of: oldSelected)!
			tableView.beginUpdates()
			
			//replace first element with selected one
			listDataSource.selectedItem = nil
			tableView.deleteRows(at: [top], with: .automatic)
			listDataSource.selectedItem = newSelected
			listDataSource.items.remove(at: indexPath.row)
			tableView.moveRow(at: indexPath, to: top)
			
			//insert previous selected element at right position
			listDataSource.items.insert(oldSelected, at: oldSelectedItemIndex)
			tableView.insertRows(at: [IndexPath(row: oldSelectedItemIndex, section: 1)], with: .automatic)
			
			//scrol to top
			tableView.selectRow(at: top, animated: true, scrollPosition: .top)
			tableView.endUpdates()
			listDataSource.startUpdating()
		}
	}
	
}



