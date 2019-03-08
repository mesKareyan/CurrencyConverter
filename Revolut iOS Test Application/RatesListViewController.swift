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
	private (set) var listDataSource = CurrencyListDataSource(api: GetCurrencyItemsApi())
	private (set) var listDelegate = CurrencyListDelegate()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.listDataSource.delegate = self
		self.tableView.dataSource = self.listDataSource
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		listDataSource.startUpdating()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		listDataSource.startUpdating()
	}

}

extension RatesListViewController: CurrencyListDataSourceDelegate {
	
	func currencyItemsUpdated() {
		self.tableView.reloadData()
	}
	
	func currencyItemsUpdatingFailed(with error: String?) {
		print(error ?? "")
	}
	
}

class CurrencyListDelegate: NSObject {
}

extension CurrencyListDelegate: UITableViewDelegate {
}

