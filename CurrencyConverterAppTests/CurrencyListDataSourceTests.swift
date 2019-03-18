//
//  CurrencyListDataSourceTests.swift
//  CurrencyConverterAppTests
//
//  Created by Mesrop Kareyan on 17/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import XCTest
@testable import CurrencyConverterApp


fileprivate var dataSource: CurrencyListDataSource!
fileprivate var tableView: UITableView!
fileprivate var apiMock: GetCurrencyItemsApiMock!
fileprivate var testExpectation: XCTestExpectation!


class CurrencyListDataSourceTests: XCTestCase {

    override func setUp() {
		super.setUp()
		apiMock = GetCurrencyItemsApiMock()
		dataSource = CurrencyListDataSource(api: apiMock)
		tableView = UITableView()
		dataSource.tableView = tableView
    }

    override func tearDown() {
		dataSource = nil
		tableView = nil
		apiMock = nil
		testExpectation = nil
		super.tearDown()
    }
	
	func testReloadData() {
		//arrange
		let testSelectedValue = 2.0
		let testRate = 4.0
		dataSource.selectedItem = CurrencyItem(abbreviation: "TestItem", rate: 0.0, value: testSelectedValue)
		dataSource.items = [CurrencyItem(abbreviation: "TestItem", rate: testRate, value: 0.0)]
		
		//act
		dataSource.reloadData()
		
		//assert
		XCTAssertEqual(dataSource.items.first!.value, testSelectedValue * testRate, "Currrency items updated not correctly");
	}
	
	func testStartUpdating() {
		
		//arrange
		dataSource.selectedItem = CurrencyItem(abbreviation: "TestItem", rate: 0.0, value: 100.0)
		apiMock.isGetItemsCalled = false
		
		//act
		dataSource.startUpdating()
		
		//assert
		testExpectation = self.expectation(description: #function)
		waitForExpectations(timeout: 2)
		
		XCTAssertTrue(apiMock.isGetItemsCalled, "Items not updated from api")
		
	}
	
	func testStopUpdating() {
		//arrange
		dataSource.startUpdating()
		
		//act
		dataSource.stopUpdating()
		
		//assert
		XCTAssertNil(dataSource.timer, "Timer's active after stopUpdating")
	}
	
	//Mark - Cell delegate
	
	func testCurrencyCellTextChangeText() {
		
		//arrange
		let testValue = "12,3"
		let cell = CurrencyTableViewCell()
		dataSource.selectedItem = CurrencyItem(abbreviation: "TestItem", rate: 0.0, value: 100.0)
		
		//act
		dataSource.currencyCell(cell, didChangeText: testValue)
		
		//assert
		XCTAssertEqual(dataSource.selectedItem.value, testValue.decimalValue)
		
	}


}

fileprivate class GetCurrencyItemsApiMock: GetCurrencyItemsApi {
	
	var isGetItemsCalled = false
	
	override func getItems(for currency: CurrencyItem, comletion: @escaping CurrencyItemsCompletion) {
		isGetItemsCalled = true
		testExpectation.fulfill()
		testExpectation = nil
		comletion(.success(with: [CurrencyItem(abbreviation: "TestItem", rate: 1.0, value: 1.0)]))
	}
	
}
