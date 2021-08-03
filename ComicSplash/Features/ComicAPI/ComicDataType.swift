//
//  ComicData.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

/*

The data structure needed for decoding the json file.

Needs to reflect the data structure of the json and should not be changed.

Additional values not found in the json should be initialized properly to avoid decoding errors.

*/

import Foundation

protocol DataType {}

struct ComicData: DataType, Decodable, Equatable {


	// JSON Relevant values
	let month: String
	let num: Int
	let link: String?
	let year: String
	let news: String?
	let safeTitle: String?
	let transcript: String?
	let alt: String?
	let img: String?
	let title: String?
	let day: String

	// Computed properties
	var dateString: String {
		if let date = DateComponents(calendar: Calendar.current, year: Int(year), month: Int(month), day: Int(day)).date {
			let formatter = DateFormatter()
			formatter.locale = Locale.current
			formatter.setLocalizedDateFormatFromTemplate("dd mm yyyy")
			return formatter.string(from: date)
		} else {
			return ""
		}
	}
}
