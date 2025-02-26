//
//  DetailScrumTests.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import XCTest

class DetailScrumTests: XCTestCase {

    func testNavigateBack() {
        AppRobot()
            .launchAppWithNewScrum()
    }

    func testScrumDetailsInfo() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .meetingTitleLabelExists(title: "Design Meeting")
            .meetingLengthLabel(minutes: 30)
            .colorLabelExists(color: "Orange")
            .attendeeExists(name: "John")
            .attendeeExists(name: "Alice")
            .attendeeExists(name: "Bob")
    }
}
