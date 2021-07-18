//
//  Workflows.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import os
import EnumKit

class Workflows {

	enum ComicSelector: CaseAccessible {
		case previous
		case newer
		case latest
		case number(Int)
	}

	let log = Logger(category: "Workflows")

	internal init(state: AppState) {
		self.state = state
	}

	let state: AppState

	// MARK: - Action receiver and workflow router.

	func run(_ action: WorkflowAction) {

		let reducer = Reducers(state: state)
		log.info("\(action.label)")

		switch action {

		case .getLatestComics:
			cacheComic(.latest, state: state) { comicData in
				// ...updating the store with the latest comic...
				reducer.run(.storeComic(comicData))
				// ...and going to this comic.
				reducer.run(.gotoComic(comicData.num))

				self.cachingComics(.latest, state: self.state) { comicData in
					reducer.run(.storeComic(comicData))
				}
			}

		case .getPreviousComic:
			reducer.run(.turnToPreviousComic)
			cacheComic(.previous, state: state) { comicData in
				reducer.run(.storeComic(comicData))
			}

		case .getNewerComic:
			reducer.run(.turnToNewerComic)
			cacheComic(.newer, state: state) { comicData in
				reducer.run(.storeComic(comicData))
			}

		case .getRandomComics:
			reducer.run(.gotoComic(0))
			reducer.run(.clearComics)
			let num = generateRandomNum(below: state.latestComicNum)
			cacheComic(.number(num), state: state) { comicData in
				reducer.run(.storeComic(comicData))
				reducer.run(.gotoComic(comicData.num))

				self.cachingComics(.previous, from: num, state: self.state) { comicData in
					reducer.run(.storeComic(comicData))
				}
				self.cachingComics(.newer, from: num, state: self.state) { comicData in
					reducer.run(.storeComic(comicData))
				}
			}

		case .addComicToFavorites(let num):
			createOrRemoveFavoriteComicInDatabase(num, state: state)

		case .getFavoriteComics:
			let subscriber = readFavoriteComicsFromDatabase(state: state)
			reducer.run(.listenToFavoritesInDatabase(subscriber))

		case .speak(let transcript):
			speak(transcript)
		}

	}

}
