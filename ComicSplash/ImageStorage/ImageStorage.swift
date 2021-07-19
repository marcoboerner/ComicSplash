//
//  ImageStorage.swift
//  ComicSplash
//
//  Created by Marco Boerner on 19.07.21.
//

import Foundation
import SDWebImageSwiftUI

class ImageStorage {

	internal init() {
		self.manager = SDWebImageManager(cache: cache, loader: loader)
	}

	let loader: SDWebImageDownloader = SDWebImageDownloader()
	let cache: SDImageCache = SDImageCache(namespace: "imageStorage", diskCacheDirectory: "Documents", config: .default)
	let manager: SDWebImageManager


	func printInfo() {
		print(cache.diskCachePath)
	}
}


//SDWebImageExternalCustomManagerKey
