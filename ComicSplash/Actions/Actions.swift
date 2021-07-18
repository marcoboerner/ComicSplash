//
//  Actions.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import Combine
import EnumKit

enum WorkflowAction: CaseAccessible {

	// Workflow actions have side effects and usually end with a reducer action.

	case getLatestComics
	case getPreviousComic
	case getNextComic
	case getRandomComics

	// DB Actions
	case addComicToFavorites(_ num: Int)
	case getFavoriteComics

	case speak(_ transcript: String)
}

enum ReducerAction: CaseAccessible {

	// Reducer actions trigger pure functions only that change the AppState.

	case clearComics

	case listenToFavoritesInDatabase(AnyCancellable)
	case previous
	case next
	case gotoComic(_ num: Int)

	case storeComic(ComicData)

}
