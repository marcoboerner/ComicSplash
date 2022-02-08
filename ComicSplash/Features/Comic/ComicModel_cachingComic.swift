//
//  Comic_cachingComic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension ComicModel {

	// Getting a defined amount of previous comics.
	func cachingComics(_ selection: ComicSelector, from num: Int? = nil, state: MainState, completion: @escaping (ComicData) -> Void) {

		// Starting from the latest or an individual comic number.
		var currentNum = num ?? state.latestComicNum
		var urlStringComponents = MainState.Settings.previousComicURLComponents
		let requiredComicAmount = MainState.Settings.requiredComicAmount
		var successCount = 0

		var nextNumFrom: (Int) -> Int

		// Choosing if increasing or decreasing the comic numbers
		switch selection {
		case .previous, .latest:
			nextNumFrom = {$0 - 1}
		case .newer:
			nextNumFrom = {$0 + 1}
		case .number:
			log.debug("ComicSelector.number(Int) not yet supported in gettingComics.")
			return
		}

		// Creating a Semaphore to run each task asynchronous but finishing in order on the background thread.
		let dispatchQueue = DispatchQueue.global(qos: .background)
		let dispatchSemaphore = DispatchSemaphore(value: 0)

		dispatchQueue.async {

			// Downloading until required amount of comics or first comic reached.
			while successCount <= requiredComicAmount && currentNum > 1 && currentNum <= state.latestComicNum {
				currentNum = nextNumFrom(currentNum)
				urlStringComponents[1] = currentNum

				self.log.info("Attempting to fetch \(selection.label) from \(urlStringComponents.map { $0.description }.joined())")

				// Getting the comic.
				self.comicAPIModel.fetchData(from: urlStringComponents) { result in

					switch result {
					case .success(let comicData):
						completion(comicData)

						successCount += 1

						// Async task has finished. Informing the semaphore.
						dispatchSemaphore.signal()

					case .failure(let error):
						self.log.error("\(error.localizedDescription)")
						dispatchSemaphore.signal()
					}
				}
				// The loop waits here until it receives the signal.
				dispatchSemaphore.wait()
			}
		}
	}
}
