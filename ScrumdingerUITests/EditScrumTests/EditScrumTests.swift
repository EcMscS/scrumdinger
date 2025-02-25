//
//  EditScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import XCTest

class EditScrumTests: XCTestCase {

    func testCancelAllChanges() {
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
            .colorLabelExists(color: "Orange")
            .tapEditButton()
            .inputTitleText(" Changed")
            .setLengthSlider(0.0)
            .tapSelectThemeButton()
            .tapNavyThemeButton()
            .addNewAttendee("Bob")
            .tapCancelButton()
            .colorLabelExists(color: "Orange")
            .tapBackButton()
            .attendeeCountExists(attendeesCount: 3)
            .meetingLengthLabel(minutes: 30)
    }


    func testEditTitle() {
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
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .inputTitleText(" Changed")
            .tapDoneButton()
            .tapBackButton()
            .meetingTitleLabelExists(title: "Design Meeting Changed")
    }

    func testEditLength() {
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
            .meetingLengthLabel(minutes: 30)
            .meetingTitleLabelExists(title: "Design Meeting")
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .setLengthSlider(0.0)
            .tapDoneButton()
            .tapBackButton()
            .meetingLengthLabel(minutes: 5)
    }

    func testAddAttendee() {
        AppRobot()
            .launchApp()
            .tapAppNewScrumButton()
            .inputTitleText("Design Meeting")
            .setLengthSlider(1.0)
            .tapSelectThemeButton()
            .tapOrangeThemeButton()
            .addNewAttendee("John")
            .tapCreateScrumButton()
            .attendeeCountExists(attendeesCount: 1)
            .tapScrumCard(withTitle: "Design Meeting")
            .tapEditButton()
            .addNewAttendee("Matt")
            .tapDoneButton()
            .tapBackButton()
            .attendeeCountExists(attendeesCount: 2)
    }
}
