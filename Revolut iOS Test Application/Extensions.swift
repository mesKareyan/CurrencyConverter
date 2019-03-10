//
//  Extensions.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 10/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import Foundation

extension Double {
	func setMinTailingDigits() -> String {
		if self == 0.0 { return "" }
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = 2
		return formatter.string(from: self as NSNumber)!
	}
}

extension Optional where Wrapped == Double {
	func setMinTailingDigits() -> String {
		switch self {
		case .none:
			return ""
		case .some(let value):
			return value.setMinTailingDigits()
		}
	}
}
