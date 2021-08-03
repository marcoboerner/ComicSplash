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
		.onReceive(state.$currentComic) { [unowned state] currentComic in

			print("state: \(state.currentComic)")
			print("new: \(currentComic)")

		}
		.onChange(of: state.currentComic) { [unowned state] newCurrentComicNum in
			if newCurrentComicNum > state.currentComic && newCurrentComicNum <= state.latestComicNum {
				print("gere?")
				workflows.run(.getNewerComic)
			} else if newCurrentComicNum > 1 {
				print("gereff?")
				workflows.run(.getPreviousComic)
			}
		}
	}
}
