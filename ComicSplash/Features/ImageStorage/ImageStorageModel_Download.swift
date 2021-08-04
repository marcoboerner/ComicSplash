//
//  ImageStorageModel_Download.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation
import SDWebImageSwiftUI

extension ImageStorageModel {

	/**
	Asynchronous downloads and stores an image into the apps documents folder.

	- Parameter comicData: The comic data object containing the url and its number as string.
	- Parameter completion: Called once download and storage succeeded, passes on errors if any.
	*/
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
					self.log.info("Image successfully downloaded and stored at \(destination.absoluteString)")
					completion(nil)
				} catch {
					completion(error)
				}
			}
		}.resume()
	}
}
