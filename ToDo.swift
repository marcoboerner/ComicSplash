//
//  ToDo.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

fileprivate struct ToDo {

	// FIXME: - Many of the individual comic methods don't react to failed requests yet. Can make trouble when reaching the very last comic or several reads fail, leaving no cached comics.

	// FIXME: - Currently the database subscriber doesn't fire when there is no initial data, so I had to add a redundant storeFavoriteComic in the createFavoriteComicInDatabase callback.

	// FIXME: - Debug the following error. (Download works despite this very error, which is strange. "Task ... finished with error [-1002] ... "unsupported URL"

	// FIXME: - When going really fast from page to page I'm ending up in limbo. have to figure out how to prevent that. maybe graying out the button or some sort of delay?

	// TODO: - Need to move the reducer that keeps checking for more comics to the workflows. And have the reducer only check a small amount before and after their number as there should not be more comics after a few numbers.

	// TODO: - PAGE TURN STATE UPDATE!!!!

	// TODO: - USE STORED IMAGES FOR FAVORITES.

	// TODO: - And everything that is now in the workflow extensions should maybe be moved into the api or its own model.

	// TODO: - Make workflow and some model methods better testable.

	// TODO: - Need to set up Realm migration in case the data changes through an app update.

	// TODO: - Create transitions for all changes in between screens and texts.

	// TODO: - Check out caching: https://developer.apple.com/documentation/foundation/url_loading_system/accessing_cached_data

	// TODO: - I might have all the reducer actions be defined in the workflow router. with completions.

	// TODO: - Instead of passing around ComicData in the views, the comic num is mostly enough considering all views have access to state.

	// TODO: - Need to setup methods to react to focus changes, calls etc.

	// TODO: - Turn the comic favorite view into something more unidirectional using the state instead of all those bindings.

	// TODO: - Write tests

	// TODO: - Setup accessibility identifiers for UI testing.
}
