//
//  EditScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import XCTest

class EditScrumTests: XCTestCase {

    func testCancelAllChanges() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .verifyMeetingThemeExists(named: "Orange")
            .tapEditButton()
            .inputScrumTitle(" Changed")
            .setDurationSlider(0.0)
            .tapThemeSelectionButton()
            .tapThemeNavyButton()
            .addAttendees(["Bob"])
            .tapCancelButton()
            .verifyMeetingThemeExists(named: "Orange")
            .tapBackButton()
            .verifyAttendeeCountExists(count: 3)
            .verifyMeetingLengthExists(minutes: 30)
    }


    func testEditTitle() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .inputScrumTitle(" Changed")
            .tapDoneButton()
            .tapBackButton()
            .verifyScrumTitleExists(named: "Design Meeting Changed")
    }

    func testEditLength() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .setDurationSlider(0.0)
            .tapDoneButton()
            .tapBackButton()
            .verifyMeetingLengthExists(minutes: 5)
    }

    func testAddAttendee() {
        AppRobot()
            .launchAppWithNewScrum(attendees: ["John"])
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .addAttendees(["Matt"])
            .tapDoneButton()
            .tapBackButton()
            .verifyAttendeeCountExists(count: 2)
    }
}
