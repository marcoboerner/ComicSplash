//
//  FavoritesModel_deleteFavoriteInDatabase.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension FavoritesModel {

	func deleteFavoriteComicInDatabase(_ num: Int, state: MainState, completion: @escaping () -> Void) {

		realmModel.deleteFromRealm(dataType: ComicData.self, primaryKey: num) { error in
			if let error = error {
				self.log.error("\(error.localizedDescription)")
			} else {
				completion()
			}
		}
	}
}
