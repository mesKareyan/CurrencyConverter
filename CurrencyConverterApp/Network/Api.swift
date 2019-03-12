//
//  Api.swift
//  Revolut iOS Test Application
//
//  Created by Mesrop Kareyan on 08/03/2019.
//  Copyright © 2019 Mesrop Kareyan. All rights reserved.
//

import Foundation

typealias NetworkRequestComletion = (NetworkRequestResult) -> ()

enum NetworkRequestResult {
	case success(with: Data)
	case failure(with: NetworkRequestError)
}

enum NetworkRequestError: Error {
	case invalidURL
	case invalidData
	case badResponse
	case badHttpResponse(HTTPURLResponse)
	case unknown(Error)
}

extension NetworkRequestError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .badResponse , .invalidData, .invalidURL:
			return "The operation couldn’t be completed";
		case let .unknown(error):
			return error.localizedDescription
		case let .badHttpResponse(response):
			return HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
		}
	}
}

class Api {
	
	var session = URLSession.shared
	
	init() {
	}
	
	func getRequest(url: URL, comletion: @escaping NetworkRequestComletion) {
		let task = session.dataTask(with: url) { (data, response, error) in
			guard error == nil else {
				comletion(.failure(with: .unknown(error!)))
				return
			}
			guard let httpResponse = response as? HTTPURLResponse else {
				comletion(.failure(with: .badResponse))
				return
			}
			guard httpResponse.statusCode == 200 else {
				comletion(.failure(with: .badHttpResponse(httpResponse)))
				return
			}
			guard let data = data else {
				comletion(.failure(with: .invalidData))
				return
			}
			comletion(.success(with: data))
		}
		task.resume()
	}
}

