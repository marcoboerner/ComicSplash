//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct ComicView: View {

	@EnvironmentObject var state: AppState

	// TODO: - maybe it's better to store the comics in an array in case one is missing?

	@State var currentComic: Int

    var body: some View {
		TabView(selection: $currentComic) {
			ForEach(state.comicsData, id: \.num) { comicData in

				Text("\(comicData.title ?? "no title")")

				}
			}
		.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
		.onChange(of: currentComic) { [currentComic] newCurrentComic in
			print("Change: \(newCurrentComic)")

// FIXME: - If used left / right / left / right you can download all the comics. Need to somehow limit that.

			if currentComic < newCurrentComic {
				Workflows(state: state).run(.getNextComic)
			} else if currentComic > newCurrentComic {
				Workflows(state: state).run(.getPreviousComic)
			}
		}
    }
}

struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
		ComicView(currentComic: 0)
			.preferredColorScheme(.dark)
    }
}
