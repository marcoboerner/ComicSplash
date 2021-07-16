//
//  Workflows.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

class Workflows {

	func run(_ action: Action) {

		switch action {

		case .getLatestComics

			let comicParser = ComicParser()
			comicParser.fetchComic(urlString: comicParser.comicURL)
			

		}

	}

}
