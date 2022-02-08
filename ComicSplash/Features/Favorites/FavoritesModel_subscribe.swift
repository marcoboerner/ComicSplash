//
//  FavoritesModel_subscribe.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import Combine

extension FavoritesModel {

	func subscribeToPublisher(_ publisher: DatabasePublisher, state: MainState, completion: @escaping (ComicData) -> Void) -> AnyCancellable {

		return publisher
			.map { response in
				response.compactMap { $0 as? ComicData }
			}
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					self.log.info("Database subscriber successfully terminated.")
				case .failure(let error):
					self.log.error("Database Service Error: \(error.localizedDescription)")
				}
			}, receiveValue: { comicData in
				comicData.forEach {
					completion($0)
				}
			})
	}
}
