//
//  Workflows_Database.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation
import Combine

extension Workflows {

	// FIXME: - I might have all the reducer actions be defined in the workflow router. with completions. that way they are not hidden in here?

	func readFavoriteComicsFromDatabase(state: AppState) -> AnyCancellable {

		let realmModel = RealmModel()

		let publisher = realmModel.openLocal(read: [ComicData.self])

		return subscribe(to: publisher, state: state)

	}

	func createOrRemoveFavoriteComicInDatabase(_ num: Int, state: AppState) {

		let realmModel = RealmModel()

		guard var comicData = state.comicsData[num] else { return }  // FIXME: - need error handling

		if comicData.favorite == true {
			comicData.favorite = false
			// remove from realm
		} else {
			comicData.favorite = true
			realmModel.writeToRealm(comicData) { error in
				if let error = error {
					self.log.error("\(error.localizedDescription)")
				}
			}
		}
	}

	private func subscribe(to publisher: DatabasePublisher, state: AppState) -> AnyCancellable {

		return publisher
			.map { response in
				return response.compactMap { $0 as? ComicData }
			}
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					self.log.info("Database subscriber successfully terminated.")
				case .failure(let error):
					switch error {
					case .undefinedError(let error):
						self.log.error("Database Service undefinedError: \(error.localizedDescription)")
					}
				}
			}, receiveValue: { dataTypes in

				dataTypes.forEach {
					Reducers(state: state).run(.storeComic($0))
				}
			})
	}

}
