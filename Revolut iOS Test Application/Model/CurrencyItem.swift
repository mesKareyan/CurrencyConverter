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
}

extension CurrencyItem: Equatable {
	public static func == (lhs: CurrencyItem, rhs: CurrencyItem) -> Bool {
		return lhs.abbreviation == rhs.abbreviation
	}
}


