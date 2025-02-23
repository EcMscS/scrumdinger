//
//  EnvironmentValues+FileService.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import SwiftUI

private struct FileServiceKey: EnvironmentKey {
    static let defaultValue: FileServiceProtocol = FileService()
}

/// Provides environment access to the file service.
extension EnvironmentValues {
    /// The file service instance available in the environment.
    public var fileService: FileServiceProtocol {
        get { self[FileServiceKey.self] }
        set { self[FileServiceKey.self] = newValue }
    }
}
