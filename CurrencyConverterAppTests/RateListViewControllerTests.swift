//
//  RateListViewControllerTests.swift
//  CurrencyConverterAppTests
//
//  Created by Mesrop Kareyan on 12/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import XCTest
import UIKit

@testable import CurrencyConverterApp

var viewController: RatesListViewController!
var delegate: CurrencyListDelegateMock!
var dataProvider: CurrencyListProvider!
var tableView: UITableView!

class RateListViewControllerTests: XCTestCase {

    override func setUp() {
		viewController = UIStoryboard(name: "Main", bundle: nil)
			.instantiateViewController(withIdentifier: "RatesListViewController") as? RatesListViewController
		delegate = CurrencyListDelegateMock()
		dataProvider = CurrencyListDataPrivider()
	}

    override func tearDown() {
		viewController = nil
    }

	func testCellDidTapAction() {

		//arrange
		viewController.dataProvider = dataProvider
		_ = viewController.view
		let tableView = viewController.tableView!
		dataProvider.tableView = viewController.tableView
		viewController.tableView.delegate = delegate
		viewController.tableView.dataSource = dataProvider as? UITableViewDataSource

		//act
		let indexPath = IndexPath(row: 0, section: 0)
		tableView.delegate!.tableView!(tableView, didSelectRowAt: indexPath)

		//assert
		XCTAssert(delegate.seleted)
    }

}


class CurrencyListDelegateMock: NSObject, CurrencyListDelegateProtocol {
	var seleted = false

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		seleted = true
	}
}

class CurrencyListDataPrivider: NSObject, CurrencyListProvider, UITableViewDataSource {

	var tableView: UITableView!

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

	func startUpdating() {
	}

	func stopUpdating() {
	}

}
