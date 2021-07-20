//
//  Comic_getNewerComic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func getNewerComic() {

		reducer.run(.turnToNewerComic)
		comicModel.cacheComic(.newer, state: state) { comicData in
			self.reducer.run(.storeComic(comicData))
		}
	}
}
