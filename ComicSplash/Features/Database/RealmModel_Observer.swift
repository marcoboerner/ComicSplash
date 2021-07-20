//
//  RealmModel_Observer.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import RealmSwift
import Combine

extension RealmModel {

	/**
	Method used class private by RealmModel to listen to and publish changes in Realm

	- Parameter results: The results returned by a realm read method.

	# Notes: #
	1. Send out updates through the publisher variable of the RealmModel
	*/
	func observeChanges<Element>(of results: [Results<Element>]?) {

		guard let results = results else { return }

		for result in results {
			guard let tokenKeyType = result.first.self else { continue }
			let tokenKey = String(describing: tokenKeyType)

			// If the same request has been fired multiple time the previous notification token is invalidated.
			elementTokens[tokenKey]?.invalidate()

			elementTokens[tokenKey] = result.observe(on: .main) { changes in

				switch changes {

				case .initial(let elements):
					self.log.info("Received initial elements: \(elements.count)")
					let dataTypes: [DataType] = Array(elements).compactMap {
						self.mapFromRealmObject($0 as? Object)
					}
					self.publisher.send(dataTypes)

				case .update(let elements, _, _, _):
					self.log.info("Received updated elements: \(elements.count)")
					let dataTypes: [DataType] = Array(elements).compactMap {
						self.mapFromRealmObject($0 as? Object)
					}
					self.publisher.send(dataTypes)

				case .error(let error):
					self.publisher.send(completion: Subscribers.Completion<DatabaseServiceError>.failure(.undefinedError(error: error)))
				}
			}
		}
	}
}
