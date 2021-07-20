//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct ComicPagesView: View {

	@EnvironmentObject var state: AppState
	@State private var currentComicNum = 0
	@Binding var comicsData: [Int : ComicData]

	var body: some View {
		TabView(selection: $currentComicNum) {
			LogoAndLoadingView(scale: 0.4, animated: false, light: true)
				.id(0)
			ForEach(comicsData.sorted(by: { $0.key > $1.key }), id: \.key) { key, _ in
				ComicView(comicNum: key)
			}
		}
		.background(Color.white)
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
		.id(comicsData.count)
		.onAppear {

			if currentComicNum == 0 {
				currentComicNum = state.latestComicNum
			}
		}
		.onChange(of: state.currentComic) { _ in
			currentComicNum = state.currentComic
		}
	}
}
