//
//  EnvironmentValues+SpeechService.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import SwiftUI

private struct SpeechServiceKey: EnvironmentKey {
    static let defaultValue: any SpeechServiceProtocol = SpeechService()
}

/// Provides environment access to the speech service.
extension EnvironmentValues {
    /// The speech service instance available in the environment.
    public var speechService: any SpeechServiceProtocol {
        get { self[SpeechServiceKey.self] }
        set { self[SpeechServiceKey.self] = newValue }
    }
}
