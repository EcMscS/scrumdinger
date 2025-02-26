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
            .tapAppNewScrumButton()
            .tapDismissScrumButton()
    }

    func testAddEmptyScrum() {
        AppRobot()
            .launchApp()
            .tapAppNewScrumButton()
            .tapCreateScrumButton()
            .attendeeCountExists(attendeesCount: 0)
            .meetingLengthLabel(minutes: 5)
    }

    func testAddScrum() {
        AppRobot()
            .launchAppWithNewScrum()
    }
}
