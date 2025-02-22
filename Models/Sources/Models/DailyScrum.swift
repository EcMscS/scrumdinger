//
//  DailyScrum.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Enumerations
import Foundation

public struct DailyScrum: Identifiable, Codable {
    public let id: UUID
    public var title: String
    public var attendees: [Attendee]
    public var length: TimeInterval
    public var theme: Theme
    public var history: [History]

    public init(
        id: UUID = UUID(),
        title: String,
        attendees: [String],
        length: TimeInterval,
        theme: Theme,
        history: [History] = []
    ) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.length = length
        self.theme = theme
        self.history = history
    }
}

extension DailyScrum: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(attendees)
        hasher.combine(length)
        hasher.combine(theme)
        hasher.combine(history)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.attendees == rhs.attendees &&
        lhs.length == rhs.length &&
        lhs.theme == rhs.theme &&
        lhs.history == rhs.history
    }
}

extension DailyScrum {
    public struct Attendee: Identifiable, Hashable, Codable {
        public let id: UUID
        public var name: String

        public init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}
