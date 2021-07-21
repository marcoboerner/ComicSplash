//
//  Workflows_getComicsNear.swift
//  ComicSplash
//
//  Created by Marco Boerner on 21.07.21.
//

import Foundation

extension Workflows {

	func getComicsNear(_ num: Int) {

		comicModel.cacheComic(.number(num), state: state) { comicData in
			self.reducer.run(.clearComics)
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
