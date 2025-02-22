//
//  DetailScrumTests.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import XCTest

class DetailScrumNavigationTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = .init()
        app.launch()
        navigateToDetailScreen()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    private func navigateToAddScreen() {
        XCTAssertTrue(
            Title.dailyScrums.element.exists,
            "Initial screen should be Daily Scrums"
        )

        // Tap the plus button to show add screen
        let plusButton = Button.plus.element
        XCTAssertTrue(plusButton.exists)
        plusButton.tap()
    }

    private func addScrum() {
        // Add a title
        let titleField = TextField.title.element
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText("Design Meeting")

        // Adjust length using slider
        let lengthSlider = Slider.length.element
        XCTAssertTrue(lengthSlider.waitForExistence(timeout: 2))
        lengthSlider.adjust(toNormalizedSliderPosition: 1.0)

        // Change theme
        let themeButton = Button.paintpalette.element
        XCTAssertTrue(themeButton.waitForExistence(timeout: 2))
        themeButton.tap()

        let orangeTheme = Button.orange.element
        XCTAssertTrue(orangeTheme.waitForExistence(timeout: 2))
        orangeTheme.tap()

        // Add attendees
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

        // Add the scrum
        let addButton = Button.add.element
        XCTAssertTrue(addButton.exists)
        addButton.tap()
    }

    private func navigateToDetailScreen() {
        let scrumCard = View.scrumCard.element

        if !scrumCard.exists {
            navigateToAddScreen()
            addScrum()
        }

        XCTAssertTrue(
            scrumCard.waitForExistence(timeout: 2),
            "Scrum card should exist"
        )

        scrumCard.tap()
    }
}

final class DetailScrumTests: DetailScrumNavigationTests {
    func testNavigateBack() {
        let backButton = Button.backToDailyScrums.element
        XCTAssertTrue(backButton.waitForExistence(timeout: 2))
        backButton.tap()

        XCTAssertTrue(
            Title.dailyScrums.element.exists,
            "Screen should be Daily Scrums"
        )
    }

    func testSubviews() {
        // Verify title
        let title = app.staticTexts["Design Meeting"]
        XCTAssertTrue(
            title.exists,
            "Title should match the created scrum"
        )

        // Verify meeting info
        let lengthLabel = app.staticTexts
            .matching(identifier: "30 minutes")
            .firstMatch
        XCTAssertTrue(
            lengthLabel.exists,
            "Meeting length should be 30 minutes"
        )

        let themeLabel = app.staticTexts["Orange"]
        XCTAssertTrue(
            themeLabel.exists,
            "Theme label should be orange"
        )

        // Verify individual attendees
        let johnLabel = app.staticTexts["John"]
        XCTAssertTrue(
            johnLabel.exists,
            "John should be in attendees list"
        )

        let bobLabel = app.staticTexts["Bob"]
        XCTAssertTrue(
            bobLabel.exists,
            "Bob should be in attendees list"
        )
    }
}
