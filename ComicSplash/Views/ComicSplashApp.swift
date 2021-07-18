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

	init() {
		//Workflows(state: state).run(.getFavoriteComics)
		Workflows(state: state).run(.getLatestComics)
	}

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(state)
        }
    }
}
