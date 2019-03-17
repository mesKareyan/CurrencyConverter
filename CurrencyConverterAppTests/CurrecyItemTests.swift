//
//  CurrecyItemTests.swift
//  CurrencyConverterAppTests
//
//  Created by Mesrop Kareyan on 18/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import XCTest
@testable import CurrencyConverterApp

class CurrecyItemTests: XCTestCase {

	func testItemForSelectedValue() {
		//arrange
		let rate = 100.0
		let selectedValue = 2.0
		let item = CurrencyItem(abbreviation: "TestItem", rate: rate, value: 0.0)
		
		//act
		let newItem = item.itemFor(value: selectedValue)
		
		//assert
		XCTAssertEqual(newItem.value, rate * selectedValue)
	}
	
	func testZeroValue() {
		//arrange
		let rate = 100.0
		let item = CurrencyItem(abbreviation: "TestItem", rate: rate, value: 0.0)
		
		//act
		let newItem = item.zeroValueItem()
		
		//assert
		XCTAssertEqual(newItem.value, 0.0)
	}
	
	func testItemsEquality() {
		//arrange
		let item1 = CurrencyItem(abbreviation: "TestItem", rate: 1.0, value: 2.0)
		let item2 = CurrencyItem(abbreviation: "TestItem", rate: 3.0, value: 4.0)
		//act
		let result = item1 == item2
		//assert
		XCTAssertTrue(result);
	}

}
