//
//  MeetingScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 25/02/2025.
//

import XCTest

class MeetingScrumRobot: Robot {

    init() {
        XCTAssertTrue(
          secondsElapsedLabel.waitForExistence(timeout: 5),
          "Expected 'Meeting Scrum' screen, but it didn't appear"
        )
    }

    // MARK: - Elements

    private func speakerLabel(named name: String) -> XCUIElement {
        app.staticTexts[name]
    }

    private var skipButton: XCUIElement {
        Button.forward.element
    }

    private var secondsElapsedLabel: XCUIElement {
        app.staticTexts["Seconds Elapsed"]
    }

    private func backToScrumButton(named meetingName: String) -> XCUIElement {
        app.buttons[meetingName]
    }

    // MARK: - Validations

    @discardableResult
    func verifySpeakerExists(named name: String) -> Self {
        XCTAssertTrue(speakerLabel(named: name).exists)
        return self
    }

    // MARK: - Interactions

    @discardableResult
    func tapSkipButton() -> Self {
        skipButton.tap()
        return self
    }

    @discardableResult
    func tapBackToScrum(named meetingName: String) -> DetailScrumRobot {
        backToScrumButton(named: meetingName).tap()
        return DetailScrumRobot()
    }
}
