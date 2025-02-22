//
//  MeetingTimerView.swift
//
//  Created by James Sedlacek on 2/17/25.
//

import Enumerations
import Models
import Resources
import SwiftUI

@MainActor
struct MeetingTimerView {
    private let activeSpeaker: DailyScrum.Attendee?
    private let speakers: [DailyScrum.Attendee]
    private let theme: Theme
    private let isRecording: Bool

    init(
        activeSpeaker: DailyScrum.Attendee?,
        speakers: [DailyScrum.Attendee],
        theme: Theme,
        isRecording: Bool
    ) {
        self.activeSpeaker = activeSpeaker
        self.speakers = speakers
        self.theme = theme
        self.isRecording = isRecording
    }

    private var activeSpeakerName: LocalizedStringKey {
        guard let name = activeSpeaker?.name else {
            return .someone
        }
        return .init(name)
    }

    private var symbol: Image.SFSymbol {
        isRecording ? .micActive : .micInactive
    }

    private var symbolAccessibilityLabel: LocalizedStringKey {
        isRecording ? .withTranscription : .withoutTranscription
    }
}

extension MeetingTimerView: View {
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay(content: timerContent)
            .overlay(content: speakerArcs)
            .padding(.horizontal)
    }

    private func timerContent() -> some View {
        VStack {
            Text(activeSpeakerName)
                .font(.title)
            Text(.isSpeaking)
            Image(symbol)
                .font(.title)
                .padding(.top)
                .accessibilityLabel(symbolAccessibilityLabel)
        }
        .accessibilityElement(children: .combine)
        .foregroundStyle(theme.accentColor)
    }

    private func speakerArcs() -> some View {
        ForEach(speakers) { speaker in
            if speaker != activeSpeaker,
               let index = speakers.firstIndex(of: speaker) {
                SpeakerArc(
                    speakerIndex: index,
                    totalSpeakers: speakers.count
                )
                .rotation(Angle(degrees: -90))
                .stroke(theme.mainColor, lineWidth: 12)
            }
        }
    }
}

#Preview("Active Speaker with Recording") {
    let john = DailyScrum.Attendee(id: UUID(), name: "John")
    let jane = DailyScrum.Attendee(id: UUID(), name: "Jane")
    let bob = DailyScrum.Attendee(id: UUID(), name: "Bob")
    return MeetingTimerView(
        activeSpeaker: john,
        speakers: [john, jane, bob],
        theme: .yellow,
        isRecording: true
    )
}

#Preview("No Active Speaker") {
    let john = DailyScrum.Attendee(id: UUID(), name: "John")
    let jane = DailyScrum.Attendee(id: UUID(), name: "Jane")
    return MeetingTimerView(
        activeSpeaker: nil,
        speakers: [john, jane],
        theme: .yellow,
        isRecording: false
    )
}
