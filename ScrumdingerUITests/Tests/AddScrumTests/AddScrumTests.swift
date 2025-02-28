//
//  AddScrumTests.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import XCTest

class AddScrumTests: XCTestCase {

    func testDismissAddScrum() {
        AppRobot()
            .launchApp()
            .tapAddScrumButton()
            .tapDismissScrumButton()
    }

    func testAddEmptyScrum() {
        AppRobot()
            .launchApp()
            .tapAddScrumButton()
            .tapCreateScrumButton()
            .verifyAttendeeCountExists(count: 0)
            .verifyMeetingLengthExists(minutes: 5)
    }

    func testAddScrum() {
        AppRobot()
            .launchAppWithNewScrum()
    }
}
