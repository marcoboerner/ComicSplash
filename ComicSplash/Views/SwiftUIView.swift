//
//  SwiftUIView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import SwiftUI

struct SwiftUIView: View {

	@State private var selectedTab = 5
	@State var myArray: [Int: String] = [1: "B", 5: "C", 7: "D"]

	var body: some View {

		VStack {
			Button("Insert before", action: {
				myArray[0] = "A"
			})
			TabView(selection: $selectedTab) {
				ForEach(myArray.sorted(by: <), id: \.key) { key, value in
					Text("\(value)")
						.onTapGesture {
							self.selectedTab = 5
						}
				}
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.id(myArray.count)      // << here !!
		}
	}
}

struct SwiftUIView_Previews: PreviewProvider {
	static var previews: some View {
		SwiftUIView()
	}
}
