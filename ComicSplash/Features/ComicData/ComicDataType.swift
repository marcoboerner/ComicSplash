//
//  ComicData.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation

protocol DataType {}

struct ComicData: DataType, Decodable, Equatable {

	// FIXME: - Gonna check if it might be better to just assign empty values or strings as default initilizer.

	// JSON Relevant values
	let month: String?
	let num: Int
	let link: String?
	let year: String?
	let news: String?
	let safeTitle: String?
	let transcript: String?
	let alt: String?
	let img: String?
	let title: String?
	let day: String?

}
