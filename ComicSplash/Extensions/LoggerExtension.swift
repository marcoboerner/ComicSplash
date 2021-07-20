//
//  LoggerExtension.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

/*

Extension for the logger.

*/

import Foundation
import os

extension Logger {

	/// Initializes logger instance with a new category. Automatically using the bundleIdentifier as subsystem.
	init(category: String) {
		self.init(subsystem: Bundle.main.bundleIdentifier!, category: category)
	}
}
