//
//  EditScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import XCTest

class EditScrumNavigationTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app?.terminate() // Reset app state
        continueAfterFailure = false
        app = .init()
        app.launch()
        navigateToEditScreen()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    private func navigateToAddScreen() {
        XCTAssertTrue(
            Title.dailyScrums.element.exists,
            "Initial screen should be Daily Scrums"
        )

        let plusButton = Button.plus.element
        XCTAssertTrue(plusButton.exists)
        plusButton.tap()
    }

    private func addScrum() {
        let titleField = TextField.title.element
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText("Design Meeting")

        let lengthSlider = Slider.length.element
        XCTAssertTrue(lengthSlider.waitForExistence(timeout: 2))
        lengthSlider.adjust(toNormalizedSliderPosition: 1.0)

        let themeButton = Button.paintpalette.element
        XCTAssertTrue(themeButton.waitForExistence(timeout: 2))
        themeButton.tap()

        let orangeTheme = Button.orange.element
        XCTAssertTrue(orangeTheme.waitForExistence(timeout: 2))
        orangeTheme.tap()

        let attendeeField = TextField.newAttendee.element
        XCTAssertTrue(attendeeField.waitForExistence(timeout: 2))

        let attendees = ["John", "Bob"]
        for attendee in attendees {
            attendeeField.tap()
            attendeeField.typeText(attendee)

            let addAttendeeButton = Button.addAttendee.element
            XCTAssertTrue(addAttendeeButton.waitForExistence(timeout: 2))
            addAttendeeButton.tap()
        }

        let addButton = Button.add.element
        XCTAssertTrue(addButton.exists)
        addButton.tap()
    }

    private func navigateToEditScreen() {
        let scrumCard = View.scrumCard(withTitle: "Design Meeting")

        if !scrumCard.exists {
            navigateToAddScreen()
            addScrum()
        }

        XCTAssertTrue(
            scrumCard.waitForExistence(timeout: 2),
            "Scrum card should exist"
        )

        scrumCard.tap()

        let editButton = Button.edit.element
        XCTAssertTrue(editButton.waitForExistence(timeout: 2))
        editButton.tap()
    }
}

final class EditScrumTests: EditScrumNavigationTests {
    func testCancelAllChanges() {
        // Change title
        let titleField = TextField.title.element
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText(" Changed")

        // Change length
        let lengthSlider = Slider.length.element
        XCTAssertTrue(lengthSlider.waitForExistence(timeout: 2))
        lengthSlider.adjust(toNormalizedSliderPosition: 0.0)

        // Change theme
        let themeButton = Button.paintpalette.element
        XCTAssertTrue(themeButton.waitForExistence(timeout: 2))
        themeButton.tap()

        let navyTheme = Button.oxblood.element
        XCTAssertTrue(navyTheme.waitForExistence(timeout: 2))
        navyTheme.tap()

        // Add new attendee
        let attendeeField = TextField.newAttendee.element
        XCTAssertTrue(attendeeField.waitForExistence(timeout: 2))
        attendeeField.tap()
        attendeeField.typeText("Bruce")

        let addAttendeeButton = Button.addAttendee.element
        XCTAssertTrue(addAttendeeButton.waitForExistence(timeout: 2))
        addAttendeeButton.tap()

        // Press cancel
        let cancelButton = Button.cancel.element
        XCTAssertTrue(cancelButton.exists)
        cancelButton.tap()

        // Verify original title remains
        let originalTitle = app.staticTexts["Design Meeting"]
        XCTAssertTrue(
            originalTitle.exists,
            "Title should remain unchanged"
        )

        // Verify original length
        let originalLength = app.staticTexts
            .matching(identifier: "30 minutes")
            .firstMatch
        XCTAssertTrue(
            originalLength.exists,
            "Meeting length should remain 30 minutes"
        )

        // Verify original theme
        let originalTheme = app.staticTexts["Orange"]
        XCTAssertTrue(
            originalTheme.exists,
            "Theme should remain orange"
        )

        // Verify new attendee was not added
        let bruceLabel = app.staticTexts["Bruce"]
        XCTAssertFalse(
            bruceLabel.exists,
            "New attendee should not be visible"
        )
    }

    func testEditTitle() {
        let titleField = TextField.title.element
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText(" Updated")

        let doneButton = Button.done.element
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()

        // Verify updated title in detail screen
        let updatedTitle = app.staticTexts["Design Meeting Updated"]
        XCTAssertTrue(
            updatedTitle.exists,
            "Title should be updated in detail screen"
        )

        // Navigate back to daily scrums
        let backButton = Button.backToDailyScrums.element
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        // Verify updated title in scrum card
        let updatedScrumCard = View.scrumCard(withTitle: "Design Meeting Updated")
        XCTAssertTrue(
            updatedScrumCard.exists,
            "Updated title should appear in scrum card"
        )
    }

    func testEditLength() {
        let lengthSlider = Slider.length.element
        XCTAssertTrue(lengthSlider.waitForExistence(timeout: 2))
        lengthSlider.adjust(toNormalizedSliderPosition: 0)

        let doneButton = Button.done.element
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()

        // Verify updated length in detail screen
        let lengthLabel = app.staticTexts
            .matching(identifier: "5 minutes")
            .firstMatch
        XCTAssertTrue(
            lengthLabel.exists,
            "Meeting length should be 5 minutes in detail screen"
        )

        // Navigate back to daily scrums
        let backButton = Button.backToDailyScrums.element
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        // Verify updated length in scrum card
        let updatedLengthLabel = app.staticTexts
            .matching(identifier: "5 minute meeting")
            .firstMatch
        XCTAssertTrue(
            updatedLengthLabel.exists,
            "Updated length should appear in scrum card"
        )
    }

    func testAddAttendee() {
        let attendeeField = TextField.newAttendee.element
        XCTAssertTrue(attendeeField.waitForExistence(timeout: 2))
        attendeeField.tap()
        attendeeField.typeText("Alice")

        let addAttendeeButton = Button.addAttendee.element
        XCTAssertTrue(addAttendeeButton.waitForExistence(timeout: 2))
        addAttendeeButton.tap()

        let doneButton = Button.done.element
        XCTAssertTrue(doneButton.exists)
        doneButton.tap()

        // Verify new attendee in detail screen
        let aliceLabel = app.staticTexts["Alice"]
        XCTAssertTrue(
            aliceLabel.exists,
            "New attendee should be visible in detail screen"
        )

        // Navigate back to daily scrums
        let backButton = Button.backToDailyScrums.element
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        // Verify updated attendee count in scrum card
        let updatedAttendeeCount = app.staticTexts["3 attendees"]
        XCTAssertTrue(
            updatedAttendeeCount.exists,
            "Updated attendee count should appear in scrum card"
        )
    }
}
