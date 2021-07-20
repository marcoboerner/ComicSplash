//
//  FavoritesModel_readFavoriteComicsFromDatabase.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import Combine

extension FavoritesModel {

	func readFavoriteComicsFromDatabase(state: AppState, completion: @escaping (ComicData) -> Void) -> AnyCancellable {
		let realmModel = RealmModel()

		let publisher = realmModel.openLocal(read: [ComicData.self])

		return subscribeToPublisher(publisher, state: state, completion: completion)
	}
}
