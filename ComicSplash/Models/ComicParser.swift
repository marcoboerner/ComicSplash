//
//  JSON.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

class ComicParser {

	func fetchData(from urlStringComponents: [LosslessStringConvertible], completion: @escaping (Data?, Error?) -> Void) {
		let urlString = urlStringComponents.map { $0.description }.joined()
		fetchData(from: urlString, completion: completion)
	}

	func fetchData(from urlString: String, completion: @escaping (Data?, Error?) -> Void) {

		if let url = URL(string: urlString) {

			let urlSession = URLSession(configuration: .default)

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
