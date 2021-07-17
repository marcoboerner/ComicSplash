//
//  SwiftUIView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct SwiftUIView: View {

	@State var myArray: [String] = ["C", "D", "E", "F", "G"]

	var body: some View {

		VStack {
			Button("Insert before", action: {
				myArray.insert("A", at: 0)
			})
			TabView {
				ForEach(myArray, id: \.self) { value in
					Text("\(value)")
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
		}
	}
}

struct SwiftUIView_Previews: PreviewProvider {
	static var previews: some View {
		SwiftUIView()
	}
}
