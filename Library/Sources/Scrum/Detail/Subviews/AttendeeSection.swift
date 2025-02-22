//
//  AttendeeSection.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Models
import SwiftUI

@MainActor
struct AttendeeSection: View {
    let attendees: [DailyScrum.Attendee]

    var body: some View {
        Section(.attendees) {
            ForEach(attendees) { attendee in
                Label(attendee.name, symbol: .person)
                    .accessibilityIdentifier(attendee.name)
            }
        }
    }
}
