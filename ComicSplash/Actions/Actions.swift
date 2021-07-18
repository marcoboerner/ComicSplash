//
//  Actions.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import Combine

// TODO: - separate reducer and workflow actions.

enum Action {

	case getLatestComics
	case getPreviousComic
	case getNextComic
	case getRandomComics

	case clearComics

	// DB Actions
	case addComicToFavorites(_ num: Int)
	case getFavoriteComics

	// Reducer Actions
	case listenToFavoritesInDatabase(AnyCancellable)
	case previous
	case next
	case gotoComic(_ num: Int)
	case heartComic(_ num: Int)

	case storeComic(ComicData)

	case speak(_ transcript: String)
}
