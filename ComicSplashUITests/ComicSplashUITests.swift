//
//  ComicSplashUITests.swift
//  ComicSplashUITests
//
//  Created by Marco Boerner on 16.07.21.
//

import XCTest

class ComicSplashUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClickForwardButton() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

		let comicView = app.otherElements["ComicView"]
		XCTAssert(comicView.waitForExistence(timeout: 0.5))

		let image = comicView.descendants(matching: .any).firstMatch
		XCTAssert(image.waitForExistence(timeout: 1))

		let button = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Triangle Arrow Right"]
		button.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
