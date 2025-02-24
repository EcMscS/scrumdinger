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
            .isOnScrumListView()
            .tapAppNewScrumButton()
            .tapDismissScrumButton()
            .isOnScrumListView()
    }

    func testAddEmptyScrum() {
        AppRobot()
            .launchApp()
            .isOnScrumListView()
            .tapAppNewScrumButton()
            .tapCreateScrumButton()
            .isOnScrumListView()
            .attendeeCountExists(attendeesCount: 0)
            .meetingLengthLabel(minutes: 5)
    }


//    func testAddScrum() {
//        // Add a title
//        let titleField = TextField.title.element
//        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
//        titleField.tap()
//        titleField.typeText("Design Meeting")
//
//        // Adjust length using slider
//        let lengthSlider = Slider.length.element
//        XCTAssertTrue(lengthSlider.waitForExistence(timeout: 2))
//        lengthSlider.adjust(toNormalizedSliderPosition: 1.0)
//
//        // Change theme
//        let themeButton = Button.paintpalette.element
//        XCTAssertTrue(themeButton.waitForExistence(timeout: 2))
//        themeButton.tap()
//
//        let orangeTheme = Button.orange.element
//        XCTAssertTrue(orangeTheme.waitForExistence(timeout: 2))
//        orangeTheme.tap()
//
//        // Add attendees
//        let attendeeField = TextField.newAttendee.element
//        XCTAssertTrue(attendeeField.waitForExistence(timeout: 2))
//
//        let attendees = ["John", "Alice", "Bob"]
//        for attendee in attendees {
//            attendeeField.tap()
//            attendeeField.typeText(attendee)
//
//            let addAttendeeButton = Button.addAttendee.element
//            XCTAssertTrue(addAttendeeButton.waitForExistence(timeout: 2))
//            addAttendeeButton.tap()
//        }
//
//        // Delete an attendee by swiping
//        let aliceCell = app.staticTexts["Alice"]
//        XCTAssertTrue(aliceCell.waitForExistence(timeout: 2))
//        aliceCell.swipeLeft()
//
//        let deleteButton = Button.delete.element
//        XCTAssertTrue(deleteButton.waitForExistence(timeout: 2))
//        deleteButton.tap()
//
//        // Add the scrum
//        let addButton = Button.add.element
//        XCTAssertTrue(addButton.exists)
//        addButton.tap()
//
//        // Verify the new scrum
//        let scrumTitle = app.staticTexts["Design Meeting"]
//        XCTAssertTrue(scrumTitle.waitForExistence(timeout: 2))
//
//        let attendeeCount = app.staticTexts["2 attendees"]
//        XCTAssertTrue(attendeeCount.exists)
//
//        // Verify meeting length using accessibility label
//        let meetingLengthLabel = app.staticTexts
//            .matching(identifier: "30 minute meeting")
//            .firstMatch
//
//        XCTAssertTrue(
//            meetingLengthLabel.exists,
//            "Meeting length should be 30 minutes"
//        )
//    }
}
