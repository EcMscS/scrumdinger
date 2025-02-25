//
//  DetailScrumTests.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import XCTest

class DetailScrumTests: XCTestCase {

    func testNavigateBack() {
        AppRobot()
            .launchApp()
            .tapAppNewScrumButton()
            .inputTitleText("Design Meeting")
            .tapCreateScrumButton()
            .tapScrumCard(withTitle: "Design Meeting")
            .tapBackButton()
    }

    func testScrumDetailsInfo() {
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
            .tapCreateScrumButton()
            .meetingTitleLabelExists(title: "Design Meeting")
            .attendeeCountExists(attendeesCount: 3)
            .meetingLengthLabel(minutes: 30)
            .tapScrumCard(withTitle: "Design Meeting")
            .meetingTitleLabelExists(title: "Design Meeting")
            .meetingLengthLabel(minutes: 30)
            .colorLabelExists(color: "Orange")
            .attendeeExists(name: "John")
            .attendeeExists(name: "Alice")
            .attendeeExists(name: "Bob")
    }
}
