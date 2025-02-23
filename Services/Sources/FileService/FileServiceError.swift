//
//  FileServiceError.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation

/// Error cases that can occur during file service operations.
/// - All errors conform to `LocalizedError` to provide human-readable descriptions.
public enum FileServiceError: LocalizedError {
    /// The URL for the specified key could not be created.
    case invalidURL
    /// An error occurred while encoding the data to JSON.
    case encodingFailed(Error)
    /// An error occurred while decoding the data from JSON.
    case decodingFailed(Error)
    /// An error occurred while writing data to the file.
    case fileWriteFailed(Error)
    /// An error occurred while reading data from the file.
    case fileReadFailed(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .encodingFailed(let error):
            return "Failed to encode data: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "Failed to decode data: \(error.localizedDescription)"
        case .fileWriteFailed(let error):
            return "Failed to write to file: \(error.localizedDescription)"
        case .fileReadFailed(let error):
            return "Failed to read from file: \(error.localizedDescription)"
        }
    }
}
