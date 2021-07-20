//
//  Actions.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

/*

The app has two types of actions.

Workflow actions are actions that trigger a workflow that has several side effects and uses feature models like Database or ImageStorage.
Most of the time but not always a Workflow action will trigger one or more Reducer actions at any time.

Reducer actions are actions that will trigger reducers that will update the app's "single source of truth" state.
Only reducer actions should change the state of the app.

Both actions can carry data. In the case of the reducer actions and state, it's only only way for the state to receive new data unless it can be calculated with a pure side effect less method by the reducer.

The actions will trigger its appropriate Workflow or Reducer through their separate routers, which is a basic switch case method.

*/

import Foundation
import Combine
import EnumKit

// MARK: - Workflow actions

enum WorkflowAction: CaseAccessible {

	/// Fetch the latest and a few earlier comics, depending on the comic cache setting in the settings state.
	case getLatestComics

	/// Fetches the next previous comic to cache and triggers a page turn
	case getPreviousComic

	/// Fetches the next newer comic to cache and triggers a page turn
	case getNewerComic

	/// Fetches a random comic and a few newer and earlier comics, depending on the comic cache setting in the settings state.
	case getRandomComics

	/// Sets a comic as a favorite and downloads its picture.
	case addComicAsFavorite(_ num: Int)

	/// Removes a comic from favorites and deletes the stored picture
	case removeComicFromFavorites(_ num: Int)

	/// Checks if the user has already favorite comics.
	case getFavoriteComics

	/// Lets the app speak a text, optional stopping previous voices.
	case startSpeaking(_ transcript: String)
}

// MARK: - Reducer actions

enum ReducerAction: CaseAccessible {

	/// Clears the comics in the state. Usually triggered by the Comics workflow.
	case clearComics

	/// Adds a new comic to the state. Usually triggered by the Comics workflow.
	case storeComic(ComicData)

	/// Adds a new comic to the favorite state. Usually triggered by the Database / Favorites workflow.
	case storeFavoriteComic(ComicData)

	/// Removes a comic from the favorites. Usually triggered by the Database / Favorites workflow.
	case removeFavoriteComic(_ num: Int)

	/// Stores the database listener in the state to stay active as long as the app is running.
	case listenToFavoritesInDatabase(AnyCancellable)

	/// Sets the next previous comic number in the state.
	case turnToPreviousComic

	/// Sets the next newer comic number in the state.
	case turnToNewerComic

	/// Sets a specific comic in the state. After app start or random for example.
	case gotoComic(_ num: Int)

}
