//
//  ImageStorage.swift
//  ComicSplash
//
//  Created by Marco Boerner on 19.07.21.
//

/*

The image storage model used by the favorites workflows to either download and save or delete images.

For testing purposes a ImageStorage protocol should be used throughout the app and not the image storage model directly as it is now.

The methods could in the future be made more generic taking only url strings or filenames as input.

URLSession.shared.downloadTask could be replaced by a combine method once it's available.

*/

import Foundation
import SDWebImageSwiftUI
import os

enum ImageStorageError: Error {
	case errorUnwrapping
}

class ImageStorageModel {

	let log = Logger(category: "ImageStorageModel")

}
