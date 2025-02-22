//
//  AudioServiceError.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import Foundation

public enum AudioServiceError: LocalizedError {
    /// Indicates that the specified sound file could not be found.
    case fileNotFound
    /// Indicates that the audio player could not be initialized.
    case initializationFailed

    public var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Failed to find sound file!"
        case .initializationFailed:
            return "Failed to initialize audio player!"
        }
    }
}
