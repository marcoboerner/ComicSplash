//
//  MainTabView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct MainTabView: View {

	var body: some View {

		TabView {
			ComicSubNavigationView()
				.tabItem {
					Image(systemName: "book.fill")
				}
			FavoritesNavigationView()
				.tabItem {
					Image(systemName: "heart.fill")
				}
		}
	}
}
