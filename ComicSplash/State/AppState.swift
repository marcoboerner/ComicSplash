//
//  State.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

class AppState: ObservableObject {

	@Published var latestComicNum: Int = 0
	@Published var currentComic: Int = 0
	@Published var comicsData: [Int: ComicData] = [:]

	struct Settings {
		static let requiredComicAmount = 10 // I'd not set it much lower than 10 so the user doesn't have to wait too long.
		static let currentComicURL = "https://xkcd.com/info.0.json"
		static let previousComicURLComponents: [LosslessStringConvertible] = ["https://xkcd.com/", 1, "/info.0.json"]
	}
}
