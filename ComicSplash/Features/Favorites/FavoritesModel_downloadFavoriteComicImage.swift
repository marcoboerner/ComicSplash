//
//  Workflows_Database.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation
import Combine

extension FavoritesModel {

	func downloadFavoriteComicImage(_ num: Int, state: AppState, completion: @escaping (Int) -> Void ) {

		guard let comicData = state.comicsData[num] else { return }

		imageStorageModel.downloadImageFor(comicData) { error in
			if let error = error {
				self.log.error("\(error.localizedDescription)")
			} else {
				completion(num)
			}
		}
	}
}
