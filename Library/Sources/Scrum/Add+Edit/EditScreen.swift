//
//  EditScreen.swift
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
struct EditScreen {
    private let scrum: DailyScrum
    @Environment(\.dismiss) private var dismiss
    @StoredData private var dailyScrums: [DailyScrum]
    @State private var title: String
    @State private var attendees: [DailyScrum.Attendee]
    @State private var lengthInMinutes: Double
    @State private var theme: Theme

    init(_ scrum: DailyScrum) {
        self.scrum = scrum
        _title = State(initialValue: scrum.title)
        _attendees = State(initialValue: scrum.attendees)
        _lengthInMinutes = State(initialValue: Double(scrum.lengthInMinutes))
        _theme = State(initialValue: scrum.theme)
    }

    private func cancelAction() {
        dismiss()
    }

    private func doneAction() {
        let updatedScrum = DailyScrum(
            id: scrum.id,
            title: title,
            attendees: attendees.map(\.name),
            lengthInMinutes: Int(lengthInMinutes),
            theme: theme
        )
        _dailyScrums.upsert(updatedScrum)
        dismiss()
    }
}

extension EditScreen: View {
    var body: some View {
        NavigationStack {
            Form {
                meetingInfoSection
                EditableAttendeesSection(attendees: $attendees)
            }
            .navigationTitle(scrum.title)
            .toolbar(content: toolbarContent)
        }
    }

    private var meetingInfoSection: some View {
        Section(.meetingInfo) {
            TitleTextField(title: $title)
            LengthSlider(lengthInMinutes: $lengthInMinutes)
            ThemePicker(selection: $theme)
        }
    }
}

extension EditScreen: ToolbarView {
    public func toolbarContent() -> some ToolbarContent {
        ToolbarButton(
            .cancel,
            placement: .cancellationAction,
            perform: cancelAction
        )

        ToolbarButton(.done, perform: doneAction)
    }
}
