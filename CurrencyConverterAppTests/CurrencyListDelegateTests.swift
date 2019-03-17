//
//  CurrencyListDelegateTests.swift
//  CurrencyConverterAppTests
//
//  Created by Mesrop Kareyan on 17/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import XCTest
@testable import CurrencyConverterApp

fileprivate var testDelegate: CurrencyListDelegate!
fileprivate var testDataSource: TableViewDataSourceMock!
fileprivate var tableView: UITableView!
fileprivate var rateTextField: RateTextFiledMock!

class CurrencyListDelegateTests: XCTestCase {

    override func setUp() {
		testDelegate = CurrencyListDelegate()
		testDataSource = TableViewDataSourceMock()
		tableView = UITableView()
		rateTextField = RateTextFiledMock()
		tableView.delegate = testDelegate
		tableView.dataSource = testDataSource
    }

    override func tearDown() {
		testDelegate = nil
		testDataSource = nil
        tableView = nil
		rateTextField = nil
    }
	
	func testThatBecomeFirstResponderIsCalled() {
		//arrange
		tableView.reloadData()
		let indexPath = IndexPath(row: 0, section: 0)
		let cell = tableView.cellForRow(at: indexPath) as! CurrencyTableViewCell
		cell.rateTextField = rateTextField
		
		//act
		testDelegate.tableView(tableView, didSelectRowAt: indexPath)
		
		//assert
		let textField = cell.rateTextField as! RateTextFiledMock
		XCTAssertTrue(textField.isBecomeFirstResponderCalled, "Text filed isnt selected")
	}
}

fileprivate class TableViewDataSourceMock: NSObject, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let currecnyCell = CurrencyTableViewCell()
		currecnyCell.rateTextField = rateTextField
		return CurrencyTableViewCell()
	}
	
}

fileprivate class RateTextFiledMock: UITextField {
	
	private(set) var isBecomeFirstResponderCalled: Bool = false
	
	override var canBecomeFirstResponder: Bool {
		return true
	}

	override func becomeFirstResponder() -> Bool {
		isBecomeFirstResponderCalled = true
		return super.becomeFirstResponder()
	}
	
}

