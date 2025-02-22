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
    public var lengthInMinutes: Int
    public var theme: Theme
    public var history: [History]

    public init(
        id: UUID = UUID(),
        title: String,
        attendees: [String],
        lengthInMinutes: Int,
        theme: Theme,
        history: [History] = []
    ) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
        self.history = history
    }
}

extension DailyScrum: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(attendees)
        hasher.combine(lengthInMinutes)
        hasher.combine(theme)
        hasher.combine(history)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.attendees == rhs.attendees &&
        lhs.lengthInMinutes == rhs.lengthInMinutes &&
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

    struct Data {
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
        var history: [History] = []
    }

    var data: Data {
        Data(
            title: title,
            attendees: attendees,
            lengthInMinutes: Double(lengthInMinutes),
            theme: theme,
            history: history
        )
    }

    mutating func update(from data: Data) {
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
    }

    init(data: Data) {
        id = UUID()
        title = data.title
        attendees = data.attendees
        lengthInMinutes = Int(data.lengthInMinutes)
        theme = data.theme
        history = data.history
    }
}
