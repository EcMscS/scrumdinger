//
//  History.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Foundation

public struct History: Identifiable, Hashable, Codable {
    public let id: UUID
    public let date: Date
    public var attendees: [DailyScrum.Attendee]
    public var lengthInMinutes: Int
    public var transcript: String?

    public init(
        id: UUID = .init(),
        date: Date = .now,
        attendees: [DailyScrum.Attendee],
        lengthInMinutes: Int = 5,
        transcript: String? = nil
    ) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}

public extension History {
    static func mock() -> History {
        .init(
            attendees: [
                .init(name: "Jon"),
                .init(name: "Darla"),
            ],
            lengthInMinutes: 10,
            transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI..."
        )
    }
}
