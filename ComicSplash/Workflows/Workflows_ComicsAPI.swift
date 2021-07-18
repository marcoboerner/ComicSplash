//
//  Workflows_ComicsAPI.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation

extension Workflows {

	func getRandomComics(state: AppState) {

		/* Ideally - (reusing the other methods)
		- random number
		- get one random comic
		- get all previous
		- get all next
		*/

		let reducer = Reducers(state: state)
		reducer.run(.clearComics)
		reducer.run(.gotoComic(0))

		let requiredComicAmount = AppState.Settings.requiredComicAmount
		let latestComicNum = state.latestComicNum
		// Offsetting the min and max value to not immediately hit an end or previously viewed comic
		let range = (requiredComicAmount*2...latestComicNum-requiredComicAmount*5)

		// TODO: - Choose a better distributed generator.
		let randomComicNum = Int.random(in: range)

		// MARK: - Getting the random comic.
		let comicParser = ComicAPI()

		// MARK: - Getting previous comics
		var currentId = randomComicNum + 1
		var urlStringComponents = AppState.Settings.previousComicURLComponents
		var successPreviousCount = 0
		var successNextCount = 0

		let dispatchGroup = DispatchGroup() // TODO: - Unless I refactor all of this I might be able to move this further up and get this code out of the completion handler.
		let dispatchQueue = DispatchQueue(label: "URL-JSON-CALLS")
		let dispatchSemaphore = DispatchSemaphore(value: 0)

		dispatchQueue.async {

			while successPreviousCount <= requiredComicAmount && currentId > 1 {
				currentId -= 1
				urlStringComponents[1] = currentId

				dispatchGroup.enter()

				// Getting the comic.
				comicParser.fetchData(from: urlStringComponents) { error in
					self.log.error("\(error.localizedDescription)")
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				} success: { comicData in
					// Updating the store with the comic.
					reducer.run(.storeComic(comicData))
					reducer.run(.gotoComic(randomComicNum))
					successPreviousCount += 1

					dispatchSemaphore.signal()
					dispatchGroup.leave()
				}
				dispatchSemaphore.wait()
			}

			var currentId = randomComicNum
			while successNextCount <= requiredComicAmount && currentId < latestComicNum {
				currentId += 1
				urlStringComponents[1] = currentId

				dispatchGroup.enter()

				// Getting the comic.
				comicParser.fetchData(from: urlStringComponents) { error in
					self.log.error("\(error.localizedDescription)")
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				} success: { comicData in
					// Updating the store with the comic.
					reducer.run(.storeComic(comicData))
					successNextCount += 1

					dispatchSemaphore.signal()
					dispatchGroup.leave()
				}
				dispatchSemaphore.wait()
			}
		}
	}

	// Getting a defined amount of previous comics.
	func getPreviousComics(state: AppState) {

		let comicAPI = ComicAPI()

		// Assigning the settings and state variables
		var currentNum = state.latestComicNum
		var urlStringComponents = AppState.Settings.previousComicURLComponents
		let requiredComicAmount = AppState.Settings.requiredComicAmount
		var successCount = 0

		// Creating a dispatchGroup and Semaphore to run each task asynchronous but finishing in order on the background thread.
		let dispatchGroup = DispatchGroup()
		let dispatchQueue = DispatchQueue.global(qos: .background)
		let dispatchSemaphore = DispatchSemaphore(value: 0)

		dispatchQueue.async {

			// Downloading until required amount of comics or first comic reached.
			while successCount <= requiredComicAmount && currentNum > 1 {
				currentNum -= 1
				urlStringComponents[1] = currentNum

				dispatchGroup.enter()

				// Getting the comic.
				comicAPI.fetchData(from: urlStringComponents) { error in
					self.log.error("\(error.localizedDescription)")
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				} success: { comicData in

					// Updating the store with the comic.
					Reducers(state: state).run(.storeComic(comicData)) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
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

	func getComic(fromPage turning: TurnDirection, state: AppState) {

		let reducer = Reducers(state: state)
		let comicParser = ComicAPI()
		var urlStringComponents = AppState.Settings.previousComicURLComponents

		// Updating current page state to trigger page turn
		reducer.run(.turnToPreviousComic)

		// Getting the comic's number before to the lowest already cached comic's number
		urlStringComponents[1] = state.comicsData.min { $0.key < $1.key }?.value.num ?? 2 - 1

		// Getting the comic.
		comicParser.fetchData(from: urlStringComponents) { error in
			self.log.error("\(error.localizedDescription)")
			return
		} success: { comicData in
			// Updating the store with the comic.
			reducer.run(.storeComic(comicData))
		}
	}

	// FIXME: - Need to refactor and make testable
	func getLatestComic(state: AppState) {

		let comicAPI = ComicAPI()

		// Getting the comic.
		comicAPI.fetchData(from: AppState.Settings.currentComicURL) { error in
			self.log.error("\(error.localizedDescription)")	// TODO: - Need to run a request that fails and return the appropriate error to handle / skip an image. Maybe if there is no current image we just start from the last one.
			return
		} success: { comicData in
			// ...updating the store with the latest comic...
			let reducer = Reducers(state: state) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
			reducer.run(.storeComic(comicData))
			// ...and going to this comic.
			reducer.run(.gotoComic(comicData.num))
		}
	}

}
