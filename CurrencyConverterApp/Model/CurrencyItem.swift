//
//  CurrencyItem.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import Foundation

struct CurrencyItem {
	
	var abbreviation: String
	var rate: Double?
	var value: Double?
	
	func zeroValueItem() -> CurrencyItem {
		return itemFor(value: 0.0)
	}
	
	func itemFor(value: Double?) -> CurrencyItem {
		let newValue = value ?? 0.0
		let currentRate = rate ?? 0.0
		return CurrencyItem(abbreviation: abbreviation, rate: rate, value: newValue * currentRate)
	}
	
}

extension CurrencyItem: Equatable {
	public static func == (lhs: CurrencyItem, rhs: CurrencyItem) -> Bool {
		return lhs.abbreviation == rhs.abbreviation
	}
}


