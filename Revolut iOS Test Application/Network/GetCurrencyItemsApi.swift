//
//  GetCurrencyItemsApi.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import Foundation

private struct Endpoint {
	private init() {}
	static let base = "https://revolut.duckdns.org/latest"
}

enum CurrencyItemsRequestResult {
	case success(with: [CurrencyItem])
	case failure(message: String?)
}
typealias CurrencyItemsCompletion = (CurrencyItemsRequestResult) -> ()

class GetCurrencyItemsApi: Api {
	
	var resultSerialiser = CurrencyItemsSerialaizer()
	
	private struct ApiEndpoint {
		private init() {}
		static let base = "https://revolut.duckdns.org/latest"
	}
	
	func getItems(for currency:CurrencyItem, comletion: @escaping CurrencyItemsCompletion) {
		getItemsData(for: currency) { (result) in
			switch result {
			case let .failure(with: error):
				comletion(.failure(message: error.errorDescription))
			case let .success(with: data):
				let items = self.resultSerialiser.itemsFrom(data: data)
				comletion(.success(with: items))
			}
		}
	}
	
	private func getItemsData(for currency:CurrencyItem, comletion: @escaping NetworkRequestComletion) {
		var components = URLComponents(string: ApiEndpoint.base)!
		components.queryItems = [
			URLQueryItem(name: "base", value: currency.abbreviation)
		]
		guard let url = components.url else {
			comletion(.failure(with: .invalidURL))
			return
		}
		getRequest(url: url, comletion: comletion)
	}
	
}


class CurrencyItemsSerialaizer {
	
	func itemsFrom(data: Data) -> [CurrencyItem] {
		guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
			let rates = json?["rates"] as? [String: Double] else {
				return []
		}
		return rates.map {key, value in CurrencyItem(abbreviation: key, rate: value, value: 0)}
			.sorted { $0.abbreviation < $1.abbreviation }
	}
	
}

