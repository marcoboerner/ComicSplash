//
//  Workflows_Database.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation

extension Workflows {

	func addOrRemoveToFavoritesComic(_ num: Int, state: AppState) {

		let realmModel = RealmModel()

		guard let comicData = state.comicsData[num] else { return } // FIXME: - need error handling

		let object = realmModel.mapToRealmObject(comicData)

		realmModel.writeToRealm(object) { error in
			if let error = error {
				print(error.localizedDescription)
			} else {
				Reducers(state: state).run(.heartComic(num))
			}
		}

	}
}
