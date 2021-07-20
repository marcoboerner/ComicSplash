//
//  RealmModel_Delete.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import RealmSwift

extension RealmModel {

	/**
	Deletes the object with the given primary key from the local realm.

	- Parameter objectType: The primary key of the realm object.
	- Parameter primaryKey: The primary key of the realm object.
	- Parameter completion: Called after the delete attempt. Passes on potential errors..

	# Notes: #
	1. The primaryKey is by default not set and needs to be defined and set or generated in the realm object.
	*/
	func deleteFromRealm(dataType: DataType.Type, primaryKey: Int, completion: @escaping (Error?) -> Void) {

		guard let objectType = mapToRealmObjectType(dataType) else {
			completion(DatabaseServiceError.dataTypeWrongOrNotMapped)
			return
		}

		do {
			let realm = try Realm()
			guard let objectToDelete = realm.object(ofType: objectType, forPrimaryKey: primaryKey) else {
				throw DatabaseServiceError.objectForDeletionNotFound
			}
			try realm.write {
				realm.delete(objectToDelete)
				completion(nil)
			}
		} catch {
			completion(error)
		}
	}
}
