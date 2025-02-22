//
//  ScrumCard.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Extensions
import Models
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct ScrumCard: View {
    private let scrum: DailyScrum

    init(_ scrum: DailyScrum) {
        self.scrum = scrum
    }

    var body: some View {
        VStack(alignment: .leading) {
            titleView
            Spacer()
            footerView
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .accessibilityIdentifier("ScrumCard_\(scrum.id)")
    }

    private var titleView: some View {
        Text(scrum.title)
            .accessibilityAddTraits(.isHeader)
            .font(.headline)
    }

    private var footerView: some View {
        HStack {
            attendeeLabel
            Spacer()
            lengthLabel
        }
        .font(.caption)
    }

    private var attendeeLabel: some View {
        Label("\(scrum.attendees.count)", symbol: .person3)
            .accessibilityLabel(.attendeeCount(scrum.attendees.count))
    }

    private var lengthLabel: some View {
        Label("\(scrum.length.minutes)", symbol: .clock)
            .accessibilityLabel(.meetingLength(scrum.length.minutes))
            .labelStyle(.trailingIcon)
    }
}
