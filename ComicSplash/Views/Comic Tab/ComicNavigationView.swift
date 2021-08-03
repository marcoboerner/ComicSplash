//
//  ComicSubNavigationView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct ComicNavigationView: View {

	@EnvironmentObject var reducer: Reducers
	@EnvironmentObject var workflows: Workflows
	@EnvironmentObject var state: AppState
	@State var capturedValue: Int = 0

	var body: some View {
		NavigationView {
			ComicPagesView()
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarItems(
					leading:
						Button(
							action: {
								workflows.run(.getRandomComics)
							},
							label: {
								Image(systemName: "shuffle")
							}
						),
					trailing:
						HStack {
							Button(
								action: {
									if state.currentComic < state.latestComicNum {
										reducer.run(.turnToNewerComic)
									}
								},
								label: {
									Image(systemName: "arrowtriangle.left.fill")
										.foregroundColor(state.currentComic < state.latestComicNum ? .accentColor : .clear)
								}
							)
							Button(
								action: {
									if state.currentComic > 1 {
										reducer.run(.turnToPreviousComic)
									}
								},
								label: {
									Image(systemName: "arrowtriangle.right.fill")
										.foregroundColor(state.currentComic > 1 ? .accentColor : .clear)
								}
							)
						}
				)
		}
		.onChange(of: state.currentComic) { capturedValue = $0 } // Workaround to capture the previous value of the published value.
		.onChange(of: capturedValue) { [capturedValue] newCurrentComicNum in

			guard state.tabViewSelection == K.Tags.comicNavigationView else { return }

			if newCurrentComicNum > capturedValue && newCurrentComicNum <= state.latestComicNum {
				workflows.run(.getNewerComic)
			} else if newCurrentComicNum > 1 {
				workflows.run(.getPreviousComic)
			}
		}
	}
}
