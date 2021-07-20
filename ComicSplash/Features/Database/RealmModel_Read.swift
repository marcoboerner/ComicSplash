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
	Opens and reads from the local default realm.

	- Warning: If the realm object has changed, migration or deletion of the app with loss of data is required.
	- Parameter dataTypes: An array of Types conforming to DataType. This type of data will be requested from the realm.
	- Returns: DatabasePublisher

	# Notes: #
	1. Store and keep alive the database publisher of type PassthroughSubject<[DataType], DatabaseServiceError> to receive data through it.
	2. The local realm file url will be printed in the debug or console log.
	*/
	func openLocal(read dataTypes: [DataType.Type]) -> DatabasePublisher {

		let objectTypes = dataTypes.compactMap { mapToRealmObjectType($0) }

		var objects: [Results<Object>] = []

		do {
			let realm = try Realm()

			log.info("Opened local realm: \(realm.configuration.fileURL!)")

			objects.append(contentsOf: objectTypes.compactMap { realm.objects($0) })

			observeChanges(of: objects)
		} catch {
			log.error("\(error.localizedDescription)")
		}

		return publisher
	}
}
