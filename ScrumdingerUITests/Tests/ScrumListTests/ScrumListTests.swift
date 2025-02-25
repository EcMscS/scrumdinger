//
//  ScrumListTests.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import XCTest

class ScrumListTests: XCTestCase {
    func testAppLaunchedInAddScrumScreen() {
        AppRobot()
            .launchApp()
    }

    override func tearDownWithError() throws {
        AppRobot()
            .terminateApp()
    }
}
