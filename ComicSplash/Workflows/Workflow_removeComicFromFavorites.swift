//
//  Workflow_removeComicFromFavorites.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func removeComicFromFavorite(_ num: Int) {
		self.reducer.run(.removeFavoriteComic(num))
		favoritesModel.deleteFavoriteComicInDatabase(num, state: state) { }
		self.favoritesModel.deleteFavoriteComicImage(num, state: self.state)
	}
}
