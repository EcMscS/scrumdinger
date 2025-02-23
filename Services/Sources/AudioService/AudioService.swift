//
//  AudioService.swift
//
//  Created by James Sedlacek on 2/17/25.
//

import AVFoundation
import SwiftUI

/// A service that manages audio playback using AVPlayer.
/// Provides caching of players for improved performance.
public final class AudioService: @unchecked Sendable {
    private var cachedPlayers: [SoundFile.ID: AVAudioPlayer] = [:]

    public init() {
        print("Initialized AudioService...")
    }
}

extension AudioService: AudioServiceProtocol {
    public func play(_ file: SoundFile) throws(AudioServiceError) {
        if let player = cachedPlayers[file] {
            player.currentTime = 0
            player.play()
            return
        }

        guard let url = file.url else {
            throw .fileNotFound
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            cachedPlayers[file.id] = player
            player.play()
        } catch {
            throw .initializationFailed
        }
    }
}
