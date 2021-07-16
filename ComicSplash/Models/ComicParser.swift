//
//  JSON.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

class ComicParser {

	let comicURL = "https://xkcd.com/info.0.json"

	func fetchComic(urlString: String) {

		if let url = URL(string: urlString) {

			let urlSession = URLSession(configuration: .default)

			let dataTask = urlSession.dataTask(with: url) { data, urlResponse, error in

				// TODO: - Need to run a request that fails and return the appropriate error to handle / skip an image.

				// FIXME: - Need to handle errors correctly
				if let error = error {
					print("Error: \(error.localizedDescription)")
				}

				if let data = data {
					self.parseJSON(data)
				}

			}

			dataTask.resume()
		}
	}

	func parseJSON(_ data: Data) { // FIXME: - Make generic, passing in type.

		let jsonDecoder = JSONDecoder()

		do {
			let comicData = try jsonDecoder.decode(ComicData.self, from: data)
			print("comicData:\n \(comicData)")
		} catch {
			print("Error: \(error.localizedDescription)")
		}

	}

}
