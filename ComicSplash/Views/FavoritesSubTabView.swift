//
//  FavoritesSubTabView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesSubTabView: View {

	@EnvironmentObject var state: AppState

		let items = 1...50

		let cols = [
			GridItem(.flexible(maximum: .infinity)),
			GridItem(.flexible(maximum: .infinity)),
			GridItem(.flexible(maximum: .infinity))
		]

		var body: some View {
			ScrollView(.vertical) {
				LazyVGrid(columns: cols, alignment: .center, spacing: nil, pinnedViews: []) {
					ForEach(state.favoriteComicsData.sorted(by: { $0.key > $1.key}), id: \.key) { comicData in
						WebImage(
							url: URL(string: comicData.value.img ?? "/"),
							options: [.highPriority, .retryFailed])
							.onSuccess { image, data, cacheType in
							}
							.resizable()
							.placeholder(Image(systemName: "photo"))
							.placeholder {
								LogoAndLoadingView()
							}
							.indicator(.activity) // Activity Indicator
							.transition(.fade(duration: 0.5)) // Fade Transition with duration
							.scaledToFit()
							.frame(alignment: .center)
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				// TODO: - If there is time make comic tab bar view reusable so I can use it for the favorites as well. Same functionality, but smaller data set.
				// Note, if later changing to a PageTabView, add the following:
				//.id(state.favoriteComicsData.count)
			}
		}
}
