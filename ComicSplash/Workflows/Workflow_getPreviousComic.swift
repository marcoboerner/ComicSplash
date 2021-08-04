//
//  Comic_getPreviousComic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func getPreviousComic() {

		comicModel.cacheComic(.previous, state: state) { comicData in
			self.reducer.run(.storeComic(comicData))
		}
	}
}
