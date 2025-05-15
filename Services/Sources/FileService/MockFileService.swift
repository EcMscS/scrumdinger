//
//  MockFileService.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation

public class MockFileService: @unchecked Sendable {
    private var storage: [String: Any] = [:]
    private var shouldThrow: Bool

    public init(shouldThrow: Bool = false) {
        self.shouldThrow = shouldThrow
    }
}

extension MockFileService: FileServiceProtocol {
    public func save<T: Encodable>(
        _ objects: [T],
        forKey key: String
    ) throws(FileServiceError) {
        if shouldThrow {
            throw .fileWriteFailed(NSError(domain: "", code: -1))
        }
        storage[key] = objects
    }

    public func load<T: Decodable>(
        forKey key: String
    ) throws(FileServiceError) -> [T] {
        if shouldThrow {
            throw .fileReadFailed(NSError(domain: "", code: -1))
        }
        guard let objects = storage[key] as? [T] else {
            throw .decodingFailed(NSError(domain: "", code: -1))
        }
        return objects
    }
}
