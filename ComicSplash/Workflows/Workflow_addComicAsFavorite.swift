//
//  Workflow_addComicAsFavorite.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func addComicAsFavorite(_ num: (Int)) {
		favoritesModel.createFavoriteComicInDatabase(num, state: state) { comicData in
			self.reducer.run(.storeFavoriteComic(comicData))
		}
		favoritesModel.downloadFavoriteComicImage(num, state: self.state) { _ in

		}
	}
}
