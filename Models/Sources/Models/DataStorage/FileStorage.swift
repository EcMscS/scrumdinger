//
//  FileStorage.swift
//
//  Created by James Sedlacek on 2/20/25.
//

import Foundation

/// A storage system that persists data to the file system using JSON encoding.
/// - Provides methods to save and load arrays of Codable objects.
/// - Uses the device's document directory for storage.
/// - Handles various error cases through `FileStorageError`.
public struct FileStorage {
    private let fileManager: FileManager
    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()

    /// Creates a new FileStorage instance.
    /// - Parameter fileManager: The file manager to use for storage operations.
    ///   Defaults to FileManager.default.
    public init(fileManager: FileManager = .default) {
        print("💾 Initializing FileStorage with fileManager: \(fileManager)")
        self.fileManager = fileManager
    }

    /// Creates a URL for the specified key in the app's document directory.
    /// - Parameter key: The key to use for the file name.
    /// - Returns: A URL if the document directory is available, nil otherwise.
    private func url(forKey key: String) -> URL? {
        print("🔍 Getting URL for key: \(key)")
        let url = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appendingPathComponent(key)
        print(url != nil ? "✅ URL created: \(url!)" : "❌ Failed to create URL")
        return url
    }

    /// Saves an array of encodable objects to a file.
    /// - Parameters:
    ///   - objects: The array of objects to save.
    ///   - key: The key to use for the file name.
    /// - Throws: A `FileStorageError` describing what went wrong if the operation fails.
    public func save<T: Encodable>(_ objects: [T], forKey key: String) throws(FileStorageError) {
        print("💾 Saving objects for key: \(key)")
        print("📦 Number of objects: \(objects.count)")

        guard let url = url(forKey: key) else {
            print("❌ Invalid URL for key: \(key)")
            throw .invalidURL
        }

        do {
            print("🔄 Encoding objects...")
            let data = try encoder.encode(objects)
            print("📝 Writing data to file...")
            try data.write(to: url)
            print("✅ Successfully saved objects to file")
        } catch let error as EncodingError {
            print("❌ Encoding failed: \(error)")
            throw .encodingFailed(error)
        } catch {
            print("❌ File write failed: \(error)")
            throw .fileWriteFailed(error)
        }
    }

    /// Loads an array of decodable objects from a file.
    /// - Parameter key: The key used to save the file.
    /// - Returns: An array of decoded objects.
    /// - Throws: A `FileStorageError` describing what went wrong if the operation fails.
    public func load<T: Decodable>(forKey key: String) throws(FileStorageError) -> [T] {
        print("📂 Loading objects for key: \(key)")

        guard let url = url(forKey: key) else {
            print("❌ Invalid URL for key: \(key)")
            throw .invalidURL
        }

        do {
            print("📖 Reading data from file...")
            let data = try Data(contentsOf: url)
            print("🔄 Decoding objects...")
            let objects = try decoder.decode([T].self, from: data)
            print("✅ Successfully loaded \(objects.count) objects")
            return objects
        } catch let error as DecodingError {
            print("❌ Decoding failed: \(error)")
            throw .decodingFailed(error)
        } catch {
            print("❌ File read failed: \(error)")
            throw .fileReadFailed(error)
        }
    }
}
