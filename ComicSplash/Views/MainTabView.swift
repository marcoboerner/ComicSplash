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

		TabView(selection: $state.tabViewSelection) {
			ComicNavigationView()
				.tag(K.Tags.comicNavigationView)
				.tabItem {
					Image(systemName: "book.fill")
						.accessibility(identifier: "book.fill")
				}
			FavoritesNavigationView()
				.tag(K.Tags.favoritesNavigationView)
				.tabItem {
					Image(systemName: "heart.fill")
						.accessibility(identifier: "heart.fill")
				}
		}
	}
}
