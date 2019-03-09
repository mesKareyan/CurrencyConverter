//
//  CurrencyListDataSource.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit

protocol CurrencyListDataSourceDelegate: class {
	
	func currencyItemsUpdated()
	func currencyItemsUpdatingFailed(with error: String?)
	
}

class CurrencyListDataSource: NSObject {
	
	var items:[CurrencyItem] = []
	var selectedItem: CurrencyItem = CurrencyItem(abbreviation: "EUR", rate: 1.0)
	let api: GetCurrencyItemsApi
	weak var delegate: CurrencyListDataSourceDelegate?
	private var timer: Timer?
	
	init(api: GetCurrencyItemsApi) {
		self.api = api
		super.init()
	}
	
	func startUpdating() {
		self.startTimer()
	}
	
	func stopUpdating() {
		self.startTimer()
	}
	
	func startTimer() {
		if timer == nil {
			timer = Timer.scheduledTimer(timeInterval: 1,
										 target: self,
										 selector: #selector(updatingLoop),
										 userInfo: nil,
										 repeats: true)
			RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
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
				case .success(with: var items):
					items.insert(self.selectedItem, at: 0)
					self.items = items
					self.delegate?.currencyItemsUpdated()
				}
			}
		}
	}

}

// MARK: - UITableViewDataSource

extension CurrencyListDataSource: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell")!
		if let currencyCell = cell as? CurrencyTableViewCell {
			currencyCell.configure(for: items[indexPath.row])
		}
		return cell
	}
	
}
