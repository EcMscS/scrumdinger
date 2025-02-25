//
//  MeetingScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 25/02/2025.
//

import XCTest

class MeetingScrumRobot: Robot {

    init() {
        XCTAssertTrue(secondsElapsed.waitForExistence(timeout: 5), "Expected 'Meeting Scrum' screen, but it didn't appear")
    }

    //MARK: - Elements

    private func speakerText(name: String) -> XCUIElement {
        app.staticTexts[name]
    }

    private var skipButton: XCUIElement {
        Button.forward.element
    }

    private var secondsElapsed: XCUIElement {
        app.staticTexts
            .matching(identifier: "Seconds Elapsed")
            .firstMatch
    }

    private func backToScrumMeeting(meetingName: String) -> XCUIElement {
        app.buttons
            .matching(identifier: meetingName)
            .firstMatch
    }

    //MARK: - Validation
    @discardableResult
    func speakerTextExists(speakerName name: String) -> MeetingScrumRobot {
        XCTAssertTrue(speakerText(name: name).exists)
        return self
    }
    
    //MARK: - Interaction
    @discardableResult
    func tapSkip() -> MeetingScrumRobot {
        skipButton.tap()
        return self
    }

    @discardableResult
    func tapBackToMeeting(meetingName: String) -> DetailScrumRobot {
        backToScrumMeeting(meetingName: meetingName).tap()
        return DetailScrumRobot()
    }

}
