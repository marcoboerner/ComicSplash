//
//  ComicSubNavigationView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import SwiftUI

struct ComicSubNavigationView: View {

	@EnvironmentObject var workflows: Workflows
	@EnvironmentObject var state: AppState

	var body: some View {
		NavigationView {
			ComicPagesView(comicsData: $state.comicsData)
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
									workflows.run(.getNewerComic)
								},
								label: {
									Image(systemName: "arrowtriangle.left.fill")
								}
							)
							Button(
								action: {
									workflows.run(.getPreviousComic)
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
