//
//  DetailScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 25/02/2025.
//

import XCTest

class DetailScrumRobot: Robot {

    init() {
        XCTAssertTrue(meetingInfoTitle.waitForExistence(timeout: 5), "Expected 'Daily Scrum' screen, but it didn't appear")
    }

    //MARK: - Elements

    private var meetingInfoTitle: XCUIElement {
            app.staticTexts
                .matching(identifier: "MEETING INFO")
                .firstMatch
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
            .matching(identifier: "\(minutes) minutes")
            .firstMatch
    }

    private func detailLabel(_ text: String) -> XCUIElement {
        app.staticTexts
            .matching(identifier: text)
            .firstMatch
    }

    private var backButton: XCUIElement {
        Button.backToDailyScrums.element
    }


    @discardableResult
    func tapBackButton() -> ScrumListRobot {
        backButton.tap()
        return ScrumListRobot()
    }

    //MARK: - Validation
    @discardableResult
    func meetingTitleLabelExists(title: String) -> DetailScrumRobot {
        XCTAssertTrue(meetingTitleLabel(meetingName: title).exists)
        return self
    }

    @discardableResult
    func attendeeCountExists(attendeesCount: Int) -> DetailScrumRobot {
        XCTAssertTrue(attendeeCountLabel(count: attendeesCount).exists)
        return self
    }

    @discardableResult
    func meetingLengthLabel(minutes: Int) -> DetailScrumRobot {
        XCTAssertTrue(meetingLengthLabel(minutes: minutes).exists)
        return self
    }

    @discardableResult
    func colorLabelExists(color: String) -> DetailScrumRobot {
        XCTAssertTrue(detailLabel(color).exists)
        return self
    }

    @discardableResult
    func attendeeExists(name: String) -> DetailScrumRobot {
        XCTAssertTrue(detailLabel(name).exists)
        return self
    }

}
