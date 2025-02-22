//
//  MeetingScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import XCTest

class MeetingScrumNavigationTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        app?.terminate() // Reset app state
        continueAfterFailure = false
        app = .init()
        app.launch()
        navigateToMeetingScreen()
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
        lengthSlider.adjust(toNormalizedSliderPosition: 0.5) // 15 minutes

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

    private func navigateToMeetingScreen() {
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

        let startMeetingButton = Button.startMeeting.element
        XCTAssertTrue(startMeetingButton.waitForExistence(timeout: 2))
        startMeetingButton.tap()
    }
}

final class MeetingScrumTests: MeetingScrumNavigationTests {
    func testSkipSpeaker() {
        // Initial speaker should be John
        let initialSpeaker = app.staticTexts["John"]
        XCTAssertTrue(
            initialSpeaker.exists,
            "Initial speaker should be John"
        )

        // Skip to next speaker
        let skipButton = Button.forward.element
        XCTAssertTrue(skipButton.exists)
        skipButton.tap()

        // Verify speaker changed to Bob
        let nextSpeaker = app.staticTexts["Bob"]
        XCTAssertTrue(
            nextSpeaker.exists,
            "Speaker should change to Bob after skip"
        )
    }

    func testEndMeetingEarly() {
        let backButton = app.buttons["Design Meeting"]
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        // Verify return to detail screen
        let startMeetingButton = Button.startMeeting.element
        XCTAssertTrue(
            startMeetingButton.exists,
            "Should return to detail screen"
        )

        // Get today's date formatted
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let todayString = dateFormatter.string(from: .now)

        // Verify today's meeting exists in history
        let todayMeeting = app.staticTexts[todayString].firstMatch
        XCTAssertTrue(
            todayMeeting.exists,
            "Today's meeting should appear in history"
        )

        // Tap on today's meeting
        todayMeeting.tap()

        // Verify meeting details
        let attendeesList = app.staticTexts["John and Bob"]
        XCTAssertTrue(
            attendeesList.exists,
            "Attendees should be listed correctly"
        )

        let transcript = app.staticTexts.matching(
            NSPredicate(format: "label CONTAINS[c] %@", "Transcript")
        ).firstMatch
        XCTAssertTrue(
            transcript.exists,
            "Transcript should be visible"
        )
    }
}
