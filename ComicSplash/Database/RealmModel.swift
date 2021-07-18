//
//  DatabaseWorkflow.swift
//  ComicSplash
//
//  Created by Marco Boerner on 17.07.21.
//

import Foundation
import RealmSwift
import Combine

typealias DatabasePublisher = PassthroughSubject<[DataType], DatabaseServiceError>

enum DatabaseServiceError: Error {
	case undefinedError(error: Error)
}

class RealmModel {

	enum MongoDBRealmError: Error {
		case noCurrentAppUser
		case objectIsNilOrNotValid
		case signInWithAppleTokenError
		case unknownAuthenticationService
	}

	// MARK: - Realm properties

	var elementTokens: [String: NotificationToken] = [:]

	deinit { elementTokens.forEach { $1.invalidate() } }

	// MARK: - DatabaseService Protocol methods

	var publisher: DatabasePublisher = DatabasePublisher()

	// MARK: - Open local

	func openLocal(read objectTypes: [DataType.Type]) -> DatabasePublisher {

		let objectTypes = objectTypes.compactMap { mapToRealmObjectType($0) }

		var results: [Results<Object>]?

		do {
			results = try readFromRealm(objectTypes)
			self.observeChanges(of: results)
		} catch {
			print("Error in openAndReadFromLocalRealm %@", error.localizedDescription)
		}

		return publisher
	}

	// MARK: - Creating a realm config

	func readFromRealm(_ objectTypes: [Object.Type]) throws -> [Results<Object>] {

// FIXME: - error handling and maybe combining with the above method. Because it can fail if the realm objects have been changed.

		var objects: [Results<Object>] = []

		let realm = try? Realm()

		print("Opened realm: \(realm!.configuration.fileURL!)")

		objects.append(contentsOf: objectTypes.compactMap { realm?.objects($0) })

		return objects
	}

	// MARK: - Observer

	func observeChanges<Element>(of results: [Results<Element>]?) {

		guard let results = results else { return }

		for result in results {
			guard let tokenKeyType = result.first.self else { continue }
			let tokenKey = String(describing: tokenKeyType)

			elementTokens[tokenKey]?.invalidate()

			elementTokens[tokenKey] = result.observe(on: .main) { changes in

				switch changes {
				case .initial(let elements):
					print("MongoDBRealm adding %@ elements", elements.count)
					let dataTypes: [DataType] = Array(elements).compactMap {
						return self.mapFromRealmObject($0 as? Object)
					}
					self.publisher.send(dataTypes)

				case .update(let elements, _, _, _):
					print("MongoDBRealm updating %@ elements", elements.count)
					let dataTypes: [DataType] = Array(elements).compactMap {
						return self.mapFromRealmObject($0 as? Object)
					}
					self.publisher.send(dataTypes)
				case .error(let error):
					self.publisher.send(completion: Subscribers.Completion<DatabaseServiceError>.failure(.undefinedError(error: error)))
				}
			}
		}
	}

	// MARK: - Write to realm

	func writeToRealm(_ data: DataType, completion: @escaping (Error?) -> Void) {

		guard let object = mapToRealmObject(data) else {
			completion(MongoDBRealmError.objectIsNilOrNotValid)
			return
		}

		do {
			let realm = try Realm()
			try realm.write {
				realm.add(object)
				completion(nil)
			}
		} catch {
			completion(error)
		}
	}

	func deleteFromRealm(_ object: Object?, completion: @escaping (Error?) -> Void) {

		guard let object = object else {
			completion(MongoDBRealmError.objectIsNilOrNotValid)
			return
		}

		do {
			let realm = try Realm()
			try realm.write {
				realm.delete(object)
				completion(nil)
			}
		} catch {
			completion(error)
		}

	}
}
