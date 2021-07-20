//
//  FavoritesPagesView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct FavoritesPagesView: View {

	@EnvironmentObject var state: AppState
	@State var tab: Int
	var comicsData: [ComicData]

	var body: some View {
		TabView(selection: $tab) {
//			LogoAndLoadingView(scale: 0.4, animated: false, light: true)
//				.id(-1)
			ForEach(comicsData.indices) { index in
				ComicView(comicNum: comicsData[index].num)
			}
		}
		.background(Color.white)
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
		.id(comicsData.count)
		.navigationBarItems(
			trailing:
				HStack {
					Button(
						action: {
							tab += 1
						},
						label: {
							Image(systemName: "arrowtriangle.left.fill")
						}
					)
					Button(
						action: {
							tab -= 1
						},
						label: {
							Image(systemName: "arrowtriangle.right.fill")
						}
					)
				}
		)
	}
}
