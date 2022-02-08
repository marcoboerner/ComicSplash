//
//  ContentView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var state: MainState

    var body: some View {

		switch state.latestComicNum {
		case 0:
			EmptyView()
		default:
			MainTabView()
		}
    }
}
