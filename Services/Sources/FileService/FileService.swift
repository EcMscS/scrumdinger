//
//  FileService.swift
//
//  Created by James Sedlacek on 2/20/25.
//

import Foundation

/// A service that persists data to the file system using JSON encoding.
/// - Provides methods to save and load arrays of Codable objects.
/// - Uses the device's document directory for storage.
/// - Handles various error cases through `FileServiceError`.
public struct FileService: FileServiceProtocol, @unchecked Sendable {
    private let fileManager: FileManager
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()

    /// Creates a new FileService instance.
    /// - Parameter fileManager: The file manager to use for storage operations.
    ///   Defaults to FileManager.default.
    public init(fileManager: FileManager = .default) {
        print("Initializing FileService...")
        self.fileManager = fileManager
    }

    /// Creates a URL for the specified key in the app's document directory.
    /// - Parameter key: The key to use for the file name.
    /// - Returns: A URL if the document directory is available, nil otherwise.
    private func url(forKey key: String) -> URL? {
        fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(key)
    }

    /// Saves an array of encodable objects to a file.
    /// - Parameters:
    ///   - objects: The array of objects to save.
    ///   - key: The key to use for the file name.
    /// - Throws: A `FileServiceError` describing what went wrong if the operation fails.
    public func save<T: Encodable>(_ objects: [T], forKey key: String) throws(FileServiceError) {
        guard let url = url(forKey: key) else {
            throw .invalidURL
        }

        do {
            let data = try encoder.encode(objects)
            try data.write(to: url)
        } catch let error as EncodingError {
            throw .encodingFailed(error)
        } catch {
            throw .fileWriteFailed(error)
        }
    }

    /// Loads an array of decodable objects from a file.
    /// - Parameter key: The key used to save the file.
    /// - Returns: An array of decoded objects.
    /// - Throws: A `FileServiceError` describing what went wrong if the operation fails.
    public func load<T: Decodable>(forKey key: String) throws(FileServiceError) -> [T] {
        guard let url = url(forKey: key) else {
            throw .invalidURL
        }

        do {
            let data = try Data(contentsOf: url)
            let objects = try decoder.decode([T].self, from: data)
            return objects
        } catch let error as DecodingError {
            throw .decodingFailed(error)
        } catch {
            throw .fileReadFailed(error)
        }
    }
}
