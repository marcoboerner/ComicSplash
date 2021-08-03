//
//  Comic_cachingComic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension ComicModel {

	// Getting a defined amount of previous comics.
	func cachingComics(_ selection: ComicSelector, from num: Int? = nil, state: AppState, completion: @escaping (ComicData) -> Void) {

		let comicAPI = ComicAPIModel()

		// Starting from the latest or an individual comic number.
		var currentNum = num ?? state.latestComicNum
		var urlStringComponents = AppState.Settings.previousComicURLComponents
		let requiredComicAmount = AppState.Settings.requiredComicAmount
		var successCount = 0

		var nextNumFrom: (Int) -> Int

		// Choosing if increasing or decreasing the comic numbers
		switch selection {
		case .previous, .latest:
			nextNumFrom = {$0 - 1}
		case .newer:
			nextNumFrom = {$0 + 1}
		case .number(_):
			log.debug("ComicSelector.number(Int) not yet supported in gettingComics.")
			return
		}

		// Creating a dispatchGroup and Semaphore to run each task asynchronous but finishing in order on the background thread.
		let dispatchGroup = DispatchGroup()
		let dispatchQueue = DispatchQueue.global(qos: .background)
		let dispatchSemaphore = DispatchSemaphore(value: 0)

		dispatchQueue.async {

			// Downloading until required amount of comics or first comic reached.
			while successCount <= requiredComicAmount && currentNum > 1 && currentNum <= state.latestComicNum {
				currentNum = nextNumFrom(currentNum)
				urlStringComponents[1] = currentNum

				dispatchGroup.enter()

				self.log.info("Attempting to fetch \(selection.label) from \(urlStringComponents.map { $0.description }.joined())")

				// Getting the comic.
				comicAPI.fetchData(from: urlStringComponents) { error in
					self.log.error("\(error.localizedDescription)")
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				} success: { comicData in
					// Updating the store with the comic.
					completion(comicData)

					successCount += 1

					// Async task has finished. Informing the group and semaphore.
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				}
				// The loop waits here until it receives the signal.
				dispatchSemaphore.wait()

			}
		}
	}
}
