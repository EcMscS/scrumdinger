//
//  View+WithDependencies.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import AudioService
import Enumerations
import Models
import SpeechService
import SwiftUI

extension View {
    public func withDependencies() -> some View {
        modifier(DependencyViewModifier())
    }
}

public struct DependencyViewModifier: ViewModifier {
    @DataStore private var dailyScrums: [DailyScrum] = []
    private let speechService: any SpeechServiceProtocol
    private let audioService: any AudioServiceProtocol

    public init() {
        print(RuntimeEnvironment.current.description)

        if RuntimeEnvironment.current.isPhysicalDevice {
            self.speechService = SpeechService()
            self.audioService = AudioService()
        } else {
            self.speechService = MockSpeechService()
            self.audioService = MockAudioService()
        }
    }

    public func body(content: Content) -> some View {
        content
            .environment(_dailyScrums.storage)
            .environment(\.speechService, speechService)
            .environment(\.audioService, audioService)
    }
}
