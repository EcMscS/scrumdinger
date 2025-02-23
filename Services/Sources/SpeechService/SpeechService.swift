//
//  SpeechService.swift
//
//  Created by James Sedlacek on 2/17/25.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

/// A service that manages speech recognition using SFSpeechRecognizer.
public final class SpeechService: SpeechServiceProtocol, @unchecked Sendable {
    private var accumulatedText: String = ""
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    private var continuationHandler: AsyncThrowingStream<String, Error>.Continuation?

    public init(localeIdentifier: String = Locale.current.identifier) {
        print("🎤 Initializing SpeechService...")
        print("📍 Using locale: \(localeIdentifier)")
        recognizer = SFSpeechRecognizer(locale: Locale(identifier: localeIdentifier))
        print(recognizer != nil ? "✅ SpeechRecognizer created" : "❌ Failed to create SpeechRecognizer")
    }

    /// Request necessary permissions for speech recognition.
    @MainActor public func requestPermissions() async throws(SpeechServiceError) {
        print("🔐 Requesting speech recognition permissions...")

        guard let recognizer else {
            print("❌ SpeechRecognizer not initialized")
            throw .initializationFailed
        }

        print("🎤 Checking speech recognition authorization...")
        let authStatus = await SFSpeechRecognizer.hasAuthorizationToRecognize()
        print("📊 Authorization status: \(authStatus)")
        guard authStatus else {
            print("❌ Not authorized to recognize speech")
            throw .notAuthorizedToRecognize
        }
        print("✅ Speech recognition authorized")

        print("🎙️ Checking microphone permission...")
        let recordPermission = await AVAudioSession.sharedInstance().hasPermissionToRecord()
        print("📊 Record permission: \(recordPermission)")
        guard recordPermission else {
            print("❌ Not permitted to record audio")
            throw .notPermittedToRecord
        }
        print("✅ Microphone access granted")

        print("🔍 Checking recognizer availability...")
        print("📊 Recognizer available: \(recognizer.isAvailable)")
        guard recognizer.isAvailable else {
            print("❌ Speech recognizer unavailable")
            throw .recognizerUnavailable
        }
    }

    /// Start recording and transcribing speech.
    @MainActor public func startRecording() throws(SpeechServiceError) -> AsyncThrowingStream<String, Error> {
        print("🎤 Starting speech recording...")

        guard let recognizer, recognizer.isAvailable else {
            print("❌ Speech recognizer unavailable")
            throw .recognizerUnavailable
        }

        print("🔄 Stopping any existing recording...")
        stopRecording()

        print("🌊 Creating transcription stream...")
        return createTranscriptionStream()
    }

    @MainActor
    private func createTranscriptionStream() -> AsyncThrowingStream<String, Error> {
        print("🔄 Creating transcription stream...")
        return AsyncThrowingStream { continuation in
            print("📝 Setting up continuation handler...")
            self.continuationHandler = continuation

            Task {
                do {
                    print("⚙️ Configuring audio session...")
                    let (engine, request) = try Self.configureAudioSession()
                    self.audioEngine = engine
                    self.request = request

                    print("🎯 Creating recognition task...")
                    task = recognizer?.recognitionTask(with: request) { [weak self] result, error in
                        print("📍 Recognition callback - hasResult: \(result != nil), hasError: \(error != nil)")
                        guard let self else {
                            print("⚠️ Self is nil in recognition callback")
                            return
                        }

                        if let error {
                            print("❌ Recognition error: \(error)")
                            continuation.finish(throwing: error)
                            print("🛑 Stopping recording due to error")
                            self.stopRecording()
                            return
                        }

                        if let result {
                            let newText = result.bestTranscription.formattedString
                            print("📝 New transcription: \(newText)")
                            continuation.yield(self.accumulatedText + newText)

                            if result.isFinal {
                                print("✅ Final result received")
                                self.accumulatedText += newText + " "
                                print("🔄 Stopping recording after final result")
                                self.stopRecording()
                            }
                        }
                    }

                    print("✅ Recording started successfully")

                } catch {
                    print("❌ Stream setup error: \(error)")
                    continuation.finish(throwing: error)
                    print("🛑 Stopping recording due to setup error")
                    self.stopRecording()
                }
            }
        }
    }

    private static func configureAudioSession() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        print("🔄 Setting up audio session...")
        let audioEngine = AVAudioEngine()
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.taskHint = .dictation
        request.addsPunctuation = true

        print("⚙️ Configuring audio session...")
        let audioSession = AVAudioSession.sharedInstance()
        do {
            print("🔊 Setting audio session category...")
            try audioSession.setCategory(.playAndRecord, mode: .measurement, options: .duckOthers)
            print("🔊 Activating audio session...")
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("❌ Audio session configuration error: \(error)")
            throw error
        }

        print("🎙️ Setting up audio input...")
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        print("📊 Recording format: \(recordingFormat)")

        print("📝 Installing audio tap...")
        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: recordingFormat
        ) { [weak request] buffer, _ in
            print("🔄 Processing audio buffer...")
            request?.append(buffer)
        }

        print("🔄 Starting audio engine...")
        audioEngine.prepare()
        do {
            try audioEngine.start()
            print("✅ Audio engine started successfully")
        } catch {
            print("❌ Audio engine start error: \(error)")
            throw error
        }

        return (audioEngine, request)
    }

    /// Stop recording and transcribing speech.
    public func stopRecording() {
        print("🛑 Stopping speech recording...")

        if let task = task {
            print("🔄 Cancelling recognition task...")
            task.cancel()
            self.task = nil
        }

        if let engine = audioEngine {
            print("🔄 Stopping audio engine...")
            engine.stop()
            engine.inputNode.removeTap(onBus: 0)
            self.audioEngine = nil
        }

        print("🧹 Cleaning up request...")
        request = nil

        if let handler = continuationHandler {
            print("🔄 Finishing continuation handler...")
            handler.finish()
            continuationHandler = nil
        }

        print("🔊 Deactivating audio session...")
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("⚠️ Error deactivating audio session: \(error)")
        }

        print("✅ Recording stopped successfully")
    }
}
