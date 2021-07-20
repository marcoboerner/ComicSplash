//
//  ComicAPIModel_fetchData.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import Combine
import os

extension ComicAPIModel {

	/**
	Downloads the json comicData from the given url string and decodes it to a ComicData object.

	- Parameter urlString: The correctly formatted URL in string format of the json comic data.
	- Parameter errorCompletion: Called if an error happened. Does not always interrupt the download.
	- Parameter success: Called when comic data has been received and decided. Passes on the comic data.

	# Notes: #
	1. Data will be received on the main thread.
	*/
	func fetchData(from urlString: String, errorCompletion: @escaping (Error) -> Void, success: @escaping (ComicData) -> Void) {

		guard let url = URL(string: urlString) else {
			errorCompletion(ComicAPIModelError.invalidURLString)
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



	/**
	Downloads the json comicData from the given url string components and decodes it to a ComicData object.

	- Parameter urlStringComponents: A collections of LosslessStringConvertible's like strings and integer.
	- Parameter errorCompletion: Called if an error happened. Does not always interrupt the download.
	- Parameter success: Called when comic data has been received and decided. Passes on the comic data.

	# Notes: #
	1. Data will be received on the main thread.
	*/
	func fetchData(from urlStringComponents: [LosslessStringConvertible], errorCompletion: @escaping (Error) -> Void, success: @escaping (ComicData) -> Void) {
		let urlString = urlStringComponents.map { $0.description }.joined()
		fetchData(from: urlString, errorCompletion: errorCompletion, success: success)
	}
	
}
