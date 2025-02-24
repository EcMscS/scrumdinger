//
//  ScrumListRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import XCTest

class ScrumListRobot: Robot {

    init() {
        XCTAssertTrue(titleText.waitForExistence(timeout: 5), "Expected 'ScrumListRobot' screen, but it didn't appear")
    }

    //MARK: - Elements
    private var addScrumButton: XCUIElement {
        Button.plus.element
    }

    private var titleText: XCUIElement {
        Title.dailyScrums.element
    }

    private func meetingTitleLabel(meetingName: String) -> XCUIElement {
        app.staticTexts[meetingName]
    }

    private func attendeeCountLabel(count: Int) -> XCUIElement {
        app.staticTexts
            .matching(identifier: "\(count) attendees")
            .firstMatch
    }

    private func meetingLengthLabel(minutes: Int) -> XCUIElement {
            app.staticTexts
                .matching(identifier: "\(minutes) minute meeting")
                .firstMatch
    }

    //MARK: - Validation
    @discardableResult
    func meetingTitleLabelExists(title: String) -> ScrumListRobot {
        XCTAssertTrue(meetingTitleLabel(meetingName: title).exists)
        return self
    }

    @discardableResult
    func attendeeCountExists(attendeesCount: Int) -> ScrumListRobot {
        XCTAssertTrue(attendeeCountLabel(count: attendeesCount).exists)
        return self
    }

    @discardableResult
    func meetingLengthLabel(minutes: Int) -> ScrumListRobot {
        XCTAssertTrue(meetingLengthLabel(minutes: minutes).exists)
        return self
    }

    //MARK: - Interaction
    @discardableResult
    func tapAppNewScrumButton() -> AddScrumRobot {
        addScrumButton.tap()
        return AddScrumRobot()
    }

}
