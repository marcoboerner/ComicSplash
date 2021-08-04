//
//  Workflow_removeComicFromFavorites.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func removeComicFromFavorite(_ num: Int) {
		favoritesModel.deleteFavoriteComicInDatabase(num, state: state)
		favoritesModel.deleteFavoriteComicImage(num, state: state)
		self.reducer.run(.removeFavoriteComic(num))
	}
}
