//
//  Workflows.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import os
import EnumKit

enum ComicSelector: CaseAccessible {
	case previous
	case newer
	case latest
	case number(Int)
}

class Workflows: ObservableObject {

	let log = Logger(category: "Workflows")

	internal init(state: AppState) {
		self.state = state
		self.reducer = Reducers(state: state)
	}

	let state: AppState
	let reducer: Reducers

	let comicModel = ComicModel()
	let favoritesModel = FavoritesModel()

	// MARK: - Action receiver and workflow router.

	func run(_ action: WorkflowAction) {

		log.info("\(action.label)")

		switch action {

		case .getLatestComics:
			getLatestComics()

		case .getPreviousComic:
			getPreviousComic()

		case .getNewerComic:
			getNewerComic()

		case .getRandomComics:
			getRandomComics()

		case .getComicsNear(let num):
			getComicsNear(num)

		case .addComicAsFavorite(let num):
			addComicAsFavorite(num)

		case .removeComicFromFavorites(let num):
			removeComicFromFavorite(num)

		case .getFavoriteComics:
			getFavoriteComics()

		case .startSpeaking(let transcript):
			startSpeaking(transcript)

		}
	}
}
