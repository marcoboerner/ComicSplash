//
//  RealmModel_Create.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import RealmSwift

extension RealmModel {

	/**
	Writes data to the local default realm.

	- Warning: If the realm object has changed, migration or deletion of the app with loss of data is required.
	- Parameter data: Any data conforming to DataType with an appropriate mapping method setup.
	- Parameter completion: Called after a successful write. Passes on optional errors..

	# Notes: #
	1. If no realm exists a new default realm will be created.
	2. Data will be created or updated.
	*/
	func writeToRealm(_ data: DataType, completion: @escaping (Error?) -> Void) {

		guard let object = mapToRealmObject(data) else {
			completion(DatabaseServiceError.objectIsNilOrNotValid)
			return
		}

		do {
			let realm = try Realm()
			try realm.write {
				realm.add(object, update: .modified)
				completion(nil)
			}
		} catch {
			completion(error)
		}
	}
}
