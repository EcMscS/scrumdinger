//
//  SpeechServiceError.swift
//
//  Created by James Sedlacek on 2/19/25.
//

import Foundation

/// Errors that can occur during speech recognition operations.
public enum SpeechServiceError: LocalizedError {
    case initializationFailed
    case notAuthorizedToRecognize
    case notPermittedToRecord
    case recognizerUnavailable
    case streamFailed(Error?)

    public var errorDescription: String? {
        switch self {
        case .initializationFailed:
            return "Failed to initialize speech recognizer"
        case .notAuthorizedToRecognize:
            return "Not authorized to recognize speech"
        case .notPermittedToRecord:
            return "Not permitted to record audio"
        case .recognizerUnavailable:
            return "Speech recognizer is unavailable"
        case .streamFailed(let error):
            return "Speech recognition stream failed: \(error?.localizedDescription ?? "Unknown error")"
        }
    }
}
