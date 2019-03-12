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

fileprivate var viewController: RatesListViewController!
fileprivate var delegate: CurrencyListDelegateMock!
fileprivate var dataProvider: CurrencyListDataPrividerMock!
fileprivate var tableView: UITableView!

class RateListViewControllerTests: XCTestCase {

    override func setUp() {
		viewController = UIStoryboard(name: "Main", bundle: nil)
			.instantiateViewController(withIdentifier: "RatesListViewController") as? RatesListViewController
		delegate = CurrencyListDelegateMock()
		dataProvider = CurrencyListDataPrividerMock()
		viewController.dataProvider = dataProvider
	}

    override func tearDown() {
		viewController = nil
    }

	func testCellDidTapAction() {

		//arrange
		_ = viewController.view
		let tableView = viewController.tableView!
		dataProvider.tableView = viewController.tableView
		viewController.tableView.delegate = delegate
		viewController.tableView.dataSource = dataProvider

		//act
		let indexPath = IndexPath(row: 0, section: 0)
		tableView.delegate!.tableView!(tableView, didSelectRowAt: indexPath)

		//assert
		XCTAssert(delegate.seleted)
    }
	
	func testThatDataStartReloadingOnWillAppear() {
		viewController.viewWillAppear(true)
		XCTAssert(dataProvider.isUpdating, "DataSource didn't start updateing")
	}
	
	func testThatDataStopReloadingOnWillDisapper() {
		viewController.viewWillDisappear(true)
		XCTAssert(!dataProvider.isUpdating, "DataSource didn't stop updated")
	}
	
	func testEndEditing() {
		viewController.endEditing()
		XCTAssert(!viewController.view.isFirstResponder, "Editing ended")
	}
	
	func testKeyboardWillShow() {
		viewController.keyboardWillShow(notification: Notification(name: Notification.Name(rawValue: "TestNotification")))
		XCTAssert(viewController.tapToHideKeyboardGesture != nil, "Tap gesture added")
	}
	
	func testKeyboardWillHide() {
		viewController.keyboardWillHide(notification: Notification(name: Notification.Name(rawValue: "TestNotification")))
		XCTAssert(viewController.tapToHideKeyboardGesture == nil, "Tap gesture removed")
	}

}

class CurrencyListDelegateMock: NSObject, CurrencyListDelegateProtocol {
	
	var seleted = false

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		seleted = true
	}
	
}

class CurrencyListDataPrividerMock: NSObject, CurrencyListProvider, UITableViewDataSource {

	var tableView: UITableView!
	private (set) var isUpdating = false

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

	func startUpdating() {
		isUpdating = true
	}

	func stopUpdating() {
		isUpdating = false
	}

}
