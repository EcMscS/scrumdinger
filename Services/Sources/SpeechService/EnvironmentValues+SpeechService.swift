//
//  EnvironmentValues+SpeechService.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import SwiftUI

/// Provides environment access to the speech service.
extension EnvironmentValues {
    /// The speech service instance available in the environment.
    @Entry public var speechService = SpeechService()
}
