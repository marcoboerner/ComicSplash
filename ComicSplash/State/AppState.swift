//
//  State.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

/*

The single source of truth App State.

The class Equatable protocol methods had to be added manually because for some reason Xcode doesn't seem to be able to synthesize the method.

Newly added states need to be added to the == method.

*/

import Foundation
import Combine
import os

class AppState: ObservableObject, Equatable {

	static func == (lhs: AppState, rhs: AppState) -> Bool {
		lhs.databaseSubscriber == rhs.databaseSubscriber &&
			lhs.latestComicNum == rhs.latestComicNum &&
			lhs.comicsData == rhs.comicsData &&
			lhs.favoriteComicsData == rhs.favoriteComicsData &&
			lhs.tabViewSelection == rhs.tabViewSelection
	}

	let log = Logger(category: "AppState")

	var databaseSubscriber: AnyCancellable?

	@Published var tabViewSelection: String = K.Tags.comicNavigationView
	@Published var latestComicNum: Int = 0
	@Published var currentComic: Int = 0
	@Published var comicsData: [Int: ComicData] = [:]
	@Published var favoriteComicsData: [Int: ComicData] = [:]

	struct Settings {
		static let requiredComicAmount = 3 // I'd not set it much lower than 10 so the user doesn't have to wait too long.
		static let latestComicURL = "https://xkcd.com/info.0.json"
		static let previousComicURLComponents: [LosslessStringConvertible] = ["https://xkcd.com/", 1, "/info.0.json"]
	}
}

class Reactors: ObservableObject {

	init(state: AppState) {
		self.state = state
		self.workflow = Workflows(state: state)

		subscribers.append(
			state.$currentComic
				.scan( (previous: 0, new: 0) ) { ($0.1, $1) }
				.sink { num in
					print("Received new: \(num)")

					guard state.tabViewSelection == K.Tags.comicNavigationView, abs(num.previous - num.new) == 1 else { return }

					if num.new > num.previous && num.new <= state.latestComicNum {
						self.workflow.run(.getNewerComic)
					} else if num.new > 1 {
						self.workflow.run(.getPreviousComic)
					}

				}
		)
	}

	private let state: AppState
	private let workflow: Workflows
	private var subscribers: [AnyCancellable] = []

}
