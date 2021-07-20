//
//  JSON.swift
//  ComicSplash
//
//  Created by Marco Boerner on 16.07.21.
//

import Foundation
import Combine
import os

/*

The Comic API Model

Has one main fetch data method and a second that accepts an array of string components instead of a url string for convenience.

The fetching and decoding of the json is all handles within the same combine subscription as this saves additional decoding methods.

Receiving on the main thread is important because the received data is then stored in a published variable of an observable object. Handling the subscription within the model as data is received only once and the subscriber terminated right after.

Even though the comic dictionary is cleared when the user goes to a random comic etc. The URLSession should by default keep a certain amount of requests in cache.

*/

enum ComicAPIModelError: Error {
	case invalidURLString
}

class ComicAPIModel {

	let log = Logger(category: "ComicAPIModel")

	var subscriber: AnyCancellable?
}
