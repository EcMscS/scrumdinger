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

/// AppScene serves as the root configuration point for the application.
///
/// This scene is responsible for:
/// - Setting up and providing access to core services (Speech, Audio, File)
/// - Managing environment dependencies based on runtime environment
/// - Configuring the main window group and its environment
/// - Handling the distinction between physical device and simulator environments
///
/// Usage:
/// ```swift
/// @main
/// struct YourApp: App {
///     var body: some Scene {
///         AppScene(content: YourRootView.init)
///     }
/// }
/// ```
@MainActor
public struct AppScene<Content: View>: Scene {
    private let content: () -> Content
    private let speechService: any SpeechServiceProtocol
    private let audioService: any AudioServiceProtocol
    private let fileService: any FileServiceProtocol
    @DataStore private var dailyScrums: [DailyScrum] = []

    /// Creates a new AppScene with the specified root content.
    /// - Parameter content: A closure that returns the root view of the application.
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
