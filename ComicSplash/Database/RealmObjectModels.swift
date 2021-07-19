//
//  RealmObjectModels.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import Foundation
import RealmSwift

// swiftlint:disable identifier_name

@objcMembers
class _ComicData: Object {

	dynamic var _id: Int = 0 // For simplicity, using the comic's num as DB id instead of an object ID.
	dynamic var favorite: Bool = true // Note: optional booleans cannot be represented in objc. Hence the default.
	dynamic var months: String?
	dynamic var num: Int = 0
	dynamic var link: String?
	dynamic var year: String?
	dynamic var news: String?
	dynamic var safeTitle: String?
	dynamic var transcript: String?
	dynamic var alt: String?
	dynamic var img: String?
	dynamic var title: String?
	dynamic var day: String?

	override static func primaryKey() -> String? {
		return "_id"
	}

	convenience init(
		favorite: Bool,
		months: String?,
		num: Int,
		link: String?,
		year: String?,
		news: String?,
		safeTitle: String?,
		transcript: String?,
		alt: String?,
		img: String?,
		title: String?,
		day: String?
	) {
		self.init()
		self._id = num
		self.favorite = favorite
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

// MARK: - Mapping the app / protocol objects to something realm understands

extension RealmModel {

	func mapFromRealmObject(_ realmObject: Object?) -> DataType? {

		guard let realmObject = realmObject else {
			return nil
		}

		switch realmObject {
		case let comicData as _ComicData:
			return ComicData(
				favorite: comicData.favorite,
				month: comicData.months,
				num: comicData.num,
				link: comicData.link,
				year: comicData.year,
				news: comicData.news,
				safeTitle: comicData.safeTitle,
				transcript: comicData.transcript,
				alt: comicData.alt,
				img: comicData.img,
				title: comicData.title,
				day: comicData.day
			)
		default:
			return nil
		}
	}

	func mapToRealmObject(_ foreignObject: DataType) -> Object? {

		switch foreignObject {
		case let comicData as ComicData:
			return _ComicData(
				favorite: comicData.favorite ?? false,
				months: comicData.month,
				num: comicData.num,
				link: comicData.link,
				year: comicData.year,
				news: comicData.news,
				safeTitle: comicData.safeTitle,
				transcript: comicData.transcript,
				alt: comicData.alt,
				img: comicData.img,
				title: comicData.title,
				day: comicData.day
			)
		default:
			return nil
		}
	}

	func mapToRealmObjectType(_ foreignType: DataType.Type) -> Object.Type? {

		switch foreignType {
		case is ComicData.Type:
			return _ComicData.self
		default:
			return nil
		}
	}

}
