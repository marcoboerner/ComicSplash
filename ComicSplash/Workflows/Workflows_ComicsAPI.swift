//
//  Workflows_ComicsAPI.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation

extension Workflows {

	func getRandomComics(state: AppState) {

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
		let comicParser = ComicParser()

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

				comicParser.fetchData(from: urlStringComponents) { data, error in
					if let error = error {
						print("Error: \(error.localizedDescription)")
					}

					else if let data = data {
						do {
							let comicData = try comicParser.parseJSON(data) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.

							DispatchQueue.main.async {
								reducer.run(.storeComic(comicData))
								reducer.run(.gotoComic(randomComicNum))
							}

							successPreviousCount += 1
						} catch {
							print("Error: \(error.localizedDescription)")
						}
					}
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

				comicParser.fetchData(from: urlStringComponents) { data, error in
					if let error = error {
						print("Error: \(error.localizedDescription)")
					}

					else if let data = data {
						do {
							let comicData = try comicParser.parseJSON(data) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
							let reducer = Reducers(state: state)
							DispatchQueue.main.async {
								reducer.run(.storeComic(comicData))
							}

							successNextCount += 1
						} catch {
							print("Error: \(error.localizedDescription)")
						}
					}
					dispatchSemaphore.signal()
					dispatchGroup.leave()
				}
				dispatchSemaphore.wait()
			}
		}

	}

	// FIXME: - None of those individual comic methods react to failed requests yet.

	func getPreviousComic() {

		let reducer = Reducers(state: self.state)

		reducer.run(.previous)

		// Note that the previous comic is codewise in the array handled as the next comic. As it is the next one available at the end of the pages

		let comicParser = ComicParser()

		var urlStringComponents = AppState.Settings.previousComicURLComponents
		urlStringComponents[1] = state.comicsData.max { $0.key < $1.key }?.value.num ?? 2 - 1

		comicParser.fetchData(from: urlStringComponents) { data, error in
			if let error = error {
				print("Error: \(error.localizedDescription)")
			}

			else if let data = data {
				do {
					let comicData = try comicParser.parseJSON(data) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.

					DispatchQueue.main.async {
						reducer.run(.storeComic(comicData))
					}
				} catch {
					print("Error: \(error.localizedDescription)")
				}
			}

		}
	}

	// FIXME: - Need to refactor and make testable
	func getLatestComics(state: AppState) {
		// MARK: - Getting the latest comic.
		let comicParser = ComicParser()
		comicParser.fetchData(from: AppState.Settings.currentComicURL) { data, error in

			// TODO: - Need to run a request that fails and return the appropriate error to handle / skip an image. Maybe if there is no current image we just start from the last one.

			// FIXME: - Need to handle errors correctly
			if let error = error {
				print("Error: \(error.localizedDescription)")
				return
			}

			else if let data = data {
				do {
					let comicData = try comicParser.parseJSON(data) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
					let reducer = Reducers(state: state)
					//		DispatchQueue.main.async {
					reducer.run(.storeComic(comicData))
					reducer.run(.gotoComic(comicData.num))
					//		}
					// FIXME: - Need to figure out what is happening on what queue.
				} catch {
					print("Error: \(error.localizedDescription)")
					return
				}
			}

			// MARK: - Getting previous comics
			var currentId = state.latestComicNum
			var urlStringComponents = AppState.Settings.previousComicURLComponents
			let requiredComicAmount = AppState.Settings.requiredComicAmount
			var successCount = 0

			let dispatchGroup = DispatchGroup() // TODO: - Unless I refactor all of this I might be able to move this further up and get this code out of the completion handler.
			let dispatchQueue = DispatchQueue(label: "URL-JSON-CALLS")
			let dispatchSemaphore = DispatchSemaphore(value: 0)

			dispatchQueue.async {

				while successCount <= requiredComicAmount && currentId > 1 {
					currentId -= 1
					urlStringComponents[1] = currentId

					dispatchGroup.enter()

					comicParser.fetchData(from: urlStringComponents) { data, error in
						if let error = error {
							print("Error: \(error.localizedDescription)")
						}

						else if let data = data {
							do {
								let comicData = try comicParser.parseJSON(data) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
								let reducer = Reducers(state: state)
								DispatchQueue.main.async {
									reducer.run(.storeComic(comicData))
								}

								successCount += 1
							} catch {
								print("Error: \(error.localizedDescription)")
							}
						}
						dispatchSemaphore.signal()
						dispatchGroup.leave()
					}
					dispatchSemaphore.wait()
				}
			}
			//				dispatchGroup.notify(queue: dispatchQueue) {
			//					DispatchQueue.main.async {
			//
			//					}
			//				}
		}
	}

}
