//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct ComicPagesView: View {

	@EnvironmentObject var state: AppState
	var body: some View {
		TabView(selection: $state.currentComic) {
			LogoAndLoadingView(scale: 0.4, animated: false, light: true)
				.id(0)
			ForEach(state.comicsData.sorted(by: { $0.key > $1.key }), id: \.key) { key, _ in
				ComicView(comicNum: key)
			}
		}
		.background(Color.white)
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
		.id(state.comicsData.count)
	}
}
