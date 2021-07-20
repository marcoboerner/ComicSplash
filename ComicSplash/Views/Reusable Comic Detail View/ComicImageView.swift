//
//  ComicImageView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicImageView: View {

	@State var activateScaling = false

	@EnvironmentObject var state: AppState
	@State var showOverlay = false
	var comicNum: Int
	@State var lastScale: CGFloat = 1.5
	@State var scale: CGFloat = 1.5
	@State var offset: CGSize = .zero
	@State var translation: CGSize = .zero

	var body: some View {

		let magnificationGesture = MagnificationGesture(minimumScaleDelta: 0.1).onChanged { value in
			withAnimation {
				activateScaling = true
				let delta = value / self.lastScale
				self.lastScale = value
				let newScale = self.scale * delta
				self.scale = min(max(newScale, 0.5), 2)
			}
		}.onEnded { _ in
			self.lastScale = 1.5
		}

		let dragGesture = DragGesture(minimumDistance: 1.0, coordinateSpace: .local).onChanged { value in
			withAnimation {
				offset.height = translation.height + value.translation.height
				offset.width = translation.width + value.translation.width
			}
		}.onEnded { value in
			translation.width += value.translation.width
			translation.height += value.translation.height
		}

		// Using this gesture is a workaround to not block the page turn gesture from the TabBarView
		let noDragGesture = DragGesture(minimumDistance: .infinity).onChanged({_ in}).onEnded({_ in})

		return
			WebImage(
				url: URL(string: state.comicsData[comicNum]?.img ?? "/"),
				options: [.retryFailed, .continueInBackground])
			.resizable()
			.placeholder {
				LogoAndLoadingView(scale: 0.4, animated: true, light: true)
			}
			.transition(.fade(duration: 0.5))
			.scaledToFit()
			.frame(alignment: .center)
			.overlay(
				AltTextOverlayView(altText: state.comicsData[comicNum]?.alt ?? "Without words", show: $showOverlay)
			)
			.offset(activateScaling ? offset : .zero)
			.scaleEffect(activateScaling ? scale : 1.0)
			.onTapGesture(count: 2) {
				withAnimation {
					activateScaling.toggle()
				}
			}
			.onLongPressGesture {
				if !activateScaling {
					withAnimation {
						offset = .zero
						scale = 1.0
						showOverlay = true
					}
				}
			}
			.simultaneousGesture(magnificationGesture)
			.highPriorityGesture(activateScaling ? dragGesture : noDragGesture)
			.onAppear {
				activateScaling = false
			}
	}
}
