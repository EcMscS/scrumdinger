//
//  MeetingScreen+View.swift
//
//  Created by James Sedlacek on 2/17/25.
//

import SwiftUI

extension MeetingScreen: View {
    var body: some View {
        let _ = Self._printChanges()
        VStack {
            headerSection
            timerSection
            footerSection
        }
        .task(priority: .background, startSpeechRecording)
        .onDisappear(perform: onDisappear)
        .onChange(of: activeSpeaker, onActiveSpeakerChange)
        .toolbarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundStyle(scrum.theme.accentColor)
        .background(
            scrum.theme.mainColor,
            in: .rect(cornerRadius: 16)
        )
        .padding()
        .alert(
            isPresented: isErrorPresented,
            error: errorToDisplay,
            actions: errorActions,
            message: errorMessage
        )
    }

    private var headerSection: some View {
        MeetingHeaderView(
            secondsElapsed: secondsElapsed,
            secondsRemaining: secondsRemaining,
            theme: scrum.theme
        )
    }

    private var timerSection: some View {
        MeetingTimerView(
            activeSpeaker: activeSpeaker,
            speakers: scrum.attendees,
            theme: scrum.theme,
            isRecording: isRecording
        )
    }

    private var footerSection: some View {
        MeetingFooterView(
            activeSpeaker: activeSpeaker,
            speakers: scrum.attendees,
            skipAction: skipAction
        )
    }

    private func errorMessage(for error: LocalizedError) -> some View {
        Text(error.errorDescription ?? "Unknown error")
    }

    private func errorActions(for error: LocalizedError) -> some View {
        Button(.ok) {}
    }
}
