//
//  TextToSpeechModel.swift
//  ComicSplash
//
//  Created by Marco Boerner on 18.07.21.
//

import Foundation
import AVFoundation

/*
TextToSpeechModel setup as a singleton.

ToDo in future version, using the AVSpeechSynthesizerDelegate to react to pause and end events.
Currently the user can only start but not stop or interrupt.

*/

class TextToSpeechModel {

	static private let speechSynthesizer = AVSpeechSynthesizer()

	/**
	Starts speaking the provided text and stops any previous sessions

	- Parameter text: The text to be spoken.

	# Notes: #
	1. The language is set to en-ZA but might default to another.
	*/
	static func speak(_ text: String) {

		// Stops previously started speaking session.
		speechSynthesizer.stopSpeaking(at: .immediate)

		let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)

		// Speech utterance rate. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
		speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate

		// Voice explicitly set to English here because the comics are in english.
		speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-ZA")

		// Starts the to speak.
		speechSynthesizer.speak(speechUtterance)

	}
}
