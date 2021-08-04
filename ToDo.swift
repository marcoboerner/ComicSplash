//
//  ToDo.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

/*

Delete after development. Only used as a to do tracker within the app.

*/

fileprivate struct ToDo {

	// FIXME: - A few of the individual comic methods don't react to failed requests yet. Can make trouble when reaching the very last comic or several reads fail, leaving no cached comics.

	// FIXME: - Currently the database subscriber doesn't fire when there is no initial data, so I had to add a redundant storeFavoriteComic in the createFavoriteComicInDatabase callback.

	// FIXME: - Debug the following error. (Download works despite this very error, which is strange. "Task ... finished with error [-1002] ... "unsupported URL"

	// FIXME: - When going really fast from page to page I'm ending up in limbo. have to figure out how to prevent that. maybe graying out the button or some sort of delay?

	// FIXME: - When removing a comic from the favorites, it's not removed from the comic array and still visible when scrolling.

	// TODO: - Need to move the reducer that keeps checking for more comics to the workflows. And have the reducer only check a small amount before and after their number as there should not be more comics after a few numbers.

	// TODO: - USE DOWNLOADED AND STORED IMAGES FOR FAVORITES.

	// TODO: - SAME AS ABOVE, USE LOCAL COMIC DATA FIRST.

	// TODO: - Need to set up Realm migration in case the data changes through an app update.

	// TODO: - Create transitions for all changes in between screens and texts.

	// TODO: - Want to confirm default caching is okay. https://developer.apple.com/documentation/foundation/url_loading_system/accessing_cached_data

	// TODO: - Instead of passing around ComicData in the views, the comic num is mostly enough considering all views have access to state.

	// TODO: - Need to setup methods to react to focus changes, receiving phone calls etc.

	// TODO: - Models / methods need to be refactored with less side effects, passing in classes etc. instead of instantiating them from within.

	// TODO: - Write tests

	// TODO: - Setup accessibility identifiers for UI testing.
}
