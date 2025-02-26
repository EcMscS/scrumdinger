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
            .speakerTextExists(speakerName: "John")
            .tapSkip()
            .speakerTextExists(speakerName: "Alice")
    }

    func testEndMeetingEarly() {
        AppRobot()
            .launchAppWithNewScrum(attendees: ["John", "Alice"])
            .tapScrumCard(withTitle: "Design Meeting")
            .meetingHistoryExists(exists: false)
            .tapStartMeetingButton()
            .tapBackToMeeting(meetingName: "Design Meeting")
            .meetingHistoryExists(exists: true)
            .tapHistoricalMeeting()
            .speakerTextExists(text: "John and Alice")
            .transcriptTextExists()
    }
}
