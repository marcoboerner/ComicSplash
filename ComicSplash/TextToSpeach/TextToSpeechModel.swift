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

//		var voice: AVSpeechSynthesisVoice!
//
//		for availableVoice in AVSpeechSynthesisVoice.speechVoices() {
//
//			if ((availableVoice.language == AVSpeechSynthesisVoice.currentLanguageCode()) && (availableVoice.quality == AVSpeechSynthesisVoiceQuality.enhanced)) {
//				voice = availableVoice
//			}
//		}
//
//		if let selectedVoice = voice {
//			print("The following voice identifier has been loaded: ",selectedVoice.identifier)
//		} else {
//			voice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode()) // load any of the voices that matches the current language selection for the device in case no enhanced voice has been found.
//		}

		// Line 1. Create an instance of AVSpeechSynthesizer.
		let speechSynthesizer = AVSpeechSynthesizer()
		// Line 2. Create an instance of AVSpeechUtterance and pass in a String to be spoken.
		let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
		//Line 3. Specify the speech utterance rate. 1 = speaking extremely the higher the values the slower speech patterns. The default rate, AVSpeechUtteranceDefaultSpeechRate is 0.5
		speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
		// Line 4. Specify the voice. It is explicitly set to English here, but it will use the device default if not specified.
		speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-ZA")
		// Line 5. Pass in the urrerance to the synthesizer to actually speak.
		speechSynthesizer.speak(speechUtterance)
	}

}

