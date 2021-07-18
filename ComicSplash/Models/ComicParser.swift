//
//  JSON.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import Combine

// TODO: - Implement caching like here: https://developer.apple.com/documentation/foundation/url_loading_system/accessing_cached_data

class ComicParser {

	var subscriber: AnyCancellable?

	func fetchData(from urlStringComponents: [LosslessStringConvertible], completion: @escaping (ComicData?, Error?) -> Void) {
		let urlString = urlStringComponents.map { $0.description }.joined()
		fetchData(from: urlString, completion: completion)
	}

	func fetchData(from urlString: String, completion: @escaping (ComicData?, Error?) -> Void) {

		if let url = URL(string: urlString) {

			let request = URLRequest(url: url)

			subscriber = URLSession.shared.dataTaskPublisher(for: request)
				.map { $0.data }
				.decode(type: ComicData.self, decoder: JSONDecoder())
				.receive(on: RunLoop.main)
				.sink(receiveCompletion: { receivedCompletion in
					switch receivedCompletion {
					case .finished:
						print("||> Successfully terminated stream")
					case .failure(let error):
						print("ComicParser Error: %@", error.localizedDescription)
						completion(nil, error)
					}
				}, receiveValue: { comicData in
					completion(comicData, nil)
				})
		}
	}
}
