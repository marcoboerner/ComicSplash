//
//  Workflows.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import os

class Workflows {

	enum TurnDirection {
		case previous
		case newer
	}

	let log = Logger(category: "Workflows")

	internal init(state: AppState) {
		self.state = state
	}

	let state: AppState

	// MARK: - Action receiver and workflow router.

	func run(_ action: WorkflowAction) {

		print("Workflow: \(action.label)")

		switch action {

		case .getLatestComics:
			getLatestComic(state: state)
			getPreviousComics(state: state)

		case .getPreviousComic:
			getComic(fromPage: .previous, state: state)

		case .getNeverComic:
			getComic(fromPage: .newer, state: state)

		case .getRandomComics:
			getRandomComics(state: state)

		case .addComicToFavorites(let num):
			addOrRemoveToFavoritesComic(num, state: state)

		case .getFavoriteComics:
			getFavoriteComicsFromDatabase(state: state)

		case .speak(let transcript):
			speak(transcript)
		}

	}

}
