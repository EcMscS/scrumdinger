//
//  MeetingScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import XCTest

class MeetingScrumTests: XCTestCase {
    func testSkipSpeaker() {
        AppRobot()
            .launchAppWithNewScrum(attendees: ["John", "Alice"])
            .tapScrumCard(withTitle: "Design Meeting")
            .tapStartMeetingButton()
            .verifySpeakerExists(named: "John")
            .tapSkipButton()
            .verifySpeakerExists(named: "Alice")
    }

    func testEndMeetingEarly() {
        AppRobot()
            .launchAppWithNewScrum(attendees: ["John", "Alice"])
            .tapScrumCard(withTitle: "Design Meeting")
            .verifyMeetingHistoryExists(exists: false)
            .tapStartMeetingButton()
            .tapBackToScrum(named: "Design Meeting")
            .verifyMeetingHistoryExists(exists: true)
            .tapHistoricalMeeting()
            .verifySpeakersExists(named: "John and Alice")
            .verifyTranscriptExists()
    }
}
