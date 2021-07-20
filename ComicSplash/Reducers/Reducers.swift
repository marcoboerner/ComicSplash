//
//  Reducers.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

/*

Reducer Router

At the moment the reducer methods are small and there are only a few so I keep them all here.
Will separate them into different files once it gets more.

The go to or page turn reducer keep checking all available numbers if there is comic data once.

*/

import Foundation
import Combine
import os

class Reducers: ObservableObject {

	let log = Logger(category: "Reducer")

	init(state: AppState) {
		self.state = state
	}

	let state: AppState

	// MARK: - Reducers Router

	func run(_ action: ReducerAction) {

		log.info("\(action.label)")

		switch action {

		case .storeComic(let comicData):
			storeComic(comicData)

		case .gotoComic(let num):
			goToComic(num)

		case .turnToPreviousComic:
			turnToPreviousComic()

		case .turnToNewerComic:
			turnToNewerComic()

		case .clearComics:
			state.currentComic = 0
			state.comicsData = [:]

		case .listenToFavoritesInDatabase(let subscriber):
			listenToFavoritesInDatabase(subscriber)

		case .storeFavoriteComic(let comicData):
			storeFavoriteComic(comicData)

		case .removeFavoriteComic(let num):
			removeFavoriteComic(num)
		}
	}

// MARK: - Reducer methods

	private func goToComic(_ num: Int) {
		let stopAt = num + 1
		var potentialComicNum = num
		while potentialComicNum >= 0 && stopAt != potentialComicNum {
			if state.comicsData[potentialComicNum] != nil {
				state.currentComic = potentialComicNum
				break
			} else if potentialComicNum == 0 {
				potentialComicNum = state.latestComicNum + 1
			}
			potentialComicNum -= 1
		}
	}

	private func turnToPreviousComic() {
		let stopAt = state.currentComic
		var potentialComicNum = state.currentComic - 1
		while potentialComicNum >= 0 && stopAt != potentialComicNum {
			if state.comicsData[potentialComicNum] != nil {
				state.currentComic = potentialComicNum
				break
			} else if potentialComicNum == 0 {
				potentialComicNum = state.latestComicNum + 1
			}
			potentialComicNum -= 1
		}
	}

	private func turnToNewerComic() {
		let stopAt = state.currentComic
		var potentialComicNum = state.currentComic + 1
		while potentialComicNum <= state.latestComicNum && stopAt != potentialComicNum {
			if state.comicsData[potentialComicNum] != nil {
				state.currentComic = potentialComicNum
				break
			} else if potentialComicNum == state.latestComicNum {
				potentialComicNum = 0
			}
			potentialComicNum += 1
		}
	}

	private func storeComic(_ comicData: ComicData) {
		state.comicsData[comicData.num] = comicData
		state.latestComicNum = max(comicData.num, state.latestComicNum)
	}

	private func listenToFavoritesInDatabase(_ subscriber: AnyCancellable) {
		state.databaseSubscriber = subscriber
	}

	private func storeFavoriteComic(_ comicData: ComicData) {
		state.favoriteComicsData[comicData.num] = comicData
	}

	private func removeFavoriteComic(_ num: Int) {
		state.favoriteComicsData.removeValue(forKey: num)
	}
}
