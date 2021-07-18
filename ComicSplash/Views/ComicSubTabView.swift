//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct ComicSubTabView: View {

	@EnvironmentObject var state: AppState
	@State private var currentComicNum = 0

	// TODO: - maybe it's better to store the comics in an array in case one is missing?

	var body: some View {
		NavigationView {
			// TODO: - Need to wrap this in its own view and attach the navigation etc after it.
			switch state.currentComic {
			case 0:
				WelcomeView()
			default:
				TabView(selection: $currentComicNum) {
					ForEach(state.comicsData.sorted(by: { $0.key > $1.key }), id: \.key) { key, _ in
						ComicView(comicNum: key)
					}
						}
				.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
				.id(state.comicsData.count)
				.onAppear {
					currentComicNum = state.latestComicNum
				}
					.navigationBarTitleDisplayMode(.inline)
					.navigationBarItems(
						leading:
							Button(
								action: {
									Workflows(state: state).run(.getRandomComics)
								},
								label: {
									Image(systemName: "shuffle")
								}
							),
						trailing:
							HStack {
								Button(
									action: {
										Workflows(state: state).run(.getNewerComic)
									},
									label: {
										Image(systemName: "arrowtriangle.left.fill")
									}
								)
								Button(
									action: {
										Workflows(state: state).run(.getPreviousComic)
									},
									label: {
										Image(systemName: "arrowtriangle.right.fill")
									}
								)
							}
					)
			}
		}
	}
}

struct ComicSubTabView_Previews: PreviewProvider {
	static var previews: some View {
		ComicSubTabView()
			.environmentObject(AppState())
			.preferredColorScheme(.dark)
	}
}
