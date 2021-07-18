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

	func getFavoriteComicsFromDatabase(state: AppState) {

		let realmModel = RealmModel()

		let publisher = realmModel.openLocal(read: [ComicData.self])

		let subscriber = subscribe(to: publisher, state: state)

		Reducers(state: state).run(.listenToFavoritesInDatabase(subscriber))

	}

	func addOrRemoveToFavoritesComic(_ num: Int, state: AppState) {

		let realmModel = RealmModel()

		guard var comicData = state.comicsData[num] else { return }  // FIXME: - need error handling

		if comicData.favorite == true {
			comicData.favorite = false
			// remove from realm
		} else {
			comicData.favorite = true
			realmModel.writeToRealm(comicData) { error in
				if let error = error {
					print(error.localizedDescription)
				}
			}
		}
	}

	private func subscribe(to publisher: DatabasePublisher, state: AppState) -> AnyCancellable {

		print("Subscribing")

		return publisher
			.map { response in
				return response.compactMap { $0 as? ComicData }
			}
			.sink(receiveCompletion: { completion in
				switch completion {
				case .finished:
					print("||> Successfully terminated stream")
				case .failure(let error):
					switch error {
					case .undefinedError(let error):
						print("Database Service undefinedError: %@", error.localizedDescription)
					}
				}
			}, receiveValue: { dataTypes in

				dataTypes.forEach {
					Reducers(state: state).run(.storeComic($0))
				}
			})
	}

}
