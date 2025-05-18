//
//  FileServiceProtocol.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation

public protocol FileServiceProtocol: Sendable {
    /// Saves an array of encodable objects to a file.
    /// - Parameters:
    ///   - objects: The array of objects to save.
    ///   - key: The key to use for the file name.
    /// - Throws: A `FileServiceError` describing what went wrong if the operation fails.
    func save<T: Encodable>(_ objects: [T], forKey key: String) throws(FileServiceError)

    /// Loads an array of decodable objects from a file.
    /// - Parameter key: The key used to save the file.
    /// - Returns: An array of decoded objects.
    /// - Throws: A `FileServiceError` describing what went wrong if the operation fails.
    func load<T: Decodable>(forKey key: String) throws(FileServiceError) -> [T]
}
