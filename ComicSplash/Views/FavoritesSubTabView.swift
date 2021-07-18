//
//  FavoritesSubTabView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesSubTabView: View {

	// FIXME: - Need to check if this might actually not refresh correctly. Delete all and add a few pics and try again.

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
					ForEach(filterAndSort(state.comicsData), id: \.key) { comicData in
						WebImage(
							url: URL(string: comicData.value.img ?? "/"),
							options: [.highPriority, .retryFailed])
							.onSuccess { image, data, cacheType in
							}
							.resizable()
							.placeholder(Image(systemName: "photo"))
							.placeholder {
								WelcomeView()
							}
							.indicator(.activity) // Activity Indicator
							.transition(.fade(duration: 0.5)) // Fade Transition with duration
							.scaledToFit()
							.frame(alignment: .center)
					}
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
			}
		}
}

func filterAndSort(_ comicsData: [Int: ComicData]) ->  [Dictionary<Int, ComicData>.Element] {

	return comicsData.filter({ $0.value.favorite == true }).sorted(by: { $0.key < $1.key })

}

struct FavoritesSubTabView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesSubTabView()
    }
}
