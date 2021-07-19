//
//  ComicImageZoomedView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 19.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicImageZoomedView: View {

	@EnvironmentObject var state: AppState
	var comicNum: Int
	@Binding var show: Bool
	@State var lastScale: CGFloat = 1.0
	@State var scale: CGFloat = 1.0
	@State var offset: CGSize = .zero

	var body: some View {

		let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0.1).onChanged { value in
			withAnimation {
				let delta = value / self.lastScale
				self.lastScale = value
				let newScale = self.scale * delta
				self.scale = min(max(newScale, 0.5), 2)
			}
		}.onEnded { _ in
			self.lastScale = 1.0
		}

		let dragGesture = DragGesture(minimumDistance: 3)
			.onChanged { value in
				withAnimation {
					offset = value.translation
				}
			}

		let tapGesture = TapGesture(count: 2)
			.onEnded {
				withAnimation {
					show.toggle()
				}
			}

		let magnificationAndDragGesture = magnificationGesture.simultaneously(with: dragGesture)
		let combinedGestures = magnificationAndDragGesture.simultaneously(with: tapGesture)

		if show {
			return
				AnyView(
					WebImage(
						url: URL(string: state.comicsData[comicNum]?.img ?? "/"),
						options: [.retryFailed, .continueInBackground])
						.resizable()
						.transition(.fade(duration: 0.5)) // Fade Transition with duration
						.scaledToFit()
						.frame(alignment: .center)
						.offset(offset)
						.scaleEffect(scale)
						.gesture(combinedGestures)
				)
		} else {
			return AnyView(EmptyView())
		}
	}
}

struct ComicImageZoomedView_Previews: PreviewProvider {
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

		return ComicImageZoomedView(comicNum: 100, show: .constant(true))
			.environmentObject(state)
	}
}

