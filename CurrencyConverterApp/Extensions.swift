//
//  Extensions.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 10/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import Foundation

class Foramtter {
	private init() {}
	static let numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 2
		return formatter
	} ()
}

extension Double {
	var stringValue: String {
		if self == 0.0 { return "" }
		return Foramtter.numberFormatter.string(from: self as NSNumber)!
	}
}

extension Optional where Wrapped == Double {
	var stringValue: String {
		switch self {
		case .none:
			return ""
		case .some(let value):
			return value.stringValue
		}
	}
}

extension String {
	var decimalValue: Double {
		if let result = Foramtter.numberFormatter.number(from: self) {
			return result.doubleValue
		}
		return 0.0
	}
}

extension Optional where Wrapped == String {
	var decimalValue: Double {
		switch self {
		case .none:
			return 0.0
		case .some(let value):
			return value.decimalValue
		}
	}
}
