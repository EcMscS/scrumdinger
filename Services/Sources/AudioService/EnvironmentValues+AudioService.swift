//
//  EnvironmentValues+AudioService.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import SwiftUI

private struct AudioServiceKey: EnvironmentKey {
    static let defaultValue: any AudioServiceProtocol = AudioService()
}

/// Provides environment access to the audio service.
extension EnvironmentValues {
    /// The audio service instance available in the environment.
    public var audioService: AudioServiceProtocol {
        get { self[AudioServiceKey.self] }
        set { self[AudioServiceKey.self] = newValue }
    }
}
