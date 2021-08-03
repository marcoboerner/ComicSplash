//
//  FavoritesSubTabView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoritesOverviewView: View {

	@EnvironmentObject var state: AppState
	@Binding var showPages: Bool

	@EnvironmentObject var reducers: Reducers

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
						.resizable()
						.placeholder {
							LogoAndLoadingView(light: true)
						}
						.transition(.fade(duration: 0.5))
						.scaledToFit()
						.frame(alignment: .center)
						.simultaneousGesture(
							TapGesture().onEnded {
								reducers.run(.clearComics)
								reducers.run(.overwriteComicsWithFavorites)
								reducers.run(.gotoComic(comicData.key))
								showPages = true
							}
						)
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
		}.background(Color.white)
	}
}
