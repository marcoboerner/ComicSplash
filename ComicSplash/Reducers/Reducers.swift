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
			self.state.comicsData.append(comicData)
			self.state.latestComicNum = max(comicData.num, self.state.latestComicNum)
			print("Comic: \(comicData.num)")

		default:
			return
		}

	}

}
