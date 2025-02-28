//
//  DetailScrumTests.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import XCTest

class DetailScrumTests: XCTestCase {

    func testScrumDetailsInfo() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .verifyMeetingTitleExists(named: "Design Meeting")
            .verifyMeetingLengthExists(minutes: 30)
            .verifyMeetingThemeExists(named: "Orange")
            .verifyAttendeeExists(named: "John")
            .verifyAttendeeExists(named: "Alice")
            .verifyAttendeeExists(named: "Bob")
    }
}
