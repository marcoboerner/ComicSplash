//
//  RealmModel_Mapping.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import RealmSwift

extension RealmModel {

	///	Converts a realm object to a DataType object.
	func mapFromRealmObject(_ realmObject: Object?) -> DataType? {

		guard let realmObject = realmObject else {
			return nil
		}

		switch realmObject {
		case let comicData as _ComicData:
			return ComicData(
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

	/// Converts an object of type DataType to a realm object.
	func mapToRealmObject(_ foreignObject: DataType) -> Object? {

		switch foreignObject {
		case let comicData as ComicData:
			return _ComicData(
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

	/// Converts a Type conforming to DataType to the matching realm object Type
	func mapToRealmObjectType(_ foreignType: DataType.Type) -> Object.Type? {

		switch foreignType {
		case is ComicData.Type:
			return _ComicData.self
		default:
			return nil
		}
	}
}
