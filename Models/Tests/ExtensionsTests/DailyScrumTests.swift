//
//  DailyScrumTests.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation
import Testing

@testable import Extensions
@testable import Models

struct DailyScrumTests {
    @Test func secondsPerSpeakerWithZeroAttendees() async throws {
        let scrum = DailyScrum(
            title: "Test",
            attendees: [],
            length: .minutes(10),
            theme: .seafoam
        )
        #expect(scrum.secondsPerSpeaker.isInfinite)
    }

    @Test func secondsPerSpeakerWithOneAttendee() async throws {
        let scrum = DailyScrum(
            title: "Test",
            attendees: ["John"],
            length: .minutes(10),
            theme: .seafoam
        )
        #expect(scrum.secondsPerSpeaker == .minutes(10))
    }

    @Test func secondsPerSpeakerWithMultipleAttendees() async throws {
        let scrum = DailyScrum(
            title: "Test",
            attendees: ["John", "Jane", "Bob"],
            length: .minutes(15),
            theme: .seafoam
        )
        #expect(scrum.secondsPerSpeaker == .minutes(5))
    }
}
