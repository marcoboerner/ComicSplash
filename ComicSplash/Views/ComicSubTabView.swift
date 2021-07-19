//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct ComicSubTabView: View {

	@EnvironmentObject var state: AppState
	@State private var currentComicNum = 0 // FIXME: - Need to go to the right page when clicking a button, random, or swiping.

	// TODO: -clicking again or double tap on the book tap should bring me back to the first comic.

	var body: some View {
		NavigationView {
			// TODO: - Need to wrap this in its own view and attach the navigation etc after it.
			TabView(selection: $currentComicNum) {
				LogoView(scale: 0.4, animated: true)
					.id(0)
				ForEach(state.comicsData.sorted(by: { $0.key > $1.key }), id: \.key) { key, _ in
					ComicView(comicNum: key)
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.id(state.comicsData.count)
			.onAppear {
				currentComicNum = state.latestComicNum
			}
			.onChange(of: state.comicsData) { _ in
				currentComicNum = state.currentComic
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
			//	}
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
