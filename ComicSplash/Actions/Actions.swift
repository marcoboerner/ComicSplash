//
//  Actions.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

enum Action {

	case getLatestComics
	case getPreviousComic
	case getNextComic
	case getRandomComics

	case clearComics

	case previous
	case next
	case gotoComic(_ num: Int)

	case storePreviousComic(ComicData)
	case storeNextComic(ComicData)
}
