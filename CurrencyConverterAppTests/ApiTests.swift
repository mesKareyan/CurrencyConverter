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

}
