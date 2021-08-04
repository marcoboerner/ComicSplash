//
//  RealmObjectModels.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

/*

The object type required by realm.

*/

import Foundation
import RealmSwift

// swiftlint:disable identifier_name

@objcMembers
class _ComicData: Object {

	dynamic var _id: Int = 0 // For simplicity, using the comic's num as DB id instead of a generated object ID.
	dynamic var months: String = ""
	dynamic var num: Int = 0
	dynamic var link: String?
	dynamic var year: String = ""
	dynamic var news: String?
	dynamic var safeTitle: String?
	dynamic var transcript: String?
	dynamic var alt: String?
	dynamic var img: String?
	dynamic var title: String?
	dynamic var day: String = ""

	override static func primaryKey() -> String? {
		return "_id"
	}

	convenience init(
		months: String,
		num: Int,
		link: String?,
		year: String,
		news: String?,
		safeTitle: String?,
		transcript: String?,
		alt: String?,
		img: String?,
		title: String?,
		day: String
	) {
		self.init()
		self._id = num
		self.months = months
		self.num = num
		self.link = link
		self.year = year
		self.news = news
		self.safeTitle = safeTitle
		self.transcript = transcript
		self.alt = alt
		self.img = img
		self.title = title
		self.day = day
	}
}
