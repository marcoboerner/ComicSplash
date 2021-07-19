//
//  ComicImageView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicImageView: View {

	@State var showComicZoomView = false

	@EnvironmentObject var state: AppState
	@State var showOverlay = false
	var comicNum: Int
	@State var lastScale: CGFloat = 1.0
	@State var scale: CGFloat = 1.0
	@State var offset: CGSize = .zero

	var body: some View {

//		let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0.1).onChanged { value in
//			withAnimation {
//				let delta = value / self.lastScale
//				self.lastScale = value
//				let newScale = self.scale * delta
//				self.scale = min(max(newScale, 0.5), 2)
//			}
//		}.onEnded { _ in
//			self.lastScale = 1.0
//		}
//
//		let tapGesture = LongPressGesture(minimumDuration: 1, maximumDistance: 1)
//
//		let dragGesture = DragGesture(minimumDistance: 5.1)
//			.onChanged { value in
//				withAnimation {
//					offset = value.translation
//				}
//			}
//			.onEnded { _ in
//				withAnimation {
//					offset = .zero
//				}
//			}
//
//		let sequencedGesture = tapGesture.sequenced(before: dragGesture)
//
//		let magnificationANDDragGesture = magnificationGesture.simultaneously(with: sequencedGesture)

		return
			ZStack {
			AltTextOverlayView(altText: state.comicsData[comicNum]?.alt ?? "Without words", show: $showOverlay)

			.zIndex(99)
		ComicImageZoomedView(comicNum: comicNum, show: $showComicZoomView)
			.edgesIgnoringSafeArea(.all)
			.zIndex(98)

			WebImage(
				url: URL(string: state.comicsData[comicNum]?.img ?? "/"),
				options: [.retryFailed, .continueInBackground])
			.resizable()
			.placeholder {
				LogoView(scale: 0.4, animated: true)
			}
			.indicator(.activity) // Activity Indicator
			.transition(.fade(duration: 0.5)) // Fade Transition with duration
			.scaledToFit()
			.frame(alignment: .center)
//			.overlay(
//				ZStack {
//
//			)
			.offset(offset)
			.scaleEffect(scale)
			.onTapGesture(count: 2) {
				print("does it")
				showComicZoomView.toggle()
			}
			.onLongPressGesture { // FIXME: - Want this as a variable, but didn't manage yet to get the right order of gestures in combination with the ones below.
				withAnimation {
					offset = .zero
					scale = 1.0
					showOverlay = true
				}
			}
			}
			//.gesture(magnificationANDDragGesture)
	}
}

struct ComicImageView_Previews: PreviewProvider {
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

		return ComicImageView(comicNum: 100)
			.environmentObject(state)
	}
}
