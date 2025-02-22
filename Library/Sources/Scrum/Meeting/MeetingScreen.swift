//
//  MeetingScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import AudioService
import Enumerations
import Models
import Protocols
import Resources
import SpeechService
import SwiftUI

@MainActor
struct MeetingScreen {
    private let speechService: SpeechService = .init()
    @Environment(\.dismiss) private var dismiss
    @Environment(\.audioService) private var audioService
    @StoredData private var dailyScrums: [DailyScrum]
    @State var scrum: DailyScrum
    @State var activeSpeaker: DailyScrum.Attendee? = nil
    @State var secondsElapsed: Int = 0
    @State var errorToDisplay: SpeechServiceError? = nil
    @State private var timerTask: Task<Void, Never>? = nil
    @State private var transcript: String = ""

    var isErrorPresented: Binding<Bool> {
        .constant(errorToDisplay != nil)
    }

    var isRecording: Bool {
        timerTask != nil && errorToDisplay == nil && !isMeetingComplete
    }

    private var scrumLengthInSeconds: Int {
        scrum.lengthInMinutes * 60
    }

    private var isMeetingComplete: Bool {
        secondsElapsed >= scrumLengthInSeconds
    }

    var secondsRemaining: Int {
        scrumLengthInSeconds - secondsElapsed
    }

    private var secondsPerSpeaker: Int {
        scrumLengthInSeconds / scrum.attendees.count
    }

    private var speakerIndex: Int {
        secondsElapsed / secondsPerSpeaker
    }

    init(_ scrum: DailyScrum) {
        _scrum = .init(initialValue: scrum)
        _activeSpeaker = .init(initialValue: scrum.attendees.first)
    }

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

    private func updateActiveSpeaker() {
        let newSpeakerIndex = min(speakerIndex, scrum.attendees.count - 1)
        guard newSpeakerIndex < scrum.attendees.count else {  return }
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
            errorToDisplay = error
        }
    }

    private func updateHistory() {
        let history = History(
            attendees: scrum.attendees,
            lengthInMinutes: scrum.lengthInMinutes,
            transcript: transcript
        )
        let updatedHistory: [History] = [history] + scrum.history
        scrum.history = updatedHistory
        _dailyScrums.upsert(scrum)
    }

    func skipAction() {
        let currentSpeakerIndex = speakerIndex
        let secondsToAdd = (currentSpeakerIndex + 1) * secondsPerSpeaker - secondsElapsed
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
