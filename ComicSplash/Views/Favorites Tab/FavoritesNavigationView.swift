//
//  FavoritesNavigationView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct FavoritesNavigationView: View {

	@EnvironmentObject var state: MainState
	@EnvironmentObject var reducers: Reducers
	@EnvironmentObject var workflows: Workflows

	@State var showPages: Bool = false

	var body: some View {
		NavigationView {
			VStack {
				FavoritesOverviewView(showPages: $showPages)

				NavigationLink(destination:
								ComicPagesView()
								.onDisappear {
									workflows.run(.getComicsNear(state.currentComic))
									showPages = false
								}
								.navigationBarItems(
									trailing:
										HStack {
											Button(
												action: {
													reducers.run(.turnToNewerComic)
												},
												label: {
													Image(systemName: "arrowtriangle.left.fill")
														.accessibility(identifier: "arrowtriangle.left.fill")
												}
											)
											Button(
												action: {
													reducers.run(.turnToPreviousComic)
												},
												label: {
													Image(systemName: "arrowtriangle.right.fill")
														.accessibility(identifier: "arrowtriangle.right.fill")
												}
											)
										}
								), isActive: $showPages ) { EmptyView() }
			}
			.navigationBarTitleDisplayMode(.inline)
		}

	}
}
