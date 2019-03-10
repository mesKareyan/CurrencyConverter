//
//  CurrencyListDataSource.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

protocol CurrencyListDataSourceDelegate: AnyObject {
	
	func selectedItemUpdated(from indexPath: IndexPath)
	func currencyItemsUpdated()
	func currencyItemsUpdatingFailed(with error: String?)
	var currencyCellDelegate: CurrencyTableViewCellEditingDelegate {get}
	
}

class CurrencyListDataSource: NSObject {
	
	let api: GetCurrencyItemsApi
	var items:[CurrencyItem] = []
	var selectedItem: CurrencyItem! = CurrencyItem(abbreviation: "EUR",
												   rate: 1.0,
												   value: 100.0)
	var tempItem: CurrencyItem!
	
	weak var delegate: CurrencyListDataSourceDelegate?
	private var timer: Timer?
	
	init(api: GetCurrencyItemsApi) {
		self.api = api
		super.init()
	}
	
	func reloadData(notify: Bool = true) {
		updateData(with: items, notify: notify)
	}
	
	func startUpdating() {
		self.startTimer()
	}
	
	func stopUpdating() {
		self.stopTimer()
	}
	
	private func startTimer() {
		if timer == nil {
			timer = Timer.scheduledTimer(timeInterval: 1,
										 target: self,
										 selector: #selector(updatingLoop),
										 userInfo: nil,
										 repeats: true)
			RunLoop.current.add(timer!, forMode: RunLoop.Mode.default)
		}
	}
	
	private func stopTimer() {
		if timer != nil {
			timer?.invalidate()
			timer = nil
		}
	}
	
	@objc private func updatingLoop() {
		api.getItems(for: selectedItem) { result in
			DispatchQueue.main.async {
				switch result {
				case .failure(message: let errorMessage):
					self.delegate?.currencyItemsUpdatingFailed(with: errorMessage)
				case .success(with: let items):
					print(items.first!.rate)
					self.updateData(with: items)
				}
			}
		}
	}
	
	private func updateData(with items: [CurrencyItem], notify: Bool = true) {
		self.items = items.map { item in
			guard let selectedValue = self.selectedItem?.value, let rate = item.rate else {
				var item = item
				item.value = 0.0
				return item
			}
			var item = item
			item.value = selectedValue * rate
			return item
		}
		if notify {
			self.delegate?.currencyItemsUpdated()
		}
	}

}

// MARK: - UITableViewDataSource

extension CurrencyListDataSource: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return selectedItem == nil ? 0 : 1
		}
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell")!
		if let currencyCell = cell as? CurrencyTableViewCell {
			if indexPath.section == 0 {
				currencyCell.configure(for: selectedItem)
			} else {
				currencyCell.configure(for: items[indexPath.row])
			}
			currencyCell.delegate = self.delegate?.currencyCellDelegate
			currencyCell.indexPath = indexPath
		}
		return cell
	}
	
}

