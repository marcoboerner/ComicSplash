//
//  Workflows_ComicsAPI.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation


// MARK: - Big fix me
// FIXME: - I think I want to move everything that happens in a case into the workflow extensions as individual methods.
// FIXME: - And everything that is now in the workflow extensions should maybe be moved into the api or its own model.


extension Workflows {

	func generateRandomNum(below maxNum: Int) -> Int {

		let requiredComicAmount = AppState.Settings.requiredComicAmount

		// Offsetting the min and max value to not immediately hit an end or previously viewed comic
		let range = (requiredComicAmount*2...maxNum-requiredComicAmount*5)

		// TODO: - Choose a better distributed generator.
		return Int.random(in: range)
	}

	// Getting a defined amount of previous comics.
	func cachingComics(_ selection: ComicSelector, from num: Int? = nil, state: AppState, completion: @escaping (ComicData) -> Void) {

		let comicAPI = ComicAPI()

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
			while successCount <= requiredComicAmount && currentNum > 1 {
				currentNum = nextNumFrom(currentNum)
				urlStringComponents[1] = currentNum

				dispatchGroup.enter()

				// Getting the comic.
				comicAPI.fetchData(from: urlStringComponents) { error in
					self.log.error("\(error.localizedDescription)")
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				} success: { comicData in
					// Updating the store with the comic.
					completion(comicData)

					 // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
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

	// MARK: - Getting individual comics

	// FIXME: - None of those individual comic methods react to failed requests yet.

	func cacheComic(_ selection: ComicSelector, state: AppState, completion: @escaping (ComicData) -> Void) {

		let comicParser = ComicAPI()
		var urlStringComponents = AppState.Settings.previousComicURLComponents

		// Getting the number of the next comic to be fetched.
		switch selection {
		case .previous:
			urlStringComponents[1] = (state.comicsData.min { $0.key < $1.key }?.value.num ?? 2) - 1
		case .newer:
			urlStringComponents[1] = (state.comicsData.max { $0.key < $1.key }?.value.num ?? 2) + 1
		case .latest:
			urlStringComponents = [AppState.Settings.latestComicURL]
		case .number(let num):
			urlStringComponents[1] = num
		}

		log.info("Attempting to fetch \(selection.label) from \(urlStringComponents.map{$0.description}.joined())")

		// Getting the comic.
		comicParser.fetchData(from: urlStringComponents) { error in
			self.log.error("\(error.localizedDescription)") // TODO: - Need to run a request that fails and return the appropriate error to handle / skip an image. Maybe if there is no current image we just start from the last one.
			return
		} success: { comicData in
			// Will trigger the reducers in the workflow router.
			completion(comicData)
		}
	}
}
