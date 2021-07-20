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
			ComicSubNavigationView()
				.tabItem {
					Image(systemName: "book.fill")
				}
			FavoritesSubTabView()
				.tabItem {
					Image(systemName: "heart.fill")
				}
		}
	}
}
