//
//  DetailScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct DetailScreen {
    @StoredData private var scrumPath: [ScrumRoute]
    @StoredData private var dailyScrums: [DailyScrum]
    @State private var scrum: DailyScrum
    @State private var routeToPresent: ScrumRoute? = nil

    init(_ scrum: DailyScrum) {
        _scrum = .init(initialValue: scrum)
    }

    private func startMeetingAction() {
        scrumPath.append(.meeting(scrum))
    }

    private func editAction() {
        routeToPresent = .edit(scrum)
    }

    private func historyAction(_ history: History) {
        scrumPath.append(.history(history))
    }

    private func onScrumChange() {
        guard let updatedScrum = dailyScrums.first(
            where: { $0.id == scrum.id }
        ) else { return }

        scrum = updatedScrum
    }
}

extension DetailScreen: View {
    var body: some View {
        List {
            MeetingInfoSection(
                scrum: scrum,
                startMeetingAction: startMeetingAction
            )

            AttendeeSection(
                attendees: scrum.attendees
            )

            HistorySection(
                history: scrum.history,
                onHistoryTap: historyAction
            )
        }
        .onChange(of: dailyScrums, onScrumChange)
        .navigationTitle(scrum.title)
        .sheet(
            item: $routeToPresent,
            content: ScrumRoute.destination
        )
        .toolbar(content: toolbarContent)
    }
}

extension DetailScreen: ToolbarView {
    public func toolbarContent() -> some ToolbarContent {
        ToolbarButton(.edit, perform: editAction)
    }
}
