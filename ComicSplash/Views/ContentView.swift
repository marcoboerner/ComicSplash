//
//  ContentView.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var state: AppState

    var body: some View {

		switch state.latestComicNum {
		case 0:
			LogoAndLoadingView()
		default:
			MainTabView()
		}
    }
}
