//
//  AltOverlayView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct AltTextOverlayView: View {

	let altText: String
	@Binding var show: Bool

	var body: some View {

		if show {
			return AnyView(
				Button(action: {
					show = false
				}, label: {
					Text(altText)
						.fontWeight(.black)
						.font(.headline)
						.padding()
						.foregroundColor(.white)
						.background(Color.black.opacity(0.7))
						.cornerRadius(10)
						.padding(10)
						.onAppear {
							DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
								withAnimation(.easeOut(duration: 1.0)) {
									show = false
								}
							}
						}
				})
			)
		} else {
			return AnyView(EmptyView())
		}
	}
}
