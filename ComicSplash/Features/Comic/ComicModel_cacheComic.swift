//
//  Comic_cacheComic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension ComicModel {

	func cacheComic(_ selection: ComicSelector, state: AppState, completion: @escaping (ComicData) -> Void) {

		let comicAPIModel = ComicAPIModel()
		var urlStringComponents = AppState.Settings.previousComicURLComponents

		// Getting the number of the next comic to be fetched.
		switch selection {
		case .previous:
			urlStringComponents[1] = (state.comicsData.min { $0.key < $1.key }?.value.num ?? 2) - 1
		case .newer:
			urlStringComponents[1] = (state.comicsData.max { $0.key < $1.key }?.value.num ?? 2) + 1
		case .latest:
			urlStringComponents = [AppState.Settings.latestComicURL]
		case .number(let num):
			urlStringComponents[1] = num
		}

		log.info("Attempting to fetch \(selection.label) from \(urlStringComponents.map {$0.description}.joined())")

		// Getting the comic.
		comicAPIModel.fetchData(from: urlStringComponents) { error in
			self.log.error("\(error.localizedDescription)")
		} success: { comicData in
			// Will trigger the reducers in the workflow router.
			completion(comicData)
		}
	}
}
