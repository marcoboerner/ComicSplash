//
//  Reducers.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

class Reducers {

	init(state: AppState) {
		self.state = state
	}

	let state: AppState

	func run(_ action: Action) {

		switch action {

		case .storePreviousComic(let comicData):
			self.state.comicsData[comicData.num] = comicData
			self.state.latestComicNum = max(comicData.num, self.state.latestComicNum)
			print("Comic: \(comicData.num)")

		case .storeNextComic(let comicData):
			self.state.comicsData[comicData.num] = comicData

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

		default:
			return
		}

	}

}
