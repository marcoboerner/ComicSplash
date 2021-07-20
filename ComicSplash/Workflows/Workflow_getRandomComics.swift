//
//  Comic_getRandomComics.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func getRandomComics() {
		reducer.run(.clearComics)
		let num = comicModel.generateRandomNum(below: state.latestComicNum)

		comicModel.cacheComic(.number(num), state: state) { comicData in
			self.reducer.run(.storeComic(comicData))
			self.reducer.run(.gotoComic(num))

			self.comicModel.cachingComics(.previous, from: num, state: self.state) { comicData in
				self.reducer.run(.storeComic(comicData))
			}
			self.comicModel.cachingComics(.newer, from: num, state: self.state) { comicData in
				self.reducer.run(.storeComic(comicData))
			}
		}
	}
}
