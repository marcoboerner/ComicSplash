//
//  TextToSpeechModel.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation
import AVFoundation

class TextToSpeechModel {

	func speak(_ text: String) {

		let speechSynthesizer = AVSpeechSynthesizer()

		let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)

		// Speech utterance rate. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
		speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate

		// Voice explicitly set to English here because the comics are in english.
		speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-ZA")

		// Starts the to speak.
		speechSynthesizer.speak(speechUtterance)

		//speechSynthesizer.stopSpeaking(at: .immediate)
	}

}
