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
            .colorLabelExists(color: "Orange")
            .tapEditButton()
            .inputTitleText(" Changed")
            .setLengthSlider(0.0)
            .tapSelectThemeButton()
            .tapNavyThemeButton()
            .addNewAttendees(["Bob"])
            .tapCancelButton()
            .colorLabelExists(color: "Orange")
            .tapBackButton()
            .attendeeCountExists(attendeesCount: 3)
            .meetingLengthLabel(minutes: 30)
    }


    func testEditTitle() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .inputTitleText(" Changed")
            .tapDoneButton()
            .tapBackButton()
            .meetingTitleLabelExists(title: "Design Meeting Changed")
    }

    func testEditLength() {
        AppRobot()
            .launchAppWithNewScrum()
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .setLengthSlider(0.0)
            .tapDoneButton()
            .tapBackButton()
            .meetingLengthLabel(minutes: 5)
    }

    func testAddAttendee() {
        AppRobot()
            .launchAppWithNewScrum(attendees: ["John"])
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .addNewAttendees(["Matt"])
            .tapDoneButton()
            .tapBackButton()
            .attendeeCountExists(attendeesCount: 2)
    }
}
