//
//  MeetingScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import AudioService
import Enumerations
import Extensions
import Models
import Protocols
import Resources
import SpeechService
import SwiftUI

@MainActor
struct MeetingScreen {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.audioService) private var audioService
    @Environment(\.speechService) private var speechService
    @StoredData private var dailyScrums: [DailyScrum]
    @State var scrum: DailyScrum
    @State var activeSpeaker: DailyScrum.Attendee? = nil
    @State var secondsElapsed: TimeInterval = 0
    @State var errorToPresent: SpeechServiceError? = nil
    @State private var timerTask: Task<Void, Never>? = nil
    @State private var transcript: String = ""

    var isErrorPresented: Binding<Bool> {
        .constant(errorToPresent != nil)
    }

    // Recording is active when timer is running, no errors, and meeting isn't complete
    var isRecording: Bool {
        timerTask != nil && errorToPresent == nil && !isMeetingComplete
    }

    // Meeting is complete when elapsed time reaches or exceeds total length
    private var isMeetingComplete: Bool {
        secondsElapsed >= scrum.length
    }

    // Calculates remaining time by subtracting elapsed from total length
    var secondsRemaining: TimeInterval {
        scrum.length - secondsElapsed
    }

    // Determines current speaker's position based on elapsed time
    private var speakerIndex: Int {
        Int(secondsElapsed / scrum.secondsPerSpeaker)
    }

    init(_ scrum: DailyScrum) {
        _scrum = .init(initialValue: scrum)
        _activeSpeaker = .init(initialValue: scrum.attendees.first)
    }

    // Creates async task that updates progress every second
    private func startTimer() {
        guard timerTask == nil else { return }

        timerTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .seconds(1))
                guard !Task.isCancelled else { break }
                updateProgress()
            }
        }
    }

    private func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
    }

    // Manages meeting completion or updates time and speaker
    func updateProgress() {
        if isMeetingComplete {
            stopTimer()
            updateHistory()
            dismiss()
        } else {
            secondsElapsed += 1
            updateActiveSpeaker()
        }
    }

    // Updates active speaker based on elapsed time, prevents index overflow
    private func updateActiveSpeaker() {
        let newSpeakerIndex = min(speakerIndex, scrum.attendees.count - 1)
        guard newSpeakerIndex < scrum.attendees.count, newSpeakerIndex >= 0 else {  return }
        let newSpeaker = scrum.attendees[newSpeakerIndex]

        // Only update and trigger sound if the speaker actually changes
        if activeSpeaker?.id != newSpeaker.id {
            activeSpeaker = newSpeaker
        }
    }

    @Sendable func startSpeechRecording() async {
        do throws(SpeechServiceError) {
            try await speechService.requestPermissions()
            startTimer()
            let stream = try speechService.startRecording()
            do {
                for try await partialResult in stream {
                    self.transcript = partialResult
                }
            } catch {
                throw .streamFailed(error) 
            }
        } catch {
            errorToPresent = error
        }
    }

    private func updateHistory() {
        let history = History(
            attendees: scrum.attendees,
            length: scrum.length,
            transcript: transcript
        )
        let updatedHistory: [History] = [history] + scrum.history
        scrum.history = updatedHistory
        _dailyScrums.upsert(scrum)
    }

    // Advances to next speaker by calculating and adding required time
    func skipAction() {
        let secondsToAdd = TimeInterval(speakerIndex + 1) * scrum.secondsPerSpeaker - secondsElapsed
        secondsElapsed += secondsToAdd
        updateActiveSpeaker()
    }

    func onActiveSpeakerChange() {
        do throws(AudioServiceError) {
            try audioService.play(.ding)
        } catch {
            print("❌ Audio error: \(error.errorDescription ?? "")")
        }
    }
}

extension MeetingScreen: ViewLifecycle {
    func onDisappear() {
        stopTimer()
        speechService.stopRecording()
        updateHistory()
    }
}
