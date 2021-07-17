//
//  Workflows.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

class Workflows {
	internal init(state: AppState) {
		self.state = state
	}

	let state: AppState

	// MARK: - Action receiver and workflow router.

	func run(_ action: Action) {

		switch action {
		case .getLatestComics:
			getLatestComics(state: state)
		case .getPreviousComic:
			getPreviousComic()
		default:
			return
		}

	}

	func getPreviousComic() {

		let comicParser = ComicParser()

		var urlStringComponents = AppState.Settings.previousComicURLComponents
		urlStringComponents[1] = state.comicsData.last!.num - 1

		comicParser.fetchData(from: urlStringComponents) { data, error in
			if let error = error {
				print("Error: \(error.localizedDescription)")
			}

			else if let data = data {
				do {
					let comicData = try comicParser.parseJSON(data) // FIXME: - Need to get this a bit more redux like. I don't like creating the instances all the time. I think that's what happens when the store is initialized once. It adds all the dependencies and creates all the pbjects. gonna try. And maybe that's why middle ware has a getstate method instead of access to state.
					let reducer = Reducers(state: self.state)
					DispatchQueue.main.async {
						reducer.run(.storeComic(comicData))
					}
				} catch {
					print("Error: \(error.localizedDescription)")
				}
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

