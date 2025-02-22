//
//  EnvironmentValues+AudioService.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import SwiftUI

/// Provides environment access to the audio service.
extension EnvironmentValues {
    /// The audio service instance available in the environment.
    @Entry public var audioService: any AudioServiceProtocol = AudioService()
}
