//
//  ComicSplashApp.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

@main
struct ComicSplashApp: App {

	let state: State = State()

	init() {
		Workflows(state: state).run(.getLatestComics)
	}

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(state)
        }
    }
}
