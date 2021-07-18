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

		case .heartComic(let num):
			state.favoriteComics.insert(num)

		default:
			return
		}

	}

}
