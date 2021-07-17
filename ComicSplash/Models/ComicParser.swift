//
//  JSON.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

// TODO: - Implement caching like here: https://developer.apple.com/documentation/foundation/url_loading_system/accessing_cached_data


class ComicParser {

	func fetchData(from urlStringComponents: [LosslessStringConvertible], completion: @escaping (Data?, Error?) -> Void) {
		let urlString = urlStringComponents.map { $0.description }.joined()
		fetchData(from: urlString, completion: completion)
	}

	func fetchData(from urlString: String, completion: @escaping (Data?, Error?) -> Void) {

		if let url = URL(string: urlString) {

			let urlSession = URLSession(configuration: .default)

			let request = URLRequest(url: url)

// TODO: - Would like to figure out how to use combine here instead of the regular completion. Also because to publish on the right thread.

//			let xxx = URLSession.shared.dataTaskPublisher(for: request)
//				.map { response in  }
//				.receive(on: RunLoop.main)
//				.sink { something in
//
//				} receiveValue: { value in
//
//				}

			let dataTask = urlSession.dataTask(with: url) { data, _, error in
				completion(data, error)
			}

			dataTask.resume()
		}
	}

	func parseJSON(_ data: Data) throws -> ComicData { // FIXME: - Make generic, passing in type.

		let jsonDecoder = JSONDecoder()

		do {
			return try jsonDecoder.decode(ComicData.self, from: data)
		} catch {
			throw error
		}

	}

}
