//
//  WelcomeView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
		Image(K.ImageSets.inAppLogo)
			.resizable()
			.aspectRatio(contentMode: .fit)
		// TODO: - Create animation that slightly pumps the image to animate loading.
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
		WelcomeView()
			.previewLayout(.device)
			.previewDevice("iPhone 8")
    }
}
