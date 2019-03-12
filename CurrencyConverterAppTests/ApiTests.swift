//
//  ApiTests.swift
//
//  Created by Mesrop Kareyan on 12/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import XCTest

@testable import CurrencyConverterApp

var api: Api!
var sessionUnderTest: URLSession!


class ApiTests: XCTestCase {

    override func setUp() {
		api = Api()
		sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
		api = nil
		sessionUnderTest = nil
    }

    func testExample() {
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
