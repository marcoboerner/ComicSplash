//
//  ContentView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var state: AppState

    var body: some View {

		switch state.comicsData.count {
		case 0:
			WelcomeView()
		default:
			MainTabView()
		}
    }
}

// FIXME: - Need to create preview content.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
			.environmentObject(AppState())
    }
}
