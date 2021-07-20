//
//  DatabaseWorkflow.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

/*

The realm model has all currently used methods for the locally stored realm database.

For testing purposes a DatabaseService protocol should be used throughout the app and not the realm model directly as it is now.

The current model can fairly easy be extended to support MongoDBRealm cloud sync with MongoDB Atlas.

The methods are fairly generic and can support other data conforming to DataType,
as long as the appropriate realm object and matching mapping methods are created.

*/

import Foundation
import RealmSwift
import Combine
import os

typealias DatabasePublisher = PassthroughSubject<[DataType], DatabaseServiceError>

enum DatabaseServiceError: Error {
	case undefinedError(error: Error)
	case objectForDeletionNotFound
	case objectIsNilOrNotValid
	case dataTypeWrongOrNotMapped
}

class RealmModel {

	let log = Logger(category: "RealmModel")

	// For each realm listener an individual notification token is stored.
	var elementTokens: [String: NotificationToken] = [:]

	// Each individual listener sends updates over the same publisher.
	var publisher: DatabasePublisher = DatabasePublisher()

	deinit { elementTokens.forEach { $1.invalidate() } }

}
