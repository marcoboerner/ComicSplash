//
//  TalkAndLoveOverlayView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct TalkAndLoveOverlayView: View {

	@EnvironmentObject var state: AppState
	@Binding var comicNum: Int

    var body: some View {
		HStack {
			Button(
				action: {
					// speak
				},
				label: {
					Image(systemName: "waveform")
						.resizable()
						.scaledToFit()
						.frame(minWidth: 15, idealWidth: 20, maxWidth: 30)
				}
			)
			Button(
				action: {
					Workflows(state: state).run(.toggleHeartForComic(comicNum))
				},
				label: {
					Image(systemName: "heart.fill")
						.resizable()
						.scaledToFit()
						.accentColor(state.favoriteComics.contains(comicNum) ? .red.opacity(1.0) : .gray.opacity(0.5))
						.frame(minWidth: 15, idealWidth: 20, maxWidth: 30)
				}
			)

		}
		.padding(10)
    }
}

struct TalkAndLoveOverlayView_Previews: PreviewProvider {
    static var previews: some View {
		TalkAndLoveOverlayView(comicNum: .constant(100))
    }
}
