//
//  Comic_cacheComic.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension ComicModel {

	func cacheComic(_ selection: ComicSelector, state: AppState, completion: @escaping (ComicData) -> Void) {

		var urlStringComponents = AppState.Settings.previousComicURLComponents

		// Getting the number of the next comic to be fetched.
		switch selection {
		case .previous:
			guard let newNum = state.comicsData.min(by: { $0.key < $1.key })?.value.num, newNum > 1 else {
				return
			}
			urlStringComponents[1] = newNum - 1
		case .newer:
			guard let newNum = state.comicsData.max(by: { $0.key < $1.key })?.value.num, newNum < state.latestComicNum else {
				return
			}
			urlStringComponents[1] = newNum + 1
		case .latest:
			urlStringComponents = [AppState.Settings.latestComicURL]
		case .number(let num):
			urlStringComponents[1] = num
		}

		log.info("Attempting to fetch \(selection.label) from \(urlStringComponents.map {$0.description}.joined())")

		// Getting the comic.
		comicAPIModel.fetchData(from: urlStringComponents) { result in

			switch result {
			case .success(let comicData):
				// Will trigger the reducers in the workflow router.
				completion(comicData)
			case .failure(let error):
				self.log.error("\(error.localizedDescription)")
			}
		}
	}
}
