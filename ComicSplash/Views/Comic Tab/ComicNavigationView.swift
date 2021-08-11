//
//  ComicSubNavigationView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct ComicNavigationView: View {

	@EnvironmentObject var reducer: Reducers
	@EnvironmentObject var workflow: Workflows
	@EnvironmentObject var state: AppState
	@State var capturedCurrentComicNum: Int = 0

	var body: some View {
		NavigationView {
			ComicPagesView()
				.navigationBarTitleDisplayMode(.inline)
				.navigationBarItems(
					leading:
						Button(
							action: {
								workflow.run(.getRandomComics)
							},
							label: {
								Image(systemName: "shuffle")
								.accessibility(identifier: "shuffle")
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
										.accessibility(identifier: "arrowtriangle.left.fill")
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
										.accessibility(identifier: "arrowtriangle.right.fill")
								}
							)
						}
				)
		}
//		.onChange(of: state.currentComic) { capturedCurrentComicNum = $0 } // Workaround to capture the previous value of the published value.
//		.onChange(of: capturedCurrentComicNum) { [capturedCurrentComicNum] newCurrentComicNum in
//
//			guard state.tabViewSelection == K.Tags.comicNavigationView else { return }
//
//			if newCurrentComicNum > capturedCurrentComicNum && newCurrentComicNum <= state.latestComicNum {
//				workflows.run(.getNewerComic)
//			} else if newCurrentComicNum > 1 {
//				workflows.run(.getPreviousComic)
//			}
//		}
	}
}
