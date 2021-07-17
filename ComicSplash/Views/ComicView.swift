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
	@Binding var comicNum: Int
	@State var showOverlay = false

// FIXME: - want to pass on only the current comic. Not all of it. Might make current comic available as a state variable.

    var body: some View {
		VStack {
			Spacer()
			ZStack {
				WebImage(
					url: URL(string: state.comicsData[comicNum]?.img ?? "/"),
					options: [.highPriority, .retryFailed])
					.onSuccess { image, data, cacheType in
					}
					.resizable()
					.placeholder(Image(systemName: "photo"))
					.placeholder {
						WelcomeView()
					}
					.indicator(.activity) // Activity Indicator
					.transition(.fade(duration: 0.5)) // Fade Transition with duration
					.scaledToFit()
					.frame(alignment: .center)
					.overlay(
						AltOverlayView(altText: state.comicsData[comicNum]?.alt ?? "Without words", show: $showOverlay)
					)
					.onLongPressGesture {
						showOverlay = true
					}
			}

			Spacer()
			VStack {
				Text("\"\(state.comicsData[comicNum]?.title ?? "Untitled")\"")
				HStack {
					Text("Issue #\(state.comicsData[comicNum]?.num ?? 0)")
					Text("\(state.comicsData[comicNum]?.day ?? "29").\(state.comicsData[comicNum]?.month ?? "08").\(state.comicsData[comicNum]?.year ?? "1997")")
				}
			}

    }
	}
}

struct ComicView_Previews: PreviewProvider {

    static var previews: some View {
		let state = AppState()
		state.comicsData[100] = ComicData(
			month: "5",
			num: 100,
			link: nil,
			year: "2006",
			news: nil,
			safeTitle: "Family Circus",
			transcript: "[[Picture shows a pathway winding through trees to a sink inside a house, out to some swings and back to ths sink, out to a ball and back to the sink...]]\nCaption: Jeffy's ongoing struggle with obsessive-compulsive disorder\n{{alt text: This was my friend David's idea}}",
			alt: "This was my friend David's idea",
			img: "https://imgs.xkcd.com/comics/family_circus.jpg",
			title: "Family Circus",
			day: "10")
		return ComicView(comicNum: .constant(100))
			.environmentObject(state)
    }
}
