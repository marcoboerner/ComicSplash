//
//  JSON.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import Combine
import os

// TODO: - Implement caching like here: https://developer.apple.com/documentation/foundation/url_loading_system/accessing_cached_data

enum ComicAPIError: Error {
	case invalidURLString
}

class ComicAPI {

	let log = Logger(category: "ComicParser")

	var subscriber: AnyCancellable?

	func fetchData(from urlStringComponents: [LosslessStringConvertible], errorCompletion: @escaping (Error) -> Void, success: @escaping (ComicData) -> Void) {
		let urlString = urlStringComponents.map { $0.description }.joined()
		fetchData(from: urlString, errorCompletion: errorCompletion, success: success)
	}

	func fetchData(from urlString: String, errorCompletion: @escaping (Error) -> Void, success: @escaping (ComicData) -> Void) {

		guard let url = URL(string: urlString) else {
			errorCompletion(ComicAPIError.invalidURLString)
			return
		}

		let request = URLRequest(url: url)

		subscriber = URLSession.shared.dataTaskPublisher(for: request)
			.retry(1)
			.map { $0.data }
			.decode(type: ComicData.self, decoder: JSONDecoder())
			.receive(on: RunLoop.main)
			.sink(receiveCompletion: { receivedCompletion in
				switch receivedCompletion {
				case .finished:
					self.log.info("URLSession subscriber successfully terminated.")
				case .failure(let error):
					errorCompletion(error)
				}
			}, receiveValue: { comicData in
				success(comicData)
			})
	}
}
