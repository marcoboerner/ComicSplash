//
//  Workflows_Comic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func getLatestComics() {

		comicModel.cacheComic(.latest, state: state) { comicData in
			// ...updating the store with the latest comic...
			self.reducer.run(.storeComic(comicData))
			// ...and going to this comic.
			self.reducer.run(.gotoComic(comicData.num))

			self.comicModel.cachingComics(.latest, state: self.state) { comicData in
				self.reducer.run(.storeComic(comicData))
			}
		}
	}
}
