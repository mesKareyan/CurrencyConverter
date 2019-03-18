//
//  CurrencyTableViewCellTests.swift
//  CurrencyConverterAppTests
//
//  Created by Mesrop Kareyan on 18/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import XCTest
import UIKit
@testable import CurrencyConverterApp

fileprivate var currancyLabel: UILabel!
fileprivate var rateTextField: UITextField!

class CurrencyTableViewCellTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		currancyLabel = UILabel()
		rateTextField = UITextField()
	}
	
	override func tearDown() {
		currancyLabel = nil
		rateTextField = nil
		super.tearDown()
	}
	
	func testConfigureForCurrencyItem() {
		//arrange
		let cell = CurrencyTableViewCell(frame: .zero)
		cell.currancyLabel = currancyLabel
		cell.rateTextField = rateTextField
		let currency = CurrencyItem(abbreviation: "TestItem", rate: 1.0, value: 2.0)
		
		//act
		cell.configure(for: currency)
		
		//assert
		XCTAssertEqual(cell.currancyLabel.text, currency.abbreviation)
		XCTAssertEqual(cell.rateTextField.text, currency.value.stringValue)
		
	}

	func testTextMaxLength() {
		//arrange
		let cell = CurrencyTableViewCell(frame: .zero)
		cell.rateTextField = rateTextField
		rateTextField.delegate = cell
		rateTextField.text = "0123456789";
		
		//act

		let result = cell.textField(rateTextField, shouldChangeCharactersIn: NSRange(location: 0, length: 10), replacementString: "0123456789a")
		
		//assert
		XCTAssertFalse(result)
	}

}
