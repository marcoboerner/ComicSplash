//
//  FavoritesNavigationView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct FavoritesNavigationView: View {

	@EnvironmentObject var state: AppState
	@State var favoriteToShow: Int = 0
	@State var showPages: Bool = false
	@State var currentTab: Int = -1
	@State var favoritesComicsDataArray: [ComicData] = []

	var body: some View {
		NavigationView {
			VStack {
				FavoritesOverviewView(favoriteToShow: $favoriteToShow, showPages: $showPages)
				NavigationLink(destination: FavoritesPagesView(tab: currentTab, comicsData: favoritesComicsDataArray), isActive: $showPages ) { EmptyView() }
			}
			.onAppear {
				favoritesComicsDataArray = state.favoriteComicsData.sorted(by: { $0.key > $1.key }).map { $0.value }
			}
			.onChange(of: state.favoriteComicsData) { favoriteComicsData in
				favoritesComicsDataArray = favoriteComicsData.sorted(by: { $0.key > $1.key }).map { $0.value }
			}
			.onDisappear {
				currentTab = favoritesComicsDataArray.firstIndex(where: { $0.num == favoriteToShow}) ?? -1
			}
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}
