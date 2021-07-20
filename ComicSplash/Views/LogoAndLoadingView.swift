//
//  WelcomeView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

struct LogoAndLoadingView: View {

	var scale: CGFloat = 1.0
	var animated: Bool = false
	var light: Bool = false
	@State var rotation: Angle = .zero

	var body: some View {
		Image(K.ImageSets.inAppLogo)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.scaleEffect(scale)
			.rotationEffect(rotation)
			.background(light ? Color.white : Color.black)
			.onAppear {
				if animated {
					withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 5.0).repeatForever().delay(0.5)) {
						rotation = Angle(degrees: 3600)
					}
				}
			}
	}
}
