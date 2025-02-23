//
//  AppScene.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import AudioService
import Enumerations
import FileService
import Models
import SpeechService
import SwiftUI

@MainActor
public struct AppScene<Content: View>: Scene {
    private let content: () -> Content
    private let speechService: any SpeechServiceProtocol
    private let audioService: any AudioServiceProtocol
    private let fileService: any FileServiceProtocol
    @DataStore private var dailyScrums: [DailyScrum] = []

    public init(content: @escaping () -> Content) {
        self.content = content

        print(RuntimeEnvironment.current.description)

        if RuntimeEnvironment.current.isPhysicalDevice {
            self.speechService = SpeechService()
            self.audioService = AudioService()
            self.fileService = FileService()
        } else {
            self.speechService = MockSpeechService()
            self.audioService = MockAudioService()
            self.fileService = MockFileService()
        }
    }

    public var body: some Scene {
        WindowGroup {
            content()
        }
        .environment(_dailyScrums.storage)
        .environment(\.speechService, speechService)
        .environment(\.audioService, audioService)
        .environment(\.fileService, fileService)
    }
}
