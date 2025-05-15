//
//  AddScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Enumerations
import Extensions
import FileService
import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct AddScreen {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.fileService) private var fileService
    @StoredData private var dailyScrums: [DailyScrum]
    @State private var title: String = ""
    @State private var attendees: [DailyScrum.Attendee] = []
    @State private var length: TimeInterval = .minutes(5)
    @State private var theme: Theme = .seafoam
    @State private var errorToPresent: FileServiceError?

    private var isErrorPresented: Binding<Bool> {
        .constant(errorToPresent != nil)
    }

    private func dismissAction() {
        dismiss()
    }

    private func addAction() {
        do throws(FileServiceError) {
            let newScrum: DailyScrum = .init(
                title: title,
                attendees: attendees.map(\.name),
                length: length,
                theme: theme
            )

            _dailyScrums.upsert(newScrum)
            try fileService.save(dailyScrums, forKey: .dailyScrumsKey)
            dismiss()
        } catch {
            errorToPresent = error
        }
    }
}

extension AddScreen: View {
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
            .navigationTitle(.empty)
            .toolbar(content: toolbarContent)
            .alert(
                isPresented: isErrorPresented,
                error: errorToPresent,
                actions: errorActions,
                message: errorMessage
            )
        }
    }

    private func errorMessage(for error: LocalizedError) -> some View {
        Text(error.errorDescription ?? "Unknown error")
    }

    private func errorActions(for error: LocalizedError) -> some View {
        Button(.ok) {}
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
