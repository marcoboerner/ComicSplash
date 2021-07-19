//
//  Workflows_Database.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation
import Combine

extension Workflows {

	func downloadFavoriteComicImage(_ num: Int, state: AppState, completion: @escaping (Int) -> Void ) {

		let imageStorageModel = ImageStorageModel()
		guard let comicData = state.comicsData[num] else { return }

		imageStorageModel.downloadImageFor(comicData) { error in
			if let error = error {
				self.log.error("\(error.localizedDescription)")
			} else {
				completion(num)
			}
		}
	}

	func deleteFavoriteComicImage(_ num: Int, state: AppState) {

		let imageStorageModel = ImageStorageModel()
		guard let comicData = state.comicsData[num] else { return }

		do {
			try imageStorageModel.deleteImageFor(comicData)
		} catch {
			log.error("\(error.localizedDescription)")
		}
	}

	// FIXME: - I might have all the reducer actions be defined in the workflow router. with completions. that way they are not hidden in here?

	func readFavoriteComicsFromDatabase(state: AppState, completion: @escaping (ComicData) -> Void) -> AnyCancellable {
		let realmModel = RealmModel()

		let publisher = realmModel.openLocal(read: [ComicData.self])

		return subscribe(to: publisher, state: state, completion: completion)
	}

	func createFavoriteComicInDatabase(_ num: Int, state: AppState, completion: @escaping (ComicData) -> Void) {

		let realmModel = RealmModel()
		guard let comicData = state.comicsData[num] else { return }

		realmModel.writeToRealm(comicData) { error in
			if let error = error {
				self.log.error("\(error.localizedDescription)")
			} else {
				completion(comicData)
			}
		}

	}

	func deleteFavoriteComicInDatabase(_ num: Int, state: AppState) {

		let realmModel = RealmModel()

		realmModel.deleteFromRealm(num) { error in
			if let error = error {
				self.log.error("\(error.localizedDescription)")
			} else {
				Reducers(state: state).run(.removeFavoriteComic(num))
			}
		}
	}

	private func subscribe(to publisher: DatabasePublisher, state: AppState, completion: @escaping (ComicData) -> Void) -> AnyCancellable {

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
			}, receiveValue: { comicData in
				comicData.forEach {
					completion($0)
				}
			})
	}
}
