//
//  History+AttendeeString.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import Foundation
import Models

extension History {
    /// A formatted string containing all attendee names separated by commas and "and"
    ///
    /// Example: "John, Jane, and Bob"
    public var attendeeString: String {
        ListFormatter.localizedString(
            byJoining: attendees.map(\.name)
        )
    }
}
