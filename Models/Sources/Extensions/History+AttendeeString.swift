//
//  History+AttendeeString.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import Foundation
import Models

extension History {
    public var attendeeString: String {
        ListFormatter.localizedString(
            byJoining: attendees.map(\.name)
        )
    }
}
