//
//  ComicSubNavigationView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct ComicNavigationView: View {

	@EnvironmentObject var workflows: Workflows
	@EnvironmentObject var state: AppState
	@State var currentComicNum = 0

	var body: some View {
		NavigationView {
			ComicPagesView(currentComicNum: $currentComicNum)
				.onChange(of: currentComicNum) { [currentComicNum] newCurrentComicNum in
					if newCurrentComicNum > currentComicNum && newCurrentComicNum <= state.latestComicNum {
						workflows.run(.getNewerComic)
					} else if newCurrentComicNum > 1 {
						workflows.run(.getPreviousComic)
					}
				}
				.onAppear {
					currentComicNum = state.currentComic
				}
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
									if currentComicNum < state.latestComicNum {
										currentComicNum += 1
									}
								},
								label: {
									Image(systemName: "arrowtriangle.left.fill")
										.foregroundColor(currentComicNum < state.latestComicNum ? .accentColor : .clear)
								}
							)
							Button(
								action: {
									if currentComicNum > 1 {
										currentComicNum -= 1
									}
								},
								label: {
									Image(systemName: "arrowtriangle.right.fill")
										.foregroundColor(currentComicNum > 1 ? .accentColor : .clear)
								}
							)
						}
				)
		}
	}
}
