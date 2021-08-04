//
//  Workflow_speak.swift
//  ComicSplash
//
//  Created by Marco Boerner on 20.07.21.
//

import Foundation

extension Workflows {

	func startSpeaking(_ transcript: String) {
		TextToSpeechModel.speak(transcript)
	}
}
