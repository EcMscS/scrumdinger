//
//  EditScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Enumerations
import FileService
import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct EditScreen {
    private let scrum: DailyScrum
    @Environment(\.dismiss) private var dismiss
    @Environment(\.fileService) private var fileService
    @StoredData private var dailyScrums: [DailyScrum]
    @State private var title: String
    @State private var attendees: [DailyScrum.Attendee]
    @State private var length: TimeInterval
    @State private var theme: Theme
    @State private var errorToPresent: FileServiceError? = nil

    private var isErrorPresented: Binding<Bool> {
        .constant(errorToPresent != nil)
    }

    init(_ scrum: DailyScrum) {
        self.scrum = scrum
        _title = State(initialValue: scrum.title)
        _attendees = State(initialValue: scrum.attendees)
        _length = State(initialValue: Double(scrum.length))
        _theme = State(initialValue: scrum.theme)
    }

    private func cancelAction() {
        dismiss()
    }

    private func doneAction() {
        do throws(FileServiceError) {
            let updatedScrum = DailyScrum(
                id: scrum.id,
                title: title,
                attendees: attendees.map(\.name),
                length: length,
                theme: theme
            )
            _dailyScrums.upsert(updatedScrum)
            try fileService.save(dailyScrums, forKey: .dailyScrumsKey)
            dismiss()
        } catch {
            errorToPresent = error
        }
    }
}

extension EditScreen: View {
    var body: some View {
        NavigationStack {
            Form {
                EditableMeetingInfoSection(
                    title: $title,
                    length: $length,
                    theme: $theme
                )

                EditableAttendeesSection(
                    attendees: $attendees
                )
            }
            .navigationTitle(scrum.title)
            .toolbar(content: toolbarContent)
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
