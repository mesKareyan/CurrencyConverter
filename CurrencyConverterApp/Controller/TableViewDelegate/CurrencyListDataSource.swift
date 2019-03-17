//
//  CurrencyListDataSource.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import UIKit


class CurrencyListDataSource: NSObject, CurrencyListProvider {
	
	let api: GetCurrencyItemsApi
	var items: [CurrencyItem] = []
	private(set) var timer: Timer?
	weak var tableView:UITableView! {
		didSet {
			tableView.dataSource = self
		}
	}
	var selectedItem: CurrencyItem! = CurrencyItem(abbreviation: "EUR",
												   rate: 1.0,
												   value: 100.0)
	
	init(api: GetCurrencyItemsApi) {
		self.api = api
		super.init()
	}
	
	func reloadData() {
		updateData(with: items)
	}
	
	func startUpdating() {
		startTimer()
	}
	
	func stopUpdating() {
		stopTimer()
	}
	
	private func startTimer() {
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
		guard let selectedItem = selectedItem else {
			return
		}
		api.getItems(for: selectedItem) { result in
			DispatchQueue.main.async {
				switch result {
				case .failure(message: let errorMessage):
					print(errorMessage ?? "")
				case .success(with: let items):
					self.updateData(with: items)
				}
			}
		}
	}
	
	private func updateData(with items: [CurrencyItem]) {
		self.items = items.map {$0.itemFor(value: selectedItem?.value)}
		tableView?.reloadSections(IndexSet(integer: 1), with: .none)
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
			currencyCell.delegate = self
		}
		return cell
	}
	
}



