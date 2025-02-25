//
//  MeetingScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import XCTest

class MeetingScrumTests: XCTestCase {

    func testSkipSpeaker() {
        AppRobot()
            .launchApp()
            .tapAppNewScrumButton()
            .inputTitleText("Design Meeting")
            .setLengthSlider(1.0)
            .tapSelectThemeButton()
            .tapOrangeThemeButton()
            .addNewAttendee("John")
            .addNewAttendee("Alice")
            .tapCreateScrumButton()
            .tapScrumCard(withTitle: "Design Meeting")
            .tapStartMeetingButton()
            .speakerTextExists(speakerName: "John")
            .tapSkip()
            .speakerTextExists(speakerName: "Alice")
    }

    func testEndMeetingEarly() {
        AppRobot()
            .launchApp()
            .tapAppNewScrumButton()
            .inputTitleText("Design Meeting")
            .setLengthSlider(1.0)
            .tapSelectThemeButton()
            .tapOrangeThemeButton()
            .addNewAttendee("John")
            .addNewAttendee("Alice")
            .tapCreateScrumButton()
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
