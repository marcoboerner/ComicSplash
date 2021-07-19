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
		ZStack {
			TabView {
				ComicSubTabView()
					.tabItem {
						Image(systemName: "book.fill")
							.resizable()
							.scaledToFit()
							.frame(minWidth: 20, idealWidth: 30, maxWidth: 40)
					}
				FavoritesSubTabView()
					.tabItem {
						Image(systemName: "heart.fill")
							.resizable()
							.scaledToFit()
							.frame(minWidth: 20, idealWidth: 30, maxWidth: 40)
					}
			}
			//.accentColor(.white)
			.font(.headline)
		}
	}
}

struct MainTabView_Previews: PreviewProvider {
	static var previews: some View {
		MainTabView()
	}
}
