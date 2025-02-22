//
//  AttendeesSection.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Models
import SwiftUI

@MainActor
struct EditableAttendeesSection {
    @Binding private var attendees: [DailyScrum.Attendee]
    @State private var newAttendeeName: String = ""

    private var addAttendeeButtonDisabled: Bool {
        newAttendeeName.isEmpty
    }

    init(attendees: Binding<[DailyScrum.Attendee]>) {
        self._attendees = attendees
    }

    private func addAttendee() {
        withAnimation {
            let attendee = DailyScrum.Attendee(name: newAttendeeName)
            attendees.append(attendee)
            newAttendeeName = ""
        }
    }

    private func onDeleteAction(_ indices: IndexSet) {
        attendees.remove(atOffsets: indices)
    }
}

extension EditableAttendeesSection: View {
    var body: some View {
        Section(.attendees) {
            ForEach(attendees) { attendee in
                Text(attendee.name)
            }
            .onDelete(perform: onDeleteAction)

            newAttendeeRow
        }
    }

    private var newAttendeeRow: some View {
        HStack {
            TextField(.newAttendee, text: $newAttendeeName)

            Button(.addAttendee, symbol: .plus, action: addAttendee)
                .labelStyle(.iconOnly)
                .symbolVariant(.circle.fill)
                .imageScale(.medium)
                .disabled(addAttendeeButtonDisabled)
        }
    }
}
