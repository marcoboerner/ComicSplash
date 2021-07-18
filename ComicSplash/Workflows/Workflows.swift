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

	func run(_ action: WorkflowAction) {

		print("Workflow: \(action.label)")

		switch action {

		case .getLatestComics:
			getLatestComics(state: state)

		case .getPreviousComic:
			getPreviousComic()

		case .getRandomComics:
			getRandomComics(state: state)

		case .addComicToFavorites(let num):
			addOrRemoveToFavoritesComic(num, state: state)

		case .getFavoriteComics:
			getFavoriteComicsFromDatabase(state: state)

		case .speak(let transcript):
			speak(transcript)

		case .getNextComic:
// TODO: - need to setup
			break
		}

	}

}
