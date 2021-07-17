//
//  ComicView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct ComicView: View {

	@EnvironmentObject var state: AppState
	@Binding var comicNum: Int

    var body: some View {
		Text("\(state.comicsData[comicNum]?.title ?? "no title")")
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
