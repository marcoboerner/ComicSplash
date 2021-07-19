//
//  Reducers.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import os

// It is encouraged to not to use a default in the switch statement so no actions are forgotten.

class Reducers {

	let log = Logger(category: "Reducers")

	init(state: AppState) {
		self.state = state
	}

	let state: AppState

	func run(_ action: ReducerAction) {

		log.info("\(action.label)")

		switch action {

		case .storeComic(let comicData):
			self.state.comicsData[comicData.num] = comicData
			self.state.latestComicNum = max(comicData.num, self.state.latestComicNum)

		case .gotoComic(let num):
			self.state.currentComic = num

		case .clearComics:
			self.state.comicsData = [:]

		case .turnToPreviousComic:
			if state.currentComic > 1 {
				state.currentComic -= 1
			}

		case .turnToNewerComic:
			if state.currentComic < state.latestComicNum {
				state.currentComic += 1
			}
			// TODO: - maybe use a max method here again

		case .listenToFavoritesInDatabase(let subscriber):
			state.databaseSubscriber = subscriber

		case .storeFavoriteComic(let comicData):
			state.favoriteComicsData[comicData.num] = comicData
			state.comicsData[comicData.num]?.favorite = true

		case .removeFavoriteComic(let num):
			// TODO: - need to figure out a way to still keep it in cache or the other dict.
			state.favoriteComicsData.removeValue(forKey: num)
			state.comicsData[num]?.favorite = false
		}

	}

}
