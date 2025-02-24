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
            .launchApp()
            .tapAppNewScrumButton()
            .inputTitleText("Design Meeting")
            .setLengthSlider(1.0)
            .tapSelectThemeButton()
            .tapOrangeThemeButton()
            .addNewAttendee("John")
            .addNewAttendee("Alice")
            .addNewAttendee("Bob")
            .deleteAttendee("Alice")
            .tapCreateScrumButton()
            .meetingTitleLabelExists(title: "Design Meeting")
            .attendeeCountExists(attendeesCount: 2)
            .meetingLengthLabel(minutes: 30)
    }
}
