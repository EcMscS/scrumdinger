//
//  LocalizedStringKey+Constants.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import SwiftUI

@MainActor
extension LocalizedStringKey {
    // MARK: - A
    public static let add = LocalizedStringKey("Add")
    public static let addAttendee = LocalizedStringKey("Add Attendee")
    public static let attendees = LocalizedStringKey("Attendees")

    // MARK: - C
    public static let cancel = LocalizedStringKey("Cancel")

    // MARK: - D
    public static let dailyScrums = LocalizedStringKey("Daily Scrums")
    public static let dismiss = LocalizedStringKey("Dismiss")
    public static let done = LocalizedStringKey("Done")

    // MARK: - E
    public static let edit = LocalizedStringKey("Edit")
    public static let empty = LocalizedStringKey("")

    // MARK: - H
    public static let history = LocalizedStringKey("History")

    // MARK: - I
    public static let isSpeaking = LocalizedStringKey("is speaking")

    // MARK: - L
    public static let lastSpeaker = LocalizedStringKey("Last Speaker")
    public static let length = LocalizedStringKey("Length")

    // MARK: - M
    public static let meetingInfo = LocalizedStringKey("Meeting Info")

    // MARK: - N
    public static let newAttendee = LocalizedStringKey("New Attendee")
    public static let nextSpeaker = LocalizedStringKey("Next speaker")
    public static let noMeetingsYet = LocalizedStringKey("No meetings yet")
    public static let noSpeakers = LocalizedStringKey("No more speakers")

    // MARK: O
    // swiftlint:disable:next identifier_name
    public static let ok = LocalizedStringKey("OK")

    // MARK: - S
    public static let secondsElapsed = LocalizedStringKey("Seconds Elapsed")
    public static let secondsRemaining = LocalizedStringKey("Seconds Remaining")
    public static let someone = LocalizedStringKey("Someone")
    public static let startMeeting = LocalizedStringKey("Start Meeting")

    // MARK: - T
    public static let theme = LocalizedStringKey("Theme")
    public static let timeRemaining = LocalizedStringKey("Time remaining")
    public static let title = LocalizedStringKey("Title")
    public static let transcript = LocalizedStringKey("Transcript")

    // MARK: - W
    public static let withTranscription = LocalizedStringKey("with transcription")
    public static let withoutTranscription = LocalizedStringKey("without transcription")

    // MARK: - Functions
    public static func attendeeCount(_ count: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(count) attendees")
    }

    public static func meetingLength(_ minutes: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(minutes) minute meeting")
    }

    public static func minutes(_ count: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(count) \(count == 1 ? "minute" : "minutes")")
    }

    public static func speakerCount(_ current: Int, _ total: Int) -> LocalizedStringKey {
        LocalizedStringKey("Speaker \(current) of \(total)")
    }

    public static func timeRemaining(minutes: Int) -> LocalizedStringKey {
        LocalizedStringKey("\(minutes) minutes")
    }
}
