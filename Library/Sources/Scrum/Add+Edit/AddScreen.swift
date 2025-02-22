//
//  AddScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Enumerations
import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct AddScreen {
    @Environment(\.dismiss) private var dismiss
    @StoredData private var dailyScrums: [DailyScrum]
    @State private var title: String = ""
    @State private var attendees: [DailyScrum.Attendee] = []
    @State private var lengthInMinutes: Double = 5
    @State private var theme: Theme = .seafoam

    private func dismissAction() {
        dismiss()
    }

    private func addAction() {
        let newScrum: DailyScrum = .init(
            title: title,
            attendees: attendees.map(\.name),
            lengthInMinutes: Int(lengthInMinutes),
            theme: theme
        )
        _dailyScrums.upsert(newScrum)
        dismiss()
    }
}

extension AddScreen: View {
    var body: some View {
        NavigationStack {
            Form {
                EditableMeetingInfoSection(
                    title: $title,
                    lengthInMinutes: $lengthInMinutes,
                    theme: $theme
                )

                EditableAttendeesSection(
                    attendees: $attendees
                )
            }
            .navigationTitle(.empty)
            .toolbar(content: toolbarContent)
        }
    }
}

extension AddScreen: ToolbarView {
    public func toolbarContent() -> some ToolbarContent {
        ToolbarButton(
            .dismiss,
            placement: .cancellationAction,
            perform: dismissAction
        )

        ToolbarButton(.add, perform: addAction)
    }
}
