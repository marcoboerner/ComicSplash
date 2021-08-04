//
//  FavoritesModel_deleteFavoriteComicImage.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension FavoritesModel {

	func deleteFavoriteComicImage(_ num: Int, state: AppState) {

		guard let comicData = state.comicsData[num] else { return }

		do {
			try imageStorageModel.deleteImageFor(comicData)
		} catch {
			log.error("\(error.localizedDescription)")
		}
	}

}
