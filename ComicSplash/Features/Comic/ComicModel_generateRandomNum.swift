//
//  Workflows_ComicsAPI.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation

extension ComicModel {

	func generateRandomNum(below maxNum: Int) -> Int {

		let requiredComicAmount = MainState.Settings.requiredComicAmount

		// Offsetting the min and max value to not immediately hit an end or previously viewed comic
		let range = (requiredComicAmount*2...maxNum-requiredComicAmount*5)

		// Using Int.random, however an equal distribution generator might be desired in the future.
		return Int.random(in: range)
	}
}
