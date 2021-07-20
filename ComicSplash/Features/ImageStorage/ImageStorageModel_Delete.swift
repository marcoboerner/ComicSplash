//
//  ImageStorageModel_Delete.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import SDWebImageSwiftUI

extension ImageStorageModel {

	/**
	Deletes a previously downloaded image.

	- Parameter comicData: The comic data object containing the url and its number as string..

	# Notes: #
	1. Throws errors
	*/
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
			log.info("Deleted image \(destination.absoluteString)")
		} catch {
			throw error
		}
	}
}
