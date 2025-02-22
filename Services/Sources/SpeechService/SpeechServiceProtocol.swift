//
//  SpeechServiceProtocol.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Foundation

public protocol SpeechServiceProtocol: AnyObject {
    @MainActor func requestPermissions() async throws(SpeechServiceError)
    @MainActor func startRecording() throws(SpeechServiceError) -> AsyncThrowingStream<String, Error>
    func stopRecording()
}
