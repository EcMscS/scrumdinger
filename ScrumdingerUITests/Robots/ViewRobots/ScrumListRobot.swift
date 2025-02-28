//
//  ScrumListRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import XCTest

class ScrumListRobot: Robot {

    init() {
        XCTAssertTrue(titleLabel.waitForExistence(timeout: 5), "Expected 'ScrumListRobot' screen, but it didn't appear")
    }

    // MARK: - Elements

    private var addScrumButton: XCUIElement {
        Button.plus.element
    }

    private var titleLabel: XCUIElement {
        Title.dailyScrums.element
    }

    private func scrumCard(withTitle title: String) -> XCUIElement {
        View.scrumCard(withTitle: title)
    }

    private func scrumTitleLabel(named title: String) -> XCUIElement {
        app.staticTexts[title]
    }

    private func attendeeCountLabel(for count: Int) -> XCUIElement {
        app.staticTexts
            .matching(identifier: "\(count) attendees")
            .firstMatch
    }

    private func meetingLengthLabel(for minutes: Int) -> XCUIElement {
        app.staticTexts
            .matching(identifier: "\(minutes) minute meeting")
            .firstMatch
    }

    // MARK: - Validations

    @discardableResult
    func verifyScrumTitleExists(named title: String) -> Self {
        XCTAssertTrue(scrumTitleLabel(named: title).exists)
        return self
    }

    @discardableResult
    func verifyAttendeeCountExists(count: Int) -> Self {
        XCTAssertTrue(attendeeCountLabel(for: count).exists)
        return self
    }

    @discardableResult
    func verifyMeetingLengthExists(minutes: Int) -> Self {
        XCTAssertTrue(meetingLengthLabel(for: minutes).exists)
        return self
    }

    // MARK: - Interactions

    @discardableResult
    func tapAddScrumButton() -> AddScrumRobot {
        addScrumButton.tap()
        return AddScrumRobot()
    }

    @discardableResult
    func tapScrumCard(withTitle title: String) -> DetailScrumRobot {
        scrumCard(withTitle: title).tap()
        return DetailScrumRobot()
    }
}
