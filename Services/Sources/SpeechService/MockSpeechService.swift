//
//  MockSpeechService.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Foundation

public final class MockSpeechService: SpeechServiceProtocol, @unchecked Sendable {
    private var accumulatedText: String = ""
    private var continuationHandler: AsyncThrowingStream<String, Error>.Continuation?
    private var shouldSimulateError: Bool
    private var simulatedTexts: [String]
    private var currentTextIndex: Int = 0

    public init(
        shouldSimulateError: Bool = false,
        simulatedTexts: [String] = ["Hello", "This is a test", "Final transcript"]
    ) {
        self.shouldSimulateError = shouldSimulateError
        self.simulatedTexts = simulatedTexts
    }

    @MainActor
    public func requestPermissions() async throws(SpeechServiceError) {
        if shouldSimulateError {
            throw .notAuthorizedToRecognize
        }
    }

    @MainActor
    public func startRecording() throws(SpeechServiceError) -> AsyncThrowingStream<String, Error> {
        if shouldSimulateError {
            throw .recognizerUnavailable
        }

        return AsyncThrowingStream { continuation in
            self.continuationHandler = continuation

            // Simulate speech recognition with a timer
            Task {
                for text in simulatedTexts {
                    try? await Task.sleep(for: .seconds(1))
                    guard !Task.isCancelled else { break }
                    accumulatedText = text
                    continuation.yield(text)
                }
                continuation.finish()
            }
        }
    }

    public func stopRecording() {
        continuationHandler?.finish()
        continuationHandler = nil
    }
}
