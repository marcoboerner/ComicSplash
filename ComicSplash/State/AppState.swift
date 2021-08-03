//
//  State.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import Combine
import os

class AppState: ObservableObject, Equatable {

	convenience init() {
		self.init()
		self.combinedPublisher = Publishers
			.CombineLatest4($latestComicNum, $currentComic, $comicsData, $favoriteComicsData)
			.handleEvents(receiveSubscription: { subscription in
				self.log.info("Subscription: \(subscription.combineIdentifier)")
			}, receiveOutput: { output in
				self.log.info("""
State:
latestComicNum = \(output.0)
currentComic = \(output.1)
comicsData = \(output.2)
favoriteComicsData = \(output.3)
""")
			}, receiveCompletion: { completion in

			}, receiveCancel: {

			}, receiveRequest: { request in

			})
			.eraseToAnyPublisher()
	}

	static func == (lhs: AppState, rhs: AppState) -> Bool {
		lhs.databaseSubscriber == rhs.databaseSubscriber &&
			lhs.latestComicNum == rhs.latestComicNum &&
			lhs.comicsData == rhs.comicsData &&
			lhs.favoriteComicsData == rhs.favoriteComicsData
	}

	let log = Logger(category: "AppState")

	var databaseSubscriber: AnyCancellable?

	@Published var latestComicNum: Int = 0
	@Published var currentComic: Int = 0
	@Published var comicsData: [Int: ComicData] = [:]
	@Published var favoriteComicsData: [Int: ComicData] = [:]

	var combinedPublisher: AnyPublisher<(Published<Int>.Publisher.Output, Published<Int>.Publisher.Output, Published<[Int : ComicData]>.Publisher.Output, Published<[Int : ComicData]>.Publisher.Output), Published<Int>.Publisher.Failure>

	struct Settings {
		static let requiredComicAmount = 3 // I'd not set it much lower than 10 so the user doesn't have to wait too long.
		static let latestComicURL = "https://xkcd.com/info.0.json"
		static let previousComicURLComponents: [LosslessStringConvertible] = ["https://xkcd.com/", 1, "/info.0.json"]
	}
}

class Receive {

	let receive = AppState().$comicsData.sink { value in

	}

}
