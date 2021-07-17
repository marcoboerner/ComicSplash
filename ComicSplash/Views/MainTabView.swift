//
//  MainTabView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct MainTabView: View {

	@EnvironmentObject var state: AppState

    var body: some View {
		TabView {
			ComicSubTabView()
				.tabItem {
					Image(systemName: "book.fill")
				}
			Text("Favorites")
				.tabItem {
					Image(systemName: "heart.fill")
				}
			Text("History")
				.tabItem {
					Image(systemName: "calendar")
				}
		}
		.font(.headline)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
