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

    // MARK: - Elements

    private var meetingInfoTitle: XCUIElement {
        app.staticTexts["MEETING INFO"]
    }

    private func meetingTitleLabel(named title: String) -> XCUIElement {
        app.staticTexts[title]
    }

    private func meetingThemeLabel(named theme: String) -> XCUIElement {
        app.staticTexts[theme]
    }

    private func attendeeCountLabel(for count: Int) -> XCUIElement {
        app.staticTexts["\(count) attendees"]
    }

    private func meetingLengthLabel(for minutes: Int) -> XCUIElement {
        app.staticTexts["\(minutes) minutes"]
    }

    private func detailLabel(text: String) -> XCUIElement {
        app.staticTexts[text]
    }

    private func meetingHistoryRow(for date: String) -> XCUIElement {
        app.staticTexts[date].firstMatch
    }

    private var backButton: XCUIElement {
        Button.backToDailyScrums.element
    }

    private var editButton: XCUIElement {
        Button.edit.element
    }

    private var startMeetingButton: XCUIElement {
        Button.startMeeting.element
    }

    // MARK: - Interactions

    @discardableResult
    func tapBackButton() -> ScrumListRobot {
        backButton.tap()
        return ScrumListRobot()
    }

    @discardableResult
    func tapEditButton() -> AddScrumRobot {
        editButton.tap()
        return AddScrumRobot()
    }

    @discardableResult
    func tapStartMeetingButton() -> MeetingScrumRobot {
        startMeetingButton.tap()
        return MeetingScrumRobot()
    }

    @discardableResult
    func tapHistoricalMeeting() -> HistoricalMeetingRobot {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let todaysDate = dateFormatter.string(from: .now)

        meetingHistoryRow(for: todaysDate).tap()
        return HistoricalMeetingRobot()
    }

    // MARK: - Validations

    @discardableResult
    func verifyMeetingTitleExists(named title: String) -> Self {
        XCTAssertTrue(meetingTitleLabel(named: title).exists)
        return self
    }

    @discardableResult
    func verifyMeetingThemeExists(named theme: String) -> Self {
        XCTAssertTrue(meetingThemeLabel(named: theme).exists)
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

    @discardableResult
    func verifyDetailLabelExists(text: String) -> Self {
        XCTAssertTrue(detailLabel(text: text).exists)
        return self
    }

    @discardableResult
    func verifyAttendeeExists(named name: String) -> Self {
        XCTAssertTrue(detailLabel(text: name).exists)
        return self
    }

    @discardableResult
    func verifyMeetingHistoryExists(exists: Bool) -> Self {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let todaysDate = dateFormatter.string(from: .now)

        let historyRow = meetingHistoryRow(for: todaysDate)

        if exists {
            XCTAssertTrue(historyRow.waitForExistence(timeout: 2), "Expected meeting history row to exist but it doesn't.")
        } else {
            XCTAssertFalse(historyRow.waitForExistence(timeout: 2), "Expected meeting history row to be absent but it exists.")
        }

        return self
    }
}
