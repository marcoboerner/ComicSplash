//
//  ComicSplashApp.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

@main
struct ComicSplashApp: App {

	let state: AppState = AppState()
	let workflows: Workflows
	let reducers: Reducers
	let reactors: Reactors

	init() {
		workflows = Workflows(state: state)
		reducers = Reducers(state: state)
		reactors = Reactors(state: state)

		// Downloading the initial comics...
		workflows.run(.getLatestComics)

		// ...and checking the database for favorites.
		workflows.run(.getFavoriteComics)
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(state)
				.environmentObject(workflows)
				.environmentObject(reducers)
		}
	}
}
