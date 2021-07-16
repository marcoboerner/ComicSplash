//
//  ContentView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var state: State

    var body: some View {

		switch state.comicsData.count {
		case 0:
			WelcomeView()
				.onAppear {
					print("appear")
				}
		default:
			Text(state.comicsData.first!.value.num.description)
		}
    }
}

// FIXME: - Need to create preview content.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
