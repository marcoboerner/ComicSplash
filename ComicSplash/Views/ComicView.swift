//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicView: View {

	@EnvironmentObject var state: AppState
	var comicNum: Int
	@State var scale = 1.0

	var body: some View {
		ZStack {
			VStack {
				Spacer()
				ComicImageView(comicNum: comicNum)
				Spacer()
				VStack {
					Text("\"\(state.comicsData[comicNum]?.title ?? "Untitled")\"")
					HStack {
						Text("Issue #\(state.comicsData[comicNum]?.num ?? 0)")
						Text("\(state.comicsData[comicNum]?.day ?? "29").\(state.comicsData[comicNum]?.month ?? "08").\(state.comicsData[comicNum]?.year ?? "1997")")
					}
				}
			}
			TalkAndLoveOverlayView(comicNum: $state.currentComic)
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
		}
	}
}
