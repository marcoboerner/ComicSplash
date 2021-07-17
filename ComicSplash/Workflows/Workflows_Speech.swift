//
//  Workflows_Speech.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation

extension Workflows {

	func speak(_ transcript: String) {

		let textToSpeechModel = TextToSpeechModel()

		textToSpeechModel.speak(transcript)

	}
}
