//
//  FavoritesModel_createFavoriteComicInDatabase.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension FavoritesModel {

	func createFavoriteComicInDatabase(_ num: Int, state: AppState, completion: @escaping (ComicData) -> Void ) {

		let realmModel = RealmModel()
		guard let comicData = state.comicsData[num] else { return }

		realmModel.writeToRealm(comicData) { error in
			if let error = error {
				self.log.error("\(error.localizedDescription)")
			} else {
				completion(comicData)
			}
		}
	}
}
