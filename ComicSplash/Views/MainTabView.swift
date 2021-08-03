//
//  MainTabView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct MainTabView: View {

	@State var tabViewSelection: String = "ComicNavigationView"

	var body: some View {

		TabView(selection: $tabViewSelection) {
			ComicNavigationView()
				.id("ComicNavigationView")
				.tabItem {
					Image(systemName: "book.fill")
				}
			FavoritesNavigationView()
				.id("FavoritesNavigationView")
				.tabItem {
					Image(systemName: "heart.fill")
				}
		}
	}
}
