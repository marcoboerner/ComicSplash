//
//  Reducers.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

// It is encouraged to not to use a default in the switch statement so no actions are forgotten.

class Reducers {

	init(state: AppState) {
		self.state = state
	}

	let state: AppState

	func run(_ action: ReducerAction) {

		print("Reducer: \(action.label)")

		switch action {

		case .storeComic(let comicData):
			self.state.comicsData[comicData.num] = comicData
			self.state.latestComicNum = max(comicData.num, self.state.latestComicNum)
			print("Comic: \(comicData.num)")

		case .gotoComic(let num):
			self.state.currentComic = num

		case .clearComics:
			self.state.comicsData = [:]

		case .previous:
			if state.currentComic > 1 {
				state.currentComic -= 1
			}

		case .next:
			if state.currentComic < state.latestComicNum {
				state.currentComic += 1
			}
			// TODO: - maybe use a max method here again

		case .listenToFavoritesInDatabase(let subscriber):
			state.databaseSubscriber = subscriber

		}

	}

}
