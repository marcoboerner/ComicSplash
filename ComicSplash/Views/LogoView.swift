//
//  WelcomeView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

// TODO: - Create transitions for all changes in between screens and texts.

struct LogoView: View {

	var scale: CGFloat = 1.0
	var animated: Bool = false
	@State var rotation: Angle = .zero

	var body: some View {
		Image(K.ImageSets.inAppLogo)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.scaleEffect(scale)
			.rotationEffect(rotation)
			.onAppear {
				if animated {
					withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.2, blendDuration: 5.0).repeatForever().delay(0.5)) {
						rotation = Angle(degrees: 3600)
					}
				}
			}
	}
}

struct WelcomeView_Previews: PreviewProvider {
	static var previews: some View {
		LogoView(scale: 0.4, animated: true)
			.previewLayout(.device)
			.previewDevice("iPhone 8")
	}
}
