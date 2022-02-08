//
//  TalkAndLoveOverlayView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct TalkAndLoveOverlayView: View {

	@EnvironmentObject var state: MainState
	@EnvironmentObject var workflows: Workflows
	@Binding var comicNum: Int

    var body: some View {
		HStack {
			Button(
				action: {
					workflows.run(.startSpeaking(state.comicsData[comicNum]?.transcript ?? "Nothing to say"))
				},
				label: {
					Image(systemName: "waveform")
						.resizable()
						.scaledToFit()
						.accentColor(state.comicsData[comicNum]?.transcript?.isEmpty ?? true ? .clear : .blue)
						.frame(minWidth: 15, idealWidth: 20, maxWidth: 30)
						.accessibility(identifier: "waveform")
				}
			)
			Button(
				action: {
					if state.favoriteComicsData[comicNum] == nil {
						workflows.run(.addComicAsFavorite(comicNum))
					} else {
						workflows.run(.removeComicFromFavorites(comicNum))
					}
				},
				label: {
					Image(systemName: "heart.fill")
						.resizable()
						.scaledToFit()
						.accentColor(state.favoriteComicsData[comicNum] != nil ? .red.opacity(1.0) : .gray.opacity(0.5))
						.frame(minWidth: 15, idealWidth: 20, maxWidth: 30)
						.accessibility(identifier: "heart.fill")
				}
			)
		}
		.padding(10)
    }
}
