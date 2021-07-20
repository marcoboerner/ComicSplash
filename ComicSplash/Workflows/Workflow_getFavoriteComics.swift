//
//  Workflow_getFavoriteComics.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func getFavoriteComics() {
		let subscriber = favoritesModel.readFavoriteComicsFromDatabase(state: state) { comicData in
			self.reducer.run(.storeFavoriteComic(comicData))
		}
		self.reducer.run(.listenToFavoritesInDatabase(subscriber))
	}
}
