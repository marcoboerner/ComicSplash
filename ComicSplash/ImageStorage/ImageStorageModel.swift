//
//  ImageStorage.swift
//  ComicSplash
//
//  Created by Marco Boerner on 19.07.21.
//

import Foundation
import SDWebImageSwiftUI

class ImageStorageModel {

	enum ImageStorageError: Error {
		case errorUnwrapping
	}

	func downloadImageFor(_ comicData: ComicData, completion: @escaping (Error?) -> Void) {

		guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
			  let urlString = comicData.img,
			  let url = URL(string: urlString)
		else {
			completion(ImageStorageError.errorUnwrapping)
			return
		}

		URLSession.shared.downloadTask(with: url) { location, _, error in
			if let error = error {
				completion(error)
			} else if let location = location {
				do {
					let fileName = comicData.num.description + "." + url.pathExtension
					let destination = documents.appendingPathComponent(fileName)
					try FileManager.default.moveItem(at: location, to: destination)
					completion(nil)
				} catch {
					completion(error)
				}
			}
		}.resume()
	}

	func deleteImageFor(_ comicData: ComicData) throws {

		guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
			  let urlString = comicData.img,
			  let url = URL(string: urlString)
		else {
			throw ImageStorageError.errorUnwrapping
		}

		let fileName = comicData.num.description + "." + url.pathExtension
		let destination = documents.appendingPathComponent(fileName)

		do {
			try FileManager.default.removeItem(at: destination)
		} catch {
			throw error
		}

	}

}
