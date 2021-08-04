//
//  ArrayExtension.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

/*

Array extension for convenience and code readability only.

*/

import Foundation

extension Array {

	/// A Boolean value indicating whether the collection is NOT empty.
	public var isNotEmpty: Bool {
		!self.isEmpty
	}
}
